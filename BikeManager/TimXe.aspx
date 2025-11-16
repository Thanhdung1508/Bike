<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="TimXe.aspx.cs" Inherits="BikeManager.TimXe" %>
<!DOCTYPE html>
<html lang="vi">
<head runat="server">
    <meta charset="utf-8" />
    <title> ViperMoto</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet" />
    <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.1/font/bootstrap-icons.css" rel="stylesheet" />

    <style>
        body {
            font-family: 'Poppins', Arial, sans-serif;
            background-color: #f3faf7;
            color: #344044;
        }

        .navbar {
            background: white !important;
        }

        .navbar-brand {
            color: #1fbf9e;
            font-weight: 600;
            font-size: 1.8rem;
        }

        .navbar-brand img {
            height: 60px;
            margin-right: 5px;
        }

        /* Cards */
        .bike-card {
            background: #fff;
            border-radius: 12px;
            overflow: hidden;
            box-shadow: 0 6px 16px rgba(0,0,0,0.05);
            transition: all .25s ease;
        }

        .bike-card:hover {
            transform: translateY(-3px);
            box-shadow: 0 8px 18px rgba(0,0,0,0.08);
        }

        .bike-card img {
            height: 180px;
            object-fit: cover;
            width: 100%;
        }

        .bike-info {
            padding: 15px;
        }

        .bike-price {
            color: #1fbf9e;
            font-weight: 600;
        }

        .footer-section {
            background: #f7faf8;
            border-top: 4px solid #e8f6f2;
            margin-top: 40px;
            color: #475d57;
        }

        footer .legal {
            background: #1fbf9e;
            color: #fff;
            padding: 14px 0;
            text-align:center;
            border-radius: 0 0 6px 6px;
            margin-top: 16px;
        }
    </style>
</head>

<body>
<form id="form1" runat="server">

    <nav class="navbar navbar-expand-lg navbar-dark">
        <div class="container">
            <a class="navbar-brand" href="Default.aspx">
                <img src="Images/OuUAAAAASUVORK5CYII.png" alt="logo" /> Viper MotoBike
            </a>

            <!-- Nếu chưa đăng nhập -->
            <asp:Panel ID="pnlChuaDangNhap" runat="server">
                <div class="d-flex ms-auto">
                    <a href="DangNhap.aspx" class="btn btn-warning me-2">Đăng nhập</a>
                    <a href="DangKy.aspx" class="btn btn-light text-success">Đăng ký</a>
                </div>
            </asp:Panel>

            <!-- Nếu đã đăng nhập -->
            <asp:Panel ID="pnlDaDangNhap" runat="server" Visible="false">
                <ul class="navbar-nav ms-auto">
                    <li class="nav-item dropdown">
                        <a class="nav-link dropdown-toggle text-dark" href="#" role="button" data-bs-toggle="dropdown">
                            <i class="bi bi-person-circle fs-5"></i>
                            <asp:Label ID="lblTenNguoiDung" runat="server"></asp:Label>
                        </a>
                        <ul class="dropdown-menu dropdown-menu-end">
                            <li><a class="dropdown-item" href="ThongTinCaNhan.aspx">Thông tin cá nhân</a></li>
                            <li><a class="dropdown-item" href="DonCuaToi.aspx">Đơn thuê xe của tôi</a></li>
                            <li><hr class="dropdown-divider"></li>
                            <li><asp:LinkButton ID="btnDangXuat" runat="server" CssClass="dropdown-item text-danger" OnClick="btnDangXuat_Click">Đăng xuất</asp:LinkButton></li>
                        </ul>
                    </li>
                </ul>
            </asp:Panel>
        </div>
    </nav>

    <div class="container mt-4">
        <h4 class="text-success mb-4"><i class="bi bi-search"></i> Kết quả tìm kiếm</h4>

        <asp:Repeater ID="rptXe" runat="server">
            <HeaderTemplate>
                <div class="row g-4">
            </HeaderTemplate>

<ItemTemplate>
    <div class="col-md-4">
        <div class="bike-card">
            <img src='<%# Eval("AnhUrl") %>' alt="xe" />
            <div class="bike-info">
                <h6 class="fw-bold mb-1"><%# Eval("TenXe") %></h6>
                <p class="mb-1 small text-muted">
                    <%# Eval("TenHangXe") %> • <%# Eval("TenLoai") %>
                </p>

                <p class="bike-price mb-2">
                    <%# string.Format("{0:N0} VNĐ/ngày", Eval("GiaMacDinh")) %>
                </p>
           
                <asp:Panel runat="server" 
                           Visible='<%# Convert.ToInt32(Eval("XeRanh")) == 1 %>'>
                    <a href='ChiTietXe.aspx?id=<%# Eval("MaXe") %>' 
                       class="btn btn-success btn-sm w-100">
                       Thuê ngay
                    </a>
                </asp:Panel>

           
                <asp:Panel runat="server" 
                           Visible='<%# Convert.ToInt32(Eval("XeRanh")) == 0 %>'>
                    <asp:LinkButton 
                        runat="server"
                        CssClass="btn btn-outline-danger btn-sm w-100"
                        CommandArgument='<%# Eval("MaXe") %>'
                        OnClick="btnXemLich_Click">
                        Xem lịch
                    </asp:LinkButton>
                </asp:Panel>


            </div>
        </div>
    </div>
</ItemTemplate>


            <FooterTemplate>
                </div>
            </FooterTemplate>
        </asp:Repeater>

        <asp:Label ID="lblThongBao" runat="server" CssClass="text-muted mt-3 d-block"></asp:Label>
    </div>

    <!-- FOOTER -->
    <footer class="footer-section mt-5">
        <div class="container py-5">
            <div class="row">
                <div class="col-md-4">
                    <img src="Images/logo.png" alt="logo" style="height:40px" />
                    <p class="mt-3">CÔNG TY TNHH VIPERMB VIỆT NAM<br />Mã số thuế: 0318208708</p>
                    <p>Email: <a href="mailto:cs@vipercar.vn">cs@viperchan.vn</a></p>
                </div>
                <div class="col-md-2">
                    <h6 class="fw-bold">Chính sách</h6>
                    <p><a href="#" class="text-decoration-none text-dark">Điều khoản</a></p>
                    <p><a href="#" class="text-decoration-none text-dark">Bảo mật</a></p>
                </div>
                <div class="col-md-3">
                    <h6 class="fw-bold">Địa điểm</h6>
                    <p>Huế</p><p>Đà Nẵng</p><p>Hội An</p>
                </div>
                <div class="col-md-3">
                    <h6 class="fw-bold">Hỗ trợ</h6>
                    <p>Hotline: 1900 0000</p>
                    <p>Quy định dịch vụ</p>
                </div>
            </div>
        </div>
        <div class="legal">© 2025 ViperChan | Thiết kế bởi <b>Three Yordle 😎</b></div>
    </footer>
    <div class="modal fade" id="lichModal" tabindex="-1">
    <div class="modal-dialog modal-dialog-centered">
        <div class="modal-content">

            <div class="modal-header">
                <h5 class="modal-title text-success">Lịch thuê xe</h5>
                <button type="button" class="btn-close" data-bs-dismiss="modal"></button>
            </div>

            <div class="modal-body">
                <asp:Repeater ID="rptLichXe" runat="server">
                    <ItemTemplate>
                        <div class="border rounded p-2 mb-2">
                            <p class="mb-1">
                                <b>Từ:</b> <%# Eval("NgayNhan") %>
                            </p>
                            <p class="mb-1">
                                <b>Đến:</b> <%# Eval("NgayTra") %>
                            </p>
                            <p class="text-danger small">
                                <i class="bi bi-calendar-x"></i> Đã có khách thuê
                            </p>
                        </div>
                    </ItemTemplate>
                </asp:Repeater>

                <asp:Label ID="lblKhongCoLich" runat="server"
                           CssClass="text-muted"></asp:Label>
            </div>

        </div>
    </div>
</div>

</form>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>


