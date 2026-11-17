<%@ Page Title="Asignación de turnos - Clínica San Rafael" Language="C#" MasterPageFile="~/Site.Master" %>

<asp:Content ID="Content1" ContentPlaceHolderID="Contenido" runat="server">

    <div class="migas"><a href="Default.aspx">Inicio</a> / Asignación de turnos</div>

    <div class="titulo-pagina">
        <div>
            <h1>Asignación de turnos</h1>
            <p>Turnos otorgados por especialidad, médico, fecha y horario.</p>
        </div>
        <div class="botones">
            <a class="btn btn-primario" href="TurnoAsignar.aspx">+ Asignar turno</a>
        </div>
    </div>

    <% if (Request.QueryString["baja"] == "ok") { %>
        <div class="aviso aviso-ok" role="status">
            <span aria-hidden="true">&#10003;</span>
            <div>El turno se canceló correctamente y el horario quedó disponible.</div>
        </div>
    <% } %>

    <div class="tarjeta">
        <div class="tarjeta-cab">
            <h2>Turnos asignados</h2>
            <span class="nota">48 turnos registrados</span>
        </div>

        <div class="filtros">
            <div class="fila">
                <div class="campo">
                    <label for="buscarTurno">Buscar paciente</label>
                    <input type="text" id="buscarTurno" placeholder="DNI o apellido y nombre..." />
                </div>
                <div class="campo">
                    <label for="especialidadTurno">Especialidad</label>
                    <select id="especialidadTurno">
                        <option>Todas</option>
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
                    <label for="medicoTurno">Médico</label>
                    <select id="medicoTurno">
                        <option>Todos</option>
                        <option>Dr. Gomez, Martin (MP-001)</option>
                        <option>Dra. Fernandez, Ana (MP-002)</option>
                        <option>Dr. Martinez, Diego (MP-003)</option>
                        <option>Dra. Sosa, Carla (MP-004)</option>
                    </select>
                </div>
                <div class="campo">
                    <label for="estadoTurno">Estado</label>
                    <select id="estadoTurno">
                        <option>Todos</option>
                        <option>Presente</option>
                        <option>Ausente</option>
                        <option>Pendiente</option>
                    </select>
                </div>
            </div>
            <div class="fila">
                <div class="campo medio">
                    <label for="desdeTurno">Desde</label>
                    <input type="date" id="desdeTurno" value="2026-11-01" />
                </div>
                <div class="campo medio">
                    <label for="hastaTurno">Hasta</label>
                    <input type="date" id="hastaTurno" value="2026-11-30" />
                </div>
                <div class="acciones-filtro">
                    <a class="btn btn-azul" href="Turnos.aspx">Filtrar</a>
                    <a class="btn btn-secundario" href="Turnos.aspx">Limpiar</a>
                </div>
            </div>
        </div>

        <div class="tabla-scroll">
            <table class="grid">
                <thead>
                    <tr>
                        <th>Fecha</th>
                        <th>Hora</th>
                        <th>Paciente</th>
                        <th>Médico</th>
                        <th>Especialidad</th>
                        <th>Estado</th>
                        <th class="acciones">Acciones</th>
                    </tr>
                </thead>
                <tbody>
                    <tr>
                        <td class="principal">13/11/2026</td>
                        <td>08:00</td>
                        <td>Gonzalez, Maria</td>
                        <td>Dr. Gomez, Martin</td>
                        <td>Clínica Médica</td>
                        <td><span class="badge badge-presente">Presente</span></td>
                        <td class="acciones">
                            <a class="btn-link" href="TurnoAsignar.aspx">Editar</a>
                            <a class="btn-link peligro" href="Turnos.aspx?baja=1">Eliminar</a>
                        </td>
                    </tr>
                    <tr>
                        <td class="principal">13/11/2026</td>
                        <td>09:00</td>
                        <td>Rodriguez, Juan</td>
                        <td>Dra. Fernandez, Ana</td>
                        <td>Cardiología</td>
                        <td><span class="badge badge-ausente">Ausente</span></td>
                        <td class="acciones">
                            <a class="btn-link" href="TurnoAsignar.aspx">Editar</a>
                            <a class="btn-link peligro" href="Turnos.aspx?baja=1">Eliminar</a>
                        </td>
                    </tr>
                    <tr>
                        <td class="principal">13/11/2026</td>
                        <td>10:00</td>
                        <td>Lopez, Lucia</td>
                        <td>Dr. Martinez, Diego</td>
                        <td>Dermatología</td>
                        <td><span class="badge badge-pendiente">Pendiente</span></td>
                        <td class="acciones">
                            <a class="btn-link" href="TurnoAsignar.aspx">Editar</a>
                            <a class="btn-link peligro" href="Turnos.aspx?baja=1">Eliminar</a>
                        </td>
                    </tr>
                    <tr>
                        <td class="principal">13/11/2026</td>
                        <td>11:00</td>
                        <td>Perez, Sofia</td>
                        <td>Dra. Sosa, Carla</td>
                        <td>Pediatría</td>
                        <td><span class="badge badge-presente">Presente</span></td>
                        <td class="acciones">
                            <a class="btn-link" href="TurnoAsignar.aspx">Editar</a>
                            <a class="btn-link peligro" href="Turnos.aspx?baja=1">Eliminar</a>
                        </td>
                    </tr>
                    <tr>
                        <td class="principal">16/11/2026</td>
                        <td>08:00</td>
                        <td>Diaz, Carlos</td>
                        <td>Dr. Romero, Pablo</td>
                        <td>Ginecología</td>
                        <td><span class="badge badge-pendiente">Pendiente</span></td>
                        <td class="acciones">
                            <a class="btn-link" href="TurnoAsignar.aspx">Editar</a>
                            <a class="btn-link peligro" href="Turnos.aspx?baja=1">Eliminar</a>
                        </td>
                    </tr>
                    <tr>
                        <td class="principal">16/11/2026</td>
                        <td>09:00</td>
                        <td>Martinez, Diego</td>
                        <td>Dra. Lopez, Lucia</td>
                        <td>Traumatología</td>
                        <td><span class="badge badge-pendiente">Pendiente</span></td>
                        <td class="acciones">
                            <a class="btn-link" href="TurnoAsignar.aspx">Editar</a>
                            <a class="btn-link peligro" href="Turnos.aspx?baja=1">Eliminar</a>
                        </td>
                    </tr>
                    <tr>
                        <td class="principal">16/11/2026</td>
                        <td>10:00</td>
                        <td>Fernandez, Ana</td>
                        <td>Dr. Diaz, Carlos</td>
                        <td>Neurología</td>
                        <td><span class="badge badge-pendiente">Pendiente</span></td>
                        <td class="acciones">
                            <a class="btn-link" href="TurnoAsignar.aspx">Editar</a>
                            <a class="btn-link peligro" href="Turnos.aspx?baja=1">Eliminar</a>
                        </td>
                    </tr>
                    <tr>
                        <td class="principal">17/11/2026</td>
                        <td>14:00</td>
                        <td>Romero, Pablo</td>
                        <td>Dra. Perez, Sofia</td>
                        <td>Oftalmología</td>
                        <td><span class="badge badge-pendiente">Pendiente</span></td>
                        <td class="acciones">
                            <a class="btn-link" href="TurnoAsignar.aspx">Editar</a>
                            <a class="btn-link peligro" href="Turnos.aspx?baja=1">Eliminar</a>
                        </td>
                    </tr>
                </tbody>
            </table>
        </div>

        <div class="paginador">
            <span class="info">Mostrando 1 a 8 de 48 registros</span>
            <div class="paginas">
                <a href="Turnos.aspx" aria-label="Anterior">&laquo;</a>
                <span class="actual">1</span>
                <a href="Turnos.aspx">2</a>
                <a href="Turnos.aspx">3</a>
                <a href="Turnos.aspx">4</a>
                <a href="Turnos.aspx">5</a>
                <a href="Turnos.aspx">6</a>
                <a href="Turnos.aspx" aria-label="Siguiente">&raquo;</a>
            </div>
        </div>
    </div>

    <% if (Request.QueryString["baja"] == "1") { %>
        <div class="velo">
            <div class="modal" role="dialog" aria-modal="true" aria-labelledby="tituloBajaTurno">
                <div class="modal-cab">
                    <div class="icono" aria-hidden="true">!</div>
                    <h3 id="tituloBajaTurno">Confirmar baja de turno</h3>
                </div>
                <div class="modal-cuerpo">
                    <p>¿Está seguro que desea eliminar el turno de <b>Gonzalez, Maria</b> del <b>13/11/2026 a las 08:00</b>?</p>
                    <p>El turno se marca como <b>cancelado</b> y el horario vuelve a quedar disponible para el profesional.</p>
                </div>
                <div class="modal-pie">
                    <a class="btn btn-secundario" href="Turnos.aspx">Cancelar</a>
                    <a class="btn btn-peligro" href="Turnos.aspx?baja=ok">Sí, eliminar</a>
                </div>
            </div>
        </div>
    <% } %>

</asp:Content>
