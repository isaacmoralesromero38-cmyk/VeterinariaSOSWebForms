using System;
using System.Data;
using System.Data.SqlClient;
using System.Web.UI;
using VeterinariaSOSWebForms.AccesoDatos;

namespace VeterinariaSOSWebForms
{
    public partial class PropietariosMascotas : Page
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
                CargarPropietariosMascotas("");
            }
        }

        private void CargarPropietariosMascotas(string buscar)
        {
            string consulta = @"
                SELECT
                    p.PRO_ID AS ID_PROPIETARIO,
                    p.PRO_IDENTIFICACION AS IDENTIFICACION,
                    CONCAT(
                        p.PRO_PRIMER_NOMBRE, ' ',
                        p.PRO_SEGUNDO_NOMBRE, ' ',
                        p.PRO_PRIMER_APELLIDO, ' ',
                        p.PRO_SEGUNDO_APELLIDO
                    ) AS NOMBRE_PROPIETARIO,
                    p.PRO_TELEFONO AS TELEFONO,
                    p.PRO_CORREO AS CORREO,
                    m.MAS_ID AS ID_MASCOTA,
                    m.MAS_NOMBRE AS NOMBRE_MASCOTA,
                    m.MAS_FECHA_NACIMIENTO AS FECHA_NACIMIENTO,
                    m.MAS_SEXO AS SEXO,
                    m.MAS_PESO AS PESO,
                    m.MAS_ALERGIAS AS ALERGIAS
                FROM dbo.VT_PROPIETARIOS AS p
                LEFT JOIN dbo.VT_MASCOTAS AS m
                    ON m.MAS_PRO_ID = p.PRO_ID
                WHERE
                    @buscar = ''
                    OR p.PRO_IDENTIFICACION LIKE '%' + @buscar + '%'
                    OR p.PRO_PRIMER_NOMBRE LIKE '%' + @buscar + '%'
                    OR p.PRO_SEGUNDO_NOMBRE LIKE '%' + @buscar + '%'
                    OR p.PRO_PRIMER_APELLIDO LIKE '%' + @buscar + '%'
                    OR p.PRO_SEGUNDO_APELLIDO LIKE '%' + @buscar + '%'
                    OR m.MAS_NOMBRE LIKE '%' + @buscar + '%'
                ORDER BY p.PRO_ID, m.MAS_ID;";

            try
            {
                using (SqlConnection conexion = ConexionBD.ObtenerConexion())
                using (SqlCommand comando = new SqlCommand(consulta, conexion))
                using (SqlDataAdapter adaptador = new SqlDataAdapter(comando))
                {
                    comando.Parameters.Add(
                        "@buscar", SqlDbType.VarChar, 100
                    ).Value = buscar.Trim();

                    DataTable tabla = new DataTable();
                    adaptador.Fill(tabla);

                    gvPropietariosMascotas.DataSource = tabla;
                    gvPropietariosMascotas.DataBind();

                    lblMensaje.Text = tabla.Rows.Count > 0
                        ? "Registros encontrados: " + tabla.Rows.Count
                        : "No se encontraron propietarios o mascotas con ese criterio.";
                }
            }
            catch (Exception)
            {
                gvPropietariosMascotas.DataSource = null;
                gvPropietariosMascotas.DataBind();

                lblMensaje.Text =
                    "No fue posible cargar los datos. Verifica la conexión y la estructura de la base de datos.";
            }
        }

        protected void btnBuscar_Click(object sender, EventArgs e)
        {
            CargarPropietariosMascotas(txtBuscar.Text);
        }

        protected void btnLimpiar_Click(object sender, EventArgs e)
        {
            txtBuscar.Text = "";
            CargarPropietariosMascotas("");
        }

        protected void btnVolver_Click(object sender, EventArgs e)
        {
            Response.Redirect("Inicio.aspx");
        }
    }
}