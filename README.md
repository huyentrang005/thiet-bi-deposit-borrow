# SmartRent — Hệ Thống Ký Quỹ Đặt Cọc Mượn Trả Thiết Bị (ECO2432)

[![GitHub Pages](https://img.shields.io/badge/DEPLOYED-GITHUB%20PAGES-success?style=for-the-badge&logo=github&logoColor=white)](https://huyentrang005.github.io/thiet-bi-deposit-borrow/web/)[![Solidity](https://img.shields.io/badge/Solidity-0.8.20-363636?style=for-the-badge&logo=solidity&logoColor=white)](contracts/project/ProjectCore.sol)
[![Network](https://img.shields.io/badge/Network-Sepolia%20Testnet-blue?style=for-the-badge&logo=ethereum&logoColor=white)](https://sepolia.etherscan.io/)
[![License](https://img.shields.io/badge/License-MIT-green?style=for-the-badge)](LICENSE)

> **Một câu giới thiệu sản phẩm (Checkpoint 1):**  
> *"Nhóm xây dựng Hệ thống ký quỹ đặt cọc mượn trả thiết bị (SmartRent) cho sinh viên và phòng thực hành/lab trường học để tự động hóa việc lưu ký và hoàn tiền cọc minh bạch, loại bỏ tranh chấp và tránh thất thoát thiết bị."*

---

## 🌐 Trải nghiệm Trực tiếp (Live Demo)

Trang web DApp đã được cấu hình sẵn sàng triển khai trên **Vercel**:

👉 **Truy cập DApp trực tiếp:** **[https://huyentrang005.github.io/thiet-bi-deposit-borrow/web/](https://huyentrang005.github.io/thiet-bi-deposit-borrow/web/)**
> Hoặc triển khai nhanh bản sao riêng của bạn chỉ với 1 cú click:
> 


## 📑 Mục lục
- [1. Nhóm làm gì & Cho ai?](#1-nhóm-làm-gì--cho-ai)
- [2. Quy tắc chính là gì?](#2-quy-tắc-chính-là-gì)
- [3. Phân công trách nhiệm thành viên](#3-phân-công-trách-nhiệm-thành-viên)
- [4. Cấu trúc thư mục dự án](#4-cấu-trúc-thư-mục-dự-án)
- [5. Hướng dẫn Triển khai lên Vercel](#5-hướng-dẫn-triển-khai-lên-vercel)
- [6. Hướng dẫn chạy thử nghiệm DApp](#6-hướng-dẫn-chạy-thử-nghiệm-dapp)

---

## 1. Nhóm làm gì & Cho ai?
- **Nhóm làm gì:** Phát triển ứng dụng phi tập trung (Web3 DApp) kết hợp Smart Contract trên Ethereum Sepolia Testnet. Hệ thống đóng vai trò bên thứ ba trung gian (Escrow) giữ tiền cọc của sinh viên khi mượn thiết bị và tự động hoàn trả cọc (hoặc trừ phí phạt theo ngày trễ hạn) khi trả thiết bị về kho.
- **Cho ai:**
  - **Sinh viên:** Có nhu cầu mượn thiết bị thực hành/nghiên cứu ngắn hạn (máy ảnh, máy chiếu, laptop, bộ kit vi điều khiển).
  - **Ban quản lý phòng thực hành / CLB:** Quản lý tình trạng mượn trả, chống thất thoát tài sản và thực thi các điều khoản bồi thường minh bạch mà không cần giữ tiền mặt hay giấy tờ tùy thân.

---

## 2. Quy tắc chính là gì?
1. **Ký quỹ bắt buộc (Escrow):** Người mượn phải nộp tiền cọc bằng Native ETH đúng bằng mức yêu cầu của thiết bị (`msg.value == depositAmount`). Tiền cọc được khóa an toàn trong hợp đồng.
2. **Độc quyền sử dụng:** Thiết bị chỉ được mượn khi đang ở trạng thái `State.Created`. Khi đang có người mượn, không ai khác có thể can thiệp.
3. **Tự động tính tiền phạt theo ngày trễ:** Hợp đồng tính tiền phạt trễ hạn theo công thức:
   $$\text{Tiền phạt} = \text{Số ngày trễ} \times \text{Mức phạt mỗi ngày}$$
   Tiền phạt tối đa không vượt quá tiền cọc (`actualPenalty <= depositAmount`).
4. **Bảo mật Checks-Effects-Interactions (CEI):** Trạng thái thiết bị được cập nhật trước khi chuyển tiền hoàn cọc bằng `call{value: ...}("")` để ngăn chặn triệt để tấn công Reentrancy.

---

## 3. Phân công trách nhiệm thành viên

| Họ và tên | Mã sinh viên | GitHub Username | Vai trò chính Lab 8–11 | Vai trò chính Lab 12–15 |
| :--- | :--- | :--- | :--- | :--- |
| **Phan Thị Huyền Trang** | `23k4300040` | [@huyentrang005](https://github.com/huyentrang005) | Hợp đồng thông minh & Đặc tả | Kiểm thử ca tấn công & Báo cáo |
| **Trần Thị Thi Thơ** | `23K4300018` | [@thot23547-cpu](https://github.com/thot23547-cpu) | Giao diện Web3 DApp | Hợp đồng & Audit bảo mật |

---

## 4. Cấu trúc thư mục dự án

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
│   ├── SPEC.md                   # Đặc tả kỹ thuật và phân tích nghiệp vụ v0.1
│   ├── ECONOMIC_RULES.md         # Quy tắc kinh tế và 5 phản biện rủi ro
│   ├── PROJECT_PLAN.md           # Kế hoạch phát triển dự án nhóm
│   ├── AI_JOURNAL.md             # Nhật ký làm việc với AI từ Lab 8 đến Lab 15
│   ├── GATE_REVIEW_1.md          # Biên bản Gate Review 1 (Duyệt phạm vi Lab 12)
│   ├── AUDIT_REPORT.md           # Báo cáo rà soát chéo hợp đồng (Lab 14)
│   └── PRESENTATION_PLAN.md      # Kịch bản thuyết trình và demo 5 phút (Lab 15)
├── evidence/                     # Minh chứng ảnh và báo cáo từng Lab (Lab 8 - Lab 15)
│   ├── lab-08/ ... lab-15/
├── vercel.json                   # Cấu hình tự động triển khai tĩnh trên Vercel
├── push.bat                      # Kịch bản tự động đẩy code & tags lên GitHub
├── pull.bat                      # Kịch bản đồng bộ code mới nhất từ GitHub
└── README.md                     # Tài liệu giới thiệu dự án
```

---

## 5. Hướng dẫn Triển khai lên Vercel

Dự án đã có tệp cấu hình `vercel.json` trỏ sẵn thư mục `web/`:

```json
{
  "$schema": "https://openapi.vercel.sh/vercel.json",
  "outputDirectory": "web",
  "buildCommand": null
}
```

1. Đăng nhập vào **[Vercel](https://vercel.com/)** bằng tài khoản GitHub `huyentrang005`.
2. Bấm **Add New...** ➔ Chọn **Project**.
3. Chọn repository **`huyentrang005/thiet-bi-deposit-borrow`** ➔ Nhấn **Import**.
4. Giữ nguyên mọi cài đặt mặc định ➔ Bấm **Deploy**. Sau ~30 giây, website sẽ hoạt động tại tên miền `*.vercel.app`.

---

## 6. Hướng dẫn chạy thử nghiệm DApp

1. Mở tệp `web/index.html` trực tiếp trên trình duyệt (hoặc qua đường dẫn Vercel) có cài đặt tiện ích ví **MetaMask**.
2. Chuyển MetaMask sang mạng **Sepolia Testnet**.
3. Bấm **Kết nối ví MetaMask**.
4. Nhập địa chỉ hợp đồng đã deploy và bấm **Tải dữ liệu**.
5. Tiến hành thử nghiệm mượn thiết bị và nghiệm thu hoàn cọc.
