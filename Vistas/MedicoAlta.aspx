<%@ Page Title="Alta de médico - Clínica San Rafael" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="MedicoAlta.aspx.cs" Inherits="Vistas.MedicoAlta" %>

<asp:Content ID="Content1" ContentPlaceHolderID="Contenido" runat="server">

    <div class="migas"><a href="Default.aspx">Inicio</a> / Alta de médico</div>

    <div class="titulo-pagina">
        <div>
            <h1>Alta de médico</h1>
            <p>Registro de un nuevo profesional, su especialidad y sus horarios.</p>
        </div>
        <div class="botones">
            <a class="btn btn-secundario" href="Medicos.aspx">Volver al listado</a>
        </div>
    </div>

    <div class="tarjeta">
        <div class="tarjeta-cab">
            <h2>Alta de médico</h2>
            <span class="nota">Los campos con * son obligatorios</span>
        </div>

        <div class="tarjeta-cuerpo">
            <div class="fila">
                <div class="campo">
                    <label for="legajo">Legajo <span class="req">*</span></label>
                    <input type="text" id="legajo" placeholder="MP-016" maxlength="10" />
                </div>
                <div class="campo">
                    <label for="dni">DNI <span class="req">*</span></label>
                    <input type="text" id="dni" placeholder="Sin puntos" maxlength="10" />
                </div>
                <div class="campo">
                    <label for="nombre">Nombre <span class="req">*</span></label>
                    <input type="text" id="nombre" maxlength="50" />
                </div>
                <div class="campo">
                    <label for="apellido">Apellido <span class="req">*</span></label>
                    <input type="text" id="apellido" maxlength="50" />
                </div>
            </div>

            <div class="fila">
                <div class="campo">
                    <label for="sexo">Sexo <span class="req">*</span></label>
                    <select id="sexo">
                        <option value="">Seleccione...</option>
                        <option>Femenino</option>
                        <option>Masculino</option>
                        <option>Otro</option>
                    </select>
                </div>
                <div class="campo">
                    <label for="nacionalidad">Nacionalidad <span class="req">*</span></label>
                    <select id="nacionalidad">
                        <option>Argentina</option>
                        <option>Boliviana</option>
                        <option>Chilena</option>
                        <option>Paraguaya</option>
                        <option>Uruguaya</option>
                    </select>
                </div>
                <div class="campo">
                    <label for="fechaNacimiento">Fecha de nacimiento <span class="req">*</span></label>
                    <input type="date" id="fechaNacimiento" />
                </div>
                <div class="campo">
                    <label for="ddlEspecialidad">Especialidad <span class="req">*</span></label>
                    <asp:DropDownList
                        ID="ddlEspecialidad"
                        runat="server"
                        CssClass=""
                        AppendDataBoundItems="true">
                        <asp:ListItem Text="Seleccione..." Value="0" />
                    </asp:DropDownList>
                </div>
            </div>

            <div class="fila">
                <div class="campo">
                    <label for="ddlProvincia">Provincia <span class="req">*</span></label>
                    <asp:DropDownList
                        ID="ddlProvincia"
                        runat="server"
                        AutoPostBack="true"
                        OnSelectedIndexChanged="ddlProvincia_SelectedIndexChanged"
                        AppendDataBoundItems="true">
                        <asp:ListItem Text="Seleccione..." Value="0" />
                    </asp:DropDownList>
                </div>
                <div class="campo">
                    <label for="ddlLocalidad">Localidad <span class="req">*</span></label>
                    <asp:DropDownList
                        ID="ddlLocalidad"
                        runat="server"
                        AppendDataBoundItems="true"
                        Enabled="false">
                        <asp:ListItem Text="Seleccione..." Value="0" />
                    </asp:DropDownList>
                </div>
                <div class="campo">
                    <label for="direccion">Dirección <span class="req">*</span></label>
                    <input type="text" id="direccion" maxlength="120" />
                </div>
                <div class="campo">
                    <label for="telefono">Teléfono <span class="req">*</span></label>
                    <input type="tel" id="telefono" placeholder="11-0000-0000" maxlength="30" />
                </div>
            </div>

            <div class="fila">
                <div class="campo">
                    <label for="email">Correo electrónico <span class="req">*</span></label>
                    <input type="email" id="email" maxlength="120" />
                </div>
                <div class="campo">
                    <label for="usuario">Usuario del sistema <span class="req">*</span></label>
                    <input type="text" id="usuario" placeholder="usuario" maxlength="50" />
                </div>
                <div class="campo">
                    <label for="clave">Contraseña <span class="req">*</span></label>
                    <input type="password" id="clave" placeholder="********" maxlength="30" />
                </div>
                <div class="campo">
                    <label for="repetirClave">Repetir contraseña <span class="req">*</span></label>
                    <input type="password" id="repetirClave" placeholder="********" maxlength="30" />
                </div>
            </div>
        </div>
    </div>

    <div class="tarjeta">
        <div class="tarjeta-cab">
            <h2>Días y horarios de atención</h2>
            <span class="nota">Un médico atiende una sola especialidad</span>
        </div>

        <div class="tarjeta-cuerpo">
            <div class="fila">
                <div class="campo">
                    <div class="etiqueta-campo">Días de atención <span class="req">*</span></div>
                    <div class="dias">
                        <label class="campo-check"><input type="checkbox" checked="checked" /> Lunes</label>
                        <label class="campo-check"><input type="checkbox" /> Martes</label>
                        <label class="campo-check"><input type="checkbox" checked="checked" /> Miércoles</label>
                        <label class="campo-check"><input type="checkbox" /> Jueves</label>
                        <label class="campo-check"><input type="checkbox" checked="checked" /> Viernes</label>
                        <label class="campo-check"><input type="checkbox" /> Sábado</label>
                    </div>
                </div>
            </div>

            <div class="fila">
                <div class="campo">
                    <label for="horaDesde">Hora desde <span class="req">*</span></label>
                    <input type="time" id="horaDesde" value="08:00" />
                </div>
                <div class="campo">
                    <label for="horaHasta">Hora hasta <span class="req">*</span></label>
                    <input type="time" id="horaHasta" value="12:00" />
                </div>
                <div class="campo">
                    <label for="horaDesdeTarde">Hora desde (tarde)</label>
                    <input type="time" id="horaDesdeTarde" value="14:00" />
                </div>
                <div class="campo">
                    <label for="horaHastaTarde">Hora hasta (tarde)</label>
                    <input type="time" id="horaHastaTarde" value="18:00" />
                </div>
            </div>

            <div class="botones">
                <asp:LinkButton
                    ID="btnGuardar"
                    runat="server"
                    CssClass="btn btn-primario"
                    OnClick="btnGuardar_Click">Guardar médico</asp:LinkButton>
                <a class="btn btn-secundario" href="Medicos.aspx">Cancelar</a>
            </div>
        </div>
    </div>

    <% if (Request.QueryString["ok"] == "1") { %>
        <div class="aviso aviso-ok" role="status">
            <span aria-hidden="true">&#10003;</span>
            <div>El médico se agregó correctamente en la base de datos.</div>
        </div>
    <% } %>

</asp:Content>