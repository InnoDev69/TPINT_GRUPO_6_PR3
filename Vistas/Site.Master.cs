using System;
using System.IO;
using System.Web.UI;

namespace Vistas
{
    public partial class SiteMaster : MasterPage
    {
        protected string NombreUsuario = string.Empty;
        protected string RolUsuario = string.Empty;
        protected string Iniciales = "SR";
        protected bool EsMedico;

        protected void Page_Load(object sender, EventArgs e)
        {
            CargarSesion();
        }

        private void CargarSesion()
        {
            // Verificar si el usuario ha iniciado sesion
            // Ya no hardcodeamos nada, deberian de tener la bd ya
            if (Session["Usuario"] != null && Session["Nombre"] != null && Session["Rol"] != null)
            {
                NombreUsuario = Convert.ToString(Session["Nombre"]);
                RolUsuario = Convert.ToString(Session["Rol"]);
                EsMedico = RolUsuario.StartsWith("Med", StringComparison.OrdinalIgnoreCase)
                    || RolUsuario.StartsWith("Méd", StringComparison.OrdinalIgnoreCase);
                Iniciales = ObtenerIniciales(NombreUsuario);
            }
            else
            {
                // Si no hay usuario en sesion, redirige al login
                Response.Redirect("~/Login.aspx", false);
                Context.ApplicationInstance.CompleteRequest();
            }
        }

        protected string Activo(params string[] paginas)
        {
            // Esta funcion devuelve "activo" si la pagina actual coincide con alguna de las paginas pasadas como parametro.
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
            // Esta funcion devuelve las iniciales del nombre completo. Si el nombre es nulo o vacio, devuelve "SR".
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
