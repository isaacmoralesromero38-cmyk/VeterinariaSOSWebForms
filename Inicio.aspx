<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Inicio.aspx.cs" Inherits="VeterinariaSOSWebForms.Inicio" %>

<!DOCTYPE html>
<html lang="es">
<head runat="server">
    <meta charset="utf-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1" />
    <title>Inicio | Veterinaria SOS</title>

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
            color: #FFFFFF;
            padding: 24px 7%;
            display: flex;
            justify-content: space-between;
            align-items: center;
            gap: 20px;
            flex-wrap: wrap;
        }

        .encabezado h1 {
            margin: 0 0 6px;
            font-size: 28px;
        }

        .encabezado p {
            margin: 0;
            color: #F6E2B3;
        }

        .boton {
            background: #D96C2C;
            color: #FFFFFF;
            border: none;
            padding: 12px 18px;
            border-radius: 8px;
            cursor: pointer;
            font-weight: bold;
        }

        .boton:hover {
            background: #B9531C;
        }

        .contenido {
            max-width: 1100px;
            margin: 35px auto;
            padding: 0 20px;
        }

        .bienvenida {
            background: #FFFFFF;
            border-radius: 14px;
            padding: 28px;
            margin-bottom: 25px;
            border-left: 7px solid #E7A84E;
            box-shadow: 0 4px 12px rgba(39, 76, 86, 0.08);
        }

        .bienvenida h2 {
            margin-top: 0;
            color: #D96C2C;
        }

        .bienvenida p {
            line-height: 1.7;
            margin-bottom: 0;
        }

        .tarjetas {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(230px, 1fr));
            gap: 20px;
        }

        .tarjeta {
            display: flex;
            flex-direction: column;
            align-items: flex-start;
            background: #FFFFFF;
            border-radius: 14px;
            padding: 25px;
            border-top: 6px solid #3E8E7E;
            box-shadow: 0 4px 12px rgba(39, 76, 86, 0.10);
            text-decoration: none;
            color: #274C56;
            transition: transform 0.2s, box-shadow 0.2s;
        }

        .tarjeta:hover {
            transform: translateY(-4px);
            box-shadow: 0 7px 16px rgba(39, 76, 86, 0.18);
        }

        .tarjeta h3 {
            margin-top: 0;
            color: #274C56;
        }

        .tarjeta p {
            line-height: 1.6;
            flex-grow: 1;
        }

        .estado {
            display: inline-block;
            margin-top: 10px;
            color: #3E8E7E;
            font-weight: bold;
            font-size: 13px;
        }

        .pie {
            text-align: center;
            padding: 25px;
            color: #274C56;
        }

        .tarjeta:focus,
        .boton:focus {
            outline: 3px solid #E7A84E;
            outline-offset: 3px;
        }

        @media (max-width: 600px) {
            .encabezado {
                padding: 22px 20px;
            }

            .encabezado h1 {
                font-size: 24px;
            }

            .contenido {
                margin: 22px auto;
            }

            .bienvenida {
                padding: 22px;
            }

            .tarjetas {
                grid-template-columns: 1fr;
            }
        }
    </style>
</head>

<body>
    <form id="form1" runat="server">

        <header class="encabezado">
            <div>
                <h1>Veterinaria SOS</h1>
                <p>Sistema de gestión veterinaria</p>
            </div>

            <asp:Button
                ID="btnCerrarSesion"
                runat="server"
                Text="Cerrar sesión"
                CssClass="boton"
                OnClick="btnCerrarSesion_Click" />
        </header>

        <main class="contenido">

            <section class="bienvenida">
                <h2>¡Hola, Clínica!</h2>

                <p>
                    Bienvenido al sistema de Veterinaria SOS.
                    Desde aquí podrás gestionar la información de los
                    propietarios, sus mascotas y las atenciones veterinarias.
                </p>
            </section>

            <section class="tarjetas">

                <a href="PropietariosMascotas.aspx" class="tarjeta">
                    <h3>Propietarios y mascotas</h3>

                    <p>
                        Consulta la información de los propietarios,
                        busca por identificación o nombre y revisa
                        las mascotas asociadas.
                    </p>

                    <span class="estado">Consultar información →</span>
                </a>

                <a href="RegistroPropietariosMascotas.aspx"
                   class="tarjeta"
                   style="border-top-color: #D96C2C;">

                    <h3>Registro de mascotas</h3>

                    <p>
                        Registra nuevos propietarios y guarda sus
                        mascotas con sus datos correspondientes.
                    </p>

                    <span class="estado">Registrar información →</span>
                </a>

                <a href="HojasAtencion.aspx"
                   class="tarjeta"
                   style="border-top-color: #E7A84E;">

                    <h3>Hojas de atención</h3>

                    <p>
                        Registra y consulta las atenciones veterinarias,
                        incluyendo síntomas, diagnósticos, tratamientos
                        y fechas de atención.
                    </p>

                    <span class="estado">Gestionar atenciones →</span>
                </a>

            </section>
        </main>

        <footer class="pie">
            Veterinaria SOS · Sistema de gestión clínica
        </footer>

    </form>
</body>
</html>