<%@ Page Title="Panel de administración - Clínica San Rafael" Language="C#" MasterPageFile="~/Site.Master" %>

<asp:Content ID="Content1" ContentPlaceHolderID="Contenido" runat="server">

    <div class="migas"><a href="Default.aspx">Inicio</a> / Panel de administración</div>

    <div class="titulo-pagina">
        <div>
            <h1>Panel de administración</h1>
            <p>Resumen general de la clínica y accesos rápidos.</p>
        </div>
    </div>

    <div class="kpis">
        <div class="kpi">
            <div class="etiqueta">Pacientes activos</div>
            <div class="valor">34</div>
            <div class="detalle">15 dados de alta este mes</div>
        </div>
        <div class="kpi teal">
            <div class="etiqueta">Médicos activos</div>
            <div class="valor">15</div>
            <div class="detalle">12 especialidades</div>
        </div>
        <div class="kpi ambar">
            <div class="etiqueta">Turnos de hoy</div>
            <div class="valor">8</div>
            <div class="detalle">3 pendientes de atención</div>
        </div>
        <div class="kpi verde">
            <div class="etiqueta">Asistencia del mes</div>
            <div class="valor">72%</div>
            <div class="detalle">Presentes sobre turnos cerrados</div>
        </div>
    </div>

    <div class="tarjeta">
        <div class="tarjeta-cab">
            <h2>Turnos de hoy</h2>
            <span class="nota">Viernes 13/11/2026</span>
        </div>

        <div class="tabla-scroll">
            <table class="grid">
                <thead>
                    <tr>
                        <th>Hora</th>
                        <th>Paciente</th>
                        <th>Médico</th>
                        <th>Especialidad</th>
                        <th>Estado</th>
                    </tr>
                </thead>
                <tbody>
                    <tr>
                        <td class="principal">08:00</td>
                        <td>Gonzalez, Maria</td>
                        <td>Dr. Gomez, Martin</td>
                        <td>Clínica Médica</td>
                        <td><span class="badge badge-presente">Presente</span></td>
                    </tr>
                    <tr>
                        <td class="principal">09:00</td>
                        <td>Rodriguez, Juan</td>
                        <td>Dra. Fernandez, Ana</td>
                        <td>Cardiología</td>
                        <td><span class="badge badge-ausente">Ausente</span></td>
                    </tr>
                    <tr>
                        <td class="principal">10:00</td>
                        <td>Lopez, Lucia</td>
                        <td>Dr. Martinez, Diego</td>
                        <td>Dermatología</td>
                        <td><span class="badge badge-pendiente">Pendiente</span></td>
                    </tr>
                    <tr>
                        <td class="principal">11:00</td>
                        <td>Perez, Sofia</td>
                        <td>Dra. Sosa, Carla</td>
                        <td>Pediatría</td>
                        <td><span class="badge badge-presente">Presente</span></td>
                    </tr>
                    <tr>
                        <td class="principal">14:00</td>
                        <td>Diaz, Carlos</td>
                        <td>Dr. Romero, Pablo</td>
                        <td>Traumatología</td>
                        <td><span class="badge badge-pendiente">Pendiente</span></td>
                    </tr>
                </tbody>
            </table>
        </div>

        <div class="paginador">
            <span class="info">Mostrando 5 de 8 turnos</span>
            <div class="paginas">
                <a href="Default.aspx" aria-label="Anterior">&laquo;</a>
                <span class="actual">1</span>
                <a href="Default.aspx">2</a>
                <a href="Default.aspx" aria-label="Siguiente">&raquo;</a>
            </div>
        </div>
    </div>

    <div class="reportes-grid">

        <div class="tarjeta">
            <div class="tarjeta-cab">
                <h2>Accesos rápidos</h2>
            </div>
            <div class="tarjeta-cuerpo">
                <div class="accesos">
                    <a class="btn btn-primario" href="PacienteAlta.aspx">+ Nuevo paciente</a>
                    <a class="btn btn-azul" href="MedicoAlta.aspx">+ Nuevo médico</a>
                    <a class="btn btn-secundario" href="TurnoAsignar.aspx">+ Asignar turno</a>
                    <a class="btn btn-secundario" href="Informes.aspx">Ver informes</a>
                </div>
                <p class="nota-pie">Los usuarios administradores, las provincias, localidades y especialidades se encuentran precargados en la base de datos y solo se pueden consultar.</p>
            </div>
        </div>

        <div class="tarjeta">
            <div class="tarjeta-cab">
                <h2>Turnos por especialidad (mes en curso)</h2>
            </div>
            <div class="tabla-scroll">
                <table class="grid">
                    <thead>
                        <tr>
                            <th>Especialidad</th>
                            <th>Turnos</th>
                            <th>Presentes</th>
                            <th>Ausentes</th>
                        </tr>
                    </thead>
                    <tbody>
                        <tr>
                            <td>Clínica Médica</td>
                            <td>12</td>
                            <td>9</td>
                            <td>3</td>
                        </tr>
                        <tr>
                            <td>Cardiología</td>
                            <td>9</td>
                            <td>6</td>
                            <td>3</td>
                        </tr>
                        <tr>
                            <td>Pediatría</td>
                            <td>7</td>
                            <td>6</td>
                            <td>1</td>
                        </tr>
                        <tr>
                            <td>Dermatología</td>
                            <td>5</td>
                            <td>4</td>
                            <td>1</td>
                        </tr>
                    </tbody>
                </table>
            </div>
        </div>

    </div>

</asp:Content>
