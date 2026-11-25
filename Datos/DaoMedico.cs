using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Datos
{
    public class DaoMedico
    {
        public int ObtenerCantidadRegistros()
        {
            const string sql = "SELECT COUNT(*) FROM Medicos WHERE EstadoRegistro = 1;";
            return Convert.ToInt32(AccesoDatos.Escalar(sql));
        }
    }
}
