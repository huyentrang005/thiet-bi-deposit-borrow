# BÁO CÁO LAB 12 — GATE REVIEW 1 (ĐÁNH GIÁ CỘT MỐC DỰ ÁN)

**Tên dự án:** Hệ thống Quản lý Đặt cọc & Mượn trả Thiết bị CLB (SmartRent)
**Repo nhóm:** `quan-ly-thiet-bi-clb`
**Thành viên:**
- Phan Thị Huyền Trang (MSSV: 23K4020050 - `@huyentrang005`)
- Trần Thị Thi Thơ (`@thot23547-cpu`)

---

## 1. Tổng quan Dự án & Tiến độ Đạt được

| Hạng mục | Tệp tài liệu / Code | Trạng thái | Ghi chú |
| :--- | :--- | :--- | :--- |
| **Kế hoạch & Phân vai** | `docs/PROJECT_PLAN.md` | ✅ Hoàn thành | Đã phân chia 4 vai trò rõ ràng |
| **Đặc tả sản phẩm** | `docs/SPEC.md` | ✅ Hoàn thành | Đã chốt 4 quy tắc vận hành chính |
| **Quy tắc kinh tế** | `docs/ECONOMIC_RULES.md` | ✅ Hoàn thành | Đã xác định cơ chế xử lý cọc & phạt |
| **Smart Contract Lõi** | `contracts/project/QuanLyThietBi.sol` | ✅ Hoàn thành | Biên dịch thành công, không lỗi |
| **Nhật ký AI** | `AI_JOURNAL.md` | ✅ Hoàn thành | Lưu trữ đầy đủ prompt phản biện |

---

## 2. Kiểm tra Smart Contract Lõi (`QuanLyThietBi.sol`)

- **Chức năng chính đã cài đặt:**
  1. `taoThietBi()`: Ban quản lý thêm thiết bị mới kèm mức tiền cọc quy định.
  2. `muonThietBi()`: Sinh viên gửi tiền ETH đặt cọc và chuyển trạng thái thiết bị sang `DangMuon`.
  3. `traThietBi()`: BQL kiểm tra thiết bị nguyên vẹn, Smart Contract tự động trả lại 100% tiền cọc cho sinh viên.
  4. `xuLyPhat()`: BQL trích thu tiền cọc vào quỹ CLB nếu sinh viên làm hỏng hoặc quá hạn trả.

- **Kết quả Audit & Bảo mật (Lab 10):**
  - Đã áp dụng pattern **Checks-Effects-Interactions** chống tấn công Reentrancy.
  - Sử dụng modifier `onlyOwner` kiểm soát quyền hạn Admin nghiêm ngặt.

---

## 3. Bảng phân công công việc & Đóng góp của thành viên

| Thành viên | Vai trò Lab 8–11 | Đóng góp chính | Tỷ lệ đóng góp |
| :--- | :--- | :--- | :--- |
| **Phan Thị Huyền Trang** | Lập trình Smart Contract | Viết hợp đồng `QuanLyThietBi.sol`, thiết lập môi trường Remix / Hardhat | 50% |
| **Trần Thị Thi Thơ** | Đặc tả & Kinh tế | Soạn thảo `SPEC.md`, `ECONOMIC_RULES.md` và kiểm thử chức năng | 50% |

---

## 4. Kế hoạch tiếp theo (Lab 13 – Lab 15)

- **Lab 13:** Viết kịch bản kiểm thử (Test scripts) giả lập các ca tấn công gian lận cọc.
- **Lab 14:** Đổi repo với nhóm khác để Audit chéo tìm lỗi còn sót lại.
- **Lab 15:** Hoàn thiện giao diện DApp Web3 (`web/index.html`) và xuất bản URL công khai.