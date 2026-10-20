<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="PropietariosMascotas.aspx.cs" Inherits="VeterinariaSOSWebForms.PropietariosMascotas" %>

<!DOCTYPE html>
<html lang="es">
<head runat="server">
    <meta charset="utf-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1" />
    <title>Propietarios y Mascotas - Veterinaria SOS</title>

    <style>
        * {
            box-sizing: border-box;
        }

        body {
            margin: 0;
            font-family: Arial, sans-serif;
            background: #F6E2B3;
            color: #274C56;
        }

        .encabezado {
            background: #274C56;
            color: white;
            padding: 24px;
            display: flex;
            justify-content: space-between;
            align-items: center;
            gap: 15px;
            flex-wrap: wrap;
        }

        .encabezado h1 {
            margin: 0;
            font-size: 26px;
        }

        .contenedor {
            max-width: 1200px;
            margin: 35px auto;
            padding: 0 20px;
        }

        .panel {
            background: white;
            padding: 25px;
            border-radius: 12px;
            box-shadow: 0 4px 12px rgba(0,0,0,.08);
        }

        .busqueda {
            display: flex;
            flex-wrap: wrap;
            gap: 10px;
            margin: 20px 0;
        }

        .campo {
            flex: 1;
            min-width: 220px;
            padding: 12px;
            border: 1px solid #ccc;
            border-radius: 6px;
            font-size: 15px;
        }

        .boton {
            padding: 12px 18px;
            border: none;
            border-radius: 6px;
            cursor: pointer;
            font-weight: bold;
            text-decoration: none;
            display: inline-block;
        }

        .buscar {
            background: #3E8E7E;
            color: white;
        }

        .limpiar {
            background: #E7A84E;
            color: #000;
        }

        .volver {
            background: #D96C2C;
            color: white;
        }

        .tabla-contenedor {
            overflow-x: auto;
            margin-top: 20px;
        }

        .tabla {
            width: 100%;
            border-collapse: collapse;
            min-width: 900px;
        }

        .tabla th {
            background: #274C56;
            color: white;
            padding: 12px;
            text-align: left;
        }

        .tabla td {
            padding: 11px;
            border-bottom: 1px solid #ddd;
        }

        .tabla tr:nth-child(even) {
            background: #f7f7f7;
        }

        .mensaje {
            display: block;
            margin: 15px 0;
            font-weight: bold;
        }

        .pie {
            text-align: center;
            padding: 20px;
            color: #274C56;
        }
    </style>
</head>
<body>
    <form id="form1" runat="server">

        <header class="encabezado">
            <h1>Veterinaria SOS | Propietarios y Mascotas</h1>
            <asp:Button ID="btnVolver" runat="server"
                Text="Volver al inicio"
                CssClass="boton volver"
                CausesValidation="false"
                OnClick="btnVolver_Click" />
        </header>

        <main class="contenedor">
            <section class="panel">
                <h2>Consulta de propietarios y mascotas</h2>
                <p>
                    Busca por identificación, nombre del propietario
                    o nombre de la mascota.
                </p>

                <div class="busqueda">
                    <asp:TextBox ID="txtBuscar" runat="server"
                        CssClass="campo"
                        MaxLength="100"
                        placeholder="Escribe un nombre o identificación">
                    </asp:TextBox>

                    <asp:Button ID="btnBuscar" runat="server"
                        Text="Buscar"
                        CssClass="boton buscar"
                        OnClick="btnBuscar_Click" />

                    <asp:Button ID="btnLimpiar" runat="server"
                        Text="Mostrar todos"
                        CssClass="boton limpiar"
                        CausesValidation="false"
                        OnClick="btnLimpiar_Click" />
                </div>

                <asp:Label ID="lblMensaje" runat="server"
                    CssClass="mensaje"
                    EnableViewState="false">
                </asp:Label>

                <div class="tabla-contenedor">
                    <asp:GridView ID="gvPropietariosMascotas" runat="server"
                        AutoGenerateColumns="False"
                        CssClass="tabla"
                        EmptyDataText="No se encontraron registros."
                        GridLines="None">

                        <Columns>
                            <asp:BoundField DataField="ID_PROPIETARIO"
                                HeaderText="ID propietario" />
                            <asp:BoundField DataField="IDENTIFICACION"
                                HeaderText="Identificación" />
                            <asp:BoundField DataField="NOMBRE_PROPIETARIO"
                                HeaderText="Propietario" />
                            <asp:BoundField DataField="TELEFONO"
                                HeaderText="Teléfono" />
                            <asp:BoundField DataField="CORREO"
                                HeaderText="Correo" />
                            <asp:BoundField DataField="ID_MASCOTA"
                                HeaderText="ID mascota" />
                            <asp:BoundField DataField="NOMBRE_MASCOTA"
                                HeaderText="Mascota" />
                            <asp:BoundField DataField="FECHA_NACIMIENTO"
                                HeaderText="Nacimiento"
                                DataFormatString="{0:dd/MM/yyyy}"
                                HtmlEncode="False" />
                            <asp:BoundField DataField="SEXO"
                                HeaderText="Sexo" />
                            <asp:BoundField DataField="PESO"
                                HeaderText="Peso (kg)" />
                            <asp:BoundField DataField="ALERGIAS"
                                HeaderText="Alergias" />
                        </Columns>
                    </asp:GridView>
                </div>
            </section>
        </main>

        <footer class="pie">
            Veterinaria SOS - Sistema de gestión veterinaria
        </footer>

    </form>
</body>
</html>
