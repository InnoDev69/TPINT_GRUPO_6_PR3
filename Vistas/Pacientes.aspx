<%@ Page Title="Gestión de pacientes - Clínica San Rafael" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Pacientes.aspx.cs" Inherits="Vistas.Pacientes" %>

<asp:Content ID="Content1" ContentPlaceHolderID="Contenido" runat="server">

    <div class="migas"><a href="Default.aspx">Inicio</a> / Gestión de pacientes</div>

    <div class="titulo-pagina">
        <div>
            <h1>Gestión de pacientes</h1>
            <p>Alta, baja, modificación y listado de pacientes de la clínica.</p>
        </div>
        <div class="botones">
            <asp:HyperLink ID="lnkNuevoPaciente" runat="server" CssClass="btn btn-primario" NavigateUrl="PacienteAlta.aspx" Text="+ Nuevo paciente" />
        </div>
    </div>

    <%--*********--%>
    <asp:Panel ID="pnlAvisoOk" runat="server" CssClass="aviso aviso-ok" Visible="false">
        <span aria-hidden="true">&#10003;</span>
        <div>
            <asp:Label ID="lblAviso" runat="server" Text="El paciente se dio de baja correctamente y ya no aparece en el listado." />
        </div>
    </asp:Panel>

    <div class="tarjeta">
        <div class="tarjeta-cab">
            <h2>Pacientes registrados</h2>
            <asp:Label ID="lblRegistrosActivos" runat="server" CssClass="nota" />
        </div>

        <div class="filtros">
            <div class="fila">
                <div class="campo">
                    <asp:Label ID="lblBuscar" runat="server" AssociatedControlID="txtBuscar" Text="Buscar" />
                    <asp:TextBox ID="txtBuscar" runat="server" placeholder="DNI, nombre, apellido o correo..." />
                </div>
                <div class="campo">
                    <asp:Label ID="lblProvincia" runat="server" AssociatedControlID="ddlProvincia" Text="Provincia" />
                    <asp:DropDownList ID="ddlProvincia" runat="server" AppendDataBoundItems="true" AutoPostBack="true" OnSelectedIndexChanged="ddlProvincia_SelectedIndexChanged">
                        <asp:ListItem Text="Todas" Value="" />
                    </asp:DropDownList>
                </div>
                <div class="campo">
                    <asp:Label ID="lblLocalidad" runat="server" AssociatedControlID="ddlLocalidad" Text="Localidad" />
                    <asp:DropDownList ID="ddlLocalidad" runat="server" AppendDataBoundItems="true">
                        <asp:ListItem Text="Todas" Value="" />
                    </asp:DropDownList>
                </div>
                <div class="campo">
                    <asp:Label ID="lblSexo" runat="server" AssociatedControlID="ddlSexo" Text="Sexo" />
                    <asp:DropDownList ID="ddlSexo" runat="server">
                        <asp:ListItem Text="Todos" Value="" />
                        <asp:ListItem Text="Femenino" Value="Femenino" />
                        <asp:ListItem Text="Masculino" Value="Masculino" />
                        <asp:ListItem Text="Otro" Value="Otro" />
                    </asp:DropDownList>
                </div>
            </div>
            <div class="botones">
                <asp:Button ID="btnBuscar" runat="server" Text="Buscar" CssClass="btn btn-azul" OnClick="btnBuscar_Click" />
                <asp:Button ID="btnLimpiar" runat="server" Text="Limpiar" CssClass="btn btn-secundario" OnClick="btnLimpiar_Click" />
            </div>
        </div>

        <div class="tabla-scroll">
            <asp:GridView ID="gvPacientes" runat="server"
                AutoGenerateColumns="false"
                CssClass="grid"
                GridLines="None"
                UseAccessibleHeader="true"
                ShowHeaderWhenEmpty="true"
                EmptyDataText="No se encontraron registros."
                DataKeyNames="DNI"
                AllowPaging="true"
                OnPageIndexChanging="gvPacientes_PageIndexChanging"
                PageSize="8">
                <Columns>
                    <asp:BoundField DataField="DNI" HeaderText="DNI" ItemStyle-CssClass="principal" />
                    <asp:BoundField DataField="Paciente" HeaderText="Paciente" />
                    <asp:BoundField DataField="Sexo" HeaderText="Sexo" />
                    <asp:BoundField DataField="Localidad" HeaderText="Localidad" />
                    <asp:BoundField DataField="Provincia" HeaderText="Provincia" />
                    <asp:BoundField DataField="Telefono" HeaderText="Teléfono" />
                    <asp:BoundField DataField="Correo" HeaderText="Correo electrónico" />
                    <asp:TemplateField HeaderText="Acciones" HeaderStyle-CssClass="acciones" ItemStyle-CssClass="acciones">
                        <ItemTemplate>
                            <asp:HyperLink ID="lnkEditar" runat="server" CssClass="btn-link" Text="Editar"
                                NavigateUrl='<%# "PacienteModificar.aspx?dni=" + Eval("DNI") %>' />
                            <asp:LinkButton ID="lnkEliminar" runat="server" CssClass="btn-link peligro" Text="Eliminar"
                                CommandName="Eliminar" CommandArgument='<%# Eval("DNI") %>' CausesValidation="false" />
                        </ItemTemplate>
                    </asp:TemplateField>
                </Columns>
            </asp:GridView>
        </div>

        <div class="paginador">
            <asp:Label ID="lblResumen" runat="server" CssClass="info" />
        </div>
    </div>

    <%--*********--%>
    <asp:Panel ID="pnlConfirmarBaja" runat="server" CssClass="velo" Visible="false">
        <div class="modal" role="dialog" aria-modal="true" aria-labelledby="tituloBajaPaciente">
            <div class="modal-cab">
                <div class="icono" aria-hidden="true">!</div>
                <h3 id="tituloBajaPaciente">Confirmar baja de paciente</h3>
            </div>
            <div class="modal-cuerpo">
                <p>
                    ¿Está seguro que desea eliminar el paciente
                    <b><asp:Label ID="lblNombreBaja" runat="server" /></b>
                    (DNI <asp:Label ID="lblDniBaja" runat="server" />)?
                </p>
                <p>El registro no se borra físicamente: se marca como <b>inactivo</b> (baja lógica) y deja de aparecer en los listados.</p>
                <asp:HiddenField ID="hfDniBaja" runat="server" />
            </div>
            <div class="modal-pie">
                <asp:Button ID="btnCancelarBaja" runat="server" Text="Cancelar" CssClass="btn btn-secundario" CausesValidation="false" />
                <asp:Button ID="btnConfirmarBaja" runat="server" Text="Sí, eliminar" CssClass="btn btn-peligro" />
            </div>
        </div>
    </asp:Panel>

</asp:Content>
