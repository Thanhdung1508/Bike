using MySql.Data.MySqlClient;
using System;
using System.Collections.Generic;
using System.Configuration;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace BikeManager.Admin
{
    public partial class TrangChu : System.Web.UI.Page
    {
        string connStr = ConfigurationManager.ConnectionStrings["MySqlConn"].ConnectionString;
        protected void Page_Load(object sender, EventArgs e)
        {
            if (Session["UserID"] == null || Session["VaiTro"]?.ToString() != "Admin")
            {
                Response.Redirect("../DangNhap.aspx");
                return;
            }

            if (!IsPostBack)
            {
                lblTenAdmin.Text = Session["UserName"].ToString();
                LoadThongKe();
            }
        }

        private void LoadThongKe()
        {
            using (MySqlConnection conn = new MySqlConnection(connStr))
            {
                conn.Open();

                lblSoXe.Text = new MySqlCommand("SELECT COUNT(*) FROM xe", conn).ExecuteScalar().ToString();
                lblSoNguoiThue.Text = new MySqlCommand("SELECT COUNT(*) FROM nguoidung WHERE vaitro='User'", conn).ExecuteScalar().ToString();
                lblSoHopDong.Text = new MySqlCommand("SELECT COUNT(*) FROM hopdong", conn).ExecuteScalar().ToString();
                lblXeBaoTri.Text = new MySqlCommand("SELECT COUNT(*) FROM xe WHERE tinhtrang='Bao Tri'", conn).ExecuteScalar().ToString();
            }
        }
    }
    }
