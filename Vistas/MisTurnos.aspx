<%@ Page Title="Mis turnos - Clínica San Rafael" Language="C#" MasterPageFile="~/Site.Master" %>

<asp:Content ID="Content1" ContentPlaceHolderID="Contenido" runat="server">

    <div class="migas"><a href="Default.aspx">Inicio</a> / Mis turnos</div>

    <div class="titulo-pagina">
        <div>
            <h1>Mis turnos</h1>
            <p>Turnos asignados al profesional. Registro de presentes y ausentes.</p>
        </div>
    </div>

    <% if (Request.QueryString["ok"] == "1") { %>
        <div class="aviso aviso-ok" role="status">
            <span aria-hidden="true">&#10003;</span>
            <div>La atención del turno se registró correctamente.</div>
        </div>
    <% } %>

    <div class="kpis">
        <div class="kpi">
            <div class="etiqueta">Turnos asignados</div>
            <div class="valor">24</div>
            <div class="detalle">Total histórico</div>
        </div>
        <div class="kpi ambar">
            <div class="etiqueta">Pendientes</div>
            <div class="valor">9</div>
            <div class="detalle">Requieren registro</div>
        </div>
        <div class="kpi verde">
            <div class="etiqueta">Presentes</div>
            <div class="valor">11</div>
            <div class="detalle">En el periodo consultado</div>
        </div>
        <div class="kpi rojo">
            <div class="etiqueta">Ausentes</div>
            <div class="valor">4</div>
            <div class="detalle">En el periodo consultado</div>
        </div>
    </div>

    <div class="tarjeta">
        <div class="tarjeta-cab">
            <h2>Mis turnos</h2>
            <span class="nota">Dr. Martin Gomez - Clínica Médica</span>
        </div>

        <div class="filtros">
            <div class="fila">
                <div class="campo">
                    <label for="buscarPacienteMedico">Buscar paciente</label>
                    <input type="text" id="buscarPacienteMedico" placeholder="DNI o apellido y nombre..." />
                </div>
                <div class="campo">
                    <label for="estadoMedico">Estado</label>
                    <select id="estadoMedico">
                        <option>Todos</option>
                        <option>Presente</option>
                        <option>Ausente</option>
                        <option>Pendiente</option>
                    </select>
                </div>
                <div class="campo">
                    <label for="desdeMedico">Desde</label>
                    <input type="date" id="desdeMedico" value="2026-11-01" />
                </div>
                <div class="campo">
                    <label for="hastaMedico">Hasta</label>
                    <input type="date" id="hastaMedico" value="2026-11-30" />
                </div>
            </div>
            <div class="botones">
                <a class="btn btn-azul" href="MisTurnos.aspx">Filtrar</a>
                <a class="btn btn-secundario" href="MisTurnos.aspx">Limpiar</a>
            </div>
        </div>

        <div class="tabla-scroll">
            <table class="grid">
                <thead>
                    <tr>
                        <th>Fecha</th>
                        <th>Hora</th>
                        <th>Paciente</th>
                        <th>DNI</th>
                        <th>Estado</th>
                        <th>Observación</th>
                        <th class="acciones">Acciones</th>
                    </tr>
                </thead>
                <tbody>
                    <tr>
                        <td class="principal">13/11/2026</td>
                        <td>08:00</td>
                        <td>Gonzalez, Maria</td>
                        <td>30.114.587</td>
                        <td><span class="badge badge-presente">Presente</span></td>
                        <td>Control de rutina. Sin cambios.</td>
                        <td class="acciones"><a class="btn-link" href="#registrar-atencion">Registrar atención</a></td>
                    </tr>
                    <tr>
                        <td class="principal">13/11/2026</td>
                        <td>09:00</td>
                        <td>Rodriguez, Juan</td>
                        <td>28.902.331</td>
                        <td><span class="badge badge-pendiente">Pendiente</span></td>
                        <td>-</td>
                        <td class="acciones"><a class="btn-link" href="#registrar-atencion">Registrar atención</a></td>
                    </tr>
                    <tr>
                        <td class="principal">13/11/2026</td>
                        <td>10:00</td>
                        <td>Lopez, Lucia</td>
                        <td>31.455.902</td>
                        <td><span class="badge badge-ausente">Ausente</span></td>
                        <td>Sin observación.</td>
                        <td class="acciones"><a class="btn-link" href="#registrar-atencion">Registrar atención</a></td>
                    </tr>
                    <tr>
                        <td class="principal">13/11/2026</td>
                        <td>11:00</td>
                        <td>Perez, Sofia</td>
                        <td>33.201.447</td>
                        <td><span class="badge badge-pendiente">Pendiente</span></td>
                        <td>-</td>
                        <td class="acciones"><a class="btn-link" href="#registrar-atencion">Registrar atención</a></td>
                    </tr>
                    <tr>
                        <td class="principal">16/11/2026</td>
                        <td>08:00</td>
                        <td>Diaz, Carlos</td>
                        <td>26.778.120</td>
                        <td><span class="badge badge-pendiente">Pendiente</span></td>
                        <td>-</td>
                        <td class="acciones"><a class="btn-link" href="#registrar-atencion">Registrar atención</a></td>
                    </tr>
                    <tr>
                        <td class="principal">16/11/2026</td>
                        <td>09:00</td>
                        <td>Martinez, Diego</td>
                        <td>29.887.003</td>
                        <td><span class="badge badge-pendiente">Pendiente</span></td>
                        <td>-</td>
                        <td class="acciones"><a class="btn-link" href="#registrar-atencion">Registrar atención</a></td>
                    </tr>
                </tbody>
            </table>
        </div>

        <div class="paginador">
            <span class="info">Mostrando 1 a 6 de 24 registros</span>
            <div class="paginas">
                <a href="MisTurnos.aspx" aria-label="Anterior">&laquo;</a>
                <span class="actual">1</span>
                <a href="MisTurnos.aspx">2</a>
                <a href="MisTurnos.aspx">3</a>
                <a href="MisTurnos.aspx">4</a>
                <a href="MisTurnos.aspx" aria-label="Siguiente">&raquo;</a>
            </div>
        </div>
    </div>

    <div class="tarjeta" id="registrar-atencion">
        <div class="tarjeta-cab">
            <h2>Registrar atención del turno</h2>
            <span class="nota">Turno del 13/11/2026 a las 09:00 - Rodriguez, Juan</span>
        </div>

        <div class="tarjeta-cuerpo">
            <div class="fila">
                <div class="campo medio">
                    <label for="resultado">Resultado del turno <span class="req">*</span></label>
                    <select id="resultado">
                        <option>Presente</option>
                        <option>Ausente</option>
                        <option>Pendiente</option>
                    </select>
                </div>
                <div class="campo">
                    <label for="observacion">Observación de la consulta</label>
                    <textarea id="observacion" rows="4">Paciente presenta mejoría. Se indica continuar con el tratamiento por 10 días y control en 30 días.</textarea>
                </div>
            </div>

            <div class="botones">
                <a class="btn btn-primario" href="MisTurnos.aspx?ok=1#registrar-atencion">Guardar atención</a>
                <a class="btn btn-secundario" href="MisTurnos.aspx">Cancelar</a>
            </div>
        </div>
    </div>

</asp:Content>
