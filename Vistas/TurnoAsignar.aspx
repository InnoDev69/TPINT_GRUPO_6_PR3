<%@ Page Title="Asignar turno - Clínica San Rafael" Language="C#" MasterPageFile="~/Site.Master" %>

<asp:Content ID="Content1" ContentPlaceHolderID="Contenido" runat="server">

    <div class="migas"><a href="Default.aspx">Inicio</a> / Asignar turno</div>

    <div class="titulo-pagina">
        <div>
            <h1>Asignar turno</h1>
            <p>Seleccione especialidad, médico, paciente, fecha y horario.</p>
        </div>
        <div class="botones">
            <a class="btn btn-secundario" href="Turnos.aspx">Volver al listado</a>
        </div>
    </div>

    <div class="turno-grid">

        <div class="tarjeta">
            <div class="tarjeta-cab">
                <h2>Nuevo turno</h2>
                <span class="nota">Duración: 1 hora</span>
            </div>

            <div class="tarjeta-cuerpo">
                <div class="fila">
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
                        </select>
                    </div>
                    <div class="campo">
                        <label for="medico">Médico <span class="req">*</span></label>
                        <select id="medico">
                            <option>Dr. Gomez, Martin (MP-001)</option>
                            <option>Dra. Fernandez, Ana (MP-002)</option>
                            <option>Dr. Martinez, Diego (MP-003)</option>
                            <option>Dra. Sosa, Carla (MP-004)</option>
                        </select>
                    </div>
                </div>

                <div class="fila">
                    <div class="campo">
                        <label for="paciente">Paciente <span class="req">*</span></label>
                        <select id="paciente">
                            <option>Gonzalez, Maria - DNI 30.114.587</option>
                            <option>Rodriguez, Juan - DNI 28.902.331</option>
                            <option>Lopez, Lucia - DNI 31.455.902</option>
                            <option>Perez, Sofia - DNI 33.201.447</option>
                            <option>Diaz, Carlos - DNI 26.778.120</option>
                        </select>
                    </div>
                </div>

                <div class="fila">
                    <div class="campo">
                        <label for="fecha">Fecha <span class="req">*</span></label>
                        <input type="date" id="fecha" value="2026-11-16" />
                    </div>
                    <div class="campo">
                        <label for="horario">Horario disponible <span class="req">*</span></label>
                        <select id="horario">
                            <option>09:00</option>
                            <option>10:00</option>
                            <option>11:00</option>
                            <option>14:00</option>
                            <option>15:00</option>
                        </select>
                    </div>
                </div>

                <div class="aviso aviso-info">
                    <span aria-hidden="true">i</span>
                    <div>El médico <b>Dr. Gomez, Martin</b> atiende los días <b>lunes, miércoles y viernes</b> de 08:00 a 12:00 y de 14:00 a 18:00. La fecha seleccionada es <b>lunes 16/11/2026</b>.</div>
                </div>

                <div class="botones">
                    <a class="btn btn-primario" href="TurnoAsignar.aspx?error=1">Guardar turno</a>
                    <a class="btn btn-secundario" href="Turnos.aspx">Cancelar</a>
                </div>
            </div>
        </div>

        <div class="tarjeta">
            <div class="tarjeta-cab">
                <h2>Agenda del día</h2>
                <span class="nota">Lunes 16/11/2026</span>
            </div>

            <div class="tabla-scroll">
                <table class="grid">
                    <thead>
                        <tr>
                            <th>Hora</th>
                            <th>Paciente</th>
                            <th>Estado</th>
                        </tr>
                    </thead>
                    <tbody>
                        <tr>
                            <td class="principal">08:00</td>
                            <td>Disponible</td>
                            <td><span class="badge badge-neutro">Libre</span></td>
                        </tr>
                        <tr>
                            <td class="principal">09:00</td>
                            <td>Rodriguez, Juan</td>
                            <td><span class="badge badge-pendiente">Pendiente</span></td>
                        </tr>
                        <tr>
                            <td class="principal">10:00</td>
                            <td>Lopez, Lucia</td>
                            <td><span class="badge badge-pendiente">Pendiente</span></td>
                        </tr>
                        <tr>
                            <td class="principal">11:00</td>
                            <td>Disponible</td>
                            <td><span class="badge badge-neutro">Libre</span></td>
                        </tr>
                        <tr>
                            <td class="principal">14:00</td>
                            <td>Perez, Sofia</td>
                            <td><span class="badge badge-presente">Presente</span></td>
                        </tr>
                    </tbody>
                </table>
            </div>
        </div>

    </div>

    <% if (Request.QueryString["error"] == "1") { %>
        <div class="aviso aviso-error" role="alert">
            <span aria-hidden="true">&#9888;</span>
            <div><b>El médico ya tiene un turno asignado en esa fecha y horario.</b> Seleccione otro horario disponible.</div>
        </div>
    <% } %>

</asp:Content>
