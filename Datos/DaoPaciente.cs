using Entidades;
using System;
using System.Collections.Generic;
using System.Data.SqlClient;
using System.Linq;
using System.Text;

namespace Datos
{
    public class DaoPaciente
    {
        public int ObtenerCantidadRegistros()
        {
            const string sql = "SELECT COUNT(*) FROM Pacientes WHERE EstadoRegistro = 1;";
            return Convert.ToInt32(AccesoDatos.Escalar(sql));
        }

        // texto: busca por DNI, nombre, apellido o correo.
        // idProvincia / idLocalidad 0 significa "sin filtro".
        // sexo: 'M', 'F', 'O' o null/"" para "Todos".
        public List<PacienteListado> Listar(string texto, int idProvincia, int idLocalidad, string sexo)
        {
            var sql = new StringBuilder(@"
                SELECT  pac.IdPaciente,
                        per.DNI,
                        per.Apellido + ', ' + per.Nombre AS Paciente,
                        CASE per.Sexo
                            WHEN 'F' THEN 'Femenino'
                            WHEN 'M' THEN 'Masculino'
                            ELSE 'Otro'
                        END AS Sexo,
                        loc.NombreLocalidad AS Localidad,
                        prov.NombreProvincia AS Provincia,
                        per.Telefono,
                        per.Email AS Correo
                FROM    Pacientes pac
                        INNER JOIN Personas per    ON per.IdPersona = pac.IdPersona
                        INNER JOIN Localidades loc ON loc.IdLocalidad = per.IdLocalidad
                        INNER JOIN Provincias prov ON prov.IdProvincia = loc.IdProvincia
                WHERE   pac.EstadoRegistro = 1
                        AND per.EstadoRegistro = 1
            ");

            var parametros = new List<SqlParameter>();

            if (!string.IsNullOrWhiteSpace(texto))
            {
                sql.Append(" AND (per.DNI LIKE @texto OR per.Nombre LIKE @texto OR per.Apellido LIKE @texto OR per.Email LIKE @texto)");
                parametros.Add(new SqlParameter("@texto", "%" + texto.Trim() + "%"));
            }

            if (idProvincia > 0)
            {
                sql.Append(" AND prov.IdProvincia = @idProvincia");
                parametros.Add(new SqlParameter("@idProvincia", idProvincia));
            }

            if (idLocalidad > 0)
            {
                sql.Append(" AND loc.IdLocalidad = @idLocalidad");
                parametros.Add(new SqlParameter("@idLocalidad", idLocalidad));
            }

            if (!string.IsNullOrWhiteSpace(sexo))
            {
                sql.Append(" AND per.Sexo = @sexo");
                parametros.Add(new SqlParameter("@sexo", sexo));
            }

            sql.Append(" ORDER BY per.Apellido, per.Nombre;");

            return AccesoDatos.Listar(sql.ToString(), dr => new PacienteListado
            {
                IdPaciente = Convert.ToInt32(dr["IdPaciente"]),
                DNI = dr["DNI"].ToString(),
                Paciente = dr["Paciente"].ToString(),
                Sexo = dr["Sexo"].ToString(),
                Localidad = dr["Localidad"].ToString(),
                Provincia = dr["Provincia"].ToString(),
                Telefono = dr["Telefono"].ToString(),
                Correo = dr["Correo"].ToString()
            }, parametros.ToArray());
        }
        public int DarDeBaja(string dni)
        {
            const string query = @"
            UPDATE pac
            SET pac.EstadoRegistro = 0
            FROM Pacientes pac
            INNER JOIN Personas per ON per.IdPersona = pac.IdPersona
            WHERE per.DNI = @dni
              AND pac.EstadoRegistro = 1;";

            return AccesoDatos.Ejecutar(
                query,
                new SqlParameter("@dni", dni.Trim())
            );
        }

        public Persona ObtenerPorDni(string dni)
        {
            const string sql = @"SELECT per.IdPersona,
                                        per.DNI,
                                        per.Nombre,
                                        per.Apellido,
                                        per.Sexo,
                                        per.Nacionalidad,
                                        per.FechaNacimiento,
                                        per.Direccion,
                                        per.IdLocalidad,
                                        per.Email,
                                        per.Telefono
                                FROM    Pacientes pac INNER JOIN Personas per ON per.IdPersona = pac.IdPersona
                                WHERE   per.DNI = @dni
                                        AND pac.EstadoRegistro = 1
                                        AND per.EstadoRegistro = 1;";

            List<Persona> lista = AccesoDatos.Listar(sql, dr => new Persona
            {
                IdPersona = Convert.ToInt32(dr["IdPersona"]),
                DNI = dr["DNI"].ToString(),
                Nombre = dr["Nombre"].ToString(),
                Apellido = dr["Apellido"].ToString(),
                Sexo = Convert.ToChar(dr["Sexo"]),
                Nacionalidad = dr["Nacionalidad"].ToString(),
                FechaNacimiento = Convert.ToDateTime(dr["FechaNacimiento"]),
                Direccion = dr["Direccion"].ToString(),
                IdLocalidad = Convert.ToInt32(dr["IdLocalidad"]),
                Email = dr["Email"].ToString(),
                Telefono = dr["Telefono"].ToString()
            }, new SqlParameter("@dni", dni.Trim()));

            return lista.FirstOrDefault();
        }

        // true si ya existe una Persona (activa o no) con ese DNI. Lo usamos antes del alta
        // porque la tabla Personas tiene UQ_Personas_DNI: sin este chequeo previo, un DNI
        // repetido tira una SqlException de constraint en vez de un mensaje claro para el usuario.
        public bool ExisteDni(string dni)
        {
            const string sql = "SELECT COUNT(*) FROM Personas WHERE DNI = @dni;";
            int cantidad = Convert.ToInt32(AccesoDatos.Escalar(sql, new SqlParameter("@dni", dni.Trim())));
            return cantidad > 0;
        }

        // Alta de paciente = alta de Persona + alta de Pacientes (IdPersona), en una sola
        // transaccion. Devuelve el IdPaciente generado.
        public int Alta(Persona persona)
        {
            const string sqlPersona = @"
                INSERT INTO Personas (DNI, Nombre, Apellido, Sexo, Nacionalidad, FechaNacimiento, Direccion, IdLocalidad, Email, Telefono)
                VALUES (@dni, @nombre, @apellido, @sexo, @nacionalidad, @fechaNacimiento, @direccion, @idLocalidad, @email, @telefono);
                SELECT CAST(SCOPE_IDENTITY() AS INT);";

            SqlParameter[] parametrosPersona =
            {
                new SqlParameter("@dni", persona.DNI.Trim()),
                new SqlParameter("@nombre", persona.Nombre.Trim()),
                new SqlParameter("@apellido", persona.Apellido.Trim()),
                new SqlParameter("@sexo", persona.Sexo.ToString()),
                new SqlParameter("@nacionalidad", persona.Nacionalidad.Trim()),
                new SqlParameter("@fechaNacimiento", persona.FechaNacimiento),
                new SqlParameter("@direccion", persona.Direccion.Trim()),
                new SqlParameter("@idLocalidad", persona.IdLocalidad),
                new SqlParameter("@email", persona.Email.Trim()),
                new SqlParameter("@telefono", persona.Telefono.Trim())
            };

            const string sqlPaciente = @"
                INSERT INTO Pacientes (IdPersona)
                VALUES (@idPersona);
                SELECT CAST(SCOPE_IDENTITY() AS INT);";

            return AccesoDatos.InsertarConDependencia(
                sqlPersona,
                parametrosPersona,
                sqlPaciente,
                idPersona => new[] { new SqlParameter("@idPersona", idPersona) });
        }
    }
}
