/* =====================================================================
   TRABAJO PRACTICO INTEGRADOR - PROGRAMACION III
   Sistema de gestion de Clinica Medica
   Base de datos: ClinicaDB  -  SQL Server 2019 o superior
   =====================================================================
   Ejecutar completo en SQL Server Management Studio.
   ===================================================================== */
IF DB_ID('ClinicaDB') IS NOT NULL
BEGIN
    ALTER DATABASE ClinicaDB SET SINGLE_USER WITH ROLLBACK IMMEDIATE;
    DROP DATABASE ClinicaDB;
END
GO
CREATE DATABASE ClinicaDB;
GO
USE ClinicaDB;
GO
/* ------------------------- TABLAS MAESTRAS ------------------------- */

CREATE TABLE Roles (
    IdRol        TINYINT      NOT NULL CONSTRAINT PK_Roles PRIMARY KEY,
    Descripcion  VARCHAR(30)  NOT NULL
);
GO

CREATE TABLE Provincias (
    IdProvincia      INT          IDENTITY(1,1) NOT NULL CONSTRAINT PK_Provincias PRIMARY KEY,
    NombreProvincia  VARCHAR(60)  NOT NULL
);
GO

CREATE TABLE Localidades (
    IdLocalidad      INT          IDENTITY(1,1) NOT NULL CONSTRAINT PK_Localidades PRIMARY KEY,
    NombreLocalidad  VARCHAR(80)  NOT NULL,
    IdProvincia      INT          NOT NULL
);
GO

ALTER TABLE Localidades ADD CONSTRAINT FK_Localidades_Provincias
    FOREIGN KEY (IdProvincia) REFERENCES Provincias (IdProvincia);
GO

CREATE TABLE Especialidades (
    IdEspecialidad  INT          IDENTITY(1,1) NOT NULL CONSTRAINT PK_Especialidades PRIMARY KEY,
    Descripcion     VARCHAR(80)  NOT NULL,
    EstadoRegistro  BIT          NOT NULL CONSTRAINT DF_Especialidades_Estado DEFAULT (1)
);
GO

CREATE TABLE DiasAtencion (
    IdDia      TINYINT     NOT NULL CONSTRAINT PK_DiasAtencion PRIMARY KEY,
    NombreDia  VARCHAR(15) NOT NULL
);
GO

CREATE TABLE EstadosTurno (
    IdEstadoTurno  TINYINT     NOT NULL CONSTRAINT PK_EstadosTurno PRIMARY KEY,
    Descripcion    VARCHAR(20) NOT NULL
);
GO

/* --------------------------- PERSONAS ------------------------------ */

CREATE TABLE Personas (
    IdPersona        INT           IDENTITY(1,1) NOT NULL CONSTRAINT PK_Personas PRIMARY KEY,
    DNI              VARCHAR(10)   NOT NULL,
    Nombre           VARCHAR(50)   NOT NULL,
    Apellido         VARCHAR(50)   NOT NULL,
    Sexo             CHAR(1)       NOT NULL,
    Nacionalidad     VARCHAR(50)   NOT NULL,
    FechaNacimiento  DATE          NOT NULL,
    Direccion        VARCHAR(120)  NOT NULL,
    IdLocalidad      INT           NOT NULL,
    Email            VARCHAR(120)  NOT NULL,
    Telefono         VARCHAR(30)   NOT NULL,
    EstadoRegistro   BIT           NOT NULL CONSTRAINT DF_Personas_Estado DEFAULT (1)
);
GO

ALTER TABLE Personas ADD CONSTRAINT UQ_Personas_DNI UNIQUE (DNI);
GO
ALTER TABLE Personas ADD CONSTRAINT CK_Personas_Sexo CHECK (Sexo IN ('M','F','O','X'));
GO
ALTER TABLE Personas ADD CONSTRAINT FK_Personas_Localidades
    FOREIGN KEY (IdLocalidad) REFERENCES Localidades (IdLocalidad);
GO

CREATE TABLE Pacientes (
    IdPaciente      INT  IDENTITY(1,1) NOT NULL CONSTRAINT PK_Pacientes PRIMARY KEY,
    IdPersona       INT  NOT NULL,
    EstadoRegistro  BIT  NOT NULL CONSTRAINT DF_Pacientes_Estado DEFAULT (1)
);
GO
ALTER TABLE Pacientes ADD CONSTRAINT UQ_Pacientes_Persona UNIQUE (IdPersona);
GO
ALTER TABLE Pacientes ADD CONSTRAINT FK_Pacientes_Personas
    FOREIGN KEY (IdPersona) REFERENCES Personas (IdPersona);
GO

CREATE TABLE Medicos (
    Legajo          VARCHAR(10)  NOT NULL CONSTRAINT PK_Medicos PRIMARY KEY,
    IdPersona       INT          NOT NULL,
    IdEspecialidad  INT          NOT NULL,
    EstadoRegistro  BIT          NOT NULL CONSTRAINT DF_Medicos_Estado DEFAULT (1)
);
GO
ALTER TABLE Medicos ADD CONSTRAINT UQ_Medicos_Persona UNIQUE (IdPersona);
GO
ALTER TABLE Medicos ADD CONSTRAINT FK_Medicos_Personas
    FOREIGN KEY (IdPersona) REFERENCES Personas (IdPersona);
GO
ALTER TABLE Medicos ADD CONSTRAINT FK_Medicos_Especialidades
    FOREIGN KEY (IdEspecialidad) REFERENCES Especialidades (IdEspecialidad);
GO

CREATE TABLE Usuarios (
    IdUsuario      INT          IDENTITY(1,1) NOT NULL CONSTRAINT PK_Usuarios PRIMARY KEY,
    NombreUsuario  VARCHAR(50)  NOT NULL,
    Clave          VARCHAR(64)  NOT NULL,   -- SHA-256 en hexadecimal
    IdRol          TINYINT      NOT NULL,
    IdPersona      INT          NOT NULL,
    EstadoRegistro BIT          NOT NULL CONSTRAINT DF_Usuarios_Estado DEFAULT (1)
);
GO
ALTER TABLE Usuarios ADD CONSTRAINT UQ_Usuarios_Nombre UNIQUE (NombreUsuario);
GO
ALTER TABLE Usuarios ADD CONSTRAINT UQ_Usuarios_Persona UNIQUE (IdPersona);
GO
ALTER TABLE Usuarios ADD CONSTRAINT FK_Usuarios_Roles
    FOREIGN KEY (IdRol) REFERENCES Roles (IdRol);
GO
ALTER TABLE Usuarios ADD CONSTRAINT FK_Usuarios_Personas
    FOREIGN KEY (IdPersona) REFERENCES Personas (IdPersona);
GO

/* ------------------------ DIAS Y HORARIOS -------------------------- */

CREATE TABLE MedicosHorarios (
    IdHorario   INT      IDENTITY(1,1) NOT NULL CONSTRAINT PK_MedicosHorarios PRIMARY KEY,
    Legajo      VARCHAR(10) NOT NULL,
    IdDia       TINYINT  NOT NULL,
    HoraDesde   TIME     NOT NULL,
    HoraHasta   TIME     NOT NULL
);
GO
ALTER TABLE MedicosHorarios ADD CONSTRAINT UQ_MedicosHorarios UNIQUE (Legajo, IdDia, HoraDesde);
GO
ALTER TABLE MedicosHorarios ADD CONSTRAINT CK_MedicosHorarios_Horas CHECK (HoraDesde < HoraHasta);
GO
ALTER TABLE MedicosHorarios ADD CONSTRAINT FK_MedicosHorarios_Medicos
    FOREIGN KEY (Legajo) REFERENCES Medicos (Legajo);
GO
ALTER TABLE MedicosHorarios ADD CONSTRAINT FK_MedicosHorarios_Dias
    FOREIGN KEY (IdDia) REFERENCES DiasAtencion (IdDia);
GO

/* ---------------------------- TURNOS ------------------------------- */

CREATE TABLE Turnos (
    IdTurno         INT           IDENTITY(1,1) NOT NULL CONSTRAINT PK_Turnos PRIMARY KEY,
    Legajo          VARCHAR(10)   NOT NULL,
    IdPaciente      INT           NOT NULL,
    IdEspecialidad  INT           NOT NULL,
    Fecha           DATE          NOT NULL,
    Hora            TIME          NOT NULL,
    IdEstadoTurno   TINYINT       NOT NULL CONSTRAINT DF_Turnos_EstadoTurno DEFAULT (1),
    Observacion     VARCHAR(300)  NULL,
    FechaRegistro   DATETIME      NOT NULL CONSTRAINT DF_Turnos_FechaRegistro DEFAULT (GETDATE()),
    EstadoRegistro  BIT           NOT NULL CONSTRAINT DF_Turnos_Estado DEFAULT (1)
);
GO
CREATE UNIQUE INDEX UQ_Turnos_Medico_Fecha_Hora
    ON Turnos (Legajo, Fecha, Hora) WHERE EstadoRegistro = 1;
GO
ALTER TABLE Turnos ADD CONSTRAINT FK_Turnos_Medicos
    FOREIGN KEY (Legajo) REFERENCES Medicos (Legajo);
GO
ALTER TABLE Turnos ADD CONSTRAINT FK_Turnos_Pacientes
    FOREIGN KEY (IdPaciente) REFERENCES Pacientes (IdPaciente);
GO
ALTER TABLE Turnos ADD CONSTRAINT FK_Turnos_Especialidades
    FOREIGN KEY (IdEspecialidad) REFERENCES Especialidades (IdEspecialidad);
GO
ALTER TABLE Turnos ADD CONSTRAINT FK_Turnos_EstadosTurno
    FOREIGN KEY (IdEstadoTurno) REFERENCES EstadosTurno (IdEstadoTurno);
GO

/* ------------------------ VISTA PARA INFORMES ---------------------- */

CREATE VIEW vw_Turnos AS
SELECT  t.IdTurno,
        t.Fecha,
        t.Hora,
        t.Legajo,
        m.IdEspecialidad,
        e.Descripcion           AS Especialidad,
        p.IdPaciente,
        per.DNI,
        per.Apellido + ', ' + per.Nombre AS Paciente,
        t.IdEstadoTurno,
        et.Descripcion          AS EstadoTurno,
        t.Observacion
FROM    Turnos t
        INNER JOIN Medicos m       ON m.Legajo = t.Legajo
        INNER JOIN Especialidades e ON e.IdEspecialidad = m.IdEspecialidad
        INNER JOIN Pacientes p      ON p.IdPaciente = t.IdPaciente
        INNER JOIN Personas per     ON per.IdPersona = p.IdPersona
        INNER JOIN EstadosTurno et  ON et.IdEstadoTurno = t.IdEstadoTurno
WHERE   t.EstadoRegistro = 1;
GO

/* ======================== DATOS PRECARGADOS ======================== */

INSERT INTO Roles (IdRol, Descripcion) VALUES (1,'Administrador'), (2,'Medico');
GO

INSERT INTO Provincias (NombreProvincia) VALUES
    (N'Buenos Aires'),
    (N'Ciudad Autonoma de Buenos Aires'),
    (N'Catamarca'),
    (N'Chaco'),
    (N'Chubut'),
    (N'Cordoba'),
    (N'Corrientes'),
    (N'Entre Rios'),
    (N'Formosa'),
    (N'Jujuy'),
    (N'La Pampa'),
    (N'La Rioja'),
    (N'Mendoza'),
    (N'Misiones'),
    (N'Neuquen'),
    (N'Rio Negro'),
    (N'Salta'),
    (N'San Juan'),
    (N'San Luis'),
    (N'Santa Cruz'),
    (N'Santa Fe'),
    (N'Santiago del Estero'),
    (N'Tierra del Fuego'),
    (N'Tucuman');
GO

INSERT INTO Localidades (NombreLocalidad, IdProvincia) VALUES
    (N'General Pacheco', 1),
    (N'San Miguel', 1),
    (N'Tigre', 1),
    (N'Vicente Lopez', 1),
    (N'La Plata', 1),
    (N'Mar del Plata', 1),
    (N'Bahia Blanca', 1),
    (N'Moron', 1),
    (N'Quilmes', 1),
    (N'Avellaneda', 1),
    (N'Ciudad de Buenos Aires', 2),
    (N'Cordoba Capital', 6),
    (N'Villa Maria', 6),
    (N'Rosario', 21),
    (N'Santa Fe Capital', 21),
    (N'Parana', 8),
    (N'Mendoza Capital', 13),
    (N'Salta Capital', 17),
    (N'San Miguel de Tucuman', 24),
    (N'Neuquen Capital', 15),
    (N'San Carlos de Bariloche', 16),
    (N'Posadas', 14),
    (N'Corrientes Capital', 7),
    (N'Resistencia', 4),
    (N'San Juan Capital', 18),
    (N'La Rioja Capital', 12),
    (N'Formosa Capital', 9),
    (N'Santa Rosa', 11),
    (N'Rio Gallegos', 20),
    (N'Ushuaia', 23),
    (N'San Luis Capital', 19),
    (N'Catamarca Capital', 3),
    (N'San Salvador de Jujuy', 10),
    (N'Santiago del Estero Capital', 22),
    (N'Rawson', 5),
    (N'Trelew', 5),
    (N'Olavarria', 1),
    (N'Pergamino', 1);
GO

INSERT INTO Especialidades (Descripcion) VALUES
    (N'Clinica Medica'),
    (N'Cardiologia'),
    (N'Dermatologia'),
    (N'Pediatria'),
    (N'Ginecologia'),
    (N'Traumatologia'),
    (N'Neurologia'),
    (N'Oftalmologia'),
    (N'Otorrinolaringologia'),
    (N'Psiquiatria'),
    (N'Endocrinologia'),
    (N'Nutricion');
GO

INSERT INTO DiasAtencion (IdDia, NombreDia) VALUES
    (1,'Lunes'), (2,'Martes'), (3,'Miercoles'), (4,'Jueves'),
    (5,'Viernes'), (6,'Sabado');
GO

INSERT INTO EstadosTurno (IdEstadoTurno, Descripcion) VALUES
    (1,'Pendiente'), (2,'Presente'), (3,'Ausente');
GO

INSERT INTO Personas (DNI, Nombre, Apellido, Sexo, Nacionalidad, FechaNacimiento, Direccion, IdLocalidad, Email, Telefono) VALUES
    (N'28000044', N'Silvina', N'Benitez', 'F', N'Argentina', '1977-07-24', N'Alsina 2712', 1, N'silvina.benitez10@mail.com', N'11-6961-6577'),
    (N'28000208', N'Luis', N'Herrera', 'M', N'Argentina', '1989-05-10', N'Las Heras 677', 2, N'luis.herrera83@mail.com', N'11-6883-6062'),
    (N'28000364', N'Maria', N'Gomez', 'F', N'Argentina', '1978-06-15', N'Los Andes 471', 3, N'maria.gomez52@mail.com', N'11-6399-9166'),
    (N'28000465', N'Diego', N'Gimenez', 'M', N'Argentina', '1987-10-16', N'Los Andes 2248', 4, N'diego.gimenez34@mail.com', N'11-5720-8851'),
    (N'28000614', N'Carolina', N'Cabrera', 'F', N'Argentina', '2006-01-19', N'Sarmiento 628', 5, N'carolina.cabrera7@mail.com', N'11-6886-9572'),
    (N'28000764', N'Diego', N'Pereyra', 'M', N'Argentina', '1982-08-05', N'Las Heras 1037', 6, N'diego.pereyra16@mail.com', N'11-6566-8484'),
    (N'28000891', N'Florencia', N'Silva', 'F', N'Argentina', '1971-09-13', N'Rivadavia 2345', 7, N'florencia.silva83@mail.com', N'11-6055-8846'),
    (N'28001014', N'Matias', N'Castro', 'M', N'Argentina', '1967-05-27', N'Rivadavia 137', 8, N'matias.castro5@mail.com', N'11-4613-8507'),
    (N'28001158', N'Carolina', N'Quiroga', 'F', N'Argentina', '1978-04-09', N'Las Heras 2011', 9, N'carolina.quiroga66@mail.com', N'11-6036-8114'),
    (N'28001317', N'Nicolas', N'Vega', 'M', N'Argentina', '1957-05-11', N'Las Heras 502', 10, N'nicolas.vega57@mail.com', N'11-6823-9440'),
    (N'28001427', N'Silvina', N'Ruiz', 'F', N'Argentina', '1966-07-27', N'Las Heras 363', 11, N'silvina.ruiz84@mail.com', N'11-5091-9166'),
    (N'28001519', N'Andres', N'Ledesma', 'M', N'Argentina', '1967-12-28', N'Los Andes 699', 12, N'andres.ledesma58@mail.com', N'11-4057-2510'),
    (N'28001701', N'Maria', N'Romero', 'F', N'Argentina', '1992-09-27', N'Belgrano 2599', 13, N'maria.romero26@mail.com', N'11-5015-2979'),
    (N'28001850', N'Carlos', N'Torres', 'M', N'Argentina', '1972-11-25', N'9 de Julio 733', 14, N'carlos.torres1@mail.com', N'11-5283-9060'),
    (N'28001987', N'Carla', N'Molina', 'F', N'Argentina', '1969-08-19', N'Mitre 2549', 15, N'carla.molina89@mail.com', N'11-6067-5762'),
    (N'28005533', N'Luis', N'Fernandez', 'M', N'Argentina', '1997-03-05', N'Moreno 1353', 3, N'luis.fernandez65@mail.com', N'11-5687-7396'),
    (N'28005683', N'Carla', N'Martinez', 'F', N'Argentina', '2006-04-13', N'Av. San Martin 534', 4, N'carla.martinez50@mail.com', N'11-4300-1841'),
    (N'28005836', N'Andres', N'Perez', 'M', N'Argentina', '1977-01-01', N'Alsina 2049', 5, N'andres.perez42@mail.com', N'11-6796-5975'),
    (N'28005932', N'Natalia', N'Rodriguez', 'F', N'Argentina', '1962-08-15', N'Moreno 2633', 6, N'natalia.rodriguez22@mail.com', N'11-4630-9513'),
    (N'28006083', N'Gustavo', N'Ortiz', 'M', N'Argentina', '1994-06-15', N'Moreno 1055', 7, N'gustavo.ortiz87@mail.com', N'11-6911-2138'),
    (N'28006216', N'Alejandra', N'Gonzalez', 'F', N'Argentina', '1957-04-21', N'Mitre 285', 8, N'alejandra.gonzalez83@mail.com', N'11-6231-1789'),
    (N'28006384', N'Javier', N'Martinez', 'M', N'Argentina', '1967-08-23', N'Av. San Martin 628', 9, N'javier.martinez83@mail.com', N'11-6170-4583'),
    (N'28006456', N'Carolina', N'Medina', 'F', N'Argentina', '1965-11-28', N'Mitre 1697', 10, N'carolina.medina35@mail.com', N'11-5742-9732'),
    (N'28006586', N'Hernan', N'Rodriguez', 'M', N'Argentina', '1979-05-06', N'9 de Julio 815', 11, N'hernan.rodriguez34@mail.com', N'11-5900-9152'),
    (N'28006749', N'Veronica', N'Vargas', 'F', N'Argentina', '1984-03-11', N'Alsina 2074', 12, N'veronica.vargas57@mail.com', N'11-4491-9638'),
    (N'28006885', N'Eduardo', N'Gonzalez', 'M', N'Argentina', '2007-02-28', N'Sarmiento 1047', 13, N'eduardo.gonzalez1@mail.com', N'11-4381-8440'),
    (N'28007039', N'Laura', N'Acosta', 'F', N'Argentina', '1989-11-06', N'Av. San Martin 1541', 14, N'laura.acosta21@mail.com', N'11-5440-9820'),
    (N'28007138', N'Gustavo', N'Medina', 'M', N'Argentina', '1994-12-09', N'Alsina 3177', 15, N'gustavo.medina73@mail.com', N'11-6994-4513'),
    (N'28007333', N'Romina', N'Suarez', 'F', N'Argentina', '1972-11-18', N'Mitre 515', 16, N'romina.suarez34@mail.com', N'11-4394-8144'),
    (N'28007411', N'Pablo', N'Vargas', 'M', N'Argentina', '1998-01-25', N'9 de Julio 3058', 17, N'pablo.vargas24@mail.com', N'11-6645-2741'),
    (N'10000000', N'Administrador', N'Sistema', 'M', N'Argentina', '1980-05-12', N'Sede Central 100', 1, N'admin@clinica.com', N'11-4000-0000');
GO

INSERT INTO Pacientes (IdPersona) VALUES
    (1),
    (2),
    (3),
    (4),
    (5),
    (6),
    (7),
    (8),
    (9),
    (10),
    (11),
    (12),
    (13),
    (14),
    (15);
GO

INSERT INTO Medicos (Legajo, IdPersona, IdEspecialidad) VALUES
    ('MP-001', 16, 1),
    ('MP-002', 17, 2),
    ('MP-003', 18, 3),
    ('MP-004', 19, 4),
    ('MP-005', 20, 5),
    ('MP-006', 21, 6),
    ('MP-007', 22, 7),
    ('MP-008', 23, 8),
    ('MP-009', 24, 9),
    ('MP-010', 25, 10),
    ('MP-011', 26, 11),
    ('MP-012', 27, 12),
    ('MP-013', 28, 1),
    ('MP-014', 29, 2),
    ('MP-015', 30, 3);
GO

INSERT INTO Usuarios (NombreUsuario, Clave, IdRol, IdPersona) VALUES
    (N'admin', CONVERT(VARCHAR(64), HASHBYTES('SHA2_256', N'admin123'), 2), 1, 31),
    (N'lfernandez', CONVERT(VARCHAR(64), HASHBYTES('SHA2_256', N'medico123'), 2), 2, 16),
    (N'cmartinez', CONVERT(VARCHAR(64), HASHBYTES('SHA2_256', N'medico123'), 2), 2, 17),
    (N'aperez', CONVERT(VARCHAR(64), HASHBYTES('SHA2_256', N'medico123'), 2), 2, 18),
    (N'nrodriguez', CONVERT(VARCHAR(64), HASHBYTES('SHA2_256', N'medico123'), 2), 2, 19),
    (N'gortiz', CONVERT(VARCHAR(64), HASHBYTES('SHA2_256', N'medico123'), 2), 2, 20),
    (N'agonzalez', CONVERT(VARCHAR(64), HASHBYTES('SHA2_256', N'medico123'), 2), 2, 21),
    (N'jmartinez', CONVERT(VARCHAR(64), HASHBYTES('SHA2_256', N'medico123'), 2), 2, 22),
    (N'cmedina', CONVERT(VARCHAR(64), HASHBYTES('SHA2_256', N'medico123'), 2), 2, 23),
    (N'hrodriguez', CONVERT(VARCHAR(64), HASHBYTES('SHA2_256', N'medico123'), 2), 2, 24),
    (N'vvargas', CONVERT(VARCHAR(64), HASHBYTES('SHA2_256', N'medico123'), 2), 2, 25),
    (N'egonzalez', CONVERT(VARCHAR(64), HASHBYTES('SHA2_256', N'medico123'), 2), 2, 26),
    (N'lacosta', CONVERT(VARCHAR(64), HASHBYTES('SHA2_256', N'medico123'), 2), 2, 27),
    (N'gmedina', CONVERT(VARCHAR(64), HASHBYTES('SHA2_256', N'medico123'), 2), 2, 28),
    (N'rsuarez', CONVERT(VARCHAR(64), HASHBYTES('SHA2_256', N'medico123'), 2), 2, 29),
    (N'pvargas', CONVERT(VARCHAR(64), HASHBYTES('SHA2_256', N'medico123'), 2), 2, 30);
GO

INSERT INTO MedicosHorarios (Legajo, IdDia, HoraDesde, HoraHasta) VALUES
    ('MP-001', 1, '08:00', '12:00'),
    ('MP-001', 1, '14:00', '18:00'),
    ('MP-001', 3, '08:00', '12:00'),
    ('MP-001', 3, '14:00', '18:00'),
    ('MP-001', 5, '08:00', '12:00'),
    ('MP-001', 5, '14:00', '18:00'),
    ('MP-002', 2, '08:00', '12:00'),
    ('MP-002', 2, '14:00', '18:00'),
    ('MP-002', 4, '08:00', '12:00'),
    ('MP-002', 4, '14:00', '18:00'),
    ('MP-002', 6, '08:00', '12:00'),
    ('MP-002', 6, '14:00', '18:00'),
    ('MP-003', 1, '08:00', '12:00'),
    ('MP-003', 1, '14:00', '18:00'),
    ('MP-003', 3, '08:00', '12:00'),
    ('MP-003', 3, '14:00', '18:00'),
    ('MP-003', 5, '08:00', '12:00'),
    ('MP-003', 5, '14:00', '18:00'),
    ('MP-004', 2, '08:00', '12:00'),
    ('MP-004', 2, '14:00', '18:00'),
    ('MP-004', 4, '08:00', '12:00'),
    ('MP-004', 4, '14:00', '18:00'),
    ('MP-004', 6, '08:00', '12:00'),
    ('MP-004', 6, '14:00', '18:00'),
    ('MP-005', 1, '08:00', '12:00'),
    ('MP-005', 1, '14:00', '18:00'),
    ('MP-005', 3, '08:00', '12:00'),
    ('MP-005', 3, '14:00', '18:00'),
    ('MP-005', 5, '08:00', '12:00'),
    ('MP-005', 5, '14:00', '18:00'),
    ('MP-006', 2, '08:00', '12:00'),
    ('MP-006', 2, '14:00', '18:00'),
    ('MP-006', 4, '08:00', '12:00'),
    ('MP-006', 4, '14:00', '18:00'),
    ('MP-006', 6, '08:00', '12:00'),
    ('MP-006', 6, '14:00', '18:00'),
    ('MP-007', 1, '08:00', '12:00'),
    ('MP-007', 1, '14:00', '18:00'),
    ('MP-007', 3, '08:00', '12:00'),
    ('MP-007', 3, '14:00', '18:00'),
    ('MP-007', 5, '08:00', '12:00'),
    ('MP-007', 5, '14:00', '18:00'),
    ('MP-008', 2, '08:00', '12:00'),
    ('MP-008', 2, '14:00', '18:00'),
    ('MP-008', 4, '08:00', '12:00'),
    ('MP-008', 4, '14:00', '18:00'),
    ('MP-008', 6, '08:00', '12:00'),
    ('MP-008', 6, '14:00', '18:00'),
    ('MP-009', 1, '08:00', '12:00'),
    ('MP-009', 1, '14:00', '18:00'),
    ('MP-009', 3, '08:00', '12:00'),
    ('MP-009', 3, '14:00', '18:00'),
    ('MP-009', 5, '08:00', '12:00'),
    ('MP-009', 5, '14:00', '18:00'),
    ('MP-010', 2, '08:00', '12:00'),
    ('MP-010', 2, '14:00', '18:00'),
    ('MP-010', 4, '08:00', '12:00'),
    ('MP-010', 4, '14:00', '18:00'),
    ('MP-010', 6, '08:00', '12:00'),
    ('MP-010', 6, '14:00', '18:00'),
    ('MP-011', 1, '08:00', '12:00'),
    ('MP-011', 1, '14:00', '18:00'),
    ('MP-011', 3, '08:00', '12:00'),
    ('MP-011', 3, '14:00', '18:00'),
    ('MP-011', 5, '08:00', '12:00'),
    ('MP-011', 5, '14:00', '18:00'),
    ('MP-012', 2, '08:00', '12:00'),
    ('MP-012', 2, '14:00', '18:00'),
    ('MP-012', 4, '08:00', '12:00'),
    ('MP-012', 4, '14:00', '18:00'),
    ('MP-012', 6, '08:00', '12:00'),
    ('MP-012', 6, '14:00', '18:00'),
    ('MP-013', 1, '08:00', '12:00'),
    ('MP-013', 1, '14:00', '18:00'),
    ('MP-013', 3, '08:00', '12:00'),
    ('MP-013', 3, '14:00', '18:00'),
    ('MP-013', 5, '08:00', '12:00'),
    ('MP-013', 5, '14:00', '18:00'),
    ('MP-014', 2, '08:00', '12:00'),
    ('MP-014', 2, '14:00', '18:00'),
    ('MP-014', 4, '08:00', '12:00'),
    ('MP-014', 4, '14:00', '18:00'),
    ('MP-014', 6, '08:00', '12:00'),
    ('MP-014', 6, '14:00', '18:00'),
    ('MP-015', 1, '08:00', '12:00'),
    ('MP-015', 1, '14:00', '18:00'),
    ('MP-015', 3, '08:00', '12:00'),
    ('MP-015', 3, '14:00', '18:00'),
    ('MP-015', 5, '08:00', '12:00'),
    ('MP-015', 5, '14:00', '18:00');
GO

INSERT INTO Turnos (Legajo, IdPaciente, IdEspecialidad, Fecha, Hora, IdEstadoTurno, Observacion) VALUES
    ('MP-001', 1, 1, '2026-10-02', '08:00', 2, N'Control de rutina. Sin cambios.'),
    ('MP-002', 2, 2, '2026-10-06', '09:00', 2, N'Se ajusto medicacion.'),
    ('MP-003', 3, 3, '2026-10-07', '10:00', 3, NULL),
    ('MP-004', 4, 4, '2026-10-10', '11:00', 1, NULL),
    ('MP-005', 5, 5, '2026-10-14', '14:00', 2, N'Consulta por dolor leve, se indica reposo.'),
    ('MP-006', 6, 6, '2026-10-17', '15:00', 2, N'Control post operatorio favorable.'),
    ('MP-007', 7, 7, '2026-10-19', '16:00', 3, NULL),
    ('MP-008', 8, 8, '2026-10-22', '17:00', 1, NULL),
    ('MP-009', 9, 9, '2026-10-26', '08:00', 2, N'Se indica tratamiento por 10 dias.'),
    ('MP-010', 10, 10, '2026-10-29', '09:00', 2, N'Control de presion arterial.'),
    ('MP-011', 11, 11, '2026-11-02', '10:00', 3, NULL),
    ('MP-012', 12, 12, '2026-11-03', '11:00', 1, NULL),
    ('MP-013', 13, 1, '2026-11-06', '14:00', 2, N'Paciente estable, control en 30 dias.'),
    ('MP-014', 14, 2, '2026-11-10', '15:00', 2, N'Se solicitaron estudios complementarios.'),
    ('MP-015', 15, 3, '2026-11-13', '16:00', 3, NULL),
    ('MP-001', 1, 1, '2026-11-16', '17:00', 1, NULL),
    ('MP-002', 2, 2, '2026-11-19', '08:00', 2, N'Se deriva a estudio de laboratorio.'),
    ('MP-003', 3, 3, '2026-11-23', '09:00', 2, N'Paciente asintomatico.'),
    ('MP-004', 4, 4, '2026-11-24', '10:00', 3, NULL),
    ('MP-005', 5, 5, '2026-11-27', '11:00', 1, NULL),
    ('MP-006', 6, 6, '2026-12-01', '14:00', 2, N'Control de rutina. Sin cambios.'),
    ('MP-007', 7, 7, '2026-12-04', '15:00', 2, N'Se ajusto medicacion.'),
    ('MP-008', 8, 8, '2026-12-08', '16:00', 3, NULL),
    ('MP-009', 9, 9, '2026-12-09', '17:00', 1, NULL),
    ('MP-010', 10, 10, '2026-12-12', '08:00', 2, N'Consulta por dolor leve, se indica reposo.'),
    ('MP-011', 11, 11, '2026-12-16', '09:00', 2, N'Control post operatorio favorable.'),
    ('MP-012', 12, 12, '2026-12-19', '10:00', 3, NULL),
    ('MP-013', 13, 1, '2026-12-21', '11:00', 1, NULL),
    ('MP-014', 14, 2, '2026-12-24', '14:00', 2, N'Se indica tratamiento por 10 dias.'),
    ('MP-015', 15, 3, '2026-10-05', '15:00', 2, N'Control de presion arterial.'),
    ('MP-001', 1, 1, '2026-10-07', '16:00', 3, NULL),
    ('MP-002', 2, 2, '2026-10-10', '17:00', 1, NULL),
    ('MP-003', 3, 3, '2026-10-12', '08:00', 2, N'Paciente estable, control en 30 dias.'),
    ('MP-004', 4, 4, '2026-10-15', '09:00', 2, N'Se solicitaron estudios complementarios.'),
    ('MP-005', 5, 5, '2026-10-19', '10:00', 3, NULL),
    ('MP-006', 6, 6, '2026-10-22', '11:00', 1, NULL),
    ('MP-007', 7, 7, '2026-10-26', '14:00', 2, N'Se deriva a estudio de laboratorio.'),
    ('MP-008', 8, 8, '2026-10-27', '15:00', 2, N'Paciente asintomatico.'),
    ('MP-009', 9, 9, '2026-10-30', '16:00', 3, NULL),
    ('MP-010', 10, 10, '2026-11-03', '17:00', 1, NULL),
    ('MP-011', 11, 11, '2026-11-06', '08:00', 2, N'Control de rutina. Sin cambios.'),
    ('MP-012', 12, 12, '2026-11-10', '09:00', 2, N'Se ajusto medicacion.'),
    ('MP-013', 13, 1, '2026-11-11', '10:00', 3, NULL),
    ('MP-014', 14, 2, '2026-11-14', '11:00', 1, NULL),
    ('MP-015', 15, 3, '2026-11-18', '14:00', 2, N'Consulta por dolor leve, se indica reposo.'),
    ('MP-001', 1, 1, '2026-11-20', '15:00', 2, N'Control post operatorio favorable.'),
    ('MP-002', 2, 2, '2026-11-24', '16:00', 3, NULL),
    ('MP-003', 3, 3, '2026-11-27', '17:00', 1, NULL);
GO

/* ======================= CONSULTAS DE VERIFICACION ================= */
-- SELECT * FROM vw_Turnos ORDER BY Fecha, Hora;
-- SELECT COUNT(*) AS TotalPersonas FROM Personas;
-- SELECT COUNT(*) AS TotalTurnos   FROM Turnos;
GO
