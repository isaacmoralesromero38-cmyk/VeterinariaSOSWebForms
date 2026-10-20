
<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="HojasAtencion.aspx.cs" Inherits="VeterinariaSOSWebForms.HojasAtencion" %>

<!DOCTYPE html>
<html lang="es">
<head runat="server">
    <meta charset="utf-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1" />
    <title>VeterinariaSOS | Hojas de atención</title>

    <style>
        * {
            box-sizing: border-box;
        }

        body {
            margin: 0;
            font-family: Arial, Helvetica, sans-serif;
            background: #F3F6F5;
            color: #263238;
        }

        .encabezado {
            background: #274C56;
            color: #FFFFFF;
            padding: 25px 20px;
            text-align: center;
        }

        .encabezado h1 {
            margin: 0 0 8px;
        }

        .encabezado p {
            margin: 0;
            color: #F6E2B3;
        }

        .contenedor {
            width: 92%;
            max-width: 1150px;
            margin: 30px auto;
        }

        .panel {
            background: #FFFFFF;
            padding: 25px;
            margin-bottom: 25px;
            border-radius: 12px;
            box-shadow: 0 3px 12px rgba(0, 0, 0, 0.08);
        }

        .panel h2 {
            color: #274C56;
            margin-top: 0;
            border-bottom: 3px solid #E7A84E;
            padding-bottom: 10px;
        }

        .campo {
            margin-bottom: 17px;
        }

        .campo label {
            display: block;
            font-weight: bold;
            margin-bottom: 7px;
            color: #274C56;
        }

        .entrada {
            width: 100%;
            padding: 11px;
            border: 1px solid #B8C7C7;
            border-radius: 6px;
            font-size: 15px;
            font-family: inherit;
        }

        .entrada:focus {
            outline: 2px solid #3E8E7E;
            border-color: #3E8E7E;
        }

        .botones {
            display: flex;
            flex-wrap: wrap;
            gap: 10px;
            margin-top: 20px;
        }

        .boton {
            padding: 12px 18px;
            border: none;
            border-radius: 6px;
            color: #FFFFFF;
            background: #3E8E7E;
            font-size: 15px;
            font-weight: bold;
            cursor: pointer;
        }

        .boton:hover {
            opacity: 0.88;
        }

        .boton-secundario {
            background: #274C56;
        }

        .boton-volver {
            background: #D96C2C;
        }

        .mensaje {
            display: block;
            padding: 14px;
            margin-bottom: 20px;
            border-radius: 7px;
            font-weight: bold;
            overflow-wrap: anywhere;
        }

        .exito {
            color: #155724;
            background: #D4EDDA;
            border: 1px solid #B7DFC2;
        }

        .error {
            color: #842029;
            background: #F8D7DA;
            border: 1px solid #F1AEB5;
        }

        .ayuda {
            color: #526568;
            font-size: 14px;
            line-height: 1.6;
        }

        .tabla-contenedor {
            width: 100%;
            overflow-x: auto;
        }

        .tabla {
            width: 100%;
            border-collapse: collapse;
            margin-top: 12px;
        }

        .tabla th {
            background: #274C56;
            color: #FFFFFF;
            padding: 12px;
            text-align: left;
            white-space: nowrap;
        }

        .tabla td {
            padding: 11px;
            border-bottom: 1px solid #DCE5E3;
            vertical-align: top;
        }

        .tabla tr:nth-child(even) {
            background: #F3F6F5;
        }

        .tabla a {
            color: #274C56;
            font-weight: bold;
        }

        .validador {
            display: block;
            color: #B42318;
            margin-top: 5px;
            font-size: 13px;
        }

        .pie {
            text-align: center;
            padding: 20px;
            background: #274C56;
            color: #FFFFFF;
            margin-top: 35px;
        }

        @media (max-width: 650px) {
            .contenedor {
                width: 95%;
                margin: 18px auto;
            }

            .panel {
                padding: 17px;
            }

            .botones {
                flex-direction: column;
            }

            .boton {
                width: 100%;
            }
        }
    </style>
</head>

<body>
    <form id="form1" runat="server">

        <header class="encabezado">
            <h1>VeterinariaSOS</h1>
            <p>Registro y control de hojas de atención veterinaria</p>
        </header>

        <main class="contenedor">

            <asp:Label ID="lblMensaje" runat="server"
                CssClass="mensaje"
                EnableViewState="false" />

            <asp:HiddenField ID="hfIdHoja" runat="server" />

            <section class="panel">
                <h2>Registro y mantenimiento de atenciones</h2>

                <p class="ayuda">
                    Completa los datos de la consulta. Utiliza el ID
                    de una mascota registrada. Para modificar o eliminar
                    una atención existente, selecciónala en la tabla inferior.
                </p>

                <div class="campo">
                    <asp:Label ID="lblIdMascota" runat="server"
                        AssociatedControlID="txtIdMascota"
                        Text="ID de la mascota" />

                    <asp:TextBox ID="txtIdMascota" runat="server"
                        CssClass="entrada"
                        TextMode="Number" />

                    <asp:RequiredFieldValidator ID="valIdMascota"
                        runat="server"
                        ControlToValidate="txtIdMascota"
                        ErrorMessage="Ingresa el ID de la mascota."
                        CssClass="validador"
                        Display="Dynamic" />
                </div>

                <div class="campo">
                    <asp:Label ID="lblFecha" runat="server"
                        AssociatedControlID="txtFecha"
                        Text="Fecha de atención" />

                    <asp:TextBox ID="txtFecha" runat="server"
                        CssClass="entrada"
                        TextMode="Date" />

                    <asp:RequiredFieldValidator ID="valFecha"
                        runat="server"
                        ControlToValidate="txtFecha"
                        ErrorMessage="Selecciona la fecha de atención."
                        CssClass="validador"
                        Display="Dynamic" />
                </div>

                <div class="campo">
                    <asp:Label ID="lblSintomas" runat="server"
                        AssociatedControlID="txtSintomas"
                        Text="Síntomas (máximo 150 caracteres)" />

                    <asp:TextBox ID="txtSintomas" runat="server"
                        CssClass="entrada"
                        TextMode="MultiLine"
                        Rows="3"
                        MaxLength="150" />

                    <asp:RequiredFieldValidator ID="valSintomas"
                        runat="server"
                        ControlToValidate="txtSintomas"
                        ErrorMessage="Ingresa los síntomas."
                        CssClass="validador"
                        Display="Dynamic" />
                </div>

                <div class="campo">
                    <asp:Label ID="lblDiagnostico" runat="server"
                        AssociatedControlID="txtDiagnostico"
                        Text="Diagnóstico (máximo 150 caracteres)" />

                    <asp:TextBox ID="txtDiagnostico" runat="server"
                        CssClass="entrada"
                        TextMode="MultiLine"
                        Rows="3"
                        MaxLength="150" />

                    <asp:RequiredFieldValidator ID="valDiagnostico"
                        runat="server"
                        ControlToValidate="txtDiagnostico"
                        ErrorMessage="Ingresa el diagnóstico."
                        CssClass="validador"
                        Display="Dynamic" />
                </div>

                <div class="campo">
                    <asp:Label ID="lblTratamiento" runat="server"
                        AssociatedControlID="txtTratamiento"
                        Text="Tratamiento (máximo 150 caracteres)" />

                    <asp:TextBox ID="txtTratamiento" runat="server"
                        CssClass="entrada"
                        TextMode="MultiLine"
                        Rows="3"
                        MaxLength="150" />

                    <asp:RequiredFieldValidator ID="valTratamiento"
                        runat="server"
                        ControlToValidate="txtTratamiento"
                        ErrorMessage="Ingresa el tratamiento."
                        CssClass="validador"
                        Display="Dynamic" />
                </div>

                <div class="botones">
                    <asp:Button ID="btnGuardar" runat="server"
                        Text="Guardar atención"
                        CssClass="boton"
                        OnClick="btnGuardar_Click" />

                    <asp:Button ID="btnActualizar" runat="server"
                        Text="Guardar cambios"
                        CssClass="boton"
                        CausesValidation="false"
                        Visible="false"
                        OnClick="btnActualizar_Click" />

                    <asp:Button ID="btnEliminar" runat="server"
                        Text="Eliminar atención"
                        CssClass="boton boton-volver"
                        CausesValidation="false"
                        Visible="false"
                        OnClick="btnEliminar_Click"
                        OnClientClick="return confirm('¿Estás seguro de eliminar esta hoja de atención? Esta acción no se puede deshacer.');" />

                    <asp:Button ID="btnCancelarEdicion" runat="server"
                        Text="Cancelar edición"
                        CssClass="boton boton-secundario"
                        CausesValidation="false"
                        Visible="false"
                        OnClick="btnCancelarEdicion_Click" />

                    <asp:Button ID="btnConsultar" runat="server"
                        Text="Consultar hojas"
                        CssClass="boton boton-secundario"
                        CausesValidation="false"
                        OnClick="btnConsultar_Click" />

                    <asp:Button ID="btnVolver" runat="server"
                        Text="Volver al inicio"
                        CssClass="boton boton-volver"
                        CausesValidation="false"
                        OnClick="btnVolver_Click" />
                </div>
            </section>

            <section class="panel">
                <h2>Hojas de atención registradas</h2>

                <p class="ayuda">
                    Selecciona una atención para cargar sus datos
                    en el formulario y realizar cambios o eliminarla.
                </p>

                <div class="tabla-contenedor">
                    <asp:GridView ID="gvHojas" runat="server"
                        AutoGenerateColumns="false"
                        DataKeyNames="HOJ_ID"
                        CssClass="tabla"
                        EmptyDataText="Todavía no hay hojas de atención registradas."
                        GridLines="None"
                        OnSelectedIndexChanged="gvHojas_SelectedIndexChanged">

                        <Columns>
                            <asp:BoundField DataField="HOJ_ID"
                                HeaderText="ID Hoja" />

                            <asp:BoundField DataField="HOJ_FECHA_ATENCION"
                                HeaderText="Fecha"
                                DataFormatString="{0:dd/MM/yyyy}" />

                            <asp:BoundField DataField="HOJ_MAS_ID"
                                HeaderText="ID Mascota" />

                            <asp:BoundField DataField="MAS_NOMBRE"
                                HeaderText="Mascota" />

                            <asp:BoundField DataField="HOJ_SINTOMAS"
                                HeaderText="Síntomas" />

                            <asp:BoundField DataField="HOJ_DIAGNOSTICO"
                                HeaderText="Diagnóstico" />

                            <asp:BoundField DataField="HOJ_TRATAMIENTO"
                                HeaderText="Tratamiento" />

                            <asp:BoundField DataField="HOJ_ADICIONADO_POR"
                                HeaderText="Registrado por" />

                            <asp:CommandField
                                ShowSelectButton="true"
                                SelectText="Seleccionar" />
                        </Columns>
                    </asp:GridView>
                </div>
            </section>

        </main>

        <footer class="pie">
            VeterinariaSOS | Sistema de gestión veterinaria
        </footer>

    </form>
</body>
</html>