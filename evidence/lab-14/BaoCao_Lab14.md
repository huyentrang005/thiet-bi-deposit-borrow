# BÁO CÁO LAB 14 — RÀ SOÁT CHÉO GIỮA CÁC NHÓM (CROSS-AUDIT)

**Nhóm thực hiện audit:**
- Phan Thị Huyền Trang (`@huyentrang005`)
- Trần Thị Thi Thơ (`@thot23547-cpu`)

**Đề tài nhóm:** Chủ đề 2 — Đặt cọc mượn thiết bị CLB (SmartRent)  
**Tệp báo cáo chi tiết:** [docs/AUDIT_REPORT.md](../../docs/AUDIT_REPORT.md)

---

## 1. Kết quả kiểm tra theo 10 hạng mục bắt buộc (Danh mục Sổ tay trang 32–33)

| # | Hạng mục kiểm tra | Câu hỏi kiểm tra | Đánh giá | Ghi chú cụ thể |
| :---: | :--- | :--- | :---: | :--- |
| **1** | **Phân quyền** | Mọi hàm nhạy cảm có kiểm tra người gọi không? | ✅ Đạt | Các hàm quản trị `returnDevice()`, `resetDevice()` đều dùng modifier `onlyOwner`. |
| **2** | **Thứ tự thao tác** | Có hàm nào chuyển tiền ra ngoài trước khi cập nhật biến trạng thái không? | ✅ Đạt | Cập nhật `state = State.Completed` trước khi chuyển ETH (`call{value}`). |
| **3** | **Điều kiện thời gian** | Dấu so sánh có đúng chiều không? | ✅ Đạt | `block.timestamp <= dueTime` (trả đúng hạn thì phạt = 0). |
| **4** | **Phép chia** | Có phép chia nào làm tròn xuống thành 0 với số nhỏ không? | ⚠️ Đã sửa | Làm tròn lên khi tính ngày trễ: `(overdueSeconds + 1 days - 1) / 1 days`. |
| **5** | **Cách chuyển ETH** | Dùng `call` hay `transfer`? Có kiểm tra kết quả trả về không? | ✅ Đạt | Dùng `payable(borrower).call{value: refund}("")` kèm `require(ok)`. |
| **6** | **Dữ liệu riêng tư** | Có dữ liệu nào tưởng là bí mật nhưng thực ra đọc được không? | ✅ Đạt | Không lưu thông tin nhạy cảm hay mật khẩu on-chain. |
| **7** | **Vòng lặp** | Có vòng lặp nào chạy trên danh sách dài không giới hạn không? | ✅ Đạt | Không dùng vòng lặp unbounded trên mảng động, không sợ vượt block gas limit. |
| **8** | **Sự kiện** | Mọi thay đổi trạng thái có ghi lại sự kiện để tra cứu không? | ✅ Đạt | Đầy đủ sự kiện `Borrowed`, `Returned`, `DeviceReset`. |
| **9** | **Trường hợp số 0** | Nạp 0 đồng, rút khi số dư 0, danh sách rỗng — xử lý thế nào? | ✅ Đạt | Kiểm tra `_depositAmount > 0` ngay từ `constructor`. |
| **10**| **Địa chỉ rỗng** | Có kiểm tra tham số địa chỉ khác `address(0)` không? | ✅ Đạt | `borrower = address(0)` an toàn khi reset trạng thái. |

---

## 2. Các phát hiện và phản hồi sửa đổi trên hợp đồng của nhóm

- **Phát hiện nhận được từ nhóm bạn:** Biến `dueTime` ban đầu không được xóa khi hết chu trình mượn, có thể khiến giao diện DApp đọc nhầm thời gian của lượt mượn cũ.
- **Biện pháp khắc phục của nhóm:** Nhóm đã thêm hàm `resetDevice()` đặt lại `dueTime = 0` và `borrower = address(0)` để sẵn sàng cho sinh viên tiếp theo mượn thiết bị mà không cần deploy lại hợp đồng mới.
