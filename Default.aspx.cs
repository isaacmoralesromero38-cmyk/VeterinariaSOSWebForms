using System;
using System.Data;
using System.Data.SqlClient;
using System.Web.UI;
using VeterinariaSOSWebForms.AccesoDatos;

namespace VeterinariaSOSWebForms
{
    public partial class _Default : Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
        }

        protected void btnIngresar_Click(object sender, EventArgs e)
        {
            Page.Validate();

            if (!Page.IsValid)
            {
                lblMensaje.CssClass = "mensaje mensaje-error";
                lblMensaje.Text = "Ingresa tu usuario y contraseña.";
                return;
            }

            string usuario = txtUsuario.Text.Trim();
            string clave = txtClave.Text;

            try
            {
                using (SqlConnection conexion = ConexionBD.ObtenerConexion())
                {
                    string consulta = @"
                        SELECT COUNT(1)
                        FROM dbo.VT_USUARIOS
                        WHERE USU_USUARIO = @Usuario
                          AND USU_CLAVE = @Clave
                          AND USU_ESTADO = 'A';";

                    using (SqlCommand comando = new SqlCommand(consulta, conexion))
                    {
                        comando.Parameters.Add("@Usuario", SqlDbType.VarChar, 15).Value = usuario;
                        comando.Parameters.Add("@Clave", SqlDbType.VarChar, 10).Value = clave;

                        conexion.Open();

                        int existe = Convert.ToInt32(comando.ExecuteScalar());

                        if (existe == 1)
                        {
                            Session["Usuario"] = usuario;

                            Response.Redirect("Inicio.aspx");
                        }
                        else
                        {
                            lblMensaje.CssClass = "mensaje mensaje-error";
                            lblMensaje.Text = "Usuario o contraseña incorrectos, o la cuenta está inactiva.";
                        }
                    }
                }
            }
            catch (SqlException)
            {
                lblMensaje.CssClass = "mensaje mensaje-error";
                lblMensaje.Text = "No se pudo consultar la base de datos. Verifica la conexión con SQL Server.";
            }
            catch (Exception)
            {
                lblMensaje.CssClass = "mensaje mensaje-error";
                lblMensaje.Text = "Ocurrió un error inesperado al intentar ingresar.";
            }
        }
    }
}