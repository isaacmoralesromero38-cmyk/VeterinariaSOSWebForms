<%@ Page Language="C#" AutoEventWireup="true"
    CodeBehind="PruebaConexion.aspx.cs"
    Inherits="VeterinariaSOSWebForms.PruebaConexion" %>

<!DOCTYPE html>
<html>
<head runat="server">
    <title>Prueba de conexión</title>
</head>
<body>
    <form id="form1" runat="server">
        <h2>Prueba de conexión a Veterinaria SOS</h2>
        <asp:Button
            ID="btnProbar"
            runat="server"
            Text="Probar conexión"
            OnClick="btnProbar_Click" />
        <br /><br />
        <asp:Label
            ID="lblResultado"
            runat="server" />
    </form>
</body>
</html>

