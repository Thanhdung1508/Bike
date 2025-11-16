<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="TrangChu.aspx.cs" Inherits="BikeManager.Admin.TrangChu" %>
<!DOCTYPE html>
<html lang="vi">
<head runat="server">
    <meta charset="utf-8" />
    <title>Quản trị hệ thống - BikeManager</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet" />
    <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.css" rel="stylesheet" />
    <style>
        body {
            font-family: "Segoe UI", sans-serif;
            background: #f4f6f9;
            overflow-x: hidden;
        }
        .sidebar {
            height: 100vh;
            width: 250px;
            position: fixed;
            left: 0;
            top: 0;
            background: linear-gradient(180deg, #007bff, #004b9a);
            color: white;
            box-shadow: 2px 0 10px rgba(0,0,0,0.2);
        }
        .sidebar h4 {
            font-weight: 700;
            text-align: center;
            margin-top: 25px;
            letter-spacing: 1px;
        }
        .sidebar a {
            display: block;
            color: #dbeafe;
            padding: 12px 22px;
            text-decoration: none;
            border-left: 4px solid transparent;
            transition: 0.3s;
            font-weight: 500;
        }
        .sidebar a:hover, .sidebar a.active {
            background: rgba(255,255,255,0.15);
            border-left: 4px solid #fff;
            color: #fff;
        }
        .main {
            margin-left: 250px;
            padding: 25px;
        }
        .topbar {
            background: white;
            border-radius: 10px;
            padding: 12px 25px;
            box-shadow: 0 3px 8px rgba(0,0,0,0.05);
            display: flex;
            justify-content: space-between;
            align-items: center;
        }
        .topbar h3 {
            font-weight: 600;
            color: #333;
        }
        .user-info {
            display: flex;
            align-items: center;
            gap: 10px;
            font-weight: 500;
            color: #444;
        }
        .dashboard {
            margin-top: 35px;
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(260px, 1fr));
            gap: 25px;
        }
        .card-stat {
            background: white;
            border-radius: 16px;
            box-shadow: 0 4px 15px rgba(0,0,0,0.08);
            padding: 25px;
            transition: transform 0.2s, box-shadow 0.3s;
        }
        .card-stat:hover {
            transform: translateY(-5px);
            box-shadow: 0 6px 18px rgba(0,0,0,0.15);
        }
        .card-icon {
            font-size: 45px;
            margin-bottom: 15px;
        }
        .card-blue { color: #0d6efd; }
        .card-green { color: #198754; }
        .card-red { color: #dc3545; }
        .card-yellow { color: #ffc107; }
        .card-stat h4 {
            font-size: 18px;
            color: #555;
            font-weight: 600;
        }
        .card-stat .value {
            font-size: 30px;
            font-weight: 700;
            margin-top: 5px;
        }
    </style>
</head>
<body>
    <form id="form1" runat="server">
        <div class="sidebar">
            <h4>BikeManager</h4>
            <a href="TrangChu.aspx" class="active"><i class="bi bi-speedometer2 me-2"></i> Bảng điều khiển</a>
            <a href="QuanLyXe.aspx"><i class="bi bi-bicycle me-2"></i> Quản lý xe</a>
            <a href="QuanLyNguoiThue.aspx"><i class="bi bi-people me-2"></i> Người thuê</a>
            <a href="QuanLyHopDong.aspx"><i class="bi bi-file-earmark-text me-2"></i> Hợp đồng</a>
            <a href="../DangXuat.aspx" class="text-danger"><i class="bi bi-box-arrow-right me-2"></i> Đăng xuất</a>
        </div>
        <div class="main">
            <div class="topbar">
                <h3>Nhà tui</h3>
                <div class="user-info">
                    <i class="bi bi-person-circle fs-4"></i>
                    <asp:Label ID="lblTenAdmin" runat="server" Text="Admin" />
                </div>
            </div>

            <!-- Dashboard -->
            <div class="dashboard">
                <div class="card-stat text-center">
                    <div class="card-icon card-blue"><i class="bi bi-bicycle"></i></div>
                    <h4>Tổng số xe</h4>
                    <asp:Label ID="lblSoXe" runat="server" CssClass="value text-primary" />
                </div>

                <div class="card-stat text-center">
                    <div class="card-icon card-green"><i class="bi bi-people-fill"></i></div>
                    <h4>Người thuê</h4>
                    <asp:Label ID="lblSoNguoiThue" runat="server" CssClass="value text-success" />
                </div>

                <div class="card-stat text-center">
                    <div class="card-icon card-red"><i class="bi bi-file-earmark-text-fill"></i></div>
                    <h4>Hợp đồng thuê</h4>
                    <asp:Label ID="lblSoHopDong" runat="server" CssClass="value text-danger" />
                </div>

                <div class="card-stat text-center">
                    <div class="card-icon card-yellow"><i class="bi bi-gear"></i></div>
                    <h4>Xe đang bảo trì</h4>
                    <asp:Label ID="lblXeBaoTri" runat="server" CssClass="value text-warning" />
                </div>
            </div>
        </div>

    </form>
</body>
</html>
