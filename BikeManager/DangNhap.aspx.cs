using MySql.Data.MySqlClient;
using System;
using System.Configuration;
using System.Security.Cryptography;
using System.Text;
using System.Web.UI;

namespace BikeManager
{
    public partial class DangNhap : Page
    {
        string connStr = ConfigurationManager.ConnectionStrings["MySqlConn"].ConnectionString;

        protected void Page_Load(object sender, EventArgs e)
        {
           
        }
        protected void btnDangNhap_Click(object sender, EventArgs e)
        {
            string email = txtEmail.Text.Trim();
            string matKhau = GetMd5(txtMatKhau.Text.Trim());

            using (MySqlConnection conn = new MySqlConnection(connStr))
            {
                try
                {
                    string query = "SELECT * FROM nguoidung WHERE email=@em AND matkhau=@mk";
                    MySqlCommand cmd = new MySqlCommand(query, conn);
                    cmd.Parameters.AddWithValue("@em", email);
                    cmd.Parameters.AddWithValue("@mk", matKhau);
                    conn.Open();
                    MySqlDataReader dr = cmd.ExecuteReader();
                    if (dr.Read())
                    {   
                        Session["UserID"] = dr["MaNguoiDung"].ToString();
                        Session["UserName"] = dr["HoTen"].ToString();
                        Session["VaiTro"] = dr["vaitro"].ToString();
                        string vaiTro = dr["vaitro"].ToString();
                        dr.Close();
                        conn.Close();
                        if (vaiTro == "Admin")
                            Response.Redirect("Admin/TrangChu.aspx", false);
                        else
                            Response.Redirect("Default.aspx", false);

                        Context.ApplicationInstance.CompleteRequest();
                    }
                    else
                    {
                        lblThongBao.Text = " Email hoặc mật khẩu không đúng!";
                    }
                }
                catch (Exception ex)
                {
                    lblThongBao.Text = "Lỗi đăng nhập: " + ex.Message;
                }
                finally
                {
                    if (conn.State == System.Data.ConnectionState.Open)
                        conn.Close();
                }
            }
        }

        private string GetMd5(string input)
        {
            using (MD5 md5 = MD5.Create())
            {
                byte[] inputBytes = Encoding.UTF8.GetBytes(input);
                byte[] hashBytes = md5.ComputeHash(inputBytes);
                StringBuilder sb = new StringBuilder();
                foreach (byte b in hashBytes)
                    sb.Append(b.ToString("x2"));
                return sb.ToString();
            }
        }
    }
}
