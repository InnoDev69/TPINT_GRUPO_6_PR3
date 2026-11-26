using System.Collections.Generic;
using Datos;
using Entidades;

namespace Negocio
{
    public class DiaAtencionNegocio
    {
        private readonly DiaAtencionDatos datos = new DiaAtencionDatos();

        public List<DiaAtencion> Listar()
        {
            return datos.Listar();
        }
    }
}
