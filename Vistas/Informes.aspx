<%@ Page Title="Informes y estadísticas - Clínica San Rafael" Language="C#" MasterPageFile="~/Site.Master" %>

<asp:Content ID="Content1" ContentPlaceHolderID="Contenido" runat="server">

    <div class="migas"><a href="Default.aspx">Inicio</a> / Informes y estadísticas</div>

    <div class="titulo-pagina">
        <div>
            <h1>Informes y estadísticas</h1>
            <p>Reportes con parámetros calculados con SUM, COUNT y porcentajes sobre la base de datos.</p>
        </div>
    </div>

    <div class="tarjeta">
        <div class="tarjeta-cab">
            <h2>Informe de asistencia</h2>
            <span class="nota">Información procesada a partir de los turnos</span>
        </div>

        <div class="tarjeta-cuerpo">
            <div class="fila">
                <div class="campo medio">
                    <label for="fechaDesde">Fecha desde</label>
                    <input type="date" id="fechaDesde" value="2026-10-01" />
                </div>
                <div class="campo medio">
                    <label for="fechaHasta">Fecha hasta</label>
                    <input type="date" id="fechaHasta" value="2026-11-30" />
                </div>
                <div class="campo">
                    <label for="especialidadInforme">Especialidad</label>
                    <select id="especialidadInforme">
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
                <div class="acciones-filtro">
                    <a class="btn btn-azul" href="Informes.aspx">Generar informe</a>
                </div>
            </div>
        </div>
    </div>

    <div class="reportes-grid">

        <div class="tarjeta">
            <div class="tarjeta-cab">
                <h2>Porcentaje de presentes y ausentes</h2>
                <span class="nota">01/10/2026 al 30/11/2026</span>
            </div>
            <div class="tarjeta-cuerpo">
                <div class="torta">
                    <div class="circulo asistencia">
                        <div class="centro">
                            <b>71,4%</b>
                            <small>Presentes</small>
                        </div>
                    </div>
                    <div class="detalle">
                        <table class="grid">
                            <thead>
                                <tr>
                                    <th>Resultado</th>
                                    <th>Turnos</th>
                                    <th>Porcentaje</th>
                                </tr>
                            </thead>
                            <tbody>
                                <tr>
                                    <td>Presentes</td>
                                    <td>15</td>
                                    <td>71,4%</td>
                                </tr>
                                <tr>
                                    <td>Ausentes</td>
                                    <td>6</td>
                                    <td>28,6%</td>
                                </tr>
                            </tbody>
                            <tfoot>
                                <tr>
                                    <td class="principal">Total cerrados</td>
                                    <td class="principal">21</td>
                                    <td class="principal">100%</td>
                                </tr>
                            </tfoot>
                        </table>
                        <p class="nota-pie">Solo se consideran los turnos con estado Presente o Ausente dentro del rango seleccionado. Los turnos pendientes no se contabilizan.</p>
                    </div>
                </div>
            </div>
        </div>

        <div class="tarjeta">
            <div class="tarjeta-cab">
                <h2>Turnos por especialidad</h2>
                <span class="nota">Cantidad y porcentaje del total</span>
            </div>
            <div class="tabla-scroll">
                <table class="grid">
                    <thead>
                        <tr>
                            <th>Especialidad</th>
                            <th>Turnos</th>
                            <th>Presentes</th>
                            <th>Ausentes</th>
                            <th>% del total</th>
                        </tr>
                    </thead>
                    <tbody>
                        <tr>
                            <td>Clínica Médica</td>
                            <td>12</td>
                            <td>9</td>
                            <td>3</td>
                            <td>25,0%</td>
                        </tr>
                        <tr>
                            <td>Cardiología</td>
                            <td>9</td>
                            <td>6</td>
                            <td>3</td>
                            <td>18,8%</td>
                        </tr>
                        <tr>
                            <td>Pediatría</td>
                            <td>7</td>
                            <td>6</td>
                            <td>1</td>
                            <td>14,6%</td>
                        </tr>
                        <tr>
                            <td>Dermatología</td>
                            <td>5</td>
                            <td>4</td>
                            <td>1</td>
                            <td>10,4%</td>
                        </tr>
                        <tr>
                            <td>Traumatología</td>
                            <td>5</td>
                            <td>4</td>
                            <td>1</td>
                            <td>10,4%</td>
                        </tr>
                        <tr>
                            <td>Ginecología</td>
                            <td>4</td>
                            <td>3</td>
                            <td>1</td>
                            <td>8,3%</td>
                        </tr>
                        <tr>
                            <td>Neurología</td>
                            <td>3</td>
                            <td>2</td>
                            <td>1</td>
                            <td>6,3%</td>
                        </tr>
                        <tr>
                            <td>Oftalmología</td>
                            <td>3</td>
                            <td>2</td>
                            <td>1</td>
                            <td>6,3%</td>
                        </tr>
                    </tbody>
                </table>
            </div>
        </div>

    </div>

    <div class="tarjeta">
        <div class="tarjeta-cab">
            <h2>Detalle de pacientes por resultado</h2>
            <span class="nota">Turnos cerrados en el periodo</span>
        </div>

        <div class="tabla-scroll">
            <table class="grid">
                <thead>
                    <tr>
                        <th>Paciente</th>
                        <th>DNI</th>
                        <th>Fecha</th>
                        <th>Médico</th>
                        <th>Especialidad</th>
                        <th>Resultado</th>
                        <th>Observación</th>
                    </tr>
                </thead>
                <tbody>
                    <tr>
                        <td>Gonzalez, Maria</td>
                        <td>30.114.587</td>
                        <td>02/10/2026</td>
                        <td>Dr. Gomez, Martin</td>
                        <td>Clínica Médica</td>
                        <td><span class="badge badge-presente">Presente</span></td>
                        <td>Control de rutina. Sin cambios.</td>
                    </tr>
                    <tr>
                        <td>Rodriguez, Juan</td>
                        <td>28.902.331</td>
                        <td>06/10/2026</td>
                        <td>Dra. Fernandez, Ana</td>
                        <td>Cardiología</td>
                        <td><span class="badge badge-presente">Presente</span></td>
                        <td>Se ajustó medicación.</td>
                    </tr>
                    <tr>
                        <td>Lopez, Lucia</td>
                        <td>31.455.902</td>
                        <td>07/10/2026</td>
                        <td>Dr. Martinez, Diego</td>
                        <td>Dermatología</td>
                        <td><span class="badge badge-ausente">Ausente</span></td>
                        <td>Sin observación.</td>
                    </tr>
                    <tr>
                        <td>Perez, Sofia</td>
                        <td>33.201.447</td>
                        <td>14/10/2026</td>
                        <td>Dra. Sosa, Carla</td>
                        <td>Pediatría</td>
                        <td><span class="badge badge-presente">Presente</span></td>
                        <td>Paciente estable, control en 30 días.</td>
                    </tr>
                    <tr>
                        <td>Diaz, Carlos</td>
                        <td>26.778.120</td>
                        <td>21/10/2026</td>
                        <td>Dr. Romero, Pablo</td>
                        <td>Ginecología</td>
                        <td><span class="badge badge-ausente">Ausente</span></td>
                        <td>Sin observación.</td>
                    </tr>
                </tbody>
            </table>
        </div>

        <div class="paginador">
            <span class="info">Mostrando 1 a 5 de 21 registros</span>
            <div class="paginas">
                <a href="Informes.aspx" aria-label="Anterior">&laquo;</a>
                <span class="actual">1</span>
                <a href="Informes.aspx">2</a>
                <a href="Informes.aspx">3</a>
                <a href="Informes.aspx" aria-label="Siguiente">&raquo;</a>
            </div>
        </div>
    </div>

</asp:Content>
