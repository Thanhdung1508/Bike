using MySql.Data.MySqlClient;
using System;
using System.Configuration;
using System.Data;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace BikeManager
{
    public partial class TimXe : System.Web.UI.Page
    {
        string connStr = ConfigurationManager.ConnectionStrings["MySqlConn"].ConnectionString;

        DateTime ngayNhan, ngayTra;
        bool coNgay;

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                KiemTraDangNhap();
                DocQueryString();
                LoadKetQua();
            }
        }

        private void DocQueryString()
        {
            string nhan = Request.QueryString["nhan"];
            string tra = Request.QueryString["tra"];

            coNgay = DateTime.TryParse(nhan, out ngayNhan) &&
                     DateTime.TryParse(tra, out ngayTra);
        }

        private void KiemTraDangNhap()
        {
            if (Session["TenDangNhap"] != null)
            {
                pnlDaDangNhap.Visible = true;
                pnlChuaDangNhap.Visible = false;
                lblTenNguoiDung.Text = Session["TenDangNhap"].ToString();
            }
            else
            {
                pnlDaDangNhap.Visible = false;
                pnlChuaDangNhap.Visible = true;
            }
        }

        protected void btnDangXuat_Click(object sender, EventArgs e)
        {
            Session.Clear();
            Response.Redirect("Default.aspx");
        }
        private void LoadKetQua()
        {
            string loai = Request.QueryString["loai"];

            using (MySqlConnection conn = new MySqlConnection(connStr))
            {
                string sql = @"
                               SELECT x.MaXe, x.TenXe, x.GiaMacDinh, x.AnhUrl,
                                 h.TenHangXe, l.TenLoai,
                   CASE 
                       WHEN EXISTS (
                           SELECT 1 FROM donxe d
                           WHERE d.MaXe = x.MaXe
                           AND (@coNgay = 1 AND @Nhan < d.NgayTra AND @Tra > d.NgayNhan)
                       ) THEN FALSE
                       ELSE TRUE
                   END AS XeRanh
                        FROM xe x
                        LEFT JOIN hangxe h ON x.HangXe = h.MaHangXe
                        LEFT JOIN loaixe l ON x.LoaiXe = l.MaLoai
                        WHERE (@Loai = '' OR x.LoaiXe = @Loai)
                ";

                MySqlCommand cmd = new MySqlCommand(sql, conn);
                cmd.Parameters.AddWithValue("@Loai", loai ?? "");
                cmd.Parameters.AddWithValue("@coNgay", coNgay ? 1 : 0);

                if (coNgay)
                {
                    cmd.Parameters.AddWithValue("@Nhan", ngayNhan);
                    cmd.Parameters.AddWithValue("@Tra", ngayTra);
                }
                else
                {
                    cmd.Parameters.AddWithValue("@Nhan", DBNull.Value);
                    cmd.Parameters.AddWithValue("@Tra", DBNull.Value);
                }

                conn.Open();
                MySqlDataAdapter da = new MySqlDataAdapter(cmd);
                DataTable dt = new DataTable();
                da.Fill(dt);

                rptXe.DataSource = dt;
                rptXe.DataBind();

                lblThongBao.Text = dt.Rows.Count == 0
                    ? "Không tìm thấy xe phù hợp."
                    : "";
            }
        }
        protected void btnXemLich_Click(object sender, EventArgs e)
        {
            LinkButton btn = (LinkButton)sender;
            string maXe = btn.CommandArgument;

            using (MySqlConnection conn = new MySqlConnection(connStr))
            {
                string sql = @"
                    SELECT DATE_FORMAT(NgayNhan, '%d/%m/%Y %H:%i') AS NgayNhan,
                           DATE_FORMAT(NgayTra, '%d/%m/%Y %H:%i') AS NgayTra
                    FROM donxe
                    WHERE MaXe = @MaXe
                    ORDER BY NgayNhan ASC
                ";

                MySqlCommand cmd = new MySqlCommand(sql, conn);
                cmd.Parameters.AddWithValue("@MaXe", maXe);

                conn.Open();
                MySqlDataAdapter da = new MySqlDataAdapter(cmd);
                DataTable dt = new DataTable();
                da.Fill(dt);

                if (dt.Rows.Count > 0)
                {
                    rptLichXe.DataSource = dt;
                    rptLichXe.DataBind();
                    lblKhongCoLich.Text = "";
                }
                else
                {
                    rptLichXe.DataSource = null;
                    rptLichXe.DataBind();
                    lblKhongCoLich.Text = "Xe này hiện không có lịch thuê nào.";
                }
            }
            ScriptManager.RegisterStartupScript(
                this, this.GetType(),
                "OpenModal", "$('#lichModal').modal('show');", true
            );
        }
    }
}
