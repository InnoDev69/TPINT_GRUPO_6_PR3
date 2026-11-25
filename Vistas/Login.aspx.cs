using System;
using System.Web.UI;
using Entidades;
using Negocio;

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

            UsuarioNegocio negocio = new UsuarioNegocio();
            Usuarios usuarioValidado = negocio.ValidarLogin(usuario, contrasenia);

            if (usuarioValidado == null)
            {
                pnlError.Visible = true;
                return;
            }

            Session["Usuario"] = usuarioValidado.NombreUsuario;
            Session["Nombre"] = usuarioValidado.Persona.Nombre + " " + usuarioValidado.Persona.Apellido;
            Session["Rol"] = usuarioValidado.Rol;
            Session["IdPersona"] = usuarioValidado.IdPersona;

            Response.Redirect("~/Default.aspx", false);
            Context.ApplicationInstance.CompleteRequest();
        }
    }
}