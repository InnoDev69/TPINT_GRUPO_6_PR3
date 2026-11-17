# TPINT_GRUPO_6_PR3 - Clínica San Rafael

Trabajo Práctico Integrador - Programación III (UTN FRGP).
Sistema de gestión de una clínica médica en ASP.NET Web Forms (.NET Framework 4.7.2), en tres capas.

## Estructura

| Carpeta | Contenido |
|---|---|
| `Entidades/` | Clases del modelo (Paciente, Médico, Turno, Usuario...) |
| `Datos/` | Acceso a SQL Server |
| `Negocio/` | Reglas de negocio y validaciones |
| `Vistas/` | Proyecto web: páginas `.aspx`, `Site.Master`, `Estilos/estilos.css` |
| `BaseDatos/` | Script SQL de creación de la base y datos de prueba |
| `Documentacion/` | DER, Word de entrega, capturas, enunciado y lineamientos de estilo |

## Requisitos

- Visual Studio con la carga de trabajo "Desarrollo de ASP.NET y web"
- .NET Framework 4.7.2 (targeting pack)
- SQL Server Express / LocalDB o SQL Server 2019+

## Puesta en marcha

1. Abrir `BaseDatos/ClinicaDB.sql` en SSMS y ejecutarlo completo.
2. Agregar la cadena de conexión `ClinicaDB` en `Vistas/Web.config`.
3. Abrir `TPINT_GRUPO_6_PR3.slnx` con Visual Studio. Los paquetes NuGet se restauran solos.
4. Establecer `Vistas` como proyecto de inicio y `Login.aspx` como página de inicio.
5. F5.

## Estado

- [x] Estructura de 4 proyectos
- [x] Pantalla de Login (`Vistas/Login.aspx`); validación contra la base pendiente
- [x] Maqueta navegable de las pantallas internas (`Vistas/Site.Master` + páginas `.aspx`)
- [ ] ABML de pacientes contra la base
- [ ] ABML de médicos contra la base
- [ ] Asignación de turnos contra la base
- [ ] Informes contra la base
- [ ] Vista del médico contra la base

### Maqueta navegable

Las pantallas internas muestran datos de ejemplo y la navegación entre ellas está resuelta:
Panel de administración, Pacientes (listado, alta y modificación), Médicos (listado, alta y modificación),
Turnos (listado y asignación), Informes, y la vista del médico (Mis turnos y Mis pacientes).

Credenciales de demostración mientras la validación real está pendiente:

| Usuario | Contraseña | Rol |
|---|---|---|
| `admin` | `admin123` | Administrador |
| `lfernandez` | `medico123` | Médico |
| `mgomez` | `medico123` | Médico (usuario solo de demo, no está en el script) |

> Los datos de las grillas y formularios son estáticos. Las altas, bajas y modificaciones solo
> muestran los avisos y modales de la maqueta; todavía no persisten en SQL Server.

## Trabajo en equipo

- Una rama por funcionalidad: `git switch -c feature/abml-pacientes`.
- `Vistas.csproj` lista cada archivo: si hay conflicto al fusionar, conservar las líneas de ambas ramas.
- El Word (`Documentacion/TPI_progra3.docx`) lo edita una sola persona a la vez.
- No subir `bin/`, `obj/`, `packages/` ni zips (ya están en `.gitignore`).
