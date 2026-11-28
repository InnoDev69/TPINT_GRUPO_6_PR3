<%@ Page Title="Alta de paciente - Clínica San Rafael" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="PacienteAlta.aspx.cs" Inherits="Vistas.PacienteAlta" %>

<asp:Content ID="Content1" ContentPlaceHolderID="Contenido" runat="server">

    <div class="migas"><a href="Default.aspx">Inicio</a> / <a href="Pacientes.aspx">Gestión de pacientes</a> / Alta de paciente</div>

    <div class="titulo-pagina">
        <div>
            <h1>Alta de paciente</h1>
            <p>Registro de un nuevo paciente en el sistema.</p>
        </div>
        <div class="botones">
            <asp:HyperLink ID="lnkVolver" runat="server" CssClass="btn btn-secundario" NavigateUrl="Pacientes.aspx" Text="Volver al listado" />
        </div>
    </div>

    <asp:Panel ID="pnlAvisoOk" runat="server" CssClass="aviso aviso-ok" Visible="false" role="status">
        <span aria-hidden="true">&#10003;</span>
        <div>El paciente se agregó correctamente en la base de datos.</div>
    </asp:Panel>

    <asp:Panel ID="pnlAvisoError" runat="server" CssClass="aviso aviso-error" Visible="false" role="alert">
        <span aria-hidden="true">!</span>
        <div>
            <asp:Label ID="lblAvisoError" runat="server" />
        </div>
    </asp:Panel>

    <div class="tarjeta">
        <div class="tarjeta-cab">
            <h2>Alta de paciente</h2>
            <span class="nota">Los campos con * son obligatorios</span>
        </div>

        <div class="tarjeta-cuerpo">
            <div class="fila">
                <div class="campo">
                    <asp:Label ID="lblDni" runat="server" AssociatedControlID="txtDni">DNI <span class="req">*</span></asp:Label>
                    <asp:TextBox ID="txtDni" runat="server" MaxLength="8" placeholder="Sin puntos" />
                    <asp:RequiredFieldValidator ID="rfvDni" runat="server" ControlToValidate="txtDni"
                        ValidationGroup="paciente" Display="Dynamic" CssClass="error-campo"
                        ErrorMessage="Ingrese el DNI." />
                    <asp:RegularExpressionValidator ID="revDni" runat="server" ControlToValidate="txtDni"
                        ValidationGroup="paciente" Display="Dynamic" CssClass="error-campo"
                        ValidationExpression="^\d{7,8}$"
                        ErrorMessage="El DNI debe tener 7 u 8 números, sin puntos." />
                </div>
                <div class="campo">
                    <asp:Label ID="lblNombre" runat="server" AssociatedControlID="txtNombre">Nombre <span class="req">*</span></asp:Label>
                    <asp:TextBox ID="txtNombre" runat="server" MaxLength="50" placeholder="Nombre" />
                    <asp:RequiredFieldValidator ID="rfvNombre" runat="server" ControlToValidate="txtNombre"
                        ValidationGroup="paciente" Display="Dynamic" CssClass="error-campo"
                        ErrorMessage="Ingrese el nombre." />
                    <asp:RegularExpressionValidator ID="revNombre" runat="server" ControlToValidate="txtNombre"
                        ValidationGroup="paciente" Display="Dynamic" CssClass="error-campo"
                        ValidationExpression="^[A-Za-zÁÉÍÓÚÜáéíóúüÑñ ]+$"
                        ErrorMessage="El nombre solo puede contener letras." />
                </div>
                <div class="campo">
                    <asp:Label ID="lblApellido" runat="server" AssociatedControlID="txtApellido">Apellido <span class="req">*</span></asp:Label>
                    <asp:TextBox ID="txtApellido" runat="server" MaxLength="50" placeholder="Apellido" />
                    <asp:RequiredFieldValidator ID="rfvApellido" runat="server" ControlToValidate="txtApellido"
                        ValidationGroup="paciente" Display="Dynamic" CssClass="error-campo"
                        ErrorMessage="Ingrese el apellido." />
                    <asp:RegularExpressionValidator ID="revApellido" runat="server" ControlToValidate="txtApellido"
                        ValidationGroup="paciente" Display="Dynamic" CssClass="error-campo"
                        ValidationExpression="^[A-Za-zÁÉÍÓÚÜáéíóúüÑñ ]+$"
                        ErrorMessage="El apellido solo puede contener letras." />
                </div>
            </div>

            <div class="fila">
                <div class="campo">
                    <asp:Label ID="lblSexo" runat="server" AssociatedControlID="ddlSexo">Sexo <span class="req">*</span></asp:Label>
                    <asp:DropDownList ID="ddlSexo" runat="server">
                        <asp:ListItem Text="Seleccione..." Value="" />
                        <asp:ListItem Text="Femenino" Value="F" />
                        <asp:ListItem Text="Masculino" Value="M" />
                        <asp:ListItem Text="Otro" Value="O" />
                    </asp:DropDownList>
                    <asp:RequiredFieldValidator ID="rfvSexo" runat="server" ControlToValidate="ddlSexo"
                        InitialValue="" ValidationGroup="paciente" Display="Dynamic" CssClass="error-campo"
                        ErrorMessage="Seleccione el sexo." />
                </div>
                <div class="campo">
                    <asp:Label ID="lblNacionalidad" runat="server" AssociatedControlID="ddlNacionalidad">Nacionalidad <span class="req">*</span></asp:Label>
                    <asp:DropDownList ID="ddlNacionalidad" runat="server">
                        <asp:ListItem Text="Seleccione una nacionalidad" Value="" />
                        <asp:ListItem Text="Argentina" Value="Argentina" />
                        <asp:ListItem Text="Boliviana" Value="Boliviana" />
                        <asp:ListItem Text="Chilena" Value="Chilena" />
                        <asp:ListItem Text="Paraguaya" Value="Paraguaya" />
                        <asp:ListItem Text="Uruguaya" Value="Uruguaya" />
                    </asp:DropDownList>
                    <asp:RequiredFieldValidator ID="rfvNacionalidad" runat="server" ControlToValidate="ddlNacionalidad"
                        InitialValue="" ValidationGroup="paciente" Display="Dynamic" CssClass="error-campo"
                        ErrorMessage="Seleccione la nacionalidad." />
                </div>
                <div class="campo">
                    <asp:Label ID="lblFechaNacimiento" runat="server" AssociatedControlID="txtFechaNacimiento">Fecha de nacimiento <span class="req">*</span></asp:Label>
                    <asp:TextBox ID="txtFechaNacimiento" runat="server" TextMode="Date" />
                    <asp:RequiredFieldValidator ID="rfvFechaNacimiento" runat="server" ControlToValidate="txtFechaNacimiento"
                        ValidationGroup="paciente" Display="Dynamic" CssClass="error-campo"
                        ErrorMessage="Ingrese la fecha de nacimiento." />
                </div>
            </div>

            <div class="fila">
                <div class="campo">
                    <asp:Label ID="lblProvincia" runat="server" AssociatedControlID="ddlProvincia">Provincia <span class="req">*</span></asp:Label>
                    <asp:DropDownList ID="ddlProvincia" runat="server" AppendDataBoundItems="true" AutoPostBack="true" OnSelectedIndexChanged="ddlProvincia_SelectedIndexChanged">
                        <asp:ListItem Text="Seleccione una provincia" Value="" />
                    </asp:DropDownList>
                    <asp:RequiredFieldValidator ID="rfvProvincia" runat="server" ControlToValidate="ddlProvincia"
                        InitialValue="" ValidationGroup="paciente" Display="Dynamic" CssClass="error-campo"
                        ErrorMessage="Seleccione la provincia." />
                </div>
                <div class="campo">
                    <asp:Label ID="lblLocalidad" runat="server" AssociatedControlID="ddlLocalidad">Localidad <span class="req">*</span></asp:Label>
                    <asp:DropDownList ID="ddlLocalidad" runat="server" AppendDataBoundItems="true">
                        <asp:ListItem Text="Seleccione una localidad" Value="" />
                    </asp:DropDownList>
                    <asp:RequiredFieldValidator ID="rfvLocalidad" runat="server" ControlToValidate="ddlLocalidad"
                        InitialValue="" ValidationGroup="paciente" Display="Dynamic" CssClass="error-campo"
                        ErrorMessage="Seleccione la localidad." />
                </div>
                <div class="campo">
                    <asp:Label ID="lblDireccion" runat="server" AssociatedControlID="txtDireccion">Dirección <span class="req">*</span></asp:Label>
                    <asp:TextBox ID="txtDireccion" runat="server" MaxLength="120" />
                    <asp:RequiredFieldValidator ID="rfvDireccion" runat="server" ControlToValidate="txtDireccion"
                        ValidationGroup="paciente" Display="Dynamic" CssClass="error-campo"
                        ErrorMessage="Ingrese la dirección." />
                </div>
            </div>

            <div class="fila">
                <div class="campo">
                    <asp:Label ID="lblTelefono" runat="server" AssociatedControlID="txtTelefono">Teléfono <span class="req">*</span></asp:Label>
                    <asp:TextBox ID="txtTelefono" runat="server" TextMode="Phone" MaxLength="30" placeholder="11-0000-0000" />
                    <asp:RequiredFieldValidator ID="rfvTelefono" runat="server" ControlToValidate="txtTelefono"
                        ValidationGroup="paciente" Display="Dynamic" CssClass="error-campo"
                        ErrorMessage="Ingrese el teléfono." />
                    <asp:RegularExpressionValidator ID="revTelefono" runat="server" ControlToValidate="txtTelefono"
                        ValidationGroup="paciente" Display="Dynamic" CssClass="error-campo"
                        ValidationExpression="^\d{8,15}$"
                        ErrorMessage="El teléfono solo puede contener números." />
                </div>
                <div class="campo">
                    <asp:Label ID="lblEmail" runat="server" AssociatedControlID="txtEmail">Correo electrónico <span class="req">*</span></asp:Label>
                    <asp:TextBox ID="txtEmail" runat="server" TextMode="Email" MaxLength="120" placeholder="correo@dominio.com" />
                    <asp:RequiredFieldValidator ID="rfvEmail" runat="server" ControlToValidate="txtEmail"
                        ValidationGroup="paciente" Display="Dynamic" CssClass="error-campo"
                        ErrorMessage="Ingrese el correo electrónico." />
                    <asp:RegularExpressionValidator ID="revEmail" runat="server" ControlToValidate="txtEmail"
                        ValidationGroup="paciente" Display="Dynamic" CssClass="error-campo"
                        ValidationExpression="^[^@\s]+@[^@\s]+\.[^@\s]+$"
                        ErrorMessage="Ingrese un correo electrónico válido." />
                </div>
            </div>

            <div class="botones">
                <asp:Button ID="btnGuardar" runat="server" Text="Guardar paciente" CssClass="btn btn-primario"
                    ValidationGroup="paciente" OnClick="btnGuardar_Click" />
                <asp:HyperLink ID="lnkCancelar" runat="server" CssClass="btn btn-secundario" NavigateUrl="Pacientes.aspx" Text="Cancelar" />
                <span class="nota ayuda">Los datos se validan antes de guardar en la base de datos.</span>
            </div>
        </div>
    </div>

</asp:Content>
