<%@ Page Title="Mis pacientes - Clínica San Rafael" Language="C#" MasterPageFile="~/Site.Master" %>

<asp:Content ID="Content1" ContentPlaceHolderID="Contenido" runat="server">

    <div class="migas"><a href="Default.aspx">Inicio</a> / Mis pacientes</div>

    <div class="titulo-pagina">
        <div>
            <h1>Mis pacientes</h1>
            <p>Pacientes que tienen o tuvieron turnos con el profesional.</p>
        </div>
    </div>

    <div class="tarjeta">
        <div class="tarjeta-cab">
            <h2>Pacientes atendidos</h2>
            <span class="nota">12 pacientes</span>
        </div>

        <div class="filtros">
            <div class="fila">
                <div class="campo">
                    <label for="buscarMisPacientes">Buscar</label>
                    <input type="text" id="buscarMisPacientes" placeholder="DNI, apellido o nombre..." />
                </div>
                <div class="campo">
                    <label for="estadoMisPacientes">Último turno</label>
                    <select id="estadoMisPacientes">
                        <option>Todos</option>
                        <option>Este mes</option>
                        <option>Mes anterior</option>
                    </select>
                </div>
                <div class="acciones-filtro">
                    <a class="btn btn-azul" href="MisPacientes.aspx">Buscar</a>
                    <a class="btn btn-secundario" href="MisPacientes.aspx">Limpiar</a>
                </div>
            </div>
        </div>

        <div class="tabla-scroll">
            <table class="grid">
                <thead>
                    <tr>
                        <th>DNI</th>
                        <th>Paciente</th>
                        <th>Sexo</th>
                        <th>Localidad</th>
                        <th>Teléfono</th>
                        <th>Último turno</th>
                        <th class="acciones">Acciones</th>
                    </tr>
                </thead>
                <tbody>
                    <tr>
                        <td class="principal">30.114.587</td>
                        <td>Gonzalez, Maria</td>
                        <td>Femenino</td>
                        <td>General Pacheco</td>
                        <td>11-4523-8890</td>
                        <td>13/11/2026 08:00</td>
                        <td class="acciones"><a class="btn-link" href="MisTurnos.aspx">Ver turnos</a></td>
                    </tr>
                    <tr>
                        <td class="principal">28.902.331</td>
                        <td>Rodriguez, Juan</td>
                        <td>Masculino</td>
                        <td>San Miguel</td>
                        <td>11-5012-7745</td>
                        <td>13/11/2026 09:00</td>
                        <td class="acciones"><a class="btn-link" href="MisTurnos.aspx">Ver turnos</a></td>
                    </tr>
                    <tr>
                        <td class="principal">31.455.902</td>
                        <td>Lopez, Lucia</td>
                        <td>Femenino</td>
                        <td>Tigre</td>
                        <td>11-6788-1120</td>
                        <td>13/11/2026 10:00</td>
                        <td class="acciones"><a class="btn-link" href="MisTurnos.aspx">Ver turnos</a></td>
                    </tr>
                    <tr>
                        <td class="principal">33.201.447</td>
                        <td>Perez, Sofia</td>
                        <td>Femenino</td>
                        <td>Rosario</td>
                        <td>341-555-2210</td>
                        <td>13/11/2026 11:00</td>
                        <td class="acciones"><a class="btn-link" href="MisTurnos.aspx">Ver turnos</a></td>
                    </tr>
                    <tr>
                        <td class="principal">26.778.120</td>
                        <td>Diaz, Carlos</td>
                        <td>Masculino</td>
                        <td>Cordoba Capital</td>
                        <td>351-422-9087</td>
                        <td>16/11/2026 08:00</td>
                        <td class="acciones"><a class="btn-link" href="MisTurnos.aspx">Ver turnos</a></td>
                    </tr>
                    <tr>
                        <td class="principal">29.887.003</td>
                        <td>Martinez, Diego</td>
                        <td>Masculino</td>
                        <td>La Plata</td>
                        <td>221-477-3390</td>
                        <td>16/11/2026 09:00</td>
                        <td class="acciones"><a class="btn-link" href="MisTurnos.aspx">Ver turnos</a></td>
                    </tr>
                </tbody>
            </table>
        </div>

        <div class="paginador">
            <span class="info">Mostrando 1 a 6 de 12 registros</span>
            <div class="paginas">
                <a href="MisPacientes.aspx" aria-label="Anterior">&laquo;</a>
                <span class="actual">1</span>
                <a href="MisPacientes.aspx">2</a>
                <a href="MisPacientes.aspx" aria-label="Siguiente">&raquo;</a>
            </div>
        </div>
    </div>

</asp:Content>
