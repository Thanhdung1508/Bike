using MySql.Data.MySqlClient;
using System.Configuration;

namespace BikeManager   
{
    public static class DbConnection
    {
        private static readonly string connStr =
            ConfigurationManager.ConnectionStrings["MySqlConn"].ConnectionString;

        public static MySqlConnection GetConnection()
        {
            return new MySqlConnection(connStr);
        }
    }
}
