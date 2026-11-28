using Negocio;
using System;
using System.Web.UI.WebControls;
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
        protected void ddlProvincia_SelectedIndexChanged(object sender, EventArgs e)
        {
            CargarLocalidades();
        }

        private void ResetearLocalidades()
        {
            ddlLocalidad.Items.Clear();
            ddlLocalidad.Items.Add(new ListItem("Seleccione...", "0"));
            ddlLocalidad.SelectedIndex = 0;
            ddlLocalidad.Enabled = false;
        }

        private void CargarLocalidades()
        {
            ResetearLocalidades();

            if (!int.TryParse(ddlProvincia.SelectedValue, out int idProvincia) || idProvincia <= 0)
            {
                return;
            }

            LocalidadNegocio negocio = new LocalidadNegocio();
            ddlLocalidad.DataSource = negocio.ObtenerPorProvincia(idProvincia);
            ddlLocalidad.DataTextField = "NombreLocalidad";
            ddlLocalidad.DataValueField = "IdLocalidad";
            ddlLocalidad.DataBind();
            ddlLocalidad.Enabled = ddlLocalidad.Items.Count > 1;
        }

        protected void btnGuardar_Click(object sender, EventArgs e)
        {
            if (ddlEspecialidad.SelectedValue == "0" ||
                ddlProvincia.SelectedValue == "0" ||
                !ddlLocalidad.Enabled ||
                ddlLocalidad.SelectedValue == "0")
            {
                return;
            }
        }
    }
}
