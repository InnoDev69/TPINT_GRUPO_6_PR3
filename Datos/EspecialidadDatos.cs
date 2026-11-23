using System;
using System.Collections.Generic;
using Entidades;

namespace Datos
{
    public class EspecialidadDatos
    {
        public List<Especialidad> Listar()
        {
            const string sql = @"
                SELECT  IdEspecialidad,
                        Descripcion
                FROM    Especialidades
                WHERE   EstadoRegistro = 1
                ORDER BY Descripcion;";

            return AccesoDatos.Listar(sql, dr => new Especialidad
            {
                IdEspecialidad = Convert.ToInt32(dr["IdEspecialidad"]),
                Descripcion = dr["Descripcion"].ToString()
            });
        }
    }
}