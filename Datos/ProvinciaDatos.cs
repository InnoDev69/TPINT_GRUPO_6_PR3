using System;
using System.Collections.Generic;
using Entidades;

namespace Datos
{
    public class ProvinciaDatos
    {
        public List<Provincia> Listar()
        {
            const string sql = @"
                SELECT  IdProvincia,
                        NombreProvincia AS Provincia
                FROM    Provincias
                ORDER BY NombreProvincia;";

            return AccesoDatos.Listar(sql, dr => new Provincia
            {
                IdProvincia = Convert.ToInt32(dr["IdProvincia"]),
                NombreProvincia = dr["Provincia"].ToString()
            });
        }
    }
}