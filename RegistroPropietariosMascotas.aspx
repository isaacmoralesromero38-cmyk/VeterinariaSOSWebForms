<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="RegistroPropietariosMascotas.aspx.cs" Inherits="VeterinariaSOSWebForms.RegistroPropietariosMascotas" %>

<!DOCTYPE html>
<html lang="es">
<head runat="server">
    <meta charset="utf-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1" />
    <title>Registro - Veterinaria SOS</title>
    <style>
        * { box-sizing: border-box; }

        body {
            margin: 0;
            font-family: Arial, sans-serif;
            background: #F6E2B3;
            color: #274C56;
        }

        header {
            background: #274C56;
            color: white;
            padding: 22px;
            display: flex;
            justify-content: space-between;
            align-items: center;
            flex-wrap: wrap;
            gap: 12px;
        }

        header h1 { margin: 0; font-size: 25px; }

        main {
            max-width: 950px;
            margin: 30px auto;
            padding: 0 18px;
        }

        .panel {
            background: white;
            padding: 25px;
            border-radius: 12px;
            box-shadow: 0 4px 12px rgba(0,0,0,.08);
            margin-bottom: 22px;
        }

        .campos {
            display: grid;
            grid-template-columns: repeat(2, minmax(0, 1fr));
            gap: 16px;
        }

        .grupo {
            display: flex;
            flex-direction: column;
            gap: 6px;
        }

        .grupo label { font-weight: bold; }

        .campo {
            width: 100%;
            padding: 11px;
            border: 1px solid #bbb;
            border-radius: 6px;
            font-size: 15px;
        }

        .acciones {
            display: flex;
            gap: 10px;
            flex-wrap: wrap;
            margin-top: 20px;
        }

        .boton {
            border: 0;
            border-radius: 6px;
            padding: 12px 18px;
            cursor: pointer;
            font-weight: bold;
            text-decoration: none;
            display: inline-block;
        }

        .guardar { background: #3E8E7E; color: white; }
        .volver { background: #D96C2C; color: white; }

        .mensaje {
            display: block;
            margin-top: 15px;
            font-weight: bold;
        }

        .error { color: #B42318; }
        .exito { color: #217346; }

        .validacion { color: #B42318; font-size: 13px; }

        @media (max-width: 650px) {
            .campos { grid-template-columns: 1fr; }
        }
    </style>
</head>
<body>
<form id="form1" runat="server">

    <header>
        <h1>Veterinaria SOS | Registro</h1>
        <asp:Button ID="btnVolver" runat="server"
            Text="Volver al inicio"
            CssClass="boton volver"
            CausesValidation="false"
            OnClick="btnVolver_Click" />
    </header>

    <main>
        <section class="panel">
            <h2>Datos del propietario</h2>

            <div class="campos">
                <div class="grupo">
                    <label>Identificación *</label>
                    <asp:TextBox ID="txtIdentificacion" runat="server"
                        CssClass="campo" MaxLength="30" />
                    <asp:RequiredFieldValidator runat="server"
                        ControlToValidate="txtIdentificacion"
                        ErrorMessage="Ingresa la identificación."
                        CssClass="validacion" />
                </div>

                <div class="grupo">
                    <label>Teléfono *</label>
                    <asp:TextBox ID="txtTelefono" runat="server"
                        CssClass="campo" MaxLength="30" />
                    <asp:RequiredFieldValidator runat="server"
                        ControlToValidate="txtTelefono"
                        ErrorMessage="Ingresa el teléfono."
                        CssClass="validacion" />
                </div>

                <div class="grupo">
                    <label>Primer nombre *</label>
                    <asp:TextBox ID="txtPrimerNombre" runat="server"
                        CssClass="campo" MaxLength="100" />
                    <asp:RequiredFieldValidator runat="server"
                        ControlToValidate="txtPrimerNombre"
                        ErrorMessage="Ingresa el primer nombre."
                        CssClass="validacion" />
                </div>

                <div class="grupo">
                    <label>Segundo nombre *</label>
                    <asp:TextBox ID="txtSegundoNombre" runat="server"
                        CssClass="campo" MaxLength="100" />
                    <asp:RequiredFieldValidator runat="server"
                        ControlToValidate="txtSegundoNombre"
                        ErrorMessage="Ingresa el segundo nombre o escribe No aplica."
                        CssClass="validacion" />
                </div>

                <div class="grupo">
                    <label>Primer apellido *</label>
                    <asp:TextBox ID="txtPrimerApellido" runat="server"
                        CssClass="campo" MaxLength="100" />
                    <asp:RequiredFieldValidator runat="server"
                        ControlToValidate="txtPrimerApellido"
                        ErrorMessage="Ingresa el primer apellido."
                        CssClass="validacion" />
                </div>

                <div class="grupo">
                    <label>Segundo apellido *</label>
                    <asp:TextBox ID="txtSegundoApellido" runat="server"
                        CssClass="campo" MaxLength="100" />
                    <asp:RequiredFieldValidator runat="server"
                        ControlToValidate="txtSegundoApellido"
                        ErrorMessage="Ingresa el segundo apellido o escribe No aplica."
                        CssClass="validacion" />
                </div>

                <div class="grupo">
                    <label>Correo electrónico *</label>
                    <asp:TextBox ID="txtCorreo" runat="server"
                        CssClass="campo" MaxLength="150"
                        TextMode="Email" />
                    <asp:RequiredFieldValidator runat="server"
                        ControlToValidate="txtCorreo"
                        ErrorMessage="Ingresa el correo."
                        CssClass="validacion" />
                </div>
            </div>
        </section>

        <section class="panel">
            <h2>Datos de la mascota</h2>

            <div class="campos">
                <div class="grupo">
                    <label>Nombre de la mascota *</label>
                    <asp:TextBox ID="txtNombreMascota" runat="server"
                        CssClass="campo" MaxLength="100" />
                    <asp:RequiredFieldValidator runat="server"
                        ControlToValidate="txtNombreMascota"
                        ErrorMessage="Ingresa el nombre de la mascota."
                        CssClass="validacion" />
                </div>

                <div class="grupo">
                    <label>Fecha de nacimiento *</label>
                    <asp:TextBox ID="txtFechaNacimiento" runat="server"
                        CssClass="campo" TextMode="Date" />
                    <asp:RequiredFieldValidator runat="server"
                        ControlToValidate="txtFechaNacimiento"
                        ErrorMessage="Selecciona la fecha de nacimiento."
                        CssClass="validacion" />
                </div>

                <div class="grupo">
                    <label>Sexo *</label>
                    <asp:DropDownList ID="ddlSexo" runat="server"
                        CssClass="campo">
                        <asp:ListItem Text="Selecciona..." Value="" />
                        <asp:ListItem Text="Hembra" Value="Hembra" />
                        <asp:ListItem Text="Macho" Value="Macho" />
                    </asp:DropDownList>
                    <asp:RequiredFieldValidator runat="server"
                        ControlToValidate="ddlSexo"
                        InitialValue=""
                        ErrorMessage="Selecciona el sexo."
                        CssClass="validacion" />
                </div>

                <div class="grupo">
                    <label>Peso en kilogramos *</label>
                    <asp:TextBox ID="txtPeso" runat="server"
                        CssClass="campo" MaxLength="15"
                        placeholder="Ejemplo: 12.5" />
                    <asp:RequiredFieldValidator runat="server"
                        ControlToValidate="txtPeso"
                        ErrorMessage="Ingresa el peso."
                        CssClass="validacion" />
                </div>

                <div class="grupo">
                    <label>Alergias</label>
                    <asp:TextBox ID="txtAlergias" runat="server"
                        CssClass="campo" MaxLength="500"
                        placeholder="Escribe Ninguna si corresponde." />
                </div>
            </div>

            <div class="acciones">
                <asp:Button ID="btnGuardar" runat="server"
                    Text="Guardar propietario y mascota"
                    CssClass="boton guardar"
                    OnClick="btnGuardar_Click" />
            </div>

            <asp:ValidationSummary ID="vsErrores" runat="server"
                CssClass="validacion"
                HeaderText="Revisa los siguientes campos:" />

            <asp:Label ID="lblMensaje" runat="server"
                CssClass="mensaje" EnableViewState="false" />
        </section>
    </main>
</form>
</body>
</html>