using MySql.Data.MySqlClient;
using System;
using System.Configuration;
using System.Data;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace BikeManager
{
    public partial class _Default : Page
    {
        string connStr = ConfigurationManager.ConnectionStrings["MySqlConn"].ConnectionString;

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                KiemTraDangNhap();
                LoadChinhSach();
                LoadHangXe();
                LoadLoaiXe();
                LoadXeTheoLoai(); 
            }
        }
        private void LoadXeTheoLoai()
        {
            using (MySqlConnection conn = new MySqlConnection(connStr))
            {
                conn.Open();
                string sql = @"
                    SELECT x.MaXe, x.TenXe, x.GiaMacDinh, x.AnhUrl, h.TenHangXe, l.TenLoai
                    FROM xe x
                    LEFT JOIN hangxe h ON x.HangXe = h.MaHangXe
                    LEFT JOIN loaixe l ON x.LoaiXe = l.MaLoai
                    WHERE x.TinhTrang='Chua thue' AND x.LoaiXe = @Loai
                    ORDER BY RAND() LIMIT 10";

                MySqlCommand cmd = new MySqlCommand(sql, conn);
                MySqlDataAdapter da;
                DataTable dt;
                cmd.Parameters.AddWithValue("@Loai", 1);
                da = new MySqlDataAdapter(cmd);
                dt = new DataTable();
                da.Fill(dt);
                rptTayGa.DataSource = dt;
                rptTayGa.DataBind();
                cmd.Parameters.Clear();

                cmd.Parameters.AddWithValue("@Loai", 2);
                da = new MySqlDataAdapter(cmd);
                dt = new DataTable();
                da.Fill(dt);
                rptXeSo.DataSource = dt;
                rptXeSo.DataBind();
                cmd.Parameters.Clear();

                cmd.Parameters.AddWithValue("@Loai", 3);
                da = new MySqlDataAdapter(cmd);
                dt = new DataTable();
                da.Fill(dt);
                rptXeCon.DataSource = dt;
                rptXeCon.DataBind();
            }
        }
        private void LoadChinhSach()
        {
            using (MySqlConnection conn = new MySqlConnection(connStr))
            {
                string query = "SELECT noi_dung FROM ChinhSach";
                MySqlCommand cmd = new MySqlCommand(query, conn);
                MySqlDataAdapter da = new MySqlDataAdapter(cmd);
                DataTable dt = new DataTable();
                da.Fill(dt);

                rptChinhSach.DataSource = dt;
                rptChinhSach.DataBind();
            }
        }


        private void LoadHangXe()
        {
            using (MySqlConnection conn = new MySqlConnection(connStr))
            {
                string query = "SELECT MaHangXe, TenHangXe, Logo FROM hangxe";
                MySqlCommand cmd = new MySqlCommand(query, conn);
                MySqlDataAdapter da = new MySqlDataAdapter(cmd);
                DataTable dt = new DataTable();
                da.Fill(dt);

                rptHangXe.DataSource = dt;
                rptHangXe.DataBind();
            }
        }

        private void LoadLoaiXe()
        {
            using (MySqlConnection conn = new MySqlConnection(connStr))
            {
                string query = "SELECT MaLoai, TenLoai FROM loaixe";
                MySqlCommand cmd = new MySqlCommand(query, conn);
                MySqlDataAdapter da = new MySqlDataAdapter(cmd);
                DataTable dt = new DataTable();
                da.Fill(dt);

                ddlLoaiXe.DataSource = dt;
                ddlLoaiXe.DataTextField = "TenLoai";
                ddlLoaiXe.DataValueField = "MaLoai";
                ddlLoaiXe.DataBind();

                ddlLoaiXe.Items.Insert(0, new ListItem(" Chọn loại xe ", ""));
            }
        }
        private void KiemTraDangNhap()
        {
            if (Session["UserID"] != null && Session["UserName"] != null)
            {
                pnlDaDangNhap.Visible = true;
                pnlChuaDangNhap.Visible = false;
                lblTenNguoiDung.Text = Session["UserName"].ToString();
            }
            else
            {
                pnlDaDangNhap.Visible = false;
                pnlChuaDangNhap.Visible = true;
            }
        }
        protected void btnTimXe_Click(object sender, EventArgs e)
        {
            string loaiXe = ddlLoaiXe.SelectedValue;
            string ngayNhan = txtNgayNhan.Text;
            string ngayTra = txtNgayTra.Text;

            string url = $"TimXe.aspx?loai={loaiXe}&nhan={ngayNhan}&tra={ngayTra}";
            Response.Redirect(url);
        }
        protected void btnDangXuat_Click(object sender, EventArgs e)
        {
            Session.Clear();
            Response.Redirect("Default.aspx");
        }
    }
}
