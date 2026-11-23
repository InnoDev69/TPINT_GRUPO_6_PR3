using System.Data.SqlClient;

namespace Vistas.Datos
{
    public class ConexionBD
    {
        private string cadenaConexion = "Data Source=localhost\\sqlexpress; Initial Catalog=ClinicaDB; Integrated Security=True";

        public SqlConnection ObtenerConexion()
        {
            return new SqlConnection(cadenaConexion);
        }
    }
}
