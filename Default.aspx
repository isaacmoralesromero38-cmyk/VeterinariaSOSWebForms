<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Default.aspx.cs" Inherits="VeterinariaSOSWebForms._Default" %>

<!DOCTYPE html>
<html lang="es">
<head runat="server">
    <meta charset="utf-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1" />
    <title>Ingreso | Veterinaria SOS</title>
    <link href="Estilos/Veterinaria.css" rel="stylesheet" />
</head>
<body>
    <form id="form1" runat="server">
        <main class="login-fondo">
            <section class="login-tarjeta">

                <div class="login-marca">
                    <div aria-hidden="true" style="font-size: 76px;">🐾</div>
                    <h1>Veterinaria SOS</h1>
                    <p>Cuidamos de quienes llenan tu vida de alegría.</p>
                </div>

                <div class="login-formulario">
                    <h2>Bienvenido</h2>
                    <p>Ingresa tus datos para continuar.</p>

                    <div class="campo">
                        <asp:Label ID="lblUsuario" runat="server"
                            AssociatedControlID="txtUsuario"
                            Text="Usuario" />
                        <asp:TextBox ID="txtUsuario" runat="server"
                            MaxLength="50"
                            autocomplete="username"
                            placeholder="Escribe tu usuario" />
                        <asp:RequiredFieldValidator ID="valUsuario"
                            runat="server"
                            ControlToValidate="txtUsuario"
                            ErrorMessage="Ingresa tu usuario."
                            CssClass="mensaje mensaje-error"
                            Display="Dynamic" />
                    </div>

                    <div class="campo">
                        <asp:Label ID="lblClave" runat="server"
                            AssociatedControlID="txtClave"
                            Text="Contraseña" />
                        <asp:TextBox ID="txtClave" runat="server"
                            TextMode="Password"
                            MaxLength="100"
                            autocomplete="current-password"
                            placeholder="Escribe tu contraseña" />
                        <asp:RequiredFieldValidator ID="valClave"
                            runat="server"
                            ControlToValidate="txtClave"
                            ErrorMessage="Ingresa tu contraseña."
                            CssClass="mensaje mensaje-error"
                            Display="Dynamic" />
                    </div>

                    <asp:Button ID="btnIngresar" runat="server"
                        Text="Ingresar"
                        CssClass="btn btn-negro"
                        OnClick="btnIngresar_Click" />

                    <asp:Label ID="lblMensaje" runat="server"
                        EnableViewState="false"
                        role="status" />
                </div>

            </section>
        </main>
    </form>
</body>
</html>