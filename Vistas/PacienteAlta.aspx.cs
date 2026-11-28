using Entidades;
using Negocio;
using System;
using System.Web.UI.WebControls;

namespace Vistas
{
    public partial class PacienteAlta : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                CargarProvincias();
                ResetearLocalidades();
            }
        }

        private void CargarProvincias()
        {
            ProvinciaNegocio negocio = new ProvinciaNegocio();

            ddlProvincia.DataSource = negocio.Listar();
            ddlProvincia.DataTextField = "NombreProvincia";
            ddlProvincia.DataValueField = "IdProvincia";
            ddlProvincia.DataBind();
        }

        private void ResetearLocalidades()
        {
            ddlLocalidad.Items.Clear();
            ddlLocalidad.Items.Add(new ListItem("Seleccione una localidad", ""));
        }

        private void CargarLocalidades(int idProvincia)
        {
            LocalidadNegocio negocio = new LocalidadNegocio();

            ddlLocalidad.DataSource = negocio.ObtenerPorProvincia(idProvincia);
            ddlLocalidad.DataTextField = "NombreLocalidad";
            ddlLocalidad.DataValueField = "IdLocalidad";
            ddlLocalidad.DataBind();
            ddlLocalidad.Items.Insert(0, new ListItem("Seleccione una localidad", ""));
        }

        protected void ddlProvincia_SelectedIndexChanged(object sender, EventArgs e)
        {
            int.TryParse(ddlProvincia.SelectedValue, out int idProvincia);
            CargarLocalidades(idProvincia);
        }

        protected void btnGuardar_Click(object sender, EventArgs e)
        {
            pnlAvisoOk.Visible = false;
            pnlAvisoError.Visible = false;

            if (!Page.IsValid)
            {
                return;
            }

            Persona persona = new Persona
            {
                DNI = txtDni.Text.Trim(),
                Nombre = txtNombre.Text.Trim(),
                Apellido = txtApellido.Text.Trim(),
                Sexo = Convert.ToChar(ddlSexo.SelectedValue),
                Nacionalidad = ddlNacionalidad.SelectedValue,
                FechaNacimiento = Convert.ToDateTime(txtFechaNacimiento.Text),
                Direccion = txtDireccion.Text.Trim(),
                IdLocalidad = Convert.ToInt32(ddlLocalidad.SelectedValue),
                Email = txtEmail.Text.Trim(),
                Telefono = txtTelefono.Text.Trim()
            };

            try
            {
                PacienteNegocio negocio = new PacienteNegocio();
                negocio.Alta(persona);

                LimpiarFormulario();
                pnlAvisoOk.Visible = true;
            }
            catch (ArgumentException ex)
            {
                lblAvisoError.Text = ex.Message;
                pnlAvisoError.Visible = true;
            }
            catch (Exception)
            {
                lblAvisoError.Text = "No se pudo guardar el paciente. Intente nuevamente.";
                pnlAvisoError.Visible = true;
            }
        }

        private void LimpiarFormulario()
        {
            txtDni.Text = string.Empty;
            txtNombre.Text = string.Empty;
            txtApellido.Text = string.Empty;
            ddlSexo.SelectedIndex = 0;
            ddlNacionalidad.SelectedIndex = 0;
            txtFechaNacimiento.Text = string.Empty;
            ddlProvincia.SelectedIndex = 0;
            ResetearLocalidades();
            txtDireccion.Text = string.Empty;
            txtTelefono.Text = string.Empty;
            txtEmail.Text = string.Empty;
        }
    }
}
