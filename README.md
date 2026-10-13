# 📱 Hệ Thống Quản Lý Đặt Cọc Mượn Trả Thiết Bị (Web3 DApp)

[![Vercel Deployment](https://img.shields.io/badge/Vercel-Deployed-000000?style=for-the-badge&logo=vercel&logoColor=white)](https://thiet-bi-deposit-borrow.vercel.app)
[![Solidity](https://img.shields.io/badge/Solidity-0.8.20-363636?style=for-the-badge&logo=solidity&logoColor=white)](contracts/QuanLyThietBi.sol)
[![Network](https://img.shields.io/badge/Network-Sepolia%20Testnet-blue?style=for-the-badge&logo=ethereum&logoColor=white)](https://sepolia.etherscan.io/)
[![License](https://img.shields.io/badge/License-MIT-green?style=for-the-badge)](LICENSE)

Đồ án môn học **ECO2432 - Tiền Điện Tử & Ứng Dụng Web3**.  
Hệ thống phi tập trung giải quyết bài toán ký quỹ (escrow) đặt cọc, theo dõi mượn trả thiết bị phòng lab minh bạch, tự động hoàn cọc theo tỷ lệ nghiệm thu hao mòn trên mạng **Ethereum Sepolia**.

---

## 🌐 Trải nghiệm Trực tiếp (Live Demo)

Trang web DApp đã được cấu hình sẵn sàng triển khai trên **Vercel**:

👉 **Truy cập DApp trực tiếp:** **[https://thiet-bi-deposit-borrow.vercel.app](https://thiet-bi-deposit-borrow.vercel.app)**

> Hoặc triển khai nhanh bản sao riêng của bạn chỉ với 1 cú click:
> 
> [![Deploy with Vercel](https://vercel.com/button)](https://vercel.com/new/clone?repository-url=https%3A%2F%2Fgithub.com%2Fhuyentrang005%2Fthiet-bi-deposit-borrow)

---

## 📑 Mục lục
- [1. Tính năng Nổi bật](#1-tính-năng-nổi-bật)
- [2. Cấu trúc Dự án](#2-cấu-trúc-dự-án)
- [3. Hướng dẫn Triển khai lên Vercel](#3-hướng-dẫn-triển-khai-lên-vercel)
- [4. Hướng dẫn Sử dụng DApp](#4-hướng-dẫn-sử-dụng-dapp)
- [5. Thông tin Nhóm & Bản quyền](#5-thông-tin-nhóm--bản-quyền)

---

## 1. Tính năng Nổi bật

- **Khóa cọc an toàn (Escrow):** Tiền cọc ETH được ký quỹ trực tiếp trên Smart Contract, loại bỏ nguy cơ gian lận từ bên thứ ba.
- **Tuân thủ quy chuẩn bảo mật:** Smart Contract áp dụng mẫu thiết kế **Checks-Effects-Interactions (CEI)**, sử dụng Custom Errors tiết kiệm gas và thư viện chuẩn **OpenZeppelin 5.x**.
- **Khấu trừ linh hoạt theo Basis Points (bps):** Quản trị viên nghiệm thu thiết bị và khấu trừ tỷ lệ hao hòn/hư hỏng (1% = 100 bps), tiền cọc còn lại lập tức hoàn về ví người mượn tự động.
- **Giao diện hiện đại & Real-time Logs:** DApp Web3 tương tác trực tiếp qua ví MetaMask, hiển thị trạng thái thiết bị và nhật ký sự kiện blockchain theo thời gian thực.

---

## 2. Cấu trúc Dự án

```bash
thiet-bi-deposit-borrow/
├── contracts/
│   └── QuanLyThietBi.sol     # Smart Contract quản lý ký quỹ & mượn trả thiết bị
├── web/
│   └── index.html             # Giao diện Web3 DApp (HTML/CSS/JS + Ethers.js v5)
├── docs/
│   ├── SPEC.md                # Đặc tả kỹ thuật và phân tích nghiệp vụ
│   ├── ECONOMIC_RULES.md      # Quy tắc kinh tế và cơ chế phạt/thưởng
│   └── PROJECT_PLAN.md        # Kế hoạch phát triển dự án nhóm
├── vercel.json                # Cấu hình tự động triển khai tĩnh trên Vercel
├── lab08.md                   # Báo cáo thiết lập repository nhóm & phân quyền
├── push.bat                   # Kịch bản tự động đẩy code lên GitHub
├── pull.bat                   # Kịch bản đồng bộ code mới nhất từ GitHub
└── README.md                  # Tài liệu giới thiệu dự án
```

---

## 3. Hướng dẫn Triển khai lên Vercel

Dự án đã có tệp cấu hình `vercel.json` trỏ sẵn thư mục `web/`:

```json
{
  "$schema": "https://openapi.vercel.sh/vercel.json",
  "outputDirectory": "web",
  "buildCommand": null
}
```

### Các bước triển khai qua Vercel Dashboard:
1. Đăng nhập vào **[Vercel](https://vercel.com/)** bằng tài khoản GitHub `huyentrang005`.
2. Bấm **Add New...** ➔ Chọn **Project**.
3. Chọn repository **`huyentrang005/thiet-bi-deposit-borrow`** ➔ Nhấn **Import**.
4. Giữ nguyên mọi cài đặt mặc định (Vercel tự động đọc file `vercel.json` để lấy giao diện từ `web/`).
5. Bấm **Deploy**. Sau ~30 giây, website sẽ hoạt động tại tên miền `*.vercel.app`.

---

## 4. Hướng dẫn Sử dụng DApp

1. **Chuẩn bị:** Cài đặt tiện ích mở rộng ví **MetaMask** trên trình duyệt và chuyển sang mạng **Sepolia Testnet**.
2. **Kết nối:** Bấm nút **"Kết nối ví MetaMask"** trên giao diện DApp.
3. **Tải dữ liệu:** Nhập địa chỉ Smart Contract đã deploy trên Sepolia vào ô *Địa chỉ Contract* và bấm **"Tải dữ liệu"**.
4. **Mượn thiết bị:** Chọn thiết bị ở trạng thái *Sẵn sàng*, bấm **"Đặt cọc & Mượn"** và xác nhận giao dịch trên MetaMask (kèm tiền cọc ETH quy định).
5. **Nghiệm thu & Hoàn cọc:** Quản trị viên nhập ID thiết bị, mức khấu trừ hao mòn (nếu có) và xác nhận hoàn cọc cho người mượn.

---

## 5. Thông tin Nhóm & Bản quyền

- **Đơn vị:** Khoa Kinh tế / CNTT - Dự án môn học ECO2432.
- **Trưởng nhóm:** Phan Thị Huyền Trang ([@huyentrang005](https://github.com/huyentrang005)).
- **Repository:** [https://github.com/huyentrang005/thiet-bi-deposit-borrow](https://github.com/huyentrang005/thiet-bi-deposit-borrow)
- **Giấy phép:** [MIT License](LICENSE).
