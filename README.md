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
| **Phan Thị Huyền Trang** (Trưởng nhóm) | [Điền MSSV] | `@huyentrang005` | Hợp đồng thông minh & Đặc tả | Kiểm thử ca tấn công & Báo cáo |
| **[Họ tên Thành viên 2]** | [Điền MSSV] | `@[username_thanh_vien_2]` | Giao diện Web3 DApp | Hợp đồng & Audit bảo mật |
| **[Họ tên Thành viên 3 (nếu có)]** | [Điền MSSV] | `@[username_thanh_vien_3]` | Kịch bản kiểm thử & Tài liệu | Giao diện hoàn thiện & Triển khai |

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
```

---

## 6. Hướng dẫn chạy thử nghiệm DApp

1. Mở tệp `web/index.html` trực tiếp trên trình duyệt có cài đặt tiện ích ví **MetaMask**.
2. Chuyển MetaMask sang mạng **Sepolia Testnet**.
3. Kết nối ví, nhập địa chỉ hợp đồng đã deploy và tiến hành thử nghiệm mượn / trả thiết bị.
