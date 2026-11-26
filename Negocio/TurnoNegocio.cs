using System;
using Datos;
using Entidades;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Negocio
{
    public class TurnoNegocio
    {
        private readonly DaoTurno dao = new DaoTurno();

        public int ObtenerCantidadTurnos()
        {
            return dao.ObtenerCantidadRegistros();
        }

        public bool EsIdValido(int id)
        {
            return id > 0;
        }
    }
}
