<%@ Page Title="Alta de paciente - Clínica San Rafael" Language="C#" MasterPageFile="~/Site.Master" %>

<asp:Content ID="Content1" ContentPlaceHolderID="Contenido" runat="server">

    <div class="migas"><a href="Default.aspx">Inicio</a> / Alta de paciente</div>

    <div class="titulo-pagina">
        <div>
            <h1>Alta de paciente</h1>
            <p>Registro de un nuevo paciente en el sistema.</p>
        </div>
        <div class="botones">
            <a class="btn btn-secundario" href="Pacientes.aspx">Volver al listado</a>
        </div>
    </div>

    <div class="tarjeta">
        <div class="tarjeta-cab">
            <h2>Alta de paciente</h2>
            <span class="nota">Los campos con * son obligatorios</span>
        </div>

        <div class="tarjeta-cuerpo">
            <div class="fila">
                <div class="campo">
                    <label for="dni">DNI <span class="req">*</span></label>
                    <input type="text" id="dni" placeholder="Sin puntos" maxlength="10" />
                </div>
                <div class="campo">
                    <label for="nombre">Nombre <span class="req">*</span></label>
                    <input type="text" id="nombre" placeholder="Nombre" maxlength="50" />
                </div>
                <div class="campo">
                    <label for="apellido">Apellido <span class="req">*</span></label>
                    <input type="text" id="apellido" placeholder="Apellido" maxlength="50" />
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
            </div>

            <div class="fila">
                <div class="campo">
                    <label for="provincia">Provincia <span class="req">*</span></label>
                    <select id="provincia">
                        <option>Buenos Aires</option>
                        <option>Ciudad Autónoma de Buenos Aires</option>
                        <option>Córdoba</option>
                        <option>Mendoza</option>
                        <option>Santa Fe</option>
                        <option>Salta</option>
                    </select>
                </div>
                <div class="campo">
                    <label for="localidad">Localidad <span class="req">*</span></label>
                    <select id="localidad">
                        <option>General Pacheco</option>
                        <option>San Miguel</option>
                        <option>Tigre</option>
                        <option>La Plata</option>
                    </select>
                </div>
                <div class="campo">
                    <label for="direccion">Dirección <span class="req">*</span></label>
                    <input type="text" id="direccion" maxlength="120" />
                </div>
            </div>

            <div class="fila">
                <div class="campo">
                    <label for="telefono">Teléfono <span class="req">*</span></label>
                    <input type="tel" id="telefono" placeholder="11-0000-0000" maxlength="30" />
                </div>
                <div class="campo">
                    <label for="email">Correo electrónico <span class="req">*</span></label>
                    <input type="email" id="email" placeholder="correo@dominio.com" maxlength="120" />
                </div>
            </div>

            <div class="botones">
                <a class="btn btn-primario" href="PacienteAlta.aspx?ok=1">Guardar paciente</a>
                <a class="btn btn-secundario" href="Pacientes.aspx">Cancelar</a>
                <span class="nota ayuda">Los datos se validan antes de guardar en la base de datos.</span>
            </div>
        </div>
    </div>

    <% if (Request.QueryString["ok"] == "1") { %>
        <div class="aviso aviso-ok" role="status">
            <span aria-hidden="true">&#10003;</span>
            <div>El paciente se agregó correctamente en la base de datos.</div>
        </div>
    <% } %>

</asp:Content>
