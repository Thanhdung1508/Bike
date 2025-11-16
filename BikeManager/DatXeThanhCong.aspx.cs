using MySql.Data.MySqlClient;
using Org.BouncyCastle.Asn1.Cmp;
using System;
using System.Collections.Generic;
using System.Configuration;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace BikeManager
{
    public partial class DatXeThanhCong : System.Web.UI.Page
    {
        string connStr = ConfigurationManager.ConnectionStrings["MySqlConn"].ConnectionString;

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                if (Request.QueryString["madon"] == null)
                {
                    lblTenKhach.Text = "Không tìm thấy đơn đặt.";
                    return;
                }

                int maDon = int.Parse(Request.QueryString["madon"]);

                using (MySqlConnection conn = new MySqlConnection(connStr))
                {
                    string sql = @"SELECT d.MaDonXe, d.TenNguoiThue, d.SoDienThoai, 
                                          d.NgayNhan, d.NgayTra, x.TenXe, x.HangXe, x.AnhUrl, x.GiaMacDinh
                                   FROM donxe d 
                                   JOIN xe x ON d.MaXe = x.MaXe
                                   WHERE d.MaDonXe = @id";

                    MySqlCommand cmd = new MySqlCommand(sql, conn);
                    cmd.Parameters.AddWithValue("@id", maDon);
                    conn.Open();

                    using (var rdr = cmd.ExecuteReader())
                    {
                        if (rdr.Read())
                        {
                            lblMaDon.Text = rdr["MaDonXe"].ToString();
                            lblTenKhach.Text = rdr["TenNguoiThue"].ToString();
                            lblSDT.Text = rdr["SoDienThoai"].ToString();

                            DateTime nhan = Convert.ToDateTime(rdr["NgayNhan"]);
                            DateTime tra = Convert.ToDateTime(rdr["NgayTra"]);

                            lblNhan.Text = nhan.ToString("HH:mm, dd/MM/yyyy");
                            lblTra.Text = tra.ToString("HH:mm, dd/MM/yyyy");

                            lblLoaiXe.Text = rdr["TenXe"].ToString() + " " + rdr["HangXe"].ToString();
                            imgXe.ImageUrl = rdr["AnhUrl"].ToString();
                            imgXe.ImageUrl = ResolveUrl(rdr["AnhUrl"].ToString());

                            decimal gia = Convert.ToDecimal(rdr["GiaMacDinh"]);
                            int soNgay = Math.Max(1, (int)Math.Ceiling((tra - nhan).TotalDays));
                            decimal tong = gia * soNgay;
                            lblTongTien.Text = tong.ToString("N0") + "đ";
                        }
                    }
                }
            }
        }
    }
}