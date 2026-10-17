# BÁO CÁO LAB 13 — KIỂM THỬ CA TẤN CÔNG VÀ GIAN LẬN BẢO MẬT

**Tên dự án:** Hệ thống Quản lý Đặt cọc & Mượn trả Thiết bị CLB (SmartRent)
**Thành viên thực hiện:**
- Phan Thị Huyền Trang (MSSV: 23K4020050 - `@huyentrang005`)
- Trần Thị Thi Thơ (`@thot23547-cpu`)

---

## 1. Danh sách các kịch bản tấn công / gian lận đã kiểm thử

### 💥 Ca 1: Tấn công Reentrancy (Rút tiền cọc lặp lại)
- **Mô tả kịch bản:** Kẻ tấn công tạo một Smart Contract độc hại để gọi hàm `traThietBi()` hoặc hàm rút cọc nhiều lần liên tiếp trước khi trạng thái được cập nhật.
- **Kết quả kiểm thử:** ❌ **Thất bại (Contract an toàn)**.
- **Cơ chế phòng thủ:** Đã áp dụng pattern **Checks-Effects-Interactions** và modifier `nonReentrant`.

### 💥 Ca 2: Giả mạo quyền Admin (Unauthorized Access)
- **Mô tả kịch bản:** Sinh viên bình thường cố tình gọi hàm `xuLyPhat()` hoặc `taoThietBi()` để can thiệp dữ liệu.
- **Kết quả kiểm thử:** ❌ **Thất bại (Contract chặn giao dịch)**.
- **Cơ chế phòng thủ:** Modifier `onlyOwner` bắt buộc chỉ duy nhất ví Admin mới thực thi được.

### 💥 Ca 3: Mượn đồ gửi thiếu tiền cọc (Insufficient Funds)
- **Mô tả kịch bản:** Người dùng gọi hàm `muonThietBi()` nhưng gửi lượng ETH ít hơn mức cọc quy định (`msg.value < tienCoc`).
- **Kết quả kiểm thử:** ❌ **Thất bại (Giao dịch bị Revert)**.
- **Cơ chế phòng thủ:** Lệnh `require(msg.value >= thietBi.tienCoc, "Khong du tien coc");` đã chặn thành công.

---

## 2. Kết luận
Smart Contract `QuanLyThietBi.sol` đã vượt qua tất cả các ca kiểm thử gian lận cơ bản, đảm bảo an toàn tiền cọc của sinh viên và quỹ CLB.