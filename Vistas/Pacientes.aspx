<%@ Page Title="Gestión de pacientes - Clínica San Rafael" Language="C#" MasterPageFile="~/Site.Master" %>

<asp:Content ID="Content1" ContentPlaceHolderID="Contenido" runat="server">

    <div class="migas"><a href="Default.aspx">Inicio</a> / Gestión de pacientes</div>

    <div class="titulo-pagina">
        <div>
            <h1>Gestión de pacientes</h1>
            <p>Alta, baja, modificación y listado de pacientes de la clínica.</p>
        </div>
        <div class="botones">
            <a class="btn btn-primario" href="PacienteAlta.aspx">+ Nuevo paciente</a>
        </div>
    </div>

    <% if (Request.QueryString["baja"] == "ok") { %>
        <div class="aviso aviso-ok" role="status">
            <span aria-hidden="true">&#10003;</span>
            <div>El paciente se dio de baja correctamente y ya no aparece en el listado.</div>
        </div>
    <% } %>

    <div class="tarjeta">
        <div class="tarjeta-cab">
            <h2>Pacientes registrados</h2>
            <span class="nota">34 registros activos</span>
        </div>

        <div class="filtros">
            <div class="fila">
                <div class="campo">
                    <label for="buscarPaciente">Buscar</label>
                    <input type="text" id="buscarPaciente" placeholder="DNI, nombre, apellido o correo..." />
                </div>
                <div class="campo">
                    <label for="provinciaPaciente">Provincia</label>
                    <select id="provinciaPaciente">
                        <option>Buenos Aires</option>
                        <option>Ciudad Autónoma de Buenos Aires</option>
                        <option>Córdoba</option>
                        <option>Mendoza</option>
                        <option>Santa Fe</option>
                        <option>Salta</option>
                    </select>
                </div>
                <div class="campo">
                    <label for="localidadPaciente">Localidad</label>
                    <select id="localidadPaciente">
                        <option>General Pacheco</option>
                        <option>San Miguel</option>
                        <option>Tigre</option>
                        <option>La Plata</option>
                    </select>
                </div>
                <div class="campo">
                    <label for="sexoPaciente">Sexo</label>
                    <select id="sexoPaciente">
                        <option>Todos</option>
                        <option>Femenino</option>
                        <option>Masculino</option>
                        <option>Otro</option>
                    </select>
                </div>
            </div>
            <div class="botones">
                <a class="btn btn-azul" href="Pacientes.aspx">Buscar</a>
                <a class="btn btn-secundario" href="Pacientes.aspx">Limpiar</a>
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
                        <th>Provincia</th>
                        <th>Teléfono</th>
                        <th>Correo electrónico</th>
                        <th class="acciones">Acciones</th>
                    </tr>
                </thead>
                <tbody>
                    <tr>
                        <td class="principal">30.114.587</td>
                        <td>Maria Gonzalez</td>
                        <td>Femenino</td>
                        <td>General Pacheco</td>
                        <td>Buenos Aires</td>
                        <td>11-4523-8890</td>
                        <td>maria.gonzalez12@mail.com</td>
                        <td class="acciones">
                            <a class="btn-link" href="PacienteModificar.aspx">Editar</a>
                            <a class="btn-link peligro" href="Pacientes.aspx?baja=1">Eliminar</a>
                        </td>
                    </tr>
                    <tr>
                        <td class="principal">28.902.331</td>
                        <td>Juan Rodriguez</td>
                        <td>Masculino</td>
                        <td>San Miguel</td>
                        <td>Buenos Aires</td>
                        <td>11-5012-7745</td>
                        <td>juan.rodriguez4@mail.com</td>
                        <td class="acciones">
                            <a class="btn-link" href="PacienteModificar.aspx">Editar</a>
                            <a class="btn-link peligro" href="Pacientes.aspx?baja=1">Eliminar</a>
                        </td>
                    </tr>
                    <tr>
                        <td class="principal">31.455.902</td>
                        <td>Lucia Lopez</td>
                        <td>Femenino</td>
                        <td>Tigre</td>
                        <td>Buenos Aires</td>
                        <td>11-6788-1120</td>
                        <td>lucia.lopez31@mail.com</td>
                        <td class="acciones">
                            <a class="btn-link" href="PacienteModificar.aspx">Editar</a>
                            <a class="btn-link peligro" href="Pacientes.aspx?baja=1">Eliminar</a>
                        </td>
                    </tr>
                    <tr>
                        <td class="principal">26.778.120</td>
                        <td>Carlos Díaz</td>
                        <td>Masculino</td>
                        <td>Cordoba Capital</td>
                        <td>Córdoba</td>
                        <td>351-422-9087</td>
                        <td>carlos.diaz7@mail.com</td>
                        <td class="acciones">
                            <a class="btn-link" href="PacienteModificar.aspx">Editar</a>
                            <a class="btn-link peligro" href="Pacientes.aspx?baja=1">Eliminar</a>
                        </td>
                    </tr>
                    <tr>
                        <td class="principal">33.201.447</td>
                        <td>Sofia Perez</td>
                        <td>Femenino</td>
                        <td>Rosario</td>
                        <td>Santa Fe</td>
                        <td>341-555-2210</td>
                        <td>sofia.perez22@mail.com</td>
                        <td class="acciones">
                            <a class="btn-link" href="PacienteModificar.aspx">Editar</a>
                            <a class="btn-link peligro" href="Pacientes.aspx?baja=1">Eliminar</a>
                        </td>
                    </tr>
                    <tr>
                        <td class="principal">29.887.003</td>
                        <td>Diego Martinez</td>
                        <td>Masculino</td>
                        <td>La Plata</td>
                        <td>Buenos Aires</td>
                        <td>221-477-3390</td>
                        <td>diego.martinez9@mail.com</td>
                        <td class="acciones">
                            <a class="btn-link" href="PacienteModificar.aspx">Editar</a>
                            <a class="btn-link peligro" href="Pacientes.aspx?baja=1">Eliminar</a>
                        </td>
                    </tr>
                    <tr>
                        <td class="principal">34.560.118</td>
                        <td>Ana Fernandez</td>
                        <td>Femenino</td>
                        <td>Mendoza Capital</td>
                        <td>Mendoza</td>
                        <td>261-433-7781</td>
                        <td>ana.fernandez5@mail.com</td>
                        <td class="acciones">
                            <a class="btn-link" href="PacienteModificar.aspx">Editar</a>
                            <a class="btn-link peligro" href="Pacientes.aspx?baja=1">Eliminar</a>
                        </td>
                    </tr>
                    <tr>
                        <td class="principal">27.334.889</td>
                        <td>Pablo Romero</td>
                        <td>Masculino</td>
                        <td>Salta Capital</td>
                        <td>Salta</td>
                        <td>387-455-1188</td>
                        <td>pablo.romero3@mail.com</td>
                        <td class="acciones">
                            <a class="btn-link" href="PacienteModificar.aspx">Editar</a>
                            <a class="btn-link peligro" href="Pacientes.aspx?baja=1">Eliminar</a>
                        </td>
                    </tr>
                </tbody>
            </table>
        </div>

        <div class="paginador">
            <span class="info">Mostrando 1 a 8 de 34 registros</span>
            <div class="paginas">
                <a href="Pacientes.aspx" aria-label="Anterior">&laquo;</a>
                <span class="actual">1</span>
                <a href="Pacientes.aspx">2</a>
                <a href="Pacientes.aspx">3</a>
                <a href="Pacientes.aspx">4</a>
                <a href="Pacientes.aspx">5</a>
                <a href="Pacientes.aspx" aria-label="Siguiente">&raquo;</a>
            </div>
        </div>
    </div>

    <% if (Request.QueryString["baja"] == "1") { %>
        <div class="velo">
            <div class="modal" role="dialog" aria-modal="true" aria-labelledby="tituloBajaPaciente">
                <div class="modal-cab">
                    <div class="icono" aria-hidden="true">!</div>
                    <h3 id="tituloBajaPaciente">Confirmar baja de paciente</h3>
                </div>
                <div class="modal-cuerpo">
                    <p>¿Está seguro que desea eliminar el paciente <b>Gonzalez, Maria</b> (DNI 30.114.587)?</p>
                    <p>El registro no se borra físicamente: se marca como <b>inactivo</b> (baja lógica) y deja de aparecer en los listados.</p>
                </div>
                <div class="modal-pie">
                    <a class="btn btn-secundario" href="Pacientes.aspx">Cancelar</a>
                    <a class="btn btn-peligro" href="Pacientes.aspx?baja=ok">Sí, eliminar</a>
                </div>
            </div>
        </div>
    <% } %>

</asp:Content>
