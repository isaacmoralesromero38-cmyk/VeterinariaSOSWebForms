using System;
using System.Data;
using System.Data.SqlClient;
using System.Globalization;
using System.Web.UI;
using System.Web.UI.WebControls;
using VeterinariaSOSWebForms.AccesoDatos;

namespace VeterinariaSOSWebForms
{
    public partial class HojasAtencion : Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (Session["Usuario"] == null)
            {
                Response.Redirect("Default.aspx");
                return;
            }

            if (!IsPostBack)
            {
                txtFecha.Text = DateTime.Today.ToString("yyyy-MM-dd");
                ConfigurarModoRegistro();
                CargarHojas();
            }
        }

        protected void btnGuardar_Click(object sender, EventArgs e)
        {
            Page.Validate();

            if (!Page.IsValid || !ValidarTextos())
                return;

            int idMascota;
            DateTime fecha;

            if (!int.TryParse(txtIdMascota.Text.Trim(), out idMascota)
                || idMascota <= 0)
            {
                MostrarMensaje("Ingrese un ID de mascota válido.", false);
                return;
            }

            if (!DateTime.TryParse(txtFecha.Text, out fecha))
            {
                MostrarMensaje("Ingrese una fecha de atención válida.", false);
                return;
            }

            try
            {
                using (SqlConnection conexion = ConexionBD.ObtenerConexion())
                {
                    conexion.Open();

                    if (!ExisteMascota(conexion, idMascota))
                    {
                        MostrarMensaje("La mascota indicada no existe.", false);
                        return;
                    }

                    string consulta = @"
                        INSERT INTO dbo.VT_HOJA
                        (
                            HOJ_FECHA_ATENCION,
                            HOJ_SINTOMAS,
                            HOJ_DIAGNOSTICO,
                            HOJ_TRATAMIENTO,
                            HOJ_MAS_ID,
                            HOJ_ADICIONADO_POR,
                            HOJ_FECHA_ADICION
                        )
                        VALUES
                        (
                            @fecha,
                            @sintomas,
                            @diagnostico,
                            @tratamiento,
                            @idMascota,
                            @usuario,
                            GETDATE()
                        );";

                    using (SqlCommand comando =
                        new SqlCommand(consulta, conexion))
                    {
                        AgregarParametrosAtencion(
                            comando, fecha, idMascota);

                        comando.Parameters.Add(
                            "@usuario", SqlDbType.VarChar, 15
                        ).Value = ObtenerUsuario();

                        int filas = comando.ExecuteNonQuery();

                        if (filas > 0)
                        {
                            LimpiarFormulario();
                            ConfigurarModoRegistro();
                            CargarHojas();

                            MostrarMensaje(
                                "La hoja de atención se registró correctamente.",
                                true);
                        }
                        else
                        {
                            MostrarMensaje(
                                "No se pudo registrar la hoja de atención.",
                                false);
                        }
                    }
                }
            }
            catch (Exception ex)
            {
                MostrarMensaje(
                    "Error al registrar la atención: " + ex.Message,
                    false);
            }
        }

        protected void btnActualizar_Click(object sender, EventArgs e)
        {
            Page.Validate();

            if (!Page.IsValid || !ValidarTextos())
                return;

            int idHoja;
            int idMascota;
            DateTime fecha;

            if (!int.TryParse(hfIdHoja.Value, out idHoja)
                || idHoja <= 0)
            {
                MostrarMensaje(
                    "Seleccione una hoja de atención válida.",
                    false);
                return;
            }

            if (!int.TryParse(txtIdMascota.Text.Trim(), out idMascota)
                || idMascota <= 0)
            {
                MostrarMensaje("Ingrese un ID de mascota válido.", false);
                return;
            }

            if (!DateTime.TryParse(txtFecha.Text, out fecha))
            {
                MostrarMensaje("Ingrese una fecha válida.", false);
                return;
            }

            try
            {
                using (SqlConnection conexion = ConexionBD.ObtenerConexion())
                {
                    conexion.Open();

                    if (!ExisteMascota(conexion, idMascota))
                    {
                        MostrarMensaje("La mascota indicada no existe.", false);
                        return;
                    }

                    string consulta = @"
                        UPDATE dbo.VT_HOJA
                        SET
                            HOJ_FECHA_ATENCION = @fecha,
                            HOJ_SINTOMAS = @sintomas,
                            HOJ_DIAGNOSTICO = @diagnostico,
                            HOJ_TRATAMIENTO = @tratamiento,
                            HOJ_MAS_ID = @idMascota,
                            HOJ_MODIFICADO_POR = @usuario,
                            HOJ_FECHA_MODIFICACION = GETDATE()
                        WHERE HOJ_ID = @idHoja;";

                    using (SqlCommand comando =
                        new SqlCommand(consulta, conexion))
                    {
                        AgregarParametrosAtencion(
                            comando, fecha, idMascota);

                        comando.Parameters.Add(
                            "@usuario", SqlDbType.VarChar, 15
                        ).Value = ObtenerUsuario();

                        comando.Parameters.Add(
                            "@idHoja", SqlDbType.Int
                        ).Value = idHoja;

                        int filas = comando.ExecuteNonQuery();

                        if (filas > 0)
                        {
                            LimpiarFormulario();
                            ConfigurarModoRegistro();
                            CargarHojas();

                            MostrarMensaje(
                                "La hoja de atención se actualizó correctamente.",
                                true);
                        }
                        else
                        {
                            MostrarMensaje(
                                "No se encontró la hoja que desea actualizar.",
                                false);
                        }
                    }
                }
            }
            catch (Exception ex)
            {
                MostrarMensaje(
                    "Error al actualizar la atención: " + ex.Message,
                    false);
            }
        }

        protected void btnEliminar_Click(object sender, EventArgs e)
        {
            int idHoja;

            if (!int.TryParse(hfIdHoja.Value, out idHoja)
                || idHoja <= 0)
            {
                MostrarMensaje(
                    "Seleccione primero una hoja de atención para eliminar.",
                    false);
                return;
            }

            try
            {
                using (SqlConnection conexion = ConexionBD.ObtenerConexion())
                {
                    conexion.Open();

                    string consulta = @"
                        DELETE FROM dbo.VT_HOJA
                        WHERE HOJ_ID = @idHoja;";

                    using (SqlCommand comando =
                        new SqlCommand(consulta, conexion))
                    {
                        comando.Parameters.Add(
                            "@idHoja", SqlDbType.Int
                        ).Value = idHoja;

                        int filas = comando.ExecuteNonQuery();

                        if (filas > 0)
                        {
                            LimpiarFormulario();
                            ConfigurarModoRegistro();
                            CargarHojas();

                            MostrarMensaje(
                                "La hoja de atención se eliminó correctamente.",
                                true);
                        }
                        else
                        {
                            MostrarMensaje(
                                "No se encontró la hoja que desea eliminar.",
                                false);
                        }
                    }
                }
            }
            catch (Exception ex)
            {
                MostrarMensaje(
                    "Error al eliminar la atención: " + ex.Message,
                    false);
            }
        }

        protected void gvHojas_SelectedIndexChanged(
            object sender, EventArgs e)
        {
            if (gvHojas.SelectedDataKey == null)
            {
                MostrarMensaje(
                    "No se pudo identificar la hoja seleccionada.",
                    false);
                return;
            }

            int idHoja;

            if (!int.TryParse(
                Convert.ToString(gvHojas.SelectedDataKey.Value),
                out idHoja))
            {
                MostrarMensaje("El ID seleccionado no es válido.", false);
                return;
            }

            try
            {
                using (SqlConnection conexion = ConexionBD.ObtenerConexion())
                {
                    conexion.Open();

                    string consulta = @"
                        SELECT
                            HOJ_ID,
                            HOJ_FECHA_ATENCION,
                            HOJ_MAS_ID,
                            HOJ_SINTOMAS,
                            HOJ_DIAGNOSTICO,
                            HOJ_TRATAMIENTO
                        FROM dbo.VT_HOJA
                        WHERE HOJ_ID = @idHoja;";

                    using (SqlCommand comando =
                        new SqlCommand(consulta, conexion))
                    {
                        comando.Parameters.Add(
                            "@idHoja", SqlDbType.Int
                        ).Value = idHoja;

                        using (SqlDataReader lector =
                            comando.ExecuteReader())
                        {
                            if (lector.Read())
                            {
                                hfIdHoja.Value =
                                    lector["HOJ_ID"].ToString();

                                txtIdMascota.Text =
                                    lector["HOJ_MAS_ID"].ToString();

                                txtFecha.Text =
                                    Convert.ToDateTime(
                                        lector["HOJ_FECHA_ATENCION"]
                                    ).ToString("yyyy-MM-dd");

                                txtSintomas.Text =
                                    lector["HOJ_SINTOMAS"].ToString();

                                txtDiagnostico.Text =
                                    lector["HOJ_DIAGNOSTICO"].ToString();

                                txtTratamiento.Text =
                                    lector["HOJ_TRATAMIENTO"].ToString();

                                ConfigurarModoEdicion();

                                MostrarMensaje(
                                    "Hoja cargada. Puede modificar sus datos.",
                                    true);
                            }
                            else
                            {
                                MostrarMensaje(
                                    "No se encontró la hoja seleccionada.",
                                    false);
                            }
                        }
                    }
                }
            }
            catch (Exception ex)
            {
                MostrarMensaje(
                    "Error al cargar la hoja seleccionada: " + ex.Message,
                    false);
            }
        }

        protected void btnCancelarEdicion_Click(
            object sender, EventArgs e)
        {
            LimpiarFormulario();
            ConfigurarModoRegistro();
            CargarHojas();

            MostrarMensaje("Se canceló la edición.", true);
        }

        protected void btnConsultar_Click(object sender, EventArgs e)
        {
            CargarHojas();
            MostrarMensaje("Consulta realizada correctamente.", true);
        }

        protected void btnVolver_Click(object sender, EventArgs e)
        {
            Response.Redirect("Inicio.aspx");
        }

        private void CargarHojas()
        {
            try
            {
                using (SqlConnection conexion = ConexionBD.ObtenerConexion())
                {
                    string consulta = @"
                        SELECT
                            h.HOJ_ID,
                            h.HOJ_FECHA_ATENCION,
                            h.HOJ_MAS_ID,
                            m.MAS_NOMBRE,
                            h.HOJ_SINTOMAS,
                            h.HOJ_DIAGNOSTICO,
                            h.HOJ_TRATAMIENTO,
                            h.HOJ_ADICIONADO_POR
                        FROM dbo.VT_HOJA AS h
                        INNER JOIN dbo.VT_MASCOTAS AS m
                            ON h.HOJ_MAS_ID = m.MAS_ID
                        ORDER BY h.HOJ_ID DESC;";

                    using (SqlDataAdapter adaptador =
                        new SqlDataAdapter(consulta, conexion))
                    {
                        DataTable tabla = new DataTable();
                        adaptador.Fill(tabla);

                        gvHojas.DataSource = tabla;
                        gvHojas.DataBind();
                    }
                }
            }
            catch (Exception ex)
            {
                MostrarMensaje(
                    "Error al cargar las hojas de atención: " + ex.Message,
                    false);
            }
        }

        private bool ExisteMascota(
            SqlConnection conexion, int idMascota)
        {
            string consulta = @"
                SELECT COUNT(*)
                FROM dbo.VT_MASCOTAS
                WHERE MAS_ID = @idMascota;";

            using (SqlCommand comando =
                new SqlCommand(consulta, conexion))
            {
                comando.Parameters.Add(
                    "@idMascota", SqlDbType.Int
                ).Value = idMascota;

                return Convert.ToInt32(
                    comando.ExecuteScalar()) > 0;
            }
        }

        private void AgregarParametrosAtencion(
            SqlCommand comando, DateTime fecha, int idMascota)
        {
            comando.Parameters.Add(
                "@fecha", SqlDbType.Date
            ).Value = fecha.Date;

            comando.Parameters.Add(
                "@sintomas", SqlDbType.VarChar, 150
            ).Value = txtSintomas.Text.Trim();

            comando.Parameters.Add(
                "@diagnostico", SqlDbType.VarChar, 150
            ).Value = txtDiagnostico.Text.Trim();

            comando.Parameters.Add(
                "@tratamiento", SqlDbType.VarChar, 150
            ).Value = txtTratamiento.Text.Trim();

            comando.Parameters.Add(
                "@idMascota", SqlDbType.Int
            ).Value = idMascota;
        }

        private bool ValidarTextos()
        {
            if (string.IsNullOrWhiteSpace(txtSintomas.Text)
                || string.IsNullOrWhiteSpace(txtDiagnostico.Text)
                || string.IsNullOrWhiteSpace(txtTratamiento.Text))
            {
                MostrarMensaje(
                    "Complete los campos de síntomas, diagnóstico y tratamiento.",
                    false);
                return false;
            }

            if (txtSintomas.Text.Trim().Length > 150)
            {
                MostrarMensaje(
                    "Los síntomas no pueden superar los 150 caracteres.",
                    false);
                return false;
            }

            if (txtDiagnostico.Text.Trim().Length > 150)
            {
                MostrarMensaje(
                    "El diagnóstico no puede superar los 150 caracteres.",
                    false);
                return false;
            }

            if (txtTratamiento.Text.Trim().Length > 150)
            {
                MostrarMensaje(
                    "El tratamiento no puede superar los 150 caracteres.",
                    false);
                return false;
            }

            return true;
        }

        private string ObtenerUsuario()
        {
            string usuario = Convert.ToString(Session["Usuario"]);

            if (string.IsNullOrWhiteSpace(usuario))
                return "SISTEMA";

            if (usuario.Length > 15)
                usuario = usuario.Substring(0, 15);

            return usuario;
        }

        private void LimpiarFormulario()
        {
            hfIdHoja.Value = "";
            txtIdMascota.Text = "";
            txtFecha.Text = "";
            txtSintomas.Text = "";
            txtDiagnostico.Text = "";
            txtTratamiento.Text = "";
        }

        private void ConfigurarModoRegistro()
        {
            btnGuardar.Visible = true;
            btnActualizar.Visible = false;
            btnEliminar.Visible = false;
            btnCancelarEdicion.Visible = false;

            gvHojas.SelectedIndex = -1;
        }

        private void ConfigurarModoEdicion()
        {
            btnGuardar.Visible = false;
            btnActualizar.Visible = true;
            btnEliminar.Visible = true;
            btnCancelarEdicion.Visible = true;
        }

        private void MostrarMensaje(string mensaje, bool correcto)
        {
            lblMensaje.Text = mensaje;
            lblMensaje.ForeColor = correcto
                ? System.Drawing.Color.DarkGreen
                : System.Drawing.Color.DarkRed;
        }
    }
}