using MySql.Data.MySqlClient;
using System;
using System.Configuration;
using System.Web.UI;

namespace BikeManager
{
    public partial class XacNhanDatXe : Page
    {
        string connStr = ConfigurationManager.ConnectionStrings["MySqlConn"].ConnectionString;

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                if (Request.QueryString["id_xe"] == null)
                {
                    lblStatus.Text = "Không tìm thấy thông tin xe.";
                    lblStatus.CssClass = "text-danger";
                    btnConfirm.Enabled = false;
                    return;
                }

                int maXe = int.Parse(Request.QueryString["id_xe"]);
                DateTime ngayNhan = DateTime.Parse(Request.QueryString["nhan"]);
                DateTime ngayTra = DateTime.Parse(Request.QueryString["tra"]);

                lblThoiGian.Text = $"{ngayNhan:HH:mm dd/MM/yyyy} - {ngayTra:HH:mm dd/MM/yyyy}";

                int soNgay = Math.Max(1, (int)Math.Ceiling((ngayTra - ngayNhan).TotalDays));
                lblSoNgay.Text = soNgay.ToString();

                using (MySqlConnection conn = new MySqlConnection(connStr))
                {
                    string sql = "SELECT TenXe, HangXe, GiaMacDinh, DiaChi, AnhUrl FROM xe WHERE MaXe=@id";
                    MySqlCommand cmd = new MySqlCommand(sql, conn);
                    cmd.Parameters.AddWithValue("@id", maXe);

                    conn.Open();
                    using (var rdr = cmd.ExecuteReader())
                    {
                        if (rdr.Read())
                        {
                            lblTenXe.Text = rdr["TenXe"].ToString();
                            lblHang.Text = rdr["HangXe"].ToString();
                            lblDiaChi.Text = rdr["DiaChi"].ToString();
                            lblGiaCoBan.Text = $"{Convert.ToDecimal(rdr["GiaMacDinh"]):N0} VNĐ/ngày";
                            lblTong.Text = $"{Convert.ToDecimal(rdr["GiaMacDinh"]) * soNgay:N0} VNĐ";
                            imgCarSmall.ImageUrl = rdr["AnhUrl"].ToString();
                        }
                        else
                        {
                            lblStatus.Text = "Xe không tồn tại hoặc đã bị xóa.";
                            lblStatus.CssClass = "text-danger";
                            btnConfirm.Enabled = false;
                        }
                    }
                }

                if (Session["UserID"] != null)
                {
                    int maNguoiDung = int.Parse(Session["UserID"].ToString());
                    using (MySqlConnection conn = new MySqlConnection(connStr))
                    {
                        string sql = "SELECT HoTen, SoDienThoai FROM nguoidung WHERE MaNguoiDung=@id";
                        MySqlCommand cmd = new MySqlCommand(sql, conn);
                        cmd.Parameters.AddWithValue("@id", maNguoiDung);
                        conn.Open();
                        using (var rdr = cmd.ExecuteReader())
                        {
                            if (rdr.Read())
                            {
                                txtTenNguoiDung.Text = rdr["HoTen"].ToString();
                                txtSDTNguoiDung.Text = rdr["SoDienThoai"].ToString();
                            }
                        }
                    }

                    pnlLogged.Visible = true;
                    pnlNotLogged.Visible = false;
                }
                else
                {
                    pnlLogged.Visible = false;
                    pnlNotLogged.Visible = true;
                }
            }
        }

        protected void btnConfirm_Click(object sender, EventArgs e)
        {
            try
            {
                int maXe = int.Parse(Request.QueryString["id_xe"]);
                DateTime ngayNhan = DateTime.Parse(Request.QueryString["nhan"]);
                DateTime ngayTra = DateTime.Parse(Request.QueryString["tra"]);

                string tenNguoiThue = "";
                string sdt = "";
                

                // Nếu có đăng nhập -> lấy sẵn thông tin
                if (Session["UserID"] != null)
                {
                    tenNguoiThue = txtTenNguoiDung.Text;
                    sdt = txtSDTNguoiDung.Text;
                }
                else
                {
                    tenNguoiThue = txtTenKhach.Text.Trim();
                    sdt = txtSDTKhach.Text.Trim();

                    if (string.IsNullOrEmpty(tenNguoiThue) || string.IsNullOrEmpty(sdt))
                    {
                        lblError.Text = "Vui lòng nhập họ tên và số điện thoại.";
                        return;
                    }
                }

                // Thêm đơn thuê
                int maDonMoi;
                using (MySqlConnection conn = new MySqlConnection(connStr))
                {
                    string sql = @"INSERT INTO donxe (MaXe, TenNguoiThue, SoDienThoai, NgayNhan, NgayTra, TrangThai)
                                   VALUES (@MaXe, @Ten, @SDT, @Nhan, @Tra,  'Chờ xác nhận');
                                   SELECT LAST_INSERT_ID();";

                    MySqlCommand cmd = new MySqlCommand(sql, conn);
                    cmd.Parameters.AddWithValue("@MaXe", maXe);
                    cmd.Parameters.AddWithValue("@Ten", tenNguoiThue);
                    cmd.Parameters.AddWithValue("@SDT", sdt);
                    cmd.Parameters.AddWithValue("@Nhan", ngayNhan);
                    cmd.Parameters.AddWithValue("@Tra", ngayTra);
                   

                    conn.Open();
                    maDonMoi = Convert.ToInt32(cmd.ExecuteScalar());
                }

                // Chuyển sang trang cảm ơn
                Response.Redirect($"DatXeThanhCong.aspx?madon={maDonMoi}");
            }
            catch (Exception ex)
            {
                lblError.Text = "Lỗi khi xử lý: " + ex.Message;
                lblError.CssClass = "text-danger";
            }
        }
    }
}
