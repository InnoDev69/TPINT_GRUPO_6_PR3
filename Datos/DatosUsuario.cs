using Entidades;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Data.SqlClient;

namespace Datos
{
    public class DatosUsuario
    {
        public Usuarios ValidarLogin(string nombreUsuario, string clave)
        {
            string consulta = @"SELECT u.IdUsuario, u.NombreUsuario, u.IdROl, u.IdPersona, p.Nombre, p.Apellido
                                FROM Usuario u
                                INNER JOIN Persona p ON p.IdPersona = u.IdPersona
                                WHERE u.NombreUsuario = @nombreUsuario 
                                AND u.Clave = @clave
                                AND u.EstadoRegistro = 1
                                AND p.EstadoRegistro = 1";
            List<Usuarios> lista = AccesoDatos.Listar<Usuarios>(consulta, dr => new Usuarios
            {
                IdUsuario = Convert.ToInt32(dr["IdUsuario"]),
                NombreUsuario = dr["NombreUsuario"].ToString(),
                IdRol = Convert.ToInt32(dr["IdRol"]),
                IdPersona = Convert.ToInt32(dr["IdPersona"]),
                Persona = new Persona
                {
                    Nombre = dr["Nombre"].ToString(),
                    Apellido = dr["Apellido"].ToString()
                },
            },
            new SqlParameter("@nombreUsuario", nombreUsuario),
            new SqlParameter("@clave", clave)

            );
            return lista.FirstOrDefault();
        }
    }
}
