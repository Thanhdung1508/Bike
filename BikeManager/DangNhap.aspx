<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="DangNhap.aspx.cs" Inherits="BikeManager.DangNhap" %>
<!DOCTYPE html>
<html lang="vi">
<head runat="server">
    <meta charset="utf-8" />
    <title>Đăng nhập - BikeManager</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet" />
    <style>
        body {
            background: rgba(0,0,0,0.2);
            height: 100vh;
            display: flex;
            align-items: center;
            justify-content: center;
            font-family: 'Segoe UI', sans-serif;
        }
        .login-card {
            background: #fff;
            border-radius: 15px;
            box-shadow: 0 0 15px rgba(0,0,0,0.2);
            padding: 40px;
            width: 380px;
        }
        .login-card h2 {
            text-align: center;
            margin-bottom: 20px;
            color: #333;
        }
        .btn-primary {
            width: 100%;
        }
        .alert {
            text-align: center;
        }
    </style>
</head>
<body>
    <form id="form1" runat="server">
        <div class="login-card">
            <h2>Đăng nhập</h2>

            <div class="mb-3">
                <label for="txtEmail" class="form-label">Email</label>
                <asp:TextBox ID="txtEmail" runat="server" CssClass="form-control" Placeholder="Nhập email..." />
            </div>

            <div class="mb-3">
                <label for="txtMatKhau" class="form-label">Mật khẩu</label>
                <asp:TextBox ID="txtMatKhau" runat="server" TextMode="Password" CssClass="form-control" Placeholder="Nhập mật khẩu..." />
            </div>

            <asp:Button ID="btnDangNhap" runat="server" Text="Đăng nhập" CssClass="btn btn-primary mb-3" OnClick="btnDangNhap_Click" />

            <asp:Label ID="lblThongBao" runat="server" CssClass="text-danger fw-bold d-block text-center"></asp:Label>

            <div class="text-center mt-3">
                <a href="DangKy.aspx">Chưa có tài khoản? Đăng ký ngay</a>
            </div>
        </div>
    </form>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
