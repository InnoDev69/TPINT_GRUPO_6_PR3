<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Login.aspx.cs" Inherits="Vistas.Login" %>

<!DOCTYPE html>
<html lang="es-AR">
<head runat="server">
    <meta charset="utf-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1" />
    <title>Iniciar sesión - Clínica San Rafael</title>
    <link href="~/Estilos/estilos.css" rel="stylesheet" runat="server" />
</head>
<body class="login-body">

    <main class="login-card">

        <!-- Columna izquierda: mensaje institucional -->
        <aside class="login-lado">
            <div>
                <div class="marca">
                    <div class="cruz" aria-hidden="true">+</div>
                    <div>
                        <strong>Clínica San Rafael</strong>
                        <span>Sistema de gestión</span>
                    </div>
                </div>

                <h2>Bienvenido al sistema</h2>
                <p>Acceso exclusivo para personal administrativo y médico de la institución.</p>
            </div>

            <div class="pie">TRABAJO PRÁCTICO INTEGRADOR · PROGRAMACIÓN III</div>
        </aside>

        <!-- Columna derecha: formulario -->
        <section class="login-form">
            <h1>Iniciar sesión</h1>
            <p class="subtitulo">Ingrese su usuario y contraseña para continuar.</p>

            <form id="form1" runat="server" defaultbutton="btnIngresar">

                <div class="fila">
                    <div class="campo">
                        <label for="<%= txtUsuario.ClientID %>">Usuario <span class="req">*</span></label>
                        <asp:TextBox ID="txtUsuario" runat="server" MaxLength="30" autocomplete="username" />
                        <asp:RequiredFieldValidator runat="server" ControlToValidate="txtUsuario"
                            ValidationGroup="login" Display="Dynamic" CssClass="error-campo"
                            ErrorMessage="Ingrese el usuario." />
                    </div>
                </div>

                <div class="fila">
                    <div class="campo">
                        <label for="<%= txtContrasenia.ClientID %>">Contraseña <span class="req">*</span></label>
                        <asp:TextBox ID="txtContrasenia" runat="server" TextMode="Password" MaxLength="30" autocomplete="current-password" />
                        <asp:RequiredFieldValidator runat="server" ControlToValidate="txtContrasenia"
                            ValidationGroup="login" Display="Dynamic" CssClass="error-campo"
                            ErrorMessage="Ingrese la contraseña." />
                        <div class="ayuda">La contraseña se muestra oculta por seguridad.</div>
                    </div>
                </div>

                <asp:Button ID="btnIngresar" runat="server" Text="Ingresar" CssClass="btn btn-primario"
                    Style="width: 100%" ValidationGroup="login" OnClick="btnIngresar_Click" />

                <p class="ayuda" style="text-align: center; margin: 14px 0 26px;">¿Olvidó su contraseña? Contacte al administrador.</p>

                <asp:Panel ID="pnlError" runat="server" Visible="false" CssClass="aviso aviso-error" role="alert">
                    <span aria-hidden="true">⚠</span>
                    <div>
                        <b>Usuario o contraseña incorrectos.</b><br />
                        Verifique los datos ingresados e intente nuevamente.
                    </div>
                </asp:Panel>

            </form>
        </section>

    </main>

</body>
</html>
