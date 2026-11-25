using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Datos
{
    public class DaoTurno
    {
        public int ObtenerCantidadRegistros()
        {
            const string sql = "SELECT COUNT(*) FROM Turnos WHERE EstadoRegistro = 1;";
            return Convert.ToInt32(AccesoDatos.Escalar(sql));
        }
    }
}
