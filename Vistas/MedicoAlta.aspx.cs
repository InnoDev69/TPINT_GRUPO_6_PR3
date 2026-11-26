using System;
using Negocio;
namespace Vistas
{
    public partial class MedicoAlta : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                CargarEspecialidades();
                CargarProvincias();
            }
        }
        private void CargarEspecialidades()
        {
            EspecialidadNegocio negocio = new EspecialidadNegocio();

            ddlEspecialidad.DataSource = negocio.Listar();
            ddlEspecialidad.DataTextField = "Descripcion";
            ddlEspecialidad.DataValueField = "IdEspecialidad";
            ddlEspecialidad.DataBind();
            ddlEspecialidad.Enabled = ddlEspecialidad.Items.Count > 1;
        }
        private void CargarProvincias()
        {
            ProvinciaNegocio negocio = new ProvinciaNegocio();
            ddlProvincia.DataSource = negocio.Listar();
            ddlProvincia.DataTextField = "NombreProvincia";
            ddlProvincia.DataValueField = "IdProvincia";
            ddlProvincia.DataBind();
        }
    }
}
