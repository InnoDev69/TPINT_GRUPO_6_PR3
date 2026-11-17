using System;
using System.Web.UI;

namespace Vistas
{
    public partial class Login : Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                if (Request.QueryString["salir"] == "1")
                {
                    Session.Clear();
                    Session.Abandon();
                }

                pnlError.Visible = false;
            }
        }

        protected void btnIngresar_Click(object sender, EventArgs e)
        {
            if (!Page.IsValid)
            {
                return;
            }

            string usuario = txtUsuario.Text.Trim();
            string contrasenia = txtContrasenia.Text;

            // TODO: reemplazar por la validación real contra SQL Server
            // (capa de negocio / acceso a datos del proyecto).
            string nombre;
            string rol;

            if (!ValidarCredenciales(usuario, contrasenia, out nombre, out rol))
            {
                pnlError.Visible = true;
                return;
            }

            Session["Usuario"] = usuario;
            Session["Nombre"] = nombre;
            Session["Rol"] = rol;

            Response.Redirect("~/Default.aspx", false);
            Context.ApplicationInstance.CompleteRequest();
        }

        private bool ValidarCredenciales(string usuario, string contrasenia, out string nombre, out string rol)
        {
            // Credenciales de demostración para recorrer la maqueta mientras
            // la validación real se conecta con la capa de negocio.
            if (usuario == "admin" && contrasenia == "admin123")
            {
                nombre = "Laura Benitez";
                rol = "Administrador";
                return true;
            }

            if (usuario == "mgomez" && contrasenia == "medico123")
            {
                nombre = "Martin Gomez";
                rol = "Medico";
                return true;
            }

            if (usuario == "lfernandez" && contrasenia == "medico123")
            {
                nombre = "Luis Fernandez";
                rol = "Medico";
                return true;
            }

            nombre = null;
            rol = null;
            return false;
        }
    }
}
