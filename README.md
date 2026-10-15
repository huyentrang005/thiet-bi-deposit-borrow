<<<<<<< HEAD
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
│   ├── project/
│   │   └── ProjectCore.sol       # Hợp đồng thông minh lõi (Chủ đề 2: Ký quỹ & phạt trễ hạn)
│   ├── training/                 # Bài mẫu học kỹ thuật (TimeLockVault, VaultBuggy, VulnerableBank)
│   └── QuanLyThietBi.sol         # Hợp đồng quản lý thiết bị ban đầu
├── test/
│   └── ProjectCoreTest.sol       # Ca kiểm thử quy tắc kinh tế & chặn gian lận
├── web/
│   └── index.html                # Giao diện Web3 DApp (HTML/CSS/JS + Ethers.js v5)
├── docs/
│   ├── SPEC.md                   # Đặc tả kỹ thuật và phân tích nghiệp vụ
│   ├── ECONOMIC_RULES.md         # Quy tắc kinh tế và cơ chế phạt/thưởng
│   ├── PROJECT_PLAN.md           # Kế hoạch phát triển dự án nhóm
│   ├── AI_JOURNAL.md             # Nhật ký làm việc với AI từ Lab 8 đến Lab 15
│   ├── GATE_REVIEW_1.md          # Biên bản Gate Review 1 (Duyệt phạm vi Lab 12)
│   ├── AUDIT_REPORT.md           # Báo cáo rà soát chéo hợp đồng (Lab 14)
│   └── PRESENTATION_PLAN.md      # Kịch bản thuyết trình và demo 5 phút (Lab 15)
├── evidence/                     # Minh chứng ảnh và log cho từng Lab (Lab 8 - Lab 15)
│   ├── lab-08/ ... lab-15/
├── vercel.json                   # Cấu hình tự động triển khai tĩnh trên Vercel
├── push.bat                      # Kịch bản tự động đẩy code & tags lên GitHub
├── pull.bat                      # Kịch bản đồng bộ code mới nhất từ GitHub
└── README.md                     # Tài liệu giới thiệu dự án
=======
# SmartRent — Hệ Thống Ký Quỹ Đặt Cọc Mượn Trả Thiết Bị (ECO2432)

> **Một câu giới thiệu sản phẩm (Checkpoint 1):**  
> *"Nhóm xây dựng Hệ thống ký quỹ đặt cọc mượn trả thiết bị (SmartRent) cho sinh viên và phòng thực hành/lab trường học để tự động hóa việc lưu ký và hoàn tiền cọc minh bạch, loại bỏ tranh chấp và tránh thất thoát thiết bị."*

---

## 1. Nhóm làm gì?
Nhóm phát triển một ứng dụng phi tập trung (Web3 DApp) kết hợp hợp đồng thông minh (Smart Contract) trên mạng Ethereum Sepolia Testnet. Hệ thống đóng vai trò bên thứ ba trung gian (Escrow) giữ tiền cọc của sinh viên khi mượn thiết bị và tự động hoàn trả cọc (hoặc trừ phí bồi thường nếu hư hỏng) khi trả thiết bị về kho.

## 2. Cho ai?
- **Sinh viên:** Có nhu cầu mượn thiết bị thực hành/nghiên cứu ngắn hạn (máy ảnh, máy tính lab, kit vi điều khiển IoT, thiết bị đo đạc).
- **Phòng thực hành / Ban quản lý thiết bị nhà trường:** Cần công cụ quản lý tình trạng mượn trả, chống thất thoát tài sản và thực thi các điều khoản bồi thường minh bạch, không phụ thuộc vào tiền mặt hay giữ giấy tờ tùy thân.

## 3. Quy tắc chính là gì?
1. **Ký quỹ bắt buộc (Escrow):** Người mượn phải nộp tiền cọc bằng Native ETH đúng bằng mức yêu cầu của thiết bị (`msg.value == tb.tienCoc`). Tiền cọc được khóa an toàn trong hợp đồng.
2. **Độc quyền sử dụng:** Thiết bị chỉ được mượn khi đang ở trạng thái `SanSang` (0). Khi đang có người mượn, không ai khác có thể can thiệp.
3. **Nghiệm thu & Khấu trừ theo Basis Point:** Khi trả thiết bị, Quản trị viên nghiệm thu tình trạng và hoàn cọc. Nếu có hư hỏng, mức khấu trừ được tính theo chuẩn Basis Point (1% = 100 bps, tối đa 10,000 bps = 100%).
4. **Bảo mật Checks-Effects-Interactions (CEI):** Trạng thái thiết bị được cập nhật trước khi chuyển tiền hoàn cọc bằng `call{value: ...}("")` để ngăn chặn triệt để tấn công Reentrancy.

---

## 4. Phân công trách nhiệm thành viên

| Họ và tên | Mã sinh viên | GitHub Username | Vai trò chính Lab 8–11 | Vai trò chính Lab 12–15 |
| :--- | :--- | :--- | :--- | :--- |
| **Phan Thị Huyền Trang**  | `23k4300040` | `@huyentrang005` | Hợp đồng thông minh & Đặc tả | Kiểm thử ca tấn công & Báo cáo |
| **Trần Thị Thi Thơ**  | `23K4300018` | `@thot23547-cpu` | Giao diện Web3 DApp | Hợp đồng & Audit bảo mật |

---

## 5. Cấu trúc thư mục (Theo chuẩn Phần B.6)

```text
├── contracts/
│   ├── QuanLyThietBi.sol     # Hợp đồng thông minh chính của nhóm
│   └── training/             # Hợp đồng mẫu dùng cho các bài thực hành sau
├── docs/
│   ├── PROJECT_PLAN.md       # Kế hoạch dự án, phân vai, mục tiêu các mốc Lab 8-15
│   ├── SPEC.md               # Đặc tả kỹ thuật v0.1 với các quy tắc kiểm thử được
│   ├── ECONOMIC_RULES.md     # Quy tắc kinh tế, dòng tiền và 5 phản biện rủi ro
│   └── AI_JOURNAL.md         # Nhật ký prompt và thẩm định AI
├── web/
│   └── index.html            # Giao diện Web3 DApp tương tác với MetaMask
├── README.md                 # Giới thiệu tổng quan đồ án nhóm
├── push.bat                  # Script đẩy code nhanh lên GitHub
└── AGENTS.md                 # Quy ước bắt buộc khi phát triển dự án
>>>>>>> origin/main
```

---

<<<<<<< HEAD
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
=======
## 6. Hướng dẫn chạy thử nghiệm DApp

1. Mở tệp `web/index.html` trực tiếp trên trình duyệt có cài đặt tiện ích ví **MetaMask**.
2. Chuyển MetaMask sang mạng **Sepolia Testnet**.
3. Kết nối ví, nhập địa chỉ hợp đồng đã deploy và tiến hành thử nghiệm mượn / trả thiết bị.
>>>>>>> origin/main
