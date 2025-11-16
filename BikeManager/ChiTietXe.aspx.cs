using MySql.Data.MySqlClient;
using System;
using System.Configuration;
using System.Web.UI;

namespace BikeManager
{
    public partial class ChiTietXe : System.Web.UI.Page
    {
        string connStr = ConfigurationManager.ConnectionStrings["MySqlConn"].ConnectionString;

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                
                if (Session["MaNguoiDung"] != null)
                {
                    pnlChuaDangNhap.Visible = false;
                    pnlDaDangNhap.Visible = true;
                    lblTenNguoiDung.Text = Session["HoTen"]?.ToString() ?? "Người dùng";
                }
                else
                {
                    pnlChuaDangNhap.Visible = true;
                    pnlDaDangNhap.Visible = false;
                }

                // Load thông tin xe
                if (Request.QueryString["id"] != null && int.TryParse(Request.QueryString["id"], out int maXe))
                    LoadThongTinXe(maXe);
            }
        }

        private void LoadThongTinXe(int maXe)
        {
            using (MySqlConnection conn = new MySqlConnection(connStr))
            {
                string sql = @"
                    SELECT 
                        x.*, 
                        n.HoTen AS ChuXe, 
                        h.TenHangXe, 
                        l.TenLoai
                    FROM xe x
                    LEFT JOIN nguoidung n ON x.MaChuXe = n.MaNguoiDung
                    LEFT JOIN hangxe h ON x.HangXe = h.MaHangXe
                    LEFT JOIN loaixe l ON x.LoaiXe = l.MaLoai
                    WHERE x.MaXe = @MaXe";

                MySqlCommand cmd = new MySqlCommand(sql, conn);
                cmd.Parameters.AddWithValue("@MaXe", maXe);

                conn.Open();
                MySqlDataReader dr = cmd.ExecuteReader();
                if (dr.Read())
                {
                    lblTenXe.Text = dr["TenXe"].ToString();
                    lblHangXe.Text = dr["TenHangXe"].ToString();
                    lblLoaiXe.Text = dr["TenLoai"].ToString();
                    lblLoaiDongCo.Text = dr["LoaiDongCo"].ToString();
                    lblNamSX.Text = dr["NamSX"].ToString();
                    lblNhienLieu.Text = dr["NhienLieu"].ToString();
                    lblDungTich.Text = dr["DungTich"].ToString() + " cc";
                    lblSoKm.Text = dr["SoKmDaChay"].ToString() + " km";
                    lblTinhTrang.Text = dr["TinhTrang"].ToString();
                    lblMoTa.Text = dr["MoTa"].ToString();
                    lblChuXe.Text = dr["ChuXe"].ToString();
                    lblDiaChi.Text = dr["DiaChi"].ToString();
                    lblGia.Text = string.Format("{0:N0} VNĐ/ngày", dr["GiaMacDinh"]);
                    imgXe.ImageUrl = dr["AnhUrl"].ToString();
                    lblGiaNgay.Text = string.Format("{0:N0} VNĐ", dr["GiaMacDinh"]);
                }
                conn.Close();
            }
        }

        protected void btnDatXe_Click(object sender, EventArgs e)
        {
            lblThongBao.Text = "";

            if (string.IsNullOrEmpty(txtNgayNhan.Text) || string.IsNullOrEmpty(txtNgayTra.Text))
            {
                lblThongBao.Text = " Vui lòng chọn thời gian nhận và trả xe.";
                return;
            }

            DateTime ngayNhan, ngayTra;
            if (!DateTime.TryParse(txtNgayNhan.Text, out ngayNhan) || !DateTime.TryParse(txtNgayTra.Text, out ngayTra))
            {
                lblThongBao.Text = " Định dạng ngày không hợp lệ.";
                return;
            }

            if (ngayNhan >= ngayTra)
            {
                lblThongBao.Text = " Ngày nhận phải nhỏ hơn ngày trả.";
                return;
            }

            if (ngayNhan.Hour < 6 || ngayTra.Hour > 23)
            {
                lblThongBao.Text = " Thời gian thuê xe phải nằm trong khung 6:00 - 23:00.";
                return;
            }

            int maXe = int.Parse(Request.QueryString["id"]);

         
            using (MySqlConnection conn = new MySqlConnection(connStr))
            {
                string checkSql = @"
                    SELECT COUNT(*) 
                    FROM donxe 
                    WHERE MaXe = @MaXe
                    AND TrangThai NOT IN ('Đã hủy', 'Từ chối')
                    AND (
                        (@Nhan BETWEEN NgayNhan AND NgayTra)
                        OR (@Tra BETWEEN NgayNhan AND NgayTra)
                        OR (NgayNhan BETWEEN @Nhan AND @Tra)
                    )";

                MySqlCommand checkCmd = new MySqlCommand(checkSql, conn);
                checkCmd.Parameters.AddWithValue("@MaXe", maXe);
                checkCmd.Parameters.AddWithValue("@Nhan", ngayNhan);
                checkCmd.Parameters.AddWithValue("@Tra", ngayTra);

                conn.Open();
                int daDat = Convert.ToInt32(checkCmd.ExecuteScalar());
                conn.Close();

                if (daDat > 0)
                {
                    lblThongBao.Text = "🚫 Xe này đã có người đặt trong thời gian bạn chọn. Vui lòng chọn thời gian khác.";
                    return;
                }
            }

            
            Response.Redirect($"XacNhanDatXe.aspx?id_xe={maXe}&nhan={ngayNhan:yyyy-MM-ddTHH:mm}&tra={ngayTra:yyyy-MM-ddTHH:mm}");
        }

        protected void btnDangXuat_Click(object sender, EventArgs e)
        {
            Session.Clear();
            Response.Redirect("Default.aspx");
        }
    }
}
