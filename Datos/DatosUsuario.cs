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
            string consulta = @"SELECT u.IdUsuario, u.NombreUsuario, u.IdRol, u.IdPersona,
                                        p.Nombre, p.Apellido, r.Descripcion AS Rol
                                FROM Usuarios u
                                INNER JOIN Personas p ON p.IdPersona = u.IdPersona
                                INNER JOIN Roles r ON r.IdRol = u.IdRol
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
                Rol = dr["Rol"].ToString(),
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