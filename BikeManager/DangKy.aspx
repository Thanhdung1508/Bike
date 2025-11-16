<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="DangKy.aspx.cs" Inherits="BikeManager.DangKy" %>

<!DOCTYPE html>
<html lang="vi">
<head runat="server">
    <meta charset="utf-8" />
    <title>Đăng ký tài khoản</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet" />
</head>
<body class="bg-light">
<form id="form1" runat="server">
<div class="container py-5" style="max-width:500px;">
    <h3 class="text-center mb-4 text-success fw-bold">Tạo tài khoản mới</h3>

    <div class="mb-3">
        <label class="form-label">Tên người dùng</label>
        <asp:TextBox ID="txtTenNguoiDung" runat="server" CssClass="form-control" placeholder="Nhập tên"></asp:TextBox>
    </div>

    <div class="mb-3">
        <label class="form-label">Email</label>
        <asp:TextBox ID="txtEmail" runat="server" CssClass="form-control" TextMode="Email" placeholder="Nhập email"></asp:TextBox>
    </div>

    <div class="mb-3">
        <label class="form-label">Số điện thoại</label>
        <asp:TextBox ID="txtSDT" runat="server" CssClass="form-control" placeholder="Nhập số điện thoại"></asp:TextBox>
    </div>

    <div class="mb-3">
        <label class="form-label">Mật khẩu</label>
        <asp:TextBox ID="txtMatKhau" runat="server" CssClass="form-control" TextMode="Password" placeholder="Nhập mật khẩu"></asp:TextBox>
    </div>

    <div class="mb-3">
        <label class="form-label">Xác nhận mật khẩu</label>
        <asp:TextBox ID="txtXacNhan" runat="server" CssClass="form-control" TextMode="Password" placeholder="Nhập lại mật khẩu"></asp:TextBox>
    </div>

    <asp:Button ID="btnDangKy" runat="server" Text="Đăng ký" CssClass="btn btn-success w-100" OnClick="btnDangKy_Click" />

    <div class="text-center mt-3">
        <a href="DangNhap.aspx">Đã có tài khoản? Đăng nhập</a>
    </div>

    <asp:Label ID="lblThongBao" runat="server" CssClass="text-danger d-block mt-3 text-center"></asp:Label>
</div>
</form>
</body>
</html>

