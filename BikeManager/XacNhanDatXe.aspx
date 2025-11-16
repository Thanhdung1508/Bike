<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="XacNhanDatXe.aspx.cs" Inherits="BikeManager.XacNhanDatXe" %>

<!DOCTYPE html>
<html lang="vi">
<head runat="server">
    <meta charset="utf-8" />
    <title>Xác nhận đặt xe | BonbonCar - ViperMoto</title>

    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet" />
    <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.1/font/bootstrap-icons.css" rel="stylesheet" />

    <style>
        body {
            font-family: 'Poppins', Arial, sans-serif;
            background: linear-gradient(180deg,#eafaf6 0%, #f7fffef0 100%);
            color: #20363a;
        }
        .page-wrap { max-width: 980px; margin: 36px auto; }
        .card-confirm {
            border-radius: 14px;
            box-shadow: 0 10px 30px rgba(16,35,30,0.08);
            overflow: hidden;
            background: #fff;
        }
        .top-step {
                background: #e9faf6;
                padding: 22px 30px;
                border-bottom: 1px solid #eef8f5;
            }

            .steps-container {
                max-width: 850px;
                margin: auto;
            }

            .step-item {
                display: flex;
                align-items: center;
                gap: 10px;
                transition: all 0.3s ease;
            }

            .step-item .dot {
                width: 40px;
                height: 40px;
                border-radius: 50%;
                display: flex;
                align-items: center;
                justify-content: center;
                font-weight: 700;
                font-size: 16px;
            }

            .step-item .step-info {
                text-align: left;
            }

            .step-item.active .dot {
                background: #1fbf9e;
                color: #fff;
                box-shadow: 0 0 10px rgba(31, 191, 158, 0.5);
            }

            .step-item.active .step-title {
                color: #1fbf9e;
                font-weight: 700;
            }

            .step-item.inactive .dot {
                background: #dff7f0;
                color: #0b6a56;
                opacity: 0.6;
            }

            .step-item.inactive .step-title {
                color: #6c7b78;
                font-weight: 500;
            }

        .step-title { font-weight:600; color:#0b6a56; }
        .body-confirm { padding: 22px; display:grid; grid-template-columns: 1fr 380px; gap:18px; }
        .left {
            padding-right: 6px;
        }
        .right {
            position:sticky; top:90px;
            height:max-content;
        }
        .box {
            background:#fff;border-radius:12px;padding:16px;border:1px solid #f0f6f4;
        }
        .box h5 { color:#133b36; font-weight:700; margin-bottom:12px; }
        .form-control[readonly] { background:#f7f9f8; }
        .order-row { display:flex; justify-content:space-between; padding:8px 0; border-bottom:1px dashed #eef6f3; }
        .order-row.total { font-weight:700; color:#0b6a56; border-bottom: none; padding-top:14px; }
        .btn-confirm { background:#1fbf9e; color:#fff; border:none; border-radius:8px; padding:12px 16px; width:100%; }
        .small-muted { color:#6e817d; font-size:13px; }
        .car-thumb { width:120px; height:80px; object-fit:cover; border-radius:8px; }
        .note { font-size:13px; color:#556863; }
        @media (max-width: 900px) {
            .body-confirm { grid-template-columns: 1fr; }
            .right { position: static; top: auto; }
        }
    </style>
</head>

<body>
    <form id="form1" runat="server">
        <div class="page-wrap">
            <div class="card-confirm">
               <div class="top-step">
    <div class="steps-container d-flex justify-content-between align-items-center text-center">
        <div class="step-item inactive">
            <div class="dot">1</div>
            <div class="step-info">
                <div class="small-muted">Bước 1</div>
                <div class="step-title">Tìm & chọn xe</div>
            </div>
        </div>
        <div class="step-item active">
            <div class="dot">2</div>
            <div class="step-info">
                <div class="small-muted">Bước 2</div>
                <div class="step-title">Xác nhận đơn hàng</div>
            </div>
        </div>
        <div class="step-item inactive">
            <div class="dot">3</div>
            <div class="step-info">
                <div class="small-muted">Bước 3</div>
                <div class="step-title">Xem lại thông tin</div>
            </div>
        </div>
        <div class="step-item inactive">
            <div class="dot">4</div>
            <div class="step-info">
                <div class="small-muted">Bước 4</div>
                <div class="step-title">Thành công</div>
            </div>
        </div>
    </div>
</div>


                <div class="body-confirm">
                    <div class="left">
                        <div class="box mb-3">
                            <h5>Thông tin người thuê</h5>
                            <asp:Panel ID="pnlNotLogged" runat="server">
                                <div class="mb-2">
                                    <label class="small-muted">Họ và tên <span class="text-danger">*</span></label>
                                    <asp:TextBox ID="txtTenKhach" runat="server" CssClass="form-control" placeholder="Nguyễn Văn A"></asp:TextBox>
                                </div>
                                <div class="mb-2">
                                    <label class="small-muted">Số điện thoại <span class="text-danger">*</span></label>
                                    <asp:TextBox ID="txtSDTKhach" runat="server" CssClass="form-control" placeholder="09xxxxxxxx"></asp:TextBox>
                                </div>
                            </asp:Panel>

                            <asp:Panel ID="pnlLogged" runat="server" Visible="false">
                                <div class="mb-2">
                                    <label class="small-muted">Họ và tên</label>
                                    <asp:TextBox ID="txtTenNguoiDung" runat="server" CssClass="form-control" ReadOnly="true" />
                                </div>
                                <div class="mb-2">
                                    <label class="small-muted">Số điện thoại</label>
                                    <asp:TextBox ID="txtSDTNguoiDung" runat="server" CssClass="form-control" ReadOnly="true" />
                                </div>
                            </asp:Panel>

                          

                            <asp:Label ID="lblError" runat="server" CssClass="text-danger"></asp:Label>
                        </div>

                        <div class="box">
                            <h5>Chi tiết đơn hàng</h5>

                            <div class="d-flex gap-3 mb-2 align-items-center">
                                <asp:Image ID="imgCarSmall" runat="server" CssClass="car-thumb" />
                                <div>
                                    <div><asp:Label ID="lblTenXe" runat="server" /></div>
                                    <div class="small-muted"><asp:Label ID="lblHang" runat="server" /></div>
                                </div>
                            </div>

                            <div class="order-row">
                                <div class="small-muted">Thời gian</div>
                                <div><asp:Label ID="lblThoiGian" runat="server" /></div>
                            </div>

                            <div class="order-row">
                                <div class="small-muted">Địa điểm</div>
                                <div><asp:Label ID="lblDiaChi" runat="server" /></div>
                            </div>

                            <div class="order-row">
                                <div class="small-muted">Giá cơ bản</div>
                                <div><asp:Label ID="lblGiaCoBan" runat="server" /></div>
                            </div>

                            <div class="order-row">
                                <div class="small-muted">Số ngày (tạm tính)</div>
                                <div><asp:Label ID="lblSoNgay" runat="server" /></div>
                            </div>

                            <div class="order-row">
                                <div class="small-muted">Giảm giá</div>
                                <div><asp:Label ID="lblGiamGia" runat="server" Text="0 VNĐ" /></div>
                            </div>

                            <div class="order-row total">
                                <div>Tổng thanh toán</div>
                                <div><asp:Label ID="lblTong" runat="server" /></div>
                            </div>

                            <div class="mt-2 small-muted">* Tổng hiển thị để khách xác nhận. Thanh toán thực tế sẽ được cập nhật khi chủ xe xác nhận.</div>
                        </div>
                    </div>
                    <div class="right">
                        <div class="box">
                            <h5>Phương thức thanh toán</h5>

                            <asp:RadioButtonList ID="rblPayment" runat="server" RepeatDirection="Vertical" CssClass="mb-3">
                                <asp:ListItem Value="hold">Thanh toán giữ chỗ (500.000 VNĐ)</asp:ListItem>
                                <asp:ListItem Value="onpickup">Thanh toán khi nhận xe (Toàn bộ)</asp:ListItem>
                            </asp:RadioButtonList>

                            <div class="mb-3">
                                <div class="note"><i class="bi bi-info-circle-fill"></i> Chú ý: chủ xe sẽ gọi xác nhận sau khi bạn nhấn "Xác nhận".</div>
                            </div>

                            <asp:Button ID="btnConfirm" runat="server" Text="XÁC NHẬN" CssClass="btn-confirm" OnClick="btnConfirm_Click" />

                            <div class="mt-3 small-muted text-center">
                                <asp:Label ID="lblStatus" runat="server" />
                            </div>
                        </div>
                    </div>

                </div>
            </div> 
        </div> 
    </form>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>

