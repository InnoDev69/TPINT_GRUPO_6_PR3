using System;
using System.Collections.Generic;
using Datos;
using Entidades;

namespace Negocio
{
    public class MedicoNegocio
    {
        private readonly MedicoDatos dao = new MedicoDatos();

        public int ObtenerCantidadRegistros()
        {
            return dao.ObtenerCantidadRegistros();
        }

        public List<MedicoListado> Listar(string texto, int idEspecialidad, int idDia)
        {
            return dao.Listar(texto, idEspecialidad, idDia);
        }

        public void DarDeBaja(string legajo)
        {
            if (string.IsNullOrWhiteSpace(legajo))
            {
                throw new ArgumentException("El legajo no puede estar vacío.", nameof(legajo));
            }

            dao.DarDeBaja(legajo);
        }
    }
}
