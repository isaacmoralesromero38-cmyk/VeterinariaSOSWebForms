using System;
using System.Web.UI;
using VeterinariaSOSWebForms.AccesoDatos;

namespace VeterinariaSOSWebForms
{
    public partial class PruebaConexion : Page
    {
        protected void btnProbar_Click(object sender, EventArgs e)
        {
            try
            {
                bool conectada = ConexionBD.ProbarConexion();

                lblResultado.Text = conectada
                    ? "Conexión exitosa con la base de datos VETERINARIASOS."
                    : "No se pudo establecer la conexión.";
            }
            catch (Exception)
            {
                lblResultado.Text =
                    "Error de conexión. Verifica el servidor, la base de datos y los permisos de acceso.";
            }
        }
    }
}