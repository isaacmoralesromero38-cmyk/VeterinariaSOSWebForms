using System;
using System.Data;
using System.Data.SqlClient;
using System.Globalization;
using System.Web.UI;
using System.Web.UI.WebControls;
using VeterinariaSOSWebForms.AccesoDatos;

namespace VeterinariaSOSWebForms
{
    public partial class RegistroPropietariosMascotas : Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (Session["Usuario"] == null)
            {
                Response.Redirect("Default.aspx");
            }
        }

        protected void btnGuardar_Click(object sender, EventArgs e)
        {
            if (!Page.IsValid)
                return;

            DateTime fechaNacimiento;
            decimal peso;

            if (!DateTime.TryParseExact(
                txtFechaNacimiento.Text,
                "yyyy-MM-dd",
                CultureInfo.InvariantCulture,
                DateTimeStyles.None,
                out fechaNacimiento))
            {
                MostrarError("Selecciona una fecha de nacimiento válida.");
                return;
            }

            if (fechaNacimiento.Date > DateTime.Today)
            {
                MostrarError("La fecha de nacimiento no puede ser futura.");
                return;
            }

            bool pesoValido = decimal.TryParse(
                txtPeso.Text.Trim(),
                NumberStyles.Number,
                CultureInfo.CurrentCulture,
                out peso);

            if (!pesoValido)
            {
                pesoValido = decimal.TryParse(
                    txtPeso.Text.Trim(),
                    NumberStyles.Number,
                    CultureInfo.InvariantCulture,
                    out peso);
            }

            if (!pesoValido || peso <= 0)
            {
                MostrarError("Ingresa un peso válido mayor que cero.");
                return;
            }

            if (ddlSexo.SelectedValue != "Hembra" &&
                ddlSexo.SelectedValue != "Macho")
            {
                MostrarError("Selecciona Hembra o Macho.");
                return;
            }

            string usuario = Convert.ToString(Session["Usuario"]);

            using (SqlConnection conexion = ConexionBD.ObtenerConexion())
            {
                conexion.Open();

                using (SqlTransaction transaccion =
                    conexion.BeginTransaction())
                {
                    try
                    {
                        string sqlPropietario = @"
                            INSERT INTO dbo.VT_PROPIETARIOS
                            (
                                PRO_IDENTIFICACION,
                                PRO_PRIMER_NOMBRE,
                                PRO_SEGUNDO_NOMBRE,
                                PRO_PRIMER_APELLIDO,
                                PRO_SEGUNDO_APELLIDO,
                                PRO_TELEFONO,
                                PRO_CORREO,
                                PRO_ADICIONADO_POR,
                                PRO_FECHA_ADICION
                            )
                            VALUES
                            (
                                @identificacion,
                                @primerNombre,
                                @segundoNombre,
                                @primerApellido,
                                @segundoApellido,
                                @telefono,
                                @correo,
                                @usuario,
                                GETDATE()
                            );

                            SELECT CAST(SCOPE_IDENTITY() AS INT);";

                        int idPropietario;

                        using (SqlCommand comando =
                            new SqlCommand(sqlPropietario, conexion, transaccion))
                        {
                            comando.Parameters.Add(
                                "@identificacion", SqlDbType.VarChar, 30
                            ).Value = txtIdentificacion.Text.Trim();

                            comando.Parameters.Add(
                                "@primerNombre", SqlDbType.VarChar, 100
                            ).Value = txtPrimerNombre.Text.Trim();

                            comando.Parameters.Add(
                                "@segundoNombre", SqlDbType.VarChar, 100
                            ).Value = txtSegundoNombre.Text.Trim();

                            comando.Parameters.Add(
                                "@primerApellido", SqlDbType.VarChar, 100
                            ).Value = txtPrimerApellido.Text.Trim();

                            comando.Parameters.Add(
                                "@segundoApellido", SqlDbType.VarChar, 100
                            ).Value = txtSegundoApellido.Text.Trim();

                            comando.Parameters.Add(
                                "@telefono", SqlDbType.VarChar, 30
                            ).Value = txtTelefono.Text.Trim();

                            comando.Parameters.Add(
                                "@correo", SqlDbType.VarChar, 150
                            ).Value = txtCorreo.Text.Trim();

                            comando.Parameters.Add(
                                "@usuario", SqlDbType.VarChar, 100
                            ).Value = usuario;

                            idPropietario = Convert.ToInt32(
                                comando.ExecuteScalar());
                        }

                        string sqlMascota = @"
                            INSERT INTO dbo.VT_MASCOTAS
                            (
                                MAS_NOMBRE,
                                MAS_FECHA_NACIMIENTO,
                                MAS_SEXO,
                                MAS_PESO,
                                MAS_ALERGIAS,
                                MAS_PRO_ID,
                                MAS_ADICIONADO_POR,
                                MAS_FECHA_ADICION
                            )
                            VALUES
                            (
                                @nombre,
                                @fecha,
                                @sexo,
                                @peso,
                                @alergias,
                                @idPropietario,
                                @usuario,
                                GETDATE()
                            );";

                        using (SqlCommand comando =
                            new SqlCommand(sqlMascota, conexion, transaccion))
                        {
                            comando.Parameters.Add(
                                "@nombre", SqlDbType.VarChar, 100
                            ).Value = txtNombreMascota.Text.Trim();

                            comando.Parameters.Add(
                                "@fecha", SqlDbType.Date
                            ).Value = fechaNacimiento.Date;

                            comando.Parameters.Add(
    "@sexo", SqlDbType.VarChar, 1
).Value = ddlSexo.SelectedValue == "Macho" ? "M" : "H";

                            SqlParameter parametroPeso =
                                comando.Parameters.Add(
                                    "@peso", SqlDbType.Decimal);

                            parametroPeso.Precision = 18;
                            parametroPeso.Scale = 2;
                            parametroPeso.Value = peso;

                            comando.Parameters.Add(
                                "@alergias", SqlDbType.VarChar, 500
                            ).Value = string.IsNullOrWhiteSpace(txtAlergias.Text)
                                ? (object)DBNull.Value
                                : txtAlergias.Text.Trim();

                            comando.Parameters.Add(
                                "@idPropietario", SqlDbType.Int
                            ).Value = idPropietario;

                            comando.Parameters.Add(
                                "@usuario", SqlDbType.VarChar, 100
                            ).Value = usuario;

                            comando.ExecuteNonQuery();
                        }

                        transaccion.Commit();

                        lblMensaje.CssClass = "mensaje exito";
                        lblMensaje.Text =
                            "¡Registro guardado correctamente! ID del propietario: "
                            + idPropietario
                            + ". Ya puedes consultar los datos.";

                        LimpiarFormulario();
                    }
                    catch (Exception ex)
                    {
                        try
                        {
                            transaccion.Rollback();
                        }
                        catch
                        {
                            // La transacción puede haberse cerrado.
                        }

                        MostrarError(
                            "Error al guardar: " + ex.Message);
                    }
                }
            }
        }

        private void LimpiarFormulario()
        {
            txtIdentificacion.Text = "";
            txtTelefono.Text = "";
            txtPrimerNombre.Text = "";
            txtSegundoNombre.Text = "";
            txtPrimerApellido.Text = "";
            txtSegundoApellido.Text = "";
            txtCorreo.Text = "";
            txtNombreMascota.Text = "";
            txtFechaNacimiento.Text = "";
            ddlSexo.SelectedIndex = 0;
            txtPeso.Text = "";
            txtAlergias.Text = "";
        }

        private void MostrarError(string mensaje)
        {
            lblMensaje.CssClass = "mensaje error";
            lblMensaje.Text = mensaje;
        }

        protected void btnVolver_Click(object sender, EventArgs e)
        {
            Response.Redirect("Inicio.aspx");
        }
    }
}