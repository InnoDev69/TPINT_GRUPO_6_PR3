using System;
using System.Collections.Generic;
using System.Web.UI.WebControls;
using Entidades;
using Negocio;

namespace Vistas
{
    public partial class Medicos : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                CargarEspecialidades();
                CargarDias();
                MostrarCantRegistros();
                CargarGrilla();
            }
        }

        protected void btnBuscar_Click(object sender, EventArgs e)
        {
            gvMedicos.PageIndex = 0;
            CargarGrilla();
        }

        protected void btnLimpiar_Click(object sender, EventArgs e)
        {
            txtBuscar.Text = string.Empty;
            ddlEspecialidad.SelectedIndex = 0;
            ddlDia.SelectedIndex = 0;
            gvMedicos.PageIndex = 0;
            CargarGrilla();
        }

        protected void gvMedicos_PageIndexChanging(object sender, GridViewPageEventArgs e)
        {
            gvMedicos.PageIndex = e.NewPageIndex;
            CargarGrilla();
        }

        private void CargarEspecialidades()
        {
            EspecialidadNegocio negocio = new EspecialidadNegocio();

            ddlEspecialidad.DataSource = negocio.Listar();
            ddlEspecialidad.DataTextField = "Descripcion";
            ddlEspecialidad.DataValueField = "IdEspecialidad";
            ddlEspecialidad.DataBind();
        }

        private void CargarDias()
        {
            DiaAtencionNegocio negocio = new DiaAtencionNegocio();

            ddlDia.DataSource = negocio.Listar();
            ddlDia.DataTextField = "NombreDia";
            ddlDia.DataValueField = "IdDia";
            ddlDia.DataBind();
        }

        private void MostrarCantRegistros()
        {
            MedicoNegocio negocio = new MedicoNegocio();
            lblRegistrosActivos.Text = negocio.ObtenerCantidadRegistros().ToString() + " registros activos";
        }

        private void CargarGrilla()
        {
            int.TryParse(ddlEspecialidad.SelectedValue, out int idEspecialidad);
            int.TryParse(ddlDia.SelectedValue, out int idDia);

            MedicoNegocio negocio = new MedicoNegocio();
            List<MedicoListado> lista = negocio.Listar(txtBuscar.Text, idEspecialidad, idDia);

            gvMedicos.DataSource = lista;
            gvMedicos.DataBind();

            lblResumen.Text = "Mostrando " + lista.Count + " de " + lista.Count + " registros";
        }

        protected void gvMedicos_RowCommand(object sender, GridViewCommandEventArgs e)
        {
            if (e.CommandName == "Eliminar")
            {
                string legajo = e.CommandArgument.ToString();

                if (string.IsNullOrWhiteSpace(legajo))
                {
                    return;
                }

                GridViewRow fila = (GridViewRow)((LinkButton)e.CommandSource).NamingContainer;

                hfLegajoBaja.Value = legajo;
                lblLegajoBaja.Text = legajo;
                lblNombreBaja.Text = fila.Cells[1].Text;
                pnlConfirmarBaja.Visible = true;
            }
        }

        protected void btnCancelarBaja_Click(object sender, EventArgs e)
        {
            hfLegajoBaja.Value = string.Empty;
            lblLegajoBaja.Text = string.Empty;
            lblNombreBaja.Text = string.Empty;
            pnlConfirmarBaja.Visible = false;
        }

        protected void btnConfirmarBaja_Click(object sender, EventArgs e)
        {
            string legajo = hfLegajoBaja.Value;

            if (string.IsNullOrWhiteSpace(legajo))
            {
                pnlConfirmarBaja.Visible = false;
                return;
            }

            try
            {
                MedicoNegocio negocio = new MedicoNegocio();
                negocio.DarDeBaja(legajo);

                pnlConfirmarBaja.Visible = false;
                pnlAvisoOk.CssClass = "aviso aviso-ok";
                lblAviso.Text = "El médico se dio de baja correctamente y ya no aparece en el listado.";
                pnlAvisoOk.Visible = true;

                MostrarCantRegistros();
                gvMedicos.PageIndex = 0;
                CargarGrilla();
            }
            catch (Exception)
            {
                pnlConfirmarBaja.Visible = false;
                pnlAvisoOk.CssClass = "aviso aviso-error";
                lblAviso.Text = "No se pudo dar de baja el médico.";
                pnlAvisoOk.Visible = true;
            }
        }
    }
}
