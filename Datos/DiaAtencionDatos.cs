using System;
using System.Collections.Generic;
using Entidades;

namespace Datos
{
    public class DiaAtencionDatos
    {
        public List<DiaAtencion> Listar()
        {
            const string sql = @"
                SELECT  IdDia,
                        NombreDia
                FROM    DiasAtencion
                ORDER BY IdDia;";

            return AccesoDatos.Listar(sql, dr => new DiaAtencion
            {
                IdDia = Convert.ToInt32(dr["IdDia"]),
                NombreDia = dr["NombreDia"].ToString()
            });
        }
    }
}
