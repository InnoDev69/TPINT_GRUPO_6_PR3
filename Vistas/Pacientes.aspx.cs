using System;
using System.Collections.Generic;
using System.Web.UI.WebControls;
using Entidades;
using Negocio;

namespace Vistas
{
    public partial class Pacientes : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                CargarProvincias();
                MostrarCantRegistros();
                CargarGrilla();
            }
        }

        protected void ddlProvincia_SelectedIndexChanged(object sender, EventArgs e)
        {
            int.TryParse(ddlProvincia.SelectedValue, out int idProvincia);
            CargarLocalidades(idProvincia);
        }

        protected void btnBuscar_Click(object sender, EventArgs e)
        {
            gvPacientes.PageIndex = 0;
            CargarGrilla();
        }

        protected void btnLimpiar_Click(object sender, EventArgs e)
        {
            txtBuscar.Text = string.Empty;
            ddlProvincia.SelectedIndex = 0;
            CargarLocalidades(0);
            ddlSexo.SelectedIndex = 0;
            gvPacientes.PageIndex = 0;
            CargarGrilla();
        }

        protected void gvPacientes_PageIndexChanging(object sender, GridViewPageEventArgs e)
        {
            gvPacientes.PageIndex = e.NewPageIndex;
            CargarGrilla();
        }

        private void CargarProvincias()
        {
            ProvinciaNegocio negocio = new ProvinciaNegocio();

            ddlProvincia.DataSource = negocio.Listar();
            ddlProvincia.DataTextField = "NombreProvincia";
            ddlProvincia.DataValueField = "IdProvincia";
            ddlProvincia.DataBind();
        }

        private void MostrarCantRegistros()
        {
            PacienteNegocio negocio = new PacienteNegocio();
            lblRegistrosActivos.Text = negocio.getCantidadRegistros().ToString() + " registros activos";
        }

        private void CargarLocalidades(int idProvincia)
        {
            LocalidadNegocio negocio = new LocalidadNegocio();

            ddlLocalidad.Items.Clear();
            ddlLocalidad.DataSource = negocio.ObtenerPorProvincia(idProvincia);
            ddlLocalidad.DataTextField = "NombreLocalidad";
            ddlLocalidad.DataValueField = "IdLocalidad";
            ddlLocalidad.DataBind();
            ddlLocalidad.Items.Insert(0, new ListItem("Todas", "0"));
        }

        private void CargarGrilla()
        {
            int.TryParse(ddlProvincia.SelectedValue, out int idProvincia);
            int.TryParse(ddlLocalidad.SelectedValue, out int idLocalidad);

            PacienteNegocio negocio = new PacienteNegocio();
            List<PacienteListado> lista = negocio.Listar(txtBuscar.Text, idProvincia, idLocalidad, ddlSexo.SelectedValue);

            gvPacientes.DataSource = lista;
            gvPacientes.DataBind();

            lblResumen.Text = "Mostrando " + lista.Count + " de " + lista.Count + " registros";
        }
    }
}