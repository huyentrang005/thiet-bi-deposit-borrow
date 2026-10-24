# BÁO CÁO LAB 14 — RÀ SOÁT CHÉO HỢP ĐỒNG THÔNG MINH (CROSS-AUDIT REPORT)

**Tên dự án:** Hệ thống Quản lý Đặt cọc & Mượn trả Thiết bị CLB (SmartRent)  
**Mã lớp / Học phần:** ECO2432 — Tiền điện tử & Công nghệ Blockchain  
**Tệp báo cáo chi tiết:** [docs/AUDIT_REPORT.md](../../docs/AUDIT_REPORT.md)

**Nhóm thực hiện audit:**
- Phan Thị Huyền Trang (MSSV: 23K4020050 - `@huyentrang005`)
- Trần Thị Thi Thơ (MSSV: 23K4300018 - `@thot23547-cpu`)

---

## 1. Kết quả kiểm tra theo 10 hạng mục bắt buộc (Sổ tay ECO2432 trang 32–33)

| # | Hạng mục kiểm tra | Tiêu chí rà soát | Đánh giá | Chi tiết kiểm chứng trên hợp đồng nhóm |
| :---: | :--- | :--- | :---: | :--- |
| **1** | **Phân quyền (Access)** | Hàm nhạy cảm có kiểm tra quyền gọi không? | ✅ Đạt | Các hàm quản trị `themThietBi`, `traVaHoanCoc`, `resetDevice` đều dùng modifier `onlyOwner`. |
| **2** | **Thứ tự thao tác (CEI)** | Có hàm nào chuyển tiền ra ngoài trước khi cập nhật state? | ✅ Đạt | Cập nhật `state = State.Completed` trước khi chuyển ETH bằng `.call{value: ...}("")`. |
| **3** | **Điều kiện thời gian** | Kiểm tra mốc thời gian có đúng logic không? | ✅ Đạt | So sánh `block.timestamp <= dueTime`, nếu quá hạn thì tính ngày trễ chính xác. |
| **4** | **Phép chia làm tròn** | Có phép chia nào làm tròn xuống 0 đối với số nhỏ không? | ⚠️ Đã sửa | Sử dụng công thức làm tròn lên: `(overdueSeconds + 1 days - 1) / 1 days` và nhân trước chia sau `(total * bps) / 10000`. |
| **5** | **Cách chuyển ETH** | Dùng `call` hay `transfer`? Có kiểm tra return boolean? | ✅ Đạt | Dùng `payable(borrower).call{value: refund}("")` kèm `require(ok, "Transfer failed")`. |
| **6** | **Dữ liệu riêng tư** | Có thông tin mật nào lưu on-chain không? | ✅ Đạt | Chỉ lưu trạng thái thiết bị và lượng tiền cọc, không lưu dữ liệu bí mật cá nhân. |
| **7** | **Vòng lặp & Giới hạn Gas** | Có vòng lặp nào duyệt mảng động dài vô hạn không? | ✅ Đạt | Truy xuất thiết bị trực tiếp qua mapping theo ID (`devices[_id]`), không lặp unbounded. |
| **8** | **Sự kiện (Event)** | Các thay đổi trạng thái có phát event không? | ✅ Đạt | Phát đầy đủ các event có indexed: `Borrowed`, `Returned`, `DeviceReset`, `ThietBiMoi`. |
| **9** | **Trường hợp số 0** | Nạp 0 đồng, cọc 0 đồng, ID = 0 xử lý ra sao? | ✅ Đạt | Kiểm tra `_depositAmount > 0` và `_id > 0`, revert an toàn khi gặp giá trị 0 không hợp lệ. |
| **10**| **Địa chỉ rỗng** | Gán `address(0)` có an toàn và có kiểm tra không? | ✅ Đạt | Đặt `borrower = address(0)` an toàn khi hoàn tất lượt mượn để reset trạng thái. |

---

## 2. Bảng phát hiện và đề xuất khắc phục qua rà soát chéo

| STT | Vị trí kiểm tra | Mức độ | Mô tả vấn đề phát hiện | Biện pháp đã khắc phục |
| :---: | :--- | :---: | :--- | :--- |
| **1** | `traVaHoanCoc()` | 🟡 Trung bình | Tham số `haoMonBps` nếu truyền > 10,000 sẽ khấu trừ vượt quá 100% tiền cọc. | Thêm kiểm tra `if (_haoMonBps > 10_000) revert KhauTruKhongHopLe(_haoMonBps);` ngay đầu hàm. |
| **2** | `tinhTienPhat()` | 🟢 Thấp | Phép chia nguyên `soGiayTre / 1 days` làm tròn xuống 0 ngày nếu trễ dưới 24h. | Chuyển sang công thức trễ tính lũy tiến làm tròn lên: `(soGiayTre + 1 days - 1) / 1 days`. |
| **3** | `dueTime` reset | 🟢 Thấp | Hạn chót `dueTime` cũ không được xóa sau khi trả, có thể gây nhầm lẫn trên UI. | Bổ sung hàm `resetDevice()` đặt lại `dueTime = 0` và `borrower = address(0)` hoàn toàn. |

---

## 3. Tổng kết
Hợp đồng lõi của nhóm đạt điểm số tuyệt đối ở tất cả 10 tiêu chí rà soát kỹ thuật của học phần ECO2432, sẵn sàng chuyển giao và triển khai thực tế.
