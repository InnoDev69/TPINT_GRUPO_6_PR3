using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Text;
using Entidades;

namespace Datos
{
    public class MedicoDatos
    {
        public int ObtenerCantidadRegistros()
        {
            const string sql = "SELECT COUNT(*) FROM Medicos WHERE EstadoRegistro = 1;";
            return Convert.ToInt32(AccesoDatos.Escalar(sql));
        }

        // texto: busca por legajo, DNI, nombre o apellido.
        // idEspecialidad / idDia en 0 significa "sin filtro".
        // DiasAtencion y Horario salen de MedicosHorarios agregados con STRING_AGG
        // (un medico puede tener varios dias/turnos cargados).
        public List<MedicoListado> Listar(string texto, int idEspecialidad, int idDia)
        {
            var sql = new StringBuilder(@"
                SELECT  m.Legajo,
                        per.DNI,
                        per.Apellido + ', ' + per.Nombre AS Medico,
                        esp.Descripcion AS Especialidad,
                        loc.NombreLocalidad AS Localidad,
                        prov.NombreProvincia AS Provincia,
                        ISNULL(dias.Dias, '-') AS DiasAtencion,
                        ISNULL(horarios.Horarios, '-') AS Horario
                FROM    Medicos m
                        INNER JOIN Personas per        ON per.IdPersona = m.IdPersona
                        INNER JOIN Especialidades esp  ON esp.IdEspecialidad = m.IdEspecialidad
                        INNER JOIN Localidades loc     ON loc.IdLocalidad = per.IdLocalidad
                        INNER JOIN Provincias prov     ON prov.IdProvincia = loc.IdProvincia
                        OUTER APPLY (
                            SELECT STRING_AGG(da.NombreDia, ', ') WITHIN GROUP (ORDER BY da.IdDia) AS Dias
                            FROM (SELECT DISTINCT IdDia FROM MedicosHorarios WHERE Legajo = m.Legajo) x
                                 INNER JOIN DiasAtencion da ON da.IdDia = x.IdDia
                        ) dias
                        OUTER APPLY (
                            SELECT STRING_AGG(CONVERT(VARCHAR(5), HoraDesde, 108) + ' a ' + CONVERT(VARCHAR(5), HoraHasta, 108), ' / ')
                                   WITHIN GROUP (ORDER BY HoraDesde) AS Horarios
                            FROM (SELECT DISTINCT HoraDesde, HoraHasta FROM MedicosHorarios WHERE Legajo = m.Legajo) h
                        ) horarios
                WHERE   m.EstadoRegistro = 1
                        AND per.EstadoRegistro = 1
            ");

            var parametros = new List<SqlParameter>();

            if (!string.IsNullOrWhiteSpace(texto))
            {
                sql.Append(" AND (m.Legajo LIKE @texto OR per.DNI LIKE @texto OR per.Nombre LIKE @texto OR per.Apellido LIKE @texto)");
                parametros.Add(new SqlParameter("@texto", SqlDbType.VarChar, 150) { Value = "%" + texto.Trim() + "%" });
            }

            if (idEspecialidad > 0)
            {
                sql.Append(" AND esp.IdEspecialidad = @idEspecialidad");
                parametros.Add(new SqlParameter("@idEspecialidad", SqlDbType.Int) { Value = idEspecialidad });
            }

            if (idDia > 0)
            {
                sql.Append(" AND EXISTS (SELECT 1 FROM MedicosHorarios mh WHERE mh.Legajo = m.Legajo AND mh.IdDia = @idDia)");
                parametros.Add(new SqlParameter("@idDia", SqlDbType.TinyInt) { Value = idDia });
            }

            sql.Append(" ORDER BY per.Apellido, per.Nombre;");

            return AccesoDatos.Listar(sql.ToString(), dr => new MedicoListado
            {
                Legajo = dr["Legajo"].ToString(),
                DNI = dr["DNI"].ToString(),
                Medico = dr["Medico"].ToString(),
                Especialidad = dr["Especialidad"].ToString(),
                Localidad = dr["Localidad"].ToString(),
                Provincia = dr["Provincia"].ToString(),
                DiasAtencion = dr["DiasAtencion"].ToString(),
                Horario = dr["Horario"].ToString()
            }, parametros.ToArray());
        }

        public int DarDeBaja(string legajo)
        {
            const string sql = "UPDATE Medicos SET EstadoRegistro = 0 WHERE Legajo = @legajo AND EstadoRegistro = 1;";

            return AccesoDatos.Ejecutar(
                sql,
                new SqlParameter("@legajo", SqlDbType.VarChar, 10) { Value = legajo.Trim() });
        }
    }
}
