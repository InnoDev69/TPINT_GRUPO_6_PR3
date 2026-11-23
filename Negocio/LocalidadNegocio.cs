using System.Collections.Generic;
using Datos;
using Entidades;

namespace Negocio
{
    public class LocalidadNegocio
    {
        private readonly LocalidadDatos datos = new LocalidadDatos();

        // Regla: sin provincia elegida no se consulta la base.
        public List<Localidad> ObtenerPorProvincia(int idProvincia)
        {
            if (idProvincia <= 0)
            {
                return new List<Localidad>();
            }

            return datos.ListarPorProvincia(idProvincia);
        }
    }
}