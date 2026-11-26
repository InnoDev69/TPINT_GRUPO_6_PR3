# Lineamientos de código

## Sistema de Gestión de Clínica Médica "Clínica San Rafael"

**Proyecto:** TPINT_GRUPO_6_PR3
**Materia:** Programación III — Tecnicatura Universitaria en Programación
**Institución:** UTN Facultad Regional General Pacheco
**Alcance:** convenciones de C# (Entidades, Datos, Negocio, Vistas) y de SQL. Complementa a `Lineamientos_Estilos.md`, que cubre únicamente HTML/CSS.

---

## 1. Objetivo

Que cualquier integrante del grupo pueda escribir una clase nueva sin inventar un criterio propio y que el código de los cuatro proyectos (`Entidades`, `Datos`, `Negocio`, `Vistas`) se lea como si lo hubiera escrito una sola persona. Estas reglas no se rompen sin acordarlo antes con el grupo.

---

## 2. Arquitectura en capas — quién puede llamar a quién

```
Vistas (.aspx / .aspx.cs)
   │  solo puede instanciar clases de Negocio
   ▼
Negocio (*Negocio.cs)
   │  valida, aplica reglas, solo puede instanciar clases de Datos
   ▼
Datos (*Datos.cs, Dao*.cs)
   │  arma el SQL, solo puede usar AccesoDatos / ConexionBD
   ▼
Entidades (clases POCO)
   usadas por las tres capas de arriba, no dependen de ninguna
```

**Regla dura:** un `.aspx.cs` **nunca** hace `new SqlConnection(...)` ni instancia una clase `*Datos` directamente. Siempre pasa por una clase `*Negocio`. Si una pantalla necesita un dato y no existe el método de Negocio que lo trae, se crea ese método — no se accede a `Datos` salteando la capa.

**Regla dura:** las clases `Entidades` no tienen lógica, solo propiedades (`get; set;`). Nada de validaciones ni de acceso a datos ahí dentro.

---

## 3. Nomenclatura de clases

| Capa | Patrón | Ejemplos correctos |
|---|---|---|
| Entidades | `<Entidad>` en singular | `Paciente`, `Medico`, `Provincia`, `Especialidad` |
| Datos | `<Entidad>Datos` | `ProvinciaDatos`, `LocalidadDatos`, `EspecialidadDatos` |
| Negocio | `<Entidad>Negocio` | `UsuarioNegocio`, `LocalidadNegocio` |

**Ya tenemos nombres que no siguen este patrón y hay que unificar antes de seguir sumando clases:**

- `DatosUsuario` → debería ser `UsuarioDatos` (el resto de la capa Datos pone el nombre de la entidad primero).
- `Usuarios` (entidad) → evaluar si pasa a `Usuario` en singular, igual que el resto de las entidades. Si se cambia, hay que actualizar todas las referencias (`DatosUsuario`/`UsuarioDatos`, `UsuarioNegocio`, `Login.aspx.cs`).
- `DaoMedico`, `DaoPaciente`, `DaoTurno` → renombrar a `MedicoDatos`, `PacienteDatos`, `TurnoDatos` para no tener dos prefijos distintos (`Dao*` y `*Datos`) conviviendo en el mismo proyecto.

A partir de ahora **no se crea ninguna clase nueva con el patrón `Dao*` o `Datos<Entidad>`**: todo lo nuevo usa `<Entidad>Datos`.

---

## 4. Namespaces

- Todo lo que está dentro de la carpeta/proyecto `Datos` va en `namespace Datos`. **No** `namespace Vistas.Datos`.
  - `ConexionDB.cs` tiene hoy `namespace Vistas.Datos` — es un error, hay que corregirlo a `namespace Datos` (y ajustar el `using` en los archivos que la referencian).
- `Entidades` → `namespace Entidades`.
- `Negocio` → `namespace Negocio`.
- `Vistas` (código behind de páginas) → `namespace Vistas`.

---

## 5. Acceso a datos (ADO.NET)

- **Toda** consulta SQL pasa por `AccesoDatos.Listar<T>(...)` o `AccesoDatos.Escalar(...)`. No se abre un `SqlConnection`/`SqlCommand` suelto en una clase `*Datos` nueva: se reutiliza el helper que ya existe.
- Los parámetros de usuario **siempre** van por `SqlParameter`, nunca concatenados en el string del SQL (riesgo de inyección). Ejemplo correcto:

  ```csharp
  new SqlParameter("@idProvincia", SqlDbType.Int) { Value = idProvincia }
  ```

  Usar siempre esta forma explícita con `SqlDbType`, no la forma corta `new SqlParameter("@nombre", valor)` que a veces infiere mal el tipo. Hay que unificar los métodos existentes que todavía usan la forma corta (`DatosUsuario`, por ejemplo) a este estilo.
- Ningún método de `Datos` hace `SELECT *`: siempre se listan las columnas que se van a usar.
- Las bajas son **siempre lógicas**: `UPDATE ... SET EstadoRegistro = 0`, nunca `DELETE`. Y toda consulta de listado filtra `WHERE EstadoRegistro = 1` salvo que se pida explícitamente lo contrario.
- Los nombres de tabla y columna en el SQL se escriben **tal como están en `ClinicaDB.sql`** (`Usuarios`, `Personas`, `Especialidades`, todo en plural). Antes de escribir una consulta nueva, revisar el script para no repetir el error de `Usuario`/`Persona` en singular que tuvo `DatosUsuario`.

---

## 6. Estilo de las consultas SQL embebidas

- Palabras clave de SQL en mayúsculas (`SELECT`, `FROM`, `WHERE`, `INNER JOIN`, `ORDER BY`).
- Verbatim string (`@"..."`) con la consulta en varias líneas y las columnas alineadas en una sola columna, como en `EspecialidadDatos` y `LocalidadDatos`:

  ```csharp
  const string sql = @"
      SELECT  IdEspecialidad,
              Descripcion
      FROM    Especialidades
      WHERE   EstadoRegistro = 1
      ORDER BY Descripcion;";
  ```

- Los alias de tabla son una sola letra o dos, en minúscula, consistentes con el nombre de la entidad (`p` para `Personas`, `u` para `Usuarios`, `m` para `Medicos`).
- Las consultas de una sola línea (como los `COUNT(*)` de `MedicoDatos`/`PacienteDatos`/`TurnoDatos`) pueden quedar en una línea porque son triviales; no hace falta el formato multilínea para esos casos.

---

## 7. Capa de Negocio

- Acá van las validaciones que no son de formato de pantalla: "sin provincia no se consulta la base", "la contraseña se hashea antes de comparar", "el string vacío no es una búsqueda válida". El ejemplo a seguir es `LocalidadNegocio` y `UsuarioNegocio`.
- Un método de Negocio nunca devuelve un `SqlDataReader` ni nada de `System.Data.SqlClient`: siempre trabaja con `Entidades` o con tipos primitivos.
- Si una regla de negocio se repite en dos lugares (por ejemplo, el criterio de qué se considera "texto vacío"), se extrae a un método privado dentro de la misma clase de Negocio, no se copia y pega.

---

## 8. Seguridad

- Las contraseñas **nunca** se guardan ni se comparan en texto plano. Siempre se hashean con `SHA256` (ver `UsuarioNegocio.CalcularHash`) antes de tocar la base.
- Ninguna pantalla guarda la contraseña en `Session`, `ViewState` ni en una cookie.
- Las credenciales de prueba (usuario/contraseña hardcodeados en el code-behind, tipo las que tenía `Login.aspx.cs` antes de conectarlo a `UsuarioNegocio`) **no vuelven a aparecer** en ningún `.aspx.cs`. Si hace falta un usuario de prueba, se inserta en `ClinicaDB.sql`.

---

## 9. Estilo general de C#

- Llaves en línea propia (estilo Allman), como en todo el código ya escrito:

  ```csharp
  public class Ejemplo
  {
      public void Metodo()
      {
          if (condicion)
          {
              // ...
          }
      }
  }
  ```

- `using` para todo lo que implementa `IDisposable` (`SqlConnection`, `SqlCommand`, `SqlDataReader`): nunca se cierra "a mano" con `.Close()`.
- Nombres de clases, métodos, propiedades y variables locales **en español**, salvo los que ya son parte del framework (`EventArgs`, `SqlConnection`, etc.). No mezclar `ObtenerCantidadRegistros()` con `GetTotalRecords()` en el mismo proyecto.
- Métodos en `PascalCase`, variables locales y parámetros en `camelCase`, constantes en `PascalCase` (`const string Sql = ...` o `const string sql = ...`; elegir uno de los dos y mantenerlo — hoy se usa `sql` en minúscula, así que seguimos con ese).
- No dejar `using` sin usar ni clases vacías a medio hacer en una rama que se mergea a `main`: si una clase todavía no se conecta a ninguna pantalla (como pasó con `DaoMedico`/`DaoPaciente`/`DaoTurno`), se aclara en el commit o en un comentario que es código preparado para un paso siguiente.
- Comentarios cortos que expliquen el "por qué" de una regla (como ya se hace en `AccesoDatos` y `LocalidadNegocio`: `// Regla: ...`), no el "qué" (eso ya lo dice el código).

---

## 10. Checklist antes de hacer commit de una clase nueva

- [ ] El namespace corresponde al proyecto (`Datos`, `Negocio`, `Entidades`, `Vistas`), no a otro.
- [ ] El nombre de la clase sigue el patrón de su capa (sección 3).
- [ ] Ningún `.aspx.cs` llama directo a una clase de `Datos`: siempre pasa por `Negocio`.
- [ ] Toda consulta usa `AccesoDatos` y `SqlParameter` con `SqlDbType` explícito.
- [ ] Los nombres de tabla/columna están copiados de `ClinicaDB.sql`, no de memoria.
- [ ] Las bajas son lógicas (`EstadoRegistro = 0`), nunca `DELETE`.
- [ ] No hay contraseñas en texto plano en ningún lado.
- [ ] No quedaron credenciales ni datos de prueba hardcodeados en el code-behind.

---

*Documento de lineamientos de código — Clínica San Rafael · Programación III · UTN FRGP. Complementa a `Lineamientos_Estilos.md`.*
