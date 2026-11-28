using Entidades;
using Negocio;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace Vistas
{
    public partial class PacienteModificar : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                string dni = Request.QueryString["dni"];
                
                CargarProvincias();
                CargarPaciente(dni);
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

        private void CargarLocalidades(int idProvincia)
        {
            LocalidadNegocio negocio = new LocalidadNegocio();

            ddlLocalidad.DataSource = negocio.ObtenerPorProvincia(idProvincia);
            ddlLocalidad.DataTextField = "NombreLocalidad";
            ddlLocalidad.DataValueField = "IdLocalidad";
            ddlLocalidad.DataBind();
        }


        protected void ddlProvincia_SelectedIndexChanged(object sender, EventArgs e)
        {
            CargarLocalidades(Convert.ToInt32(ddlProvincia.SelectedValue));
        }

        protected void btnGuardar_Click(object sender, EventArgs e)
        {
            if (!Page.IsValid) return;

        }

        private void CargarPaciente(string dni)
        {           
            PacienteNegocio pacienteNegocio = new PacienteNegocio();
            Persona p = pacienteNegocio.ObtenerPorDni(dni);

            LocalidadNegocio localidadNegocio = new LocalidadNegocio();
            Localidad localidad = localidadNegocio.ObtenerPorId(p.IdLocalidad);
           
            ddlProvincia.SelectedValue = localidad.IdProvincia.ToString();
            CargarLocalidades(localidad.IdProvincia);
            ddlLocalidad.SelectedValue = p.IdLocalidad.ToString();            
                                
            txtDni.Text = p.DNI;
            txtNombre.Text = p.Nombre;
            txtApellido.Text = p.Apellido;
            ddlSexo.SelectedValue = p.Sexo.ToString();
            ddlNacionalidad.SelectedValue = p.Nacionalidad;
            txtFechaNacimiento.Text = p.FechaNacimiento.ToString("yyyy-MM-dd");
            txtDireccion.Text = p.Direccion;
            txtTelefono.Text = p.Telefono;
            txtEmail.Text = p.Email;
            
        }

        
    }
}