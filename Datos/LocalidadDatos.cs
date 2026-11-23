using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using Entidades;

namespace Datos
{
    public class LocalidadDatos
    {
        public List<Localidad> ListarPorProvincia(int idProvincia)
        {
            const string sql = @"
                SELECT  IdLocalidad,
                        NombreLocalidad AS Localidad,
                        IdProvincia
                FROM    Localidades
                WHERE   IdProvincia = @idProvincia
                ORDER BY NombreLocalidad;";

            return AccesoDatos.Listar(sql, dr => new Localidad
            {
                IdLocalidad = Convert.ToInt32(dr["IdLocalidad"]),
                NombreLocalidad = dr["Localidad"].ToString(),
                IdProvincia = Convert.ToInt32(dr["IdProvincia"])
            }, new SqlParameter("@idProvincia", SqlDbType.Int) { Value = idProvincia });
        }
    }
}