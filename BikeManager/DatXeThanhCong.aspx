<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="DatXeThanhCong.aspx.cs" Inherits="BikeManager.DatXeThanhCong" %>

<!DOCTYPE html>
<html lang="vi">
<head runat="server">
    <meta charset="utf-8" />
    <title>Đặt xe thành công | BonbonCar - ViperMoto</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet" />

    <style>
        body {
            background: linear-gradient(180deg, #ecfffa 0%, #f6fffc 100%);
            font-family: 'Poppins', sans-serif;
            color: #183e35;
            animation: fadeIn 1.2s ease-in;
        }

        @keyframes fadeIn {
            from { opacity: 0; transform: translateY(30px); }
            to { opacity: 1; transform: translateY(0); }
        }

        .success-wrap {
            max-width: 780px;
            margin: 60px auto;
            background: #fff;
            border-radius: 22px;
            box-shadow: 0 10px 35px rgba(19, 53, 46, 0.12);
            padding: 40px;
            text-align: center;
        }

        .car-img {
            width: 100%;
            max-height: 240px;
            object-fit: cover;
            border-radius: 12px;
            margin-bottom: 20px;
        }

        .info-row {
            display: flex;
            justify-content: space-between;
            padding: 8px 0;
            border-bottom: 1px dashed #e4f4f0;
            font-size: 15px;
        }

        .info-row:last-child { border: none; }

        .total-box {
            margin-top: 20px;
            background: #f3fbf9;
            border-radius: 10px;
            padding: 14px;
            font-weight: 600;
        }

        .small-note {
            font-size: 13px;
            color: #6e817d;
        }
        .snake-box {
            margin-top: 50px;
            text-align: center;
            animation: fadeIn 1.4s ease-in;
        }

        svg.snake-logo {
            width: 220px;
            height: 220px;
            margin-bottom: 12px;
        }

        @keyframes snakeBow {
            0%, 100% { transform: rotate(0deg); }
            30% { transform: rotate(12deg); }
            60% { transform: rotate(-10deg); }
            80% { transform: rotate(6deg); }
        }

        @keyframes tailWave {
            0%, 100% { transform: rotate(0deg); }
            50% { transform: rotate(-8deg); }
        }

        .snake-head {
            transform-origin: 60% 70%;
            animation: snakeBow 2.8s ease-in-out infinite;
        }

        .snake-tail {
            transform-origin: 20% 60%;
            animation: tailWave 3s ease-in-out infinite;
        }

        .thank-text {
            font-size: 22px;
            color: #0a6d57;
            font-weight: 800;
            margin-bottom: 6px;
        }

        .sub-thank {
            font-size: 15px;
            color: #667974;
        }
    </style>
</head>
<body>
    <form id="form1" runat="server">
        <div class="success-wrap">
            <h4 class="mb-3">Thông tin đơn thuê</h4>

            <asp:Image ID="imgXe" runat="server" CssClass="car-img" />

            <div class="info-row">
                <div>Mã đặt xe</div>
                <div><asp:Label ID="lblMaDon" runat="server" /></div>
            </div>
            <div class="info-row">
                <div>Tên khách thuê</div>
                <div><asp:Label ID="lblTenKhach" runat="server" /></div>
            </div>
            <div class="info-row">
                <div>Số điện thoại</div>
                <div><asp:Label ID="lblSDT" runat="server" /></div>
            </div>
            <div class="info-row">
                <div>Ngày nhận</div>
                <div><asp:Label ID="lblNhan" runat="server" /></div>
            </div>
            <div class="info-row">
                <div>Ngày trả</div>
                <div><asp:Label ID="lblTra" runat="server" /></div>
            </div>
            <div class="info-row">
                <div>Loại xe</div>
                <div><asp:Label ID="lblLoaiXe" runat="server" /></div>
            </div>

            <div class="total-box">
                <div class="d-flex justify-content-between">
                    <div>Tổng cộng tiền thuê xe</div>
                    <div><asp:Label ID="lblTongTien" runat="server" /></div>
                </div>
                <div class="small-note mt-1">Bạn sẽ thanh toán khi nhận xe</div>
            </div>

            <div class="snake-box">
                <svg class="snake-logo" viewBox="0 0 200 200" xmlns="http://www.w3.org/2000/svg">
                 
                    <path class="snake-tail" d="M30 140 Q70 100 110 140 T190 140" stroke="#1fbf9e" stroke-width="10" fill="none" stroke-linecap="round"/>
                   
                    <g class="snake-head">
                        <circle cx="160" cy="100" r="26" fill="#1fbf9e"/>
                        <circle cx="154" cy="94" r="4" fill="#fff"/>
                        <circle cx="168" cy="94" r="4" fill="#fff"/>
                        <path d="M160 122 Q158 130 162 130 Q166 130 164 122 Z" fill="#fff"/>
                    </g>
                </svg>

                <div class="thank-text"> Cảm ơn bạn đã đặt xe tại ViperMoto!</div>
                <div class="sub-thank">Đơn hàng đã được gửi tới chủ xe, họ sẽ sớm liên hệ với bạn để xác nhận.</div>
            </div>
        </div>
    </form>

    <script>
        setTimeout(() => {
            document.body.style.transition = "opacity 1.5s";
            document.body.style.opacity = "0";
            setTimeout(() => {
                window.location.href = "Default.aspx";
            }, 1500);
        }, 10000);
    </script>
</body>
</html>
