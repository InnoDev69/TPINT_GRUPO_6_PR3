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
            bool credencialesValidas = ValidarCredenciales(usuario, contrasenia);

            if (!credencialesValidas)
            {
                pnlError.Visible = true;
                return;
            }

            Session["Usuario"] = usuario;
            Response.Redirect("~/Default.aspx", false);
            Context.ApplicationInstance.CompleteRequest();
        }

        private bool ValidarCredenciales(string usuario, string contrasenia)
        {
            // Placeholder: siempre falla hasta conectar con la base de datos.
            return false;
        }
    }
}
