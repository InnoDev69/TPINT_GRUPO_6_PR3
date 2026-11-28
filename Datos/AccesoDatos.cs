using System;
using System.Collections.Generic;
using System.Data.SqlClient;
using Vistas.Datos;

namespace Datos
{
    // Responsabilidad unica: aca se ejecuta la consulta de lectura y devuelve la lista mapeada.
    public static class AccesoDatos
    {
        public static List<T> Listar<T>(string sql, Func<SqlDataReader, T> mapear, params SqlParameter[] parametros)
        {
            var lista = new List<T>();

            using (SqlConnection cn = new ConexionBD().ObtenerConexion())
            using (SqlCommand cmd = new SqlCommand(sql, cn))
            {
                if (parametros != null && parametros.Length > 0)
                {
                    cmd.Parameters.AddRange(parametros);
                }

                cn.Open();

                using (SqlDataReader dr = cmd.ExecuteReader())
                {
                    while (dr.Read())
                    {
                        lista.Add(mapear(dr));
                    }
                }
            }

            return lista;
        }
        //obtiene un unico valor de la db
        public static object Escalar(string sql, params SqlParameter[] parametros)
        {
            using (SqlConnection conexion = new ConexionBD().ObtenerConexion())
            using (SqlCommand cmd = new SqlCommand(sql, conexion))
            {
                if (parametros != null && parametros.Length > 0)
                {
                    cmd.Parameters.AddRange(parametros);
                }

                conexion.Open();
                return cmd.ExecuteScalar();
            }
        }
        public static int Ejecutar(string sql, params SqlParameter[] parametros)
        {
            using (SqlConnection conexion = new ConexionBD().ObtenerConexion())
            using (SqlCommand cmd = new SqlCommand(sql, conexion))
            {
                if (parametros != null && parametros.Length > 0)
                {
                    cmd.Parameters.AddRange(parametros);
                }

                conexion.Open();
                return cmd.ExecuteNonQuery();
            }
        }

        // Inserta un registro "padre" (ej: Personas) y, dentro de la misma transaccion,
        // un registro "hijo" que depende del identity recien generado (ej: Pacientes.IdPersona).
        // sqlPadre y sqlHijo deben terminar con "SELECT CAST(SCOPE_IDENTITY() AS INT);" para
        // que ExecuteScalar devuelva el id insertado. Si el segundo insert falla, se hace
        // rollback del primero tambien: no queda una Persona huerfana sin Paciente/Medico.
        public static int InsertarConDependencia(
            string sqlPadre,
            SqlParameter[] parametrosPadre,
            string sqlHijo,
            Func<int, SqlParameter[]> parametrosHijo)
        {
            using (SqlConnection cn = new ConexionBD().ObtenerConexion())
            {
                cn.Open();

                using (SqlTransaction tx = cn.BeginTransaction())
                {
                    try
                    {
                        int idPadre;
                        using (SqlCommand cmd = new SqlCommand(sqlPadre, cn, tx))
                        {
                            if (parametrosPadre != null && parametrosPadre.Length > 0)
                            {
                                cmd.Parameters.AddRange(parametrosPadre);
                            }

                            idPadre = Convert.ToInt32(cmd.ExecuteScalar());
                        }

                        int idHijo;
                        using (SqlCommand cmd = new SqlCommand(sqlHijo, cn, tx))
                        {
                            SqlParameter[] parametros = parametrosHijo(idPadre);

                            if (parametros != null && parametros.Length > 0)
                            {
                                cmd.Parameters.AddRange(parametros);
                            }

                            idHijo = Convert.ToInt32(cmd.ExecuteScalar());
                        }

                        tx.Commit();
                        return idHijo;
                    }
                    catch
                    {
                        tx.Rollback();
                        throw;
                    }
                }
            }
        }
    }
}
