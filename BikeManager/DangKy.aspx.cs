using MySql.Data.MySqlClient;
using System;
using System.Configuration;
using System.Security.Cryptography;
using System.Text;
using System.Web.UI;

namespace BikeManager
{
    public partial class DangKy : System.Web.UI.Page
    {
        string connStr = ConfigurationManager.ConnectionStrings["MySqlConn"].ConnectionString;

        protected void Page_Load(object sender, EventArgs e)
        {
        }
        protected void btnDangKy_Click(object sender, EventArgs e)
        {
            string ten = txtTenNguoiDung.Text.Trim();
            string email = txtEmail.Text.Trim();
            string sdt = txtSDT.Text.Trim();
            string matKhau = txtMatKhau.Text.Trim();
            string xacNhan = txtXacNhan.Text.Trim();

            if (string.IsNullOrEmpty(ten) || string.IsNullOrEmpty(email) ||
                string.IsNullOrEmpty(matKhau) || string.IsNullOrEmpty(xacNhan))
            {
                lblThongBao.Text = " Vui lòng nhập đầy đủ thông tin.";
                return;
            }

            if (matKhau != xacNhan)
            {
                lblThongBao.Text = " Mật khẩu xác nhận không khớp.";
                return;
            }

            string hashedPassword = GetMd5(matKhau);

            using (MySqlConnection conn = new MySqlConnection(connStr))
            {
                string query = "INSERT INTO nguoidung (HoTen, Email, MatKhau, SoDienThoai, VaiTro) " +
                               "VALUES (@ten, @em, @mk, @sdt, 'KhachHang')";
                MySqlCommand cmd = new MySqlCommand(query, conn);
                cmd.Parameters.AddWithValue("@ten", ten);
                cmd.Parameters.AddWithValue("@em", email);
                cmd.Parameters.AddWithValue("@mk", hashedPassword);
                cmd.Parameters.AddWithValue("@sdt", sdt);

                try
                {
                    conn.Open();
                    cmd.ExecuteNonQuery();

                    
                    lblThongBao.CssClass = "text-success d-block mt-3 text-center";
                    lblThongBao.Text = "✅ Đăng ký thành công! <a href='DangNhap.aspx'>Đăng nhập ngay</a>";

                 
                    txtTenNguoiDung.Text = "";
                    txtEmail.Text = "";
                    txtSDT.Text = "";
                    txtMatKhau.Text = "";
                    txtXacNhan.Text = "";
                }
                catch (MySqlException ex)
                {
                    if (ex.Message.Contains("Duplicate entry"))
                        lblThongBao.Text = " Email đã tồn tại.";
                    else
                        lblThongBao.Text = " Lỗi hệ thống: " + ex.Message;
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
