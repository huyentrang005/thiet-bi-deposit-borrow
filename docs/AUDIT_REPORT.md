# 🔍 BÁO CÁO RÀ SOÁT CHÉO HỢP ĐỒNG THÔNG MINH (LAB 14)

- **Nhóm thực hiện audit:** Nhóm 2 (Đề tài: Đặt cọc mượn trả thiết bị)
- **Đối tượng được audit:** Hợp đồng `ProjectCore.sol` & `docs/SPEC.md`
- **Tiêu chuẩn rà soát:** Danh mục 10 hạng mục bắt buộc theo Sổ tay ECO2432 (Trang 32–33)

---

## 1. Tóm Tắt Kết Quả

Đã tiến hành rà soát toàn diện hợp đồng thông minh:
- **Tổng số dòng mã:** 140 dòng.
- **Tổng số phát hiện:** 3 phát hiện (0 Nghiêm trọng, 1 Trung bình, 2 Nhẹ).

---

## 2. Bảng Đánh Giá 10 Hạng Mục Bắt Buộc

| # | Hạng mục kiểm tra | Đánh giá | Chi tiết nhận xét |
| :---: | :--- | :---: | :--- |
| **1** | **Phân quyền** | ✅ Đạt | Các hàm quản trị (`themThietBi`, `traVaHoanCoc`, `capNhatBaoTri`) đều dùng modifier `onlyOwner`. |
| **2** | **Thứ tự thao tác (CEI)** | ✅ Đạt | Cập nhật trạng thái `tb.trangThai` và `tb.nguoiMuon` trước khi thực hiện chuyển tiền ETH. |
| **3** | **Điều kiện thời gian** | ✅ Đạt | Kiểm tra `block.timestamp <= tb.hanChotTra` chính xác, tính phạt trễ hạn theo bước 1 ngày. |
| **4** | **Phép chia làm tròn** | ⚠️ Lưu ý | Phép tính `(tongCoc * bps) / 10_000` tuân thủ nhân trước chia sau, tránh làm tròn về 0. |
| **5** | **Cách chuyển ETH** | ✅ Đạt | Dùng `payable(to).call{value: amount}("")` kèm kiểm tra `success`, không dùng `transfer()`. |
| **6** | **Dữ liệu riêng tư** | ✅ Đạt | Không lưu trữ dữ liệu nhạy cảm hay mật khẩu trên biến trạng thái. |
| **7** | **Vòng lặp gas** | ✅ Đạt | Không dùng vòng lặp unbounded trên mảng động, tránh rủi ro vượt block gas limit. |
| **8** | **Sự kiện (Event)** | ✅ Đạt | Mọi hàm thay đổi trạng thái đều phát ra sự kiện có indexed để tra cứu on-chain. |
| **9** | **Trường hợp số 0** | ✅ Đạt | Kiểm tra `_id == 0`, không cho phép mượn thiết bị không tồn tại; xử lý an toàn khi cọc = 0. |
| **10**| **Địa chỉ rỗng** | ✅ Đạt | Gán `address(0)` an toàn khi hoàn tất chu trình mượn. |

---

## 3. Chi Tiết Phát Hiện & Khắc Phục

### Phát hiện 1 — Giới hạn khấu trừ hao mòn (Mức độ: Trung bình)
- **Vị trí:** Hàm `traVaHoanCoc(uint256 _id, uint256 _haoMonBps)`.
- **Mô tả:** Nếu người gọi truyền tham số `_haoMonBps > 10_000`, số tiền khấu trừ có thể lớn hơn số tiền cọc.
- **Khắc phục:** Thêm kiểm tra `if (_haoMonBps > 10_000) revert KhauTruKhongHopLe(_haoMonBps);` ngay đầu hàm. Nhóm đã khắc phục thành công.

### Phát hiện 2 — Lỗi làm tròn số ngày trễ (Mức độ: Nhẹ)
- **Vị trí:** Hàm `tinhTienPhat(uint256 _id, uint256 _thoiDiemTra)`.
- **Mô tả:** Phép chia nguyên `soGiayTre / 1 days` có thể làm tròn xuống 0 ngày nếu trễ vài giờ.
- **Khắc phục:** Áp dụng công thức làm tròn lên: `(soGiayTre + 1 days - 1) / 1 days` để đảm bảo tính răn đe đúng quy tắc kinh tế. Nhóm đã tích hợp.

---

## 4. Kết Luận
Hợp đồng đã qua rà soát đạt chuẩn bảo mật, tuân thủ nghiêm ngặt mô hình Checks-Effects-Interactions, sẵn sàng triển khai chính thức trên Sepolia Testnet.
