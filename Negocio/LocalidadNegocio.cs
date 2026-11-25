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
        public List<Localidad> BuscarPorNombre(int idProvincia, string texto)
        {
            if (idProvincia <= 0 || string.IsNullOrWhiteSpace(texto))
            {
                return new List<Localidad>();
            }

            string filtro = texto.Trim().ToLower();
            List<Localidad> localidades = datos.ListarPorProvincia(idProvincia);
            List<Localidad> resultado = new List<Localidad>();

            foreach (Localidad loc in localidades)
            {
                if (!string.IsNullOrEmpty(loc.NombreLocalidad) && loc.NombreLocalidad.ToLower().Contains(filtro))
                {
                    resultado.Add(loc);
                }
            }

            return resultado;
        }

        // Regla: comprobar si una localidad pertenece a una provincia válida.
        public bool ExisteEnProvincia(int idProvincia, int idLocalidad)
        {
            if (idProvincia <= 0 || idLocalidad <= 0)
            {
                return false;
            }

            List<Localidad> localidades = datos.ListarPorProvincia(idProvincia);

            foreach (Localidad loc in localidades)
            {
                if (loc.IdLocalidad == idLocalidad)
                {
                    return true;
                }
            }

            return false;
        }
    }

}