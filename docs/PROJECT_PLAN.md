# PROJECT PLAN — Quản Lý Đặt Cọc Mượn Trả Thiết Bị (SmartRent)

## 1. Định vị sản phẩm (Checkpoint 1)

> **"Nhóm xây dựng Hệ thống ký quỹ đặt cọc mượn trả thiết bị (SmartRent) cho sinh viên và phòng thực hành/lab trường học để tự động hóa việc lưu ký và hoàn tiền cọc minh bạch, loại bỏ tranh chấp và tránh thất thoát thiết bị."**

---

## 2. Thành viên và vai trò

| Họ và tên | Mã sinh viên | Vai chính Lab 8–11 | Vai chính Lab 12–15 |
| :--- | :--- | :--- | :--- |
| **Phan Thị Huyền Trang** (Trưởng nhóm) | [Điền MSSV] | Hợp đồng thông minh & Đặc tả | Kiểm thử ca tấn công & Báo cáo |
| **[Họ tên Thành viên 2]** | [Điền MSSV] | Giao diện Web3 DApp | Hợp đồng & Audit bảo mật |
| **[Họ tên Thành viên 3 (nếu có)]** | [Điền MSSV] | Kịch bản kiểm thử & Tài liệu | Giao diện hoàn thiện & Triển khai |

*Ghi chú:* Bốn vai gồm Đặc tả, Hợp đồng, Giao diện, Kiểm thử. Nhóm xoay vai theo đúng quy định trước Lab 15.

---

## 3. Người dùng và vấn đề

- **Người dùng chính:** 
  - Sinh viên cần mượn thiết bị học tập/thực hành (máy tính, máy ảnh, bộ kit vi điều khiển, thiết bị đo lường).
  - Quản trị viên phòng thực hành / Thủ kho nhà trường.
- **Vấn đề cần giải quyết:** 
  - Thủ tục mượn truyền thống giữ CCCD/thẻ sinh viên hoặc tiền mặt dễ thất lạc, ghi chép sổ sách thủ công thiếu minh bạch.
  - Sinh viên lo ngại bị giữ tiền cọc quá lâu hoặc bị trừ phí không rõ lý do.
  - Ban quản lý khó giám sát lịch sử thiết bị và thực thi các chế tài xử phạt khi thiết bị bị hỏng hóc hoặc trả trễ.
- **Sản phẩm cuối nhìn thấy được:** 
  - Một ứng dụng DApp Web3 chạy trên mạng Sepolia Testnet kết nối trực tiếp với ví MetaMask.
  - Sinh viên xem danh sách thiết bị khả dụng, bấm mượn và đặt cọc bằng ETH.
  - Quản trị viên nghiệm thu thiết bị khi trả và hợp đồng tự động hoàn trả cọc về ví sinh viên qua cơ chế ký quỹ (Escrow).

---

## 4. Mốc bắt buộc

- **Lab 8:** Khởi tạo codebase nhóm, kế hoạch dự án, đặc tả v0.1 và quy tắc kinh tế.
- **Lab 9:** Hợp đồng thông minh lõi (`QuanLyThietBi.sol`) biên dịch và triển khai thử nghiệm được.
- **Lab 10:** Audit nội bộ và sửa lỗi có bằng chứng (kiểm tra phân quyền, CEI, chống Reentrancy).
- **Lab 11:** Quy tắc kinh tế chạy đúng (tính đúng tiền hoàn cọc, tỷ lệ khấu trừ Basis Point).
- **Lab 12:** Gate Review 1 (Bảo vệ tiến độ giữa kỳ).
- **Lab 13:** Kiểm thử các ca tấn công/gian lận (rút tiền trái phép, cọc thiếu, can thiệp trạng thái).
- **Lab 14:** Audit chéo với nhóm khác trong lớp.
- **Lab 15:** URL DApp công khai (Front-end Web3 tương tác hoàn chỉnh).
