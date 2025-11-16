<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="ChiTietXe.aspx.cs" Inherits="BikeManager.ChiTietXe" %>
<!DOCTYPE html>
<html lang="vi">
<head runat="server">
    <meta charset="utf-8" />
    <title>Chi tiết xe |  ViperMoto</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet" />
    <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.1/font/bootstrap-icons.css" rel="stylesheet" />

    <style>
        body {
            font-family: 'Poppins', Arial, sans-serif;
            background-color: #f3faf7; /* mint-light similar BonbonCar */
            color: #344044;
        }

            .navbar {
                background: white !important;
            }

            .navbar-brand {
                color: #80e8de;
                font-weight: 600;
                font-size: 1.8rem;
                font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            }

                .navbar-brand img {
                    height: 60px;
                    margin-right: 5px;
                }

            .navbar .btn {
                border-radius: 20px;
            }

        .brand {
            display: flex;
            align-items: center;
            gap: 12px;
            font-weight: 600;
        }

        .brand img { height: 30px; }

        .container-custom {
            max-width: 1180px;
            margin: 30px auto;
        }

        .gallery {
            background: #fff;
            border-radius: 12px;
            padding: 18px;
            box-shadow: 0 6px 18px rgba(16, 35, 30, 0.06);
        }

        .main-image {
            border-radius: 12px;
            overflow: hidden;
            height: 420px;
        }

        .main-image img {
            width: 100%;
            height: 100%;
            object-fit: cover;
            display: block;
        }

        .thumbs {
            margin-top: 12px;
            display:flex;
            gap:10px;
        }

        .thumbs img {
            width: 84px;
            height: 64px;
            object-fit: cover;
            border-radius: 8px;
            cursor: pointer;
            border: 2px solid transparent;
        }

        .thumbs img.active {
            border-color: #1fbf9e;
        }

        .car-title {
            margin-top: 16px;
        }

        .feature-list i {
            color: #1fbf9e;
        }

        .desc {
            color: #54606a;
            line-height: 1.7;
        }

        .policy-card {
            margin-top: 18px;
            background: #fff;
            border-radius: 10px;
            padding: 16px;
        }


        .price-box {
            background: #fff;
            border-radius: 12px;
            padding: 18px;
            box-shadow: 0 6px 18px rgba(16, 35, 30, 0.06);
            position: sticky;
            top: 110px;
        }

        .price-box .price {
            color: #1fbf9e;
            font-weight: 700;
            font-size: 22px;
        }

        .btn-book {
            background-color: #1fbf9e;
            color: #fff;
            border: none;
        }

        .btn-book:hover {
            background-color: #17a986;
        }

        .small-muted {
            color: #7b8a87;
            font-size: 13px;
        }

        .summary-line {
            display:flex;
            justify-content:space-between;
            align-items:center;
            padding: 8px 0;
            border-bottom: 1px solid #eef6f3;
        }

        .summary-line:last-child { border-bottom: none; }

        .text-danger-strong {
            color: #d9534f;
            font-weight: 600;
        }

        /* Footer */
        footer.footer-section {
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

        @media (max-width: 991px) {
            .main-image { height: 260px; }
            .price-box { position: static; top: auto; margin-top: 16px; }
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

         <asp:Panel ID="pnlChuaDangNhap" runat="server">
             <div class="d-flex ms-auto">
                 <a href="DangNhap.aspx" class="btn btn-warning me-2">Đăng nhập</a>
                 <a href="DangKy.aspx" class="btn btn-light text-success">Đăng ký</a>
             </div>
         </asp:Panel>

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
                         <li>
                             <asp:LinkButton ID="btnDangXuat" runat="server" CssClass="dropdown-item text-danger" OnClick="btnDangXuat_Click">Đăng xuất</asp:LinkButton>
                         </li>
                     </ul>
                 </li>
             </ul>
         </asp:Panel>
     </div>
 </nav>


        <!-- Page content -->
        <div class="container container-custom">
            <div class="row g-4">
                <div class="col-lg-8">
                    <div class="gallery">
                        <div class="row g-3">
                            <div class="col-12">
                                <div class="main-image" id="mainImageWrap">
                                    <asp:Image ID="imgXe" runat="server" CssClass="w-100 h-100" />
                                </div>
                            </div>

                            <div class="col-12">
                                <div class="thumbs" id="thumbs">
                                   
                                    <img src='<%# imgXe.ImageUrl == "" ? "Images/placeholder.png" : imgXe.ImageUrl %>' alt="thumb" class="active" onclick="changeMain(this)" />
                                    <img src='<%# imgXe.ImageUrl == "" ? "Images/placeholder.png" : imgXe.ImageUrl %>' alt="thumb" onclick="changeMain(this)" />
                                    <img src='<%# imgXe.ImageUrl == "" ? "Images/placeholder.png" : imgXe.ImageUrl %>' alt="thumb" onclick="changeMain(this)" />
                                    <img src='<%# imgXe.ImageUrl == "" ? "Images/placeholder.png" : imgXe.ImageUrl %>' alt="thumb" onclick="changeMain(this)" />
                                </div>
                            </div>

                            <div class="col-12 car-title">
                                <h2 class="mb-1"><asp:Label ID="lblTenXe" runat="server" CssClass="h4"></asp:Label></h2>
                                <p class="small-muted mb-2"><i class="bi bi-geo-alt me-1"></i> <asp:Label ID="lblDiaChi" runat="server" /></p>

                                <div class="row">
                                    <div class="col-md-6">
                                        <ul class="feature-list list-unstyled">
                                            <li class="mb-2"><i class="bi bi-car-front me-2"></i><b>Hãng:</b> <asp:Label ID="lblHangXe" runat="server" /></li>
                                            <li class="mb-2"><i class="bi bi-gear-wide-connected me-2"></i><b>Loại:</b> <asp:Label ID="lblLoaiXe" runat="server" /></li>
                                            <li class="mb-2"><i class="bi bi-ev-front me-2"></i><b>Động cơ:</b> <asp:Label ID="lblLoaiDongCo" runat="server" /></li>
                                            <li class="mb-2"><i class="bi bi-bezier me-2"></i><b>Dung tích:</b> <asp:Label ID="lblDungTich" runat="server" /></li>

                                        </ul>
                                    </div>
                                    <div class="col-md-6">
                                        <ul class="feature-list list-unstyled">
                                            <li class="mb-2"><i class="bi bi-calendar3 me-2"></i><b>Năm:</b> <asp:Label ID="lblNamSX" runat="server" /></li>
                                            <li class="mb-2"><i class="bi bi-fuel-pump me-2"></i><b>Nhiên liệu:</b> <asp:Label ID="lblNhienLieu" runat="server" /></li>
                                            <li class="mb-2"><i class="bi bi-speedometer2 me-2"></i><b>KM:</b> <asp:Label ID="lblSoKm" runat="server" /></li>
                                             <li class="mb-2"><i class="bi bi-check2-circle me-2"></i><b>Tình trạng:</b> <asp:Label ID="lblTinhTrang" runat="server" /></li>
                                        </ul>
                                    </div>
                                </div>

                                <hr />

                                <h6>Mô tả</h6>
                                <p class="desc"><asp:Label ID="lblMoTa" runat="server" /></p>
                                <div class="mt-3">
                                <h6><i class="bi bi-person-circle me-2" style="color:#1fbf9e"></i>Chủ xe</h6>
                                <p class="mb-0"><asp:Label ID="lblChuXe" runat="server" /></p>
                            </div>

                                <div class="policy-card">
                                    <h6 class="mb-2"><i class="bi bi-shield-check me-2" style="color:#1fbf9e"></i>Chính sách hủy chuyến</h6>
                                    <ul>
                                        <li>Miễn phí hủy nếu thực hiện trước 24 giờ so với thời gian nhận xe.</li>
                                        <li>Hủy trong vòng 24 giờ trước giờ nhận xe: phí 30% tổng giá trị chuyến.</li>
                                        <li>Không hoàn tiền nếu hủy sau thời gian nhận xe đã đăng ký.</li>
                                    </ul>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>

               
                <div class="col-lg-4">
                    <div class="price-box">
                        <div class="d-flex justify-content-between align-items-center mb-2">
                            <div>
                                <div class="small-muted">Giá thuê</div>
                                <div class="price"><asp:Label ID="lblGia" runat="server" /></div>
                            </div>
                            <div class="text-end small-muted">
                                <div><i class="bi bi-star-fill text-warning"></i> <b>4.8</b></div>
                                <div class="small">12 đánh giá</div>
                            </div>
                        </div>

                        <hr />

                        <div class="mb-3">
                            <label class="form-label small-muted">Thời gian nhận xe</label>
                            <asp:TextBox ID="txtNgayNhan" runat="server" TextMode="DateTimeLocal" CssClass="form-control" />
                        </div>

                        <div class="mb-3">
                            <label class="form-label small-muted">Thời gian trả xe</label>
                            <asp:TextBox ID="txtNgayTra" runat="server" TextMode="DateTimeLocal" CssClass="form-control" />
                        </div>

                        <asp:Button ID="btnDatXe" runat="server" Text="Đặt xe ngay" CssClass="btn btn-book w-100 py-2" OnClick="btnDatXe_Click" />

                        <asp:Label ID="lblThongBao" runat="server" CssClass="d-block mt-3" />

                        <hr class="my-3" />

                        <div class="small-muted mb-2">Chi tiết thuê</div>
                        <div class="summary-line">
                            <div><small>Giá / ngày</small></div>
                            <div><small><asp:Label ID="lblGiaNgay" runat="server" /></small></div>
                        </div>
                        <div class="summary-line">
                            <div><small>Số ngày (tạm tính)</small></div>
                            <div><small id="calc-days">0</small></div>
                        </div>
                        <div class="summary-line">
                            <div><small>Tạm tính</small></div>
                            <div><small id="calc-sub">0 VNĐ</small></div>
                        </div>

                        <div class="mt-3 small text-muted">
                            <i class="bi bi-info-circle"></i> Lưu ý: thanh toán giữ chỗ sẽ được hoàn theo điều khoản khi hủy.
                        </div>
                    </div>
                </div>
            </div>
        </div>

        <!-- Footer -->
        <footer class="footer-section">
            <div class="container container-custom py-5">
                <div class="row">
                    <div class="col-md-4">
                        <img src="Images/OuUAAAAASUVORK5CYII.png" alt="logo" style="height:100px" />
                        <p class="mt-3">CÔNG TY TNHH VIPERMB VIỆT NAM<br />Mã số thuế: 0318208708</p>
                        <p>Email: <a href="mailto:cs@vipercar.vn">cs@vipercar.vn</a></p>
                    </div>

                    <div class="col-md-2">
                        <h6 class="fw-bold">Chính sách</h6>
                        <p><a href="#" class="text-decoration-none text-dark">Điều khoản</a></p>
                        <p><a href="#" class="text-decoration-none text-dark">Chính sách bảo mật</a></p>
                    </div>

                    <div class="col-md-3">
                        <h6 class="fw-bold">Địa điểm</h6>
                        <p>Hà Nội</p>
                        <p>Đà Nẵng</p>
                        <p>Hồ Chí Minh</p>
                    </div>

                    <div class="col-md-3">
                        <h6 class="fw-bold">Hỗ trợ</h6>
                        <p>Hotline: 1900 5335</p>
                        <p>Quy định dịch vụ</p>
                    </div>
                </div>
            </div>

            <div class="legal">
                © 2025 ViperCar | Thiết kế bởi <b>Three Yordle 😎</b>
            </div>
        </footer>

        <asp:HiddenField ID="hdOrderId" runat="server" />
    </form>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
    <script>
        function changeMain(el) {
            var mainImg = document.querySelector("#<%= imgXe.ClientID %>");
            if (!mainImg) {
                var img = document.querySelector("#mainImageWrap img");
                if (img) img.src = el.src;
            } else {
                mainImg.src = el.src;
            }

            var thumbs = document.querySelectorAll("#thumbs img");
            thumbs.forEach(function (t) { t.classList.remove('active'); });
            el.classList.add('active');
        }

        
        function calcSummary() {
            var a = document.querySelector("input[id$='txtNgayNhan']");
            var b = document.querySelector("input[id$='txtNgayTra']");
            var lblDays = document.getElementById('calc-days');
            var lblSub = document.getElementById('calc-sub');
            var priceLabel = document.querySelector("span[id$='lblGia']") || document.querySelector("label[id$='lblGia']");
            // đọc giá từ lblGia (định dạng "1.200.000 VNĐ/ngày")
            var priceText = priceLabel ? priceLabel.innerText : '';
            var price = 0;
            if (priceText) {
                var m = priceText.replace(/\./g, '').match(/(\d+)/);
                if (m) price = parseInt(m[1]);
            }

            if (a && b && a.value && b.value) {
                var d1 = new Date(a.value);
                var d2 = new Date(b.value);
                var diff = Math.ceil((d2 - d1) / (1000 * 60 * 60 * 24));
                if (diff < 0) diff = 0;
                lblDays.innerText = diff;
                var sub = diff * price;
                lblSub.innerText = sub.toLocaleString('vi-VN') + ' VNĐ';
            } else {
                lblDays.innerText = '0';
                lblSub.innerText = '0 VNĐ';
            }
        }

        document.addEventListener('DOMContentLoaded', function () {
            var a = document.querySelector("input[id$='txtNgayNhan']");
            var b = document.querySelector("input[id$='txtNgayTra']");
            if (a) a.addEventListener('change', calcSummary);
            if (b) b.addEventListener('change', calcSummary);

            // initial calc
            calcSummary();
        });
    </script>
</body>
</html>
