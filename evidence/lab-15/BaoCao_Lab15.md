# BÁO CÁO LAB 15 — GIAO DIỆN DAPP WEB3, XUẤT BẢN CÔNG KHAI VÀ TỔNG KẾT ĐỒ ÁN

**Tên dự án:** Hệ thống Quản lý Đặt cọc & Mượn trả Thiết bị CLB (SmartRent)  
**Mã lớp / Học phần:** ECO2432 — Tiền điện tử & Công nghệ Blockchain  
**Repo nhóm:** `https://github.com/huyentrang005/thiet-bi-deposit-borrow`  
**Địa chỉ DApp trực tuyến:** [https://thiet-bi-deposit-borrow.vercel.app](https://thiet-bi-deposit-borrow.vercel.app)  
**Phiên bản phát hành:** Tag Git `v1.0.0` (Production Ready)

**Thành viên thực hiện:**
- Phan Thị Huyền Trang (MSSV: 23K4020050 - `@huyentrang005`)
- Trần Thị Thi Thơ (MSSV: 23K4300018 - `@thot23547-cpu`)

---

## 1. Kết quả Xuất bản DApp & Triển khai On-Chain

| Hạng mục | Thông số triển khai |
| :--- | :--- |
| **Mạng Blockchain** | Ethereum Sepolia Testnet (Chain ID: `11155111`) |
| **Hợp đồng QuanLyThietBi** | `0xC61d78A92B7Dfdf85fAB1c22135977721dd96F4c` |
| **Hợp đồng ProjectCore** | `0x47666Fab8bd0Ac7003bce3f5C3585383F09486E2` |
| **Trình duyệt khối (Blockscout/Etherscan)** | [Xem Contract trên Sepolia](https://sepolia.etherscan.io/address/0xC61d78A92B7Dfdf85fAB1c22135977721dd96F4c) |
| **Dền tảng Hosting DApp** | Vercel Serverless Static Platform (`vercel.json`) |
| **Thư viện Web3** | Ethers.js v5.7.2 CDN + Vanilla Modern CSS/JS |

---

## 2. Bảng ánh xạ kết nối giao diện với Smart Contract

| Thành phần DApp | Thao tác trên Giao diện | Phương thức Smart Contract | Loại tương tác |
| :--- | :--- | :--- | :---: |
| **Danh mục thiết bị** | Bảng hiển thị danh sách thiết bị CLB | `danhSachThietBi(id)` / `devices(id)` | View (Miễn phí) |
| **Đặt cọc mượn đồ** | Nút *"Mượn thiết bị"* kèm số ETH cọc | `muonThietBi(id)` / `borrow()` | Write (Yêu cầu ký ví & nạp ETH) |
| **Nghiệm thu & Hoàn cọc** | Form Admin nhập ID và % khấu trừ | `traVaHoanCoc(id, bps)` / `returnDevice()` | Write (Chỉ Admin) |
| **Thêm thiết bị mới** | Form Admin nhập tên & mức cọc | `themThietBi(ten, cocWei)` | Write (Chỉ Admin) |
| **Kiểm tra tiền phạt** | Hiển thị tính toán phạt trễ hạn | `tinhTienPhat(id, now)` / `calculatePenalty()` | View (Miễn phí) |

---

## 3. Check-list Hoàn thành Đồ án (Lab 8 – Lab 15)

- [x] **Tài liệu đặc tả (Docs):** Hoàn thành đầy đủ `PROJECT_PLAN.md`, `SPEC.md`, `ECONOMIC_RULES.md`, `GATE_REVIEW_1.md`, `AUDIT_REPORT.md`, `PRESENTATION_PLAN.md`.
- [x] **Smart Contracts:** Mã nguồn chuẩn Solidity 0.8.20, áp dụng Checks-Effects-Interactions, ngăn chặn triệt để Reentrancy.
- [x] **Kiểm thử tự động (Tests):** Đầy đủ các ca kiểm thử quy tắc kinh tế, ca vi phạm gửi thiếu cọc, ca tấn công reentrancy.
- [x] **Audit bảo mật:** Đã vượt qua rà soát 10 tiêu chuẩn bắt buộc và giải quyết 100% các khuyến nghị.
- [x] **DApp Web3:** Giao diện trực quan phong cách hiện đại (Dark Glassmorphism), hỗ trợ cả chế độ Demo trải nghiệm nhanh và chế độ tương tác On-Chain qua MetaMask.
- [x] **Minh chứng (Evidence):** Đầy đủ 8 thư mục từ `evidence/lab-08` đến `evidence/lab-15` kèm báo cáo Markdown và ảnh chụp bằng chứng.
- [x] **Nhật ký AI:** Ghi chép chi tiết toàn bộ các prompt trao đổi và phản biện kỹ thuật trong `AI_JOURNAL.md`.

---

## 4. Phân công Thuyết trình Đồ án (5 phút)

- **Phan Thị Huyền Trang (3 phút đầu):**
  - Giới thiệu bài toán đặt cọc thiết bị trong trường đại học và định vị sản phẩm SmartRent.
  - Trực tiếp thao tác DApp: kết nối MetaMask, nạp cọc mượn thiết bị, giải thích luồng khóa cọc trên Smart Contract.
  - Phân tích kiến trúc an toàn CEI chống rút cọc kép.
- **Trần Thị Thi Thơ (2 phút sau):**
  - Trình bày công thức kinh tế phạt trễ hạn và nghiệm thu khấu trừ hao mòn.
  - Thực hiện demo ca chặn gian lận (gửi thiếu tiền cọc bị Smart Contract từ chối).
  - Tổng kết kết quả triển khai Vercel, bài học kinh nghiệm và định hướng mở rộng hệ thống.
