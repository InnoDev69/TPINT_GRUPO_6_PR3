using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Entidades
{
    public class Usuarios
    {
        public int IdUsuario { get; set; }
        public string NombreUsuario { get; set; }
        public string Clave { get; set; }
        public int IdRol { get; set; }
        public int IdPersona { get; set; }
        public bool EstadoRegistro { get; set; }

        // Esto es la descripcion del rol (Administrador / Medico) obtenida de la tabla Roles,
        // para no hardcodear el mapeo IdRol -> texto en la capa de Vistas.
        public string Rol { get; set; }

        public Persona Persona { get; set; }
    }
}