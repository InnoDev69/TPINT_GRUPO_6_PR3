using System;
using System.IO;
using System.Web.UI;

namespace Vistas
{
    public partial class SiteMaster : MasterPage
    {
        protected string NombreUsuario = "Laura Benitez";
        protected string RolUsuario = "Administrador";
        protected string Iniciales = "LB";
        protected bool EsMedico;

        protected void Page_Load(object sender, EventArgs e)
        {
            CargarSesion();
        }

        private void CargarSesion()
        {
            // Mientras el login no valide contra la base, las páginas se pueden
            // abrir directamente con un usuario de demostración.
            if (Session["Nombre"] == null || Session["Rol"] == null)
            {
                string actual = Path.GetFileName(Request.AppRelativeCurrentExecutionFilePath);

                if (string.Equals(actual, "MisTurnos.aspx", StringComparison.OrdinalIgnoreCase)
                    || string.Equals(actual, "MisPacientes.aspx", StringComparison.OrdinalIgnoreCase))
                {
                    Session["Usuario"] = "mgomez";
                    Session["Nombre"] = "Martin Gomez";
                    Session["Rol"] = "Medico";
                }
                else
                {
                    Session["Usuario"] = "admin";
                    Session["Nombre"] = "Laura Benitez";
                    Session["Rol"] = "Administrador";
                }
            }

            NombreUsuario = Convert.ToString(Session["Nombre"]);
            RolUsuario = Convert.ToString(Session["Rol"]);
            EsMedico = RolUsuario.StartsWith("Med", StringComparison.OrdinalIgnoreCase)
                || RolUsuario.StartsWith("Méd", StringComparison.OrdinalIgnoreCase);
            Iniciales = ObtenerIniciales(NombreUsuario);
        }

        protected string Activo(params string[] paginas)
        {
            string actual = Path.GetFileName(Request.AppRelativeCurrentExecutionFilePath);

            foreach (string pagina in paginas)
            {
                if (string.Equals(actual, pagina, StringComparison.OrdinalIgnoreCase))
                {
                    return "activo";
                }
            }

            return string.Empty;
        }

        private static string ObtenerIniciales(string nombre)
        {
            if (string.IsNullOrWhiteSpace(nombre))
            {
                return "SR";
            }

            string[] partes = nombre.Trim().Split(new[] { ' ' }, StringSplitOptions.RemoveEmptyEntries);

            if (partes.Length == 1)
            {
                return partes[0].Substring(0, 1).ToUpperInvariant();
            }

            return (partes[0].Substring(0, 1) + partes[partes.Length - 1].Substring(0, 1)).ToUpperInvariant();
        }
    }
}
