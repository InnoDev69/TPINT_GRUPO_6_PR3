using System;
using System.Collections.Generic;
using System.Data.SqlClient;
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

        public int BajaLogica(int id)
        {
            const string consulta = @"UPDATE Turnos
                               SET EstadoRegistro = 0
                               WHERE IdTurno = @IdTurno
                               AND EstadoRegistro = 1;";
            return AccesoDatos.Ejecutar(consulta, new SqlParameter("@IdTurno", id));
        }
    }
}
