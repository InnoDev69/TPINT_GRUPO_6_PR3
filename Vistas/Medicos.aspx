<%@ Page Title="Gestión de médicos - Clínica San Rafael" Language="C#" MasterPageFile="~/Site.Master" %>

<asp:Content ID="Content1" ContentPlaceHolderID="Contenido" runat="server">

    <div class="migas"><a href="Default.aspx">Inicio</a> / Gestión de médicos</div>

    <div class="titulo-pagina">
        <div>
            <h1>Gestión de médicos</h1>
            <p>Alta, baja, modificación y listado de profesionales de la clínica.</p>
        </div>
        <div class="botones">
            <a class="btn btn-primario" href="MedicoAlta.aspx">+ Nuevo médico</a>
        </div>
    </div>

    <% if (Request.QueryString["baja"] == "ok") { %>
        <div class="aviso aviso-ok" role="status">
            <span aria-hidden="true">&#10003;</span>
            <div>El médico se dio de baja correctamente y ya no aparece en el listado.</div>
        </div>
    <% } %>

    <div class="tarjeta">
        <div class="tarjeta-cab">
            <h2>Médicos registrados</h2>
            <span class="nota">15 registros activos</span>
        </div>

        <div class="filtros">
            <div class="fila">
                <div class="campo">
                    <label for="buscarMedico">Buscar</label>
                    <input type="text" id="buscarMedico" placeholder="Legajo, nombre, apellido o DNI..." />
                </div>
                <div class="campo">
                    <label for="especialidadMedico">Especialidad</label>
                    <select id="especialidadMedico">
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
                    <label for="diaMedico">Día de atención</label>
                    <select id="diaMedico">
                        <option>Todos</option>
                        <option>Lunes</option>
                        <option>Martes</option>
                        <option>Miércoles</option>
                        <option>Jueves</option>
                        <option>Viernes</option>
                        <option>Sábado</option>
                    </select>
                </div>
                <div class="acciones-filtro">
                    <a class="btn btn-azul" href="Medicos.aspx">Buscar</a>
                    <a class="btn btn-secundario" href="Medicos.aspx">Limpiar</a>
                </div>
            </div>
        </div>

        <div class="tabla-scroll">
            <table class="grid">
                <thead>
                    <tr>
                        <th>Legajo</th>
                        <th>Médico</th>
                        <th>Especialidad</th>
                        <th>Días de atención</th>
                        <th>Horario</th>
                        <th>Localidad</th>
                        <th class="acciones">Acciones</th>
                    </tr>
                </thead>
                <tbody>
                    <tr>
                        <td class="principal">MP-001</td>
                        <td>Dr. Martin Gomez</td>
                        <td><span class="badge badge-teal">Clínica Médica</span></td>
                        <td>Lun, Mié, Vie</td>
                        <td>08:00 a 12:00 / 14:00 a 18:00</td>
                        <td>General Pacheco</td>
                        <td class="acciones">
                            <a class="btn-link" href="MedicoModificar.aspx">Editar</a>
                            <a class="btn-link peligro" href="Medicos.aspx?baja=1">Eliminar</a>
                        </td>
                    </tr>
                    <tr>
                        <td class="principal">MP-002</td>
                        <td>Dra. Ana Fernandez</td>
                        <td><span class="badge badge-teal">Cardiología</span></td>
                        <td>Mar, Jue, Sáb</td>
                        <td>08:00 a 12:00 / 14:00 a 18:00</td>
                        <td>San Miguel</td>
                        <td class="acciones">
                            <a class="btn-link" href="MedicoModificar.aspx">Editar</a>
                            <a class="btn-link peligro" href="Medicos.aspx?baja=1">Eliminar</a>
                        </td>
                    </tr>
                    <tr>
                        <td class="principal">MP-003</td>
                        <td>Dr. Diego Martinez</td>
                        <td><span class="badge badge-teal">Dermatología</span></td>
                        <td>Lun, Mié, Vie</td>
                        <td>08:00 a 12:00 / 14:00 a 18:00</td>
                        <td>Tigre</td>
                        <td class="acciones">
                            <a class="btn-link" href="MedicoModificar.aspx">Editar</a>
                            <a class="btn-link peligro" href="Medicos.aspx?baja=1">Eliminar</a>
                        </td>
                    </tr>
                    <tr>
                        <td class="principal">MP-004</td>
                        <td>Dra. Carla Sosa</td>
                        <td><span class="badge badge-teal">Pediatría</span></td>
                        <td>Mar, Jue, Sáb</td>
                        <td>08:00 a 12:00 / 14:00 a 18:00</td>
                        <td>La Plata</td>
                        <td class="acciones">
                            <a class="btn-link" href="MedicoModificar.aspx">Editar</a>
                            <a class="btn-link peligro" href="Medicos.aspx?baja=1">Eliminar</a>
                        </td>
                    </tr>
                    <tr>
                        <td class="principal">MP-005</td>
                        <td>Dr. Pablo Romero</td>
                        <td><span class="badge badge-teal">Ginecología</span></td>
                        <td>Lun, Mié, Vie</td>
                        <td>08:00 a 12:00 / 14:00 a 18:00</td>
                        <td>Rosario</td>
                        <td class="acciones">
                            <a class="btn-link" href="MedicoModificar.aspx">Editar</a>
                            <a class="btn-link peligro" href="Medicos.aspx?baja=1">Eliminar</a>
                        </td>
                    </tr>
                    <tr>
                        <td class="principal">MP-006</td>
                        <td>Dra. Lucia Lopez</td>
                        <td><span class="badge badge-teal">Traumatología</span></td>
                        <td>Mar, Jue, Sáb</td>
                        <td>08:00 a 12:00 / 14:00 a 18:00</td>
                        <td>Cordoba Capital</td>
                        <td class="acciones">
                            <a class="btn-link" href="MedicoModificar.aspx">Editar</a>
                            <a class="btn-link peligro" href="Medicos.aspx?baja=1">Eliminar</a>
                        </td>
                    </tr>
                    <tr>
                        <td class="principal">MP-007</td>
                        <td>Dr. Carlos Diaz</td>
                        <td><span class="badge badge-teal">Neurología</span></td>
                        <td>Lun, Mié, Vie</td>
                        <td>08:00 a 12:00 / 14:00 a 18:00</td>
                        <td>Mendoza Capital</td>
                        <td class="acciones">
                            <a class="btn-link" href="MedicoModificar.aspx">Editar</a>
                            <a class="btn-link peligro" href="Medicos.aspx?baja=1">Eliminar</a>
                        </td>
                    </tr>
                    <tr>
                        <td class="principal">MP-008</td>
                        <td>Dra. Sofia Perez</td>
                        <td><span class="badge badge-teal">Oftalmología</span></td>
                        <td>Mar, Jue, Sáb</td>
                        <td>08:00 a 12:00 / 14:00 a 18:00</td>
                        <td>Salta Capital</td>
                        <td class="acciones">
                            <a class="btn-link" href="MedicoModificar.aspx">Editar</a>
                            <a class="btn-link peligro" href="Medicos.aspx?baja=1">Eliminar</a>
                        </td>
                    </tr>
                </tbody>
            </table>
        </div>

        <div class="paginador">
            <span class="info">Mostrando 1 a 8 de 15 registros</span>
            <div class="paginas">
                <a href="Medicos.aspx" aria-label="Anterior">&laquo;</a>
                <span class="actual">1</span>
                <a href="Medicos.aspx">2</a>
                <a href="Medicos.aspx" aria-label="Siguiente">&raquo;</a>
            </div>
        </div>
    </div>

    <% if (Request.QueryString["baja"] == "1") { %>
        <div class="velo">
            <div class="modal" role="dialog" aria-modal="true" aria-labelledby="tituloBajaMedico">
                <div class="modal-cab">
                    <div class="icono" aria-hidden="true">!</div>
                    <h3 id="tituloBajaMedico">Confirmar baja de médico</h3>
                </div>
                <div class="modal-cuerpo">
                    <p>¿Está seguro que desea eliminar al profesional <b>Dr. Martin Gomez</b> (Legajo MP-001)?</p>
                    <p>El registro no se borra físicamente: se marca como <b>inactivo</b> (baja lógica) y no podrá recibir nuevos turnos. Los turnos asignados se conservan.</p>
                </div>
                <div class="modal-pie">
                    <a class="btn btn-secundario" href="Medicos.aspx">Cancelar</a>
                    <a class="btn btn-peligro" href="Medicos.aspx?baja=ok">Sí, eliminar</a>
                </div>
            </div>
        </div>
    <% } %>

</asp:Content>
