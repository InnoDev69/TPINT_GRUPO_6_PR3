using System.Collections.Generic;
using Datos;
using Entidades;
namespace Negocio
{   public class EspecialidadNegocio
    {
        private readonly EspecialidadDatos datos = new EspecialidadDatos();
        public List<Especialidad> Listar()
        {
            return datos.Listar();
        }
    }
}
