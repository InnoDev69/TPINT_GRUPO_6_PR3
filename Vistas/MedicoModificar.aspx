<%@ Page Title="Modificar médico - Clínica San Rafael" Language="C#" MasterPageFile="~/Site.Master" %>

<asp:Content ID="Content1" ContentPlaceHolderID="Contenido" runat="server">

    <div class="migas"><a href="Default.aspx">Inicio</a> / Modificar médico</div>

    <div class="titulo-pagina">
        <div>
            <h1>Modificar médico</h1>
            <p>Edición de los datos de un profesional existente.</p>
        </div>
        <div class="botones">
            <a class="btn btn-secundario" href="Medicos.aspx">Volver al listado</a>
        </div>
    </div>

    <div class="tarjeta">
        <div class="tarjeta-cab">
            <h2>Modificar médico</h2>
            <span class="nota">Los campos con * son obligatorios</span>
        </div>

        <div class="tarjeta-cuerpo">
            <div class="aviso aviso-info">
                <span aria-hidden="true">i</span>
                <div>Los campos se cargan automáticamente con los datos actuales del médico. Modifique solo lo necesario.</div>
            </div>

            <div class="fila">
                <div class="campo">
                    <label for="legajo">Legajo <span class="req">*</span></label>
                    <input type="text" id="legajo" value="MP-001" maxlength="10" readonly="readonly" />
                </div>
                <div class="campo">
                    <label for="dni">DNI <span class="req">*</span></label>
                    <input type="text" id="dni" value="28.005.533" maxlength="10" />
                </div>
                <div class="campo">
                    <label for="nombre">Nombre <span class="req">*</span></label>
                    <input type="text" id="nombre" value="Martin" maxlength="50" />
                </div>
                <div class="campo">
                    <label for="apellido">Apellido <span class="req">*</span></label>
                    <input type="text" id="apellido" value="Gomez" maxlength="50" />
                </div>
            </div>

            <div class="fila">
                <div class="campo">
                    <label for="sexo">Sexo <span class="req">*</span></label>
                    <select id="sexo">
                        <option>Masculino</option>
                        <option>Femenino</option>
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
                    <input type="date" id="fechaNacimiento" value="1997-03-05" />
                </div>
                <div class="campo">
                    <label for="especialidad">Especialidad <span class="req">*</span></label>
                    <select id="especialidad">
                        <option>Clínica Médica</option>
                        <option>Cardiología</option>
                        <option>Dermatología</option>
                        <option>Pediatría</option>
                        <option>Ginecología</option>
                        <option>Traumatología</option>
                        <option>Neurología</option>
                        <option>Oftalmología</option>
                        <option>Otorrinolaringología</option>
                        <option>Psiquiatría</option>
                        <option>Endocrinología</option>
                        <option>Nutrición</option>
                    </select>
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
                    <input type="text" id="direccion" value="Moreno 1353" maxlength="120" />
                </div>
                <div class="campo">
                    <label for="telefono">Teléfono <span class="req">*</span></label>
                    <input type="tel" id="telefono" value="11-5687-7396" maxlength="30" />
                </div>
            </div>

            <div class="fila">
                <div class="campo">
                    <label for="email">Correo electrónico <span class="req">*</span></label>
                    <input type="email" id="email" value="martin.gomez@mail.com" maxlength="120" />
                </div>
                <div class="campo">
                    <label for="usuario">Usuario del sistema <span class="req">*</span></label>
                    <input type="text" id="usuario" value="mgomez" maxlength="50" />
                </div>
                <div class="campo">
                    <label for="clave">Contraseña <span class="req">*</span></label>
                    <input type="password" id="clave" placeholder="********" maxlength="30" />
                    <div class="ayuda">Deje el campo vacío para conservar la contraseña actual.</div>
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
                <a class="btn btn-primario" href="MedicoModificar.aspx?ok=1">Guardar médico</a>
                <a class="btn btn-secundario" href="Medicos.aspx">Cancelar</a>
            </div>
        </div>
    </div>

    <% if (Request.QueryString["ok"] == "1") { %>
        <div class="aviso aviso-ok" role="status">
            <span aria-hidden="true">&#10003;</span>
            <div>Los datos del médico se actualizaron correctamente en la base de datos.</div>
        </div>
    <% } %>

</asp:Content>
