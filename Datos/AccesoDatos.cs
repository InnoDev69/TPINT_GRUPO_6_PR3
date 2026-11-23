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
    }
}