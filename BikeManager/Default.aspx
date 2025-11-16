<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Default.aspx.cs" Inherits="BikeManager._Default" %>
<!DOCTYPE html>
<html lang="vi">
<head runat="server">
    <meta charset="utf-8" />
    <title>ViperCar</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet" />
    <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.1/font/bootstrap-icons.css" rel="stylesheet" />
    <link href="Content/Site.css" rel="stylesheet" />
    <style>
        .hero {
    position: relative;
    background: url('Images/thiennhien.jpg') center center/cover no-repeat;
    min-height: 500px;
    display: flex;
    align-items: center;
    justify-content: center;
}
    </style>
</head>

<body>
    <form id="form1" runat="server">
        <!-- Cái đầu -->
        <nav class="navbar navbar-expand-lg navbar-dark">
            <div class="container">
                <a class="navbar-brand" href="Default.aspx">
                    <img src="Images/OuUAAAAASUVORK5CYII.png" alt="logo" /> ViperMotoBike
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

        <!-- Tìm kiếm -->
        <section class="hero">
            <div class="search-box">
                <div class="row g-3 align-items-end">
                    <div class="col-md-4">
                    <label>Loại xe</label>
                    <asp:DropDownList ID="ddlLoaiXe" runat="server" CssClass="form-select"></asp:DropDownList>
                </div>
                    <div class="col-md-3">
                        <label class="form-label">Ngày nhận xe</label>
                        <asp:TextBox ID="txtNgayNhan" runat="server" TextMode="Date" CssClass="form-control"></asp:TextBox>
                    </div>
                    <div class="col-md-3">
                        <label class="form-label">Ngày trả xe</label>
                        <asp:TextBox ID="txtNgayTra" runat="server" TextMode="Date" CssClass="form-control"></asp:TextBox>
                    </div>
                    <div class="col-md-2 d-grid">
                        <asp:Button ID="btnTimXe" runat="server" Text="TÌM XE" CssClass="btn btn-success" OnClick="btnTimXe_Click" />
                    </div>
                </div>
            </div>
        </section>

<!-- Xe ga -->
<section class="container mt-5">
  <div class="d-flex justify-content-between align-items-center mb-3">
    <h4 class="fw-semibold text-success">Xe Tay Ga</h4>
    <a href="TimXe.aspx?loai=1" class="text-decoration-none fw-semibold">Xem thêm →</a>
  </div>
  <div class="scroll-container">
    <asp:Repeater ID="rptTayGa" runat="server">
      <ItemTemplate>
        <div class="bike-card">
          <img src='<%# Eval("AnhUrl") %>' alt='<%# Eval("TenXe") %>' />
          <div class="bike-info">
            <h6 class="fw-bold mb-1"><%# Eval("TenXe") %></h6>
            <p class="text-muted small mb-1"><%# Eval("TenHangXe") %></p>
            <p class="bike-price mb-2"><%# string.Format("{0:N0} VNĐ/ngày", Eval("GiaMacDinh")) %></p>
            <a href='ChiTietXe.aspx?id=<%# Eval("MaXe") %>' class="btn btn-outline-success btn-sm w-100">Xem chi tiết</a>
          </div>
        </div>
      </ItemTemplate>
    </asp:Repeater>
  </div>
</section>

<!-- xe số -->
<section class="container mt-5">
  <div class="d-flex justify-content-between align-items-center mb-3">
    <h4 class="fw-semibold text-success">Xe Số</h4>
    <a href="TimXe.aspx?loai=2" class="text-decoration-none fw-semibold">Xem thêm →</a>
  </div>
  <div class="scroll-container">
    <asp:Repeater ID="rptXeSo" runat="server">
      <ItemTemplate>
        <div class="bike-card">
          <img src='<%# Eval("AnhUrl") %>' alt='<%# Eval("TenXe") %>' />
          <div class="bike-info">
            <h6 class="fw-bold mb-1"><%# Eval("TenXe") %></h6>
            <p class="text-muted small mb-1"><%# Eval("TenHangXe") %></p>
            <p class="bike-price mb-2"><%# string.Format("{0:N0} VNĐ/ngày", Eval("GiaMacDinh")) %></p>
            <a href='ChiTietXe.aspx?id=<%# Eval("MaXe") %>' class="btn btn-outline-success btn-sm w-100">Xem chi tiết</a>
          </div>
        </div>
      </ItemTemplate>
    </asp:Repeater>
  </div>
</section>

<!-- xe tay côn -->
<section class="container mt-5">
  <div class="d-flex justify-content-between align-items-center mb-3">
    <h4 class="fw-semibold text-success">Xe Côn Tay</h4>
    <a href="TimXe.aspx?loai=3" class="text-decoration-none fw-semibold">Xem thêm →</a>
  </div>
  <div class="scroll-container">
    <asp:Repeater ID="rptXeCon" runat="server">
      <ItemTemplate>
        <div class="bike-card">
          <img src='<%# Eval("AnhUrl") %>' alt='<%# Eval("TenXe") %>' />
          <div class="bike-info">
            <h6 class="fw-bold mb-1"><%# Eval("TenXe") %></h6>
            <p class="text-muted small mb-1"><%# Eval("TenHangXe") %></p>
            <p class="bike-price mb-2"><%# string.Format("{0:N0} VNĐ/ngày", Eval("GiaMacDinh")) %></p>
            <a href='ChiTietXe.aspx?id=<%# Eval("MaXe") %>' class="btn btn-outline-success btn-sm w-100">Xem chi tiết</a>
          </div>
        </div>
      </ItemTemplate>
    </asp:Repeater>
  </div>
</section>

        <section class="container text-center mt-5">
    <h4 class="fw-bold mb-4">Chọn xe theo hãng</h4>
    <div class="row justify-content-center" id="brandList">
        <asp:Repeater ID="rptHangXe" runat="server">
            <ItemTemplate>
                <div class="col-6 col-sm-4 col-md-3 col-lg-2 mb-4">
                    <div class="card shadow-sm border-0 brand-card" 
                         style="cursor:pointer" 
                         onclick="location.href='TimXe.aspx?hang=<%# Eval("TenHangXe") %>'">
                        <div class="card-body text-center">
                             <img src='<%# Eval("logo") %>'
                                 alt='<%# Eval("TenHangXe") %>' 
                                 class="img-fluid mb-2" style="height:60px; object-fit:contain;" />
                            <h6 class="fw-bold"><%# Eval("TenHangXe") %></h6>
                        </div>
                    </div>
                </div>
            </ItemTemplate>
        </asp:Repeater>
    </div>
</section>

        

  <section class="faq">
       <h2>Câu hỏi thường gặp</h2>

    <details>
      <summary>Tại sao tôi nên chọn thuê xe ở Viper?</summary>
      <p>BonbonCar cung cấp dịch vụ thuê xe  với thủ tục nhanh gọn, giá cả minh bạch, 
         đa dạng dòng xe và hỗ trợ khách hàng tận tâm. Bạn có thể dễ dàng đặt xe và nhận xe 
         ngay gần vị trí của mình.</p>
    </details>

    <details>
      <summary>Thủ tục cho thuê xe bao gồm những gì?</summary>
      <p>Bạn cần chuẩn bị giấy tờ tùy thân (CMND/CCCD và bằng lái xe), hợp đồng thuê xe, 
         và khoản đặt cọc (tùy theo dòng xe). Sau khi hoàn tất kiểm tra xe, bạn có thể nhận xe để sử dụng.</p>
    </details>

    <details>
      <summary>Đặt cọc xe máy và thủ tục hoàn cọc ra sao?</summary>
      <p>Khoản đặt cọc sẽ được hoàn trả ngay sau khi bạn trả xe, nếu xe không gặp sự cố 
         hay phát sinh chi phí bổ sung. ViperMoto sẽ hoàn tiền đúng phương thức bạn đã đặt cọc ban đầu.</p>
    </details>

    <details>
      <summary>Vị trí nhận xe tại đâu?</summary>
      <p>Bạn có thể nhận xe tại các điểm giao dịch hoặc yêu cầu giao xe tận nơi 
         (có thể có phụ phí). Chúng tôi hỗ trợ linh hoạt để phù hợp với lịch trình của bạn.</p>
    </details>

    <details>
      <summary>Tôi có phải nhận và trả xe đúng giờ?</summary>
      <p>Có. Bạn nên nhận và trả xe đúng thời gian ghi trong hợp đồng. 
         Nếu trả trễ,ViperChan sẽ tính thêm phí theo quy định. 
         Trường hợp cần gia hạn, bạn vui lòng liên hệ trước để được hỗ trợ.</p>
    </details>

    <details >
      <summary>Tôi có cần vệ sinh hay đổ xăng khi trả xe?</summary>
      <p>Bạn cần trả xe theo hiện trạng ban đầu để tránh chi phí phát sinh. 
         Do đó, vui lòng vệ sinh xe nếu cần thiết hoặc Chúng tui sẽ tính thêm phí 
         trong trường hợp xe quá dơ đó nha 
         Tương tự, đảm bảo mức xăng khi trả xe như lúc nhận xe, 
         nếu thiếu ViperChan sẽ tính phụ phí nhiên liệu 27.000 đồng/lít.</p>
    </details>

    <details>
      <summary>Trường hợp xe xảy ra sự cố tôi cần làm gì?</summary>
      <p>Bạn hãy dừng xe ở vị trí an toàn, liên hệ ngay với Viper! qua số hotline trên hợp đồng 
         để được hướng dẫn xử lý. Không tự ý sửa chữa hay di chuyển xe khi chưa có chỉ định từ ViperChan.</p>
    </details>

  </section>


                <footer class="footer-section mt-5">
                    <div class="container py-5">
                        <div class="row text-dark">
                            <div class="col-md-4 mb-4">
                                <img src="Images/OuUAAAAASUVORK5CYII.png" alt="logo" class="mb-3" style="height:100px;">
                                <h6 class="fw-bold">CÔNG TY TNHH VIPERMB VIỆT NAM</h6>
                                <p>Mã số thuế: 0318208708<br />Cấp ngày: 11/12/2025</p>
                                <p><b>HLE</b><br>43 Cao Thắng, Quận Thanh Khê, TP.Đà Nẵng</p>
                                <p>Email: <a href="mailto:cs@vipercar.vn">cs@viperXe.vn</a></p>
                            </div>

                            <div class="col-md-2 mb-4">
                                <h6 class="fw-bold">Chính sách</h6>
                                <asp:Repeater ID="rptChinhSach" runat="server">
                                    <ItemTemplate>
                                        <p><a href='#' class="text-dark text-decoration-none"><%# Eval("noi_dung") %></a></p>
                                    </ItemTemplate>
                                </asp:Repeater>
                            </div>

                            <div class="col-md-2 mb-4">
                                <h6 class="fw-bold">Địa điểm dịch vụ</h6>
                                <p>Quảng Nam</p>
                                <p>Đà Nẵng</p>
                                <p>Hội An</p>
                                <p>Huế</p>
                            </div>

                            <div class="col-md-2 mb-4">
                                <h6 class="fw-bold">Hỗ trợ</h6>
                                <p>Quy định dịch vụ</p>
                                <p><i class="bi bi-telephone"></i> 1900 0000</p>
                            </div>
                        </div>
                    </div>

                    <div class="text-center py-3 bg-success text-white">
                        © 2025 ViperChan | Thiết kế bởi <b> Three Yordle 😎</b>
                    </div>
                </footer>
    </form>
</body>
     <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</html>
