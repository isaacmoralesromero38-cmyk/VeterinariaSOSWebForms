using System;
using System.Configuration;
using System.Data.SqlClient;

namespace VeterinariaSOSWebForms.AccesoDatos
{
    public class ConexionBD
    {
        public static SqlConnection ObtenerConexion()
        {
            string cadena = ConfigurationManager
                .ConnectionStrings["VeterinariaSOS"]
                .ConnectionString;

            return new SqlConnection(cadena);
        }

        public static bool ProbarConexion()
        {
            using (SqlConnection conexion = ObtenerConexion())
            {
                conexion.Open();
                return conexion.State == System.Data.ConnectionState.Open;
            }
        }
    }
}