<%@ Page Title="Gestión de médicos - Clínica San Rafael" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Medicos.aspx.cs" Inherits="Vistas.Medicos" %>

<asp:Content ID="Content1" ContentPlaceHolderID="Contenido" runat="server">

    <div class="migas"><a href="Default.aspx">Inicio</a> / Gestión de médicos</div>

    <div class="titulo-pagina">
        <div>
            <h1>Gestión de médicos</h1>
            <p>Alta, baja, modificación y listado de profesionales de la clínica.</p>
        </div>
        <div class="botones">
            <asp:HyperLink ID="lnkNuevoMedico" runat="server" CssClass="btn btn-primario" NavigateUrl="MedicoAlta.aspx" Text="+ Nuevo médico" />
        </div>
    </div>

    <asp:Panel ID="pnlAvisoOk" runat="server" CssClass="aviso aviso-ok" Visible="false">
        <span aria-hidden="true">&#10003;</span>
        <div>
            <asp:Label ID="lblAviso" runat="server" Text="El médico se dio de baja correctamente y ya no aparece en el listado." />
        </div>
    </asp:Panel>

    <div class="tarjeta">
        <div class="tarjeta-cab">
            <h2>Médicos registrados</h2>
            <asp:Label ID="lblRegistrosActivos" runat="server" CssClass="nota" />
        </div>

        <div class="filtros">
            <div class="fila">
                <div class="campo">
                    <asp:Label ID="lblBuscar" runat="server" AssociatedControlID="txtBuscar" Text="Buscar" />
                    <asp:TextBox ID="txtBuscar" runat="server" placeholder="Legajo, nombre, apellido o DNI..." />
                </div>
                <div class="campo">
                    <asp:Label ID="lblEspecialidad" runat="server" AssociatedControlID="ddlEspecialidad" Text="Especialidad" />
                    <asp:DropDownList ID="ddlEspecialidad" runat="server" AppendDataBoundItems="true">
                        <asp:ListItem Text="Todas" Value="" />
                    </asp:DropDownList>
                </div>
                <div class="campo">
                    <asp:Label ID="lblDia" runat="server" AssociatedControlID="ddlDia" Text="Día de atención" />
                    <asp:DropDownList ID="ddlDia" runat="server" AppendDataBoundItems="true">
                        <asp:ListItem Text="Todos" Value="" />
                    </asp:DropDownList>
                </div>
                <div class="acciones-filtro">
                    <asp:Button ID="btnBuscar" runat="server" Text="Buscar" CssClass="btn btn-azul" OnClick="btnBuscar_Click" />
                    <asp:Button ID="btnLimpiar" runat="server" Text="Limpiar" CssClass="btn btn-secundario" CausesValidation="false" OnClick="btnLimpiar_Click" />
                </div>
            </div>
        </div>

        <div class="tabla-scroll">
            <asp:GridView ID="gvMedicos" runat="server"
                AutoGenerateColumns="false"
                CssClass="grid"
                GridLines="None"
                UseAccessibleHeader="true"
                ShowHeaderWhenEmpty="true"
                EmptyDataText="No se encontraron registros."
                DataKeyNames="Legajo"
                AllowPaging="true"
                OnPageIndexChanging="gvMedicos_PageIndexChanging"
                PageSize="8"
                OnRowCommand="gvMedicos_RowCommand">
                <Columns>
                    <asp:BoundField DataField="Legajo" HeaderText="Legajo" ItemStyle-CssClass="principal" />
                    <asp:BoundField DataField="Medico" HeaderText="Médico" />
                    <asp:BoundField DataField="Especialidad" HeaderText="Especialidad" />
                    <asp:BoundField DataField="DiasAtencion" HeaderText="Días de atención" />
                    <asp:BoundField DataField="Horario" HeaderText="Horario" />
                    <asp:BoundField DataField="Localidad" HeaderText="Localidad" />
                    <asp:TemplateField HeaderText="Acciones" HeaderStyle-CssClass="acciones" ItemStyle-CssClass="acciones">
                        <ItemTemplate>
                            <asp:HyperLink ID="lnkEditar" runat="server" CssClass="btn-link" Text="Editar"
                                NavigateUrl='<%# "MedicoModificar.aspx?legajo=" + Eval("Legajo") %>' />
                            <asp:LinkButton ID="lnkEliminar" runat="server" CssClass="btn-link peligro" Text="Eliminar"
                                CommandName="Eliminar" CommandArgument='<%# Eval("Legajo") %>' CausesValidation="false" />
                        </ItemTemplate>
                    </asp:TemplateField>
                </Columns>
            </asp:GridView>
        </div>

        <div class="paginador">
            <asp:Label ID="lblResumen" runat="server" CssClass="info" />
        </div>
    </div>

    <asp:Panel ID="pnlConfirmarBaja" runat="server" CssClass="velo" Visible="false">
        <div class="modal" role="dialog" aria-modal="true" aria-labelledby="tituloBajaMedico">
            <div class="modal-cab">
                <div class="icono" aria-hidden="true">!</div>
                <h3 id="tituloBajaMedico">Confirmar baja de médico</h3>
            </div>
            <div class="modal-cuerpo">
                <p>
                    ¿Está seguro que desea eliminar al profesional
                    <b><asp:Label ID="lblNombreBaja" runat="server" /></b>
                    (Legajo <asp:Label ID="lblLegajoBaja" runat="server" />)?
                </p>
                <p>El registro no se borra físicamente: se marca como <b>inactivo</b> (baja lógica) y no podrá recibir nuevos turnos. Los turnos asignados se conservan.</p>
                <asp:HiddenField ID="hfLegajoBaja" runat="server" />
            </div>
            <div class="modal-pie">
                <asp:Button ID="btnCancelarBaja" runat="server" Text="Cancelar" CssClass="btn btn-secundario" CausesValidation="false" OnClick="btnCancelarBaja_Click" />
                <asp:Button ID="btnConfirmarBaja" runat="server" Text="Sí, eliminar" CssClass="btn btn-peligro" OnClick="btnConfirmarBaja_Click" />
            </div>
        </div>
    </asp:Panel>

</asp:Content>
