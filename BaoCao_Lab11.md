# BÁO CÁO LAB 11 — CÀI QUY TẮC KINH TẾ VÀO SẢN PHẨM

**Nhóm thực hiện:**
- Phan Thị Huyền Trang (`@huyentrang005`)
- Trần Thị Thi Thơ (`@thot23547-cpu`)

**Đề tài nhóm:** Chủ đề 2 — Đặt cọc mượn thiết bị CLB (SmartRent)  
**Tệp hợp đồng triển khai:** [contracts/project/ProjectCore.sol](file:///c:/Users/LAPTOP/Documents/TIEN%20DIEN%20TU/thiet-bi-deposit-borrow/contracts/project/ProjectCore.sol)

---

## 1. Quy tắc kinh tế nhóm đã chọn và cài đặt (Theo yêu cầu Sổ tay trang 45)

> **"Chủ đề 2: Đặt cọc mượn thiết bị | Việc nhóm phải tự làm thêm: Tính tiền phạt theo số ngày trễ"**

Nhóm đã cài đặt quy tắc kinh tế vào hàm `returnDevice()` và `calculatePenalty()` trong hợp đồng `ProjectCore.sol`:

1. **Khóa cọc ban đầu (Escrow):** Người mượn gửi đúng số tiền cọc `depositAmount` (ví dụ: 0.05 ETH). Hợp đồng giữ tiền an toàn, không ai được rút trước hạn.
2. **Quy tắc thời hạn:** Thời hạn mượn kết thúc tại `dueTime = block.timestamp + borrowDuration`.
3. **Quy tắc tính phạt trễ hạn:**
   - Nếu trả trước hoặc đúng hạn (`block.timestamp <= dueTime`): Tiền phạt = `0`, hoàn lại **100% tiền cọc** cho người mượn.
   - Nếu trả trễ hạn (`block.timestamp > dueTime`): Tính số ngày trễ hạn `overdueDays = (overdueSeconds + 1 days - 1) / 1 days`.
   - $\text{Tiền phạt} = \text{Số ngày trễ} \times \text{Mức phạt mỗi ngày}$.
   - Tiền cọc hoàn trả còn lại = `depositAmount - penalty` (chuyển về cho người mượn).
   - Phần tiền phạt được tự động trích nộp vào quỹ CLB (`owner`).
   - Khống chế trần: Tiền phạt tối đa không vượt quá 100% tiền cọc đã đóng (`penalty <= depositAmount`).

---

## 2. Kết quả kiểm thử thực tế trên Remix VM (Bước 4)

### Ca 1 — Ca hợp lệ (Happy Path): Trả đúng hạn
- **Kịch bản:** Sinh viên gọi `borrow()` gửi 0.05 ETH. Quản trị viên gọi `returnDevice()` trong thời hạn mượn.
- **Kết quả:** Giao dịch thành công, phát sự kiện `Returned(borrower, 0.05 ETH, 0 ETH)`.
- **Dòng tiền thực tế:** Người mượn nhận lại đủ 0.05 ETH, Quỹ CLB nhận 0 ETH phạt.

### Ca 2 — Ca vi phạm bị chặn (Negative Test): Gửi thiếu tiền cọc
- **Kịch bản:** Tiền cọc quy định là 0.05 ETH, nhưng người mượn cố tình chỉ gửi `0.02 ETH`.
- **Kết quả:** Giao dịch bị Revert ngay lập tức với mã lỗi tùy biến: **`WrongDepositAmount()`**.
- **Ý nghĩa kinh tế:** Ngăn chặn việc sinh viên cố tình đặt cọc không đủ giá trị để chiếm đoạt tài sản của CLB.

### Ca 3 — Ca vi phạm bị chặn: Không phải Owner gọi nghiệm thu hoàn cọc
- **Kịch bản:** Người mượn hoặc bên thứ ba tự ý gọi `returnDevice()`.
- **Kết quả:** Giao dịch bị Revert ngay lập tức với mã lỗi: **`NotOwner()`**.
- **Ý nghĩa:** Chỉ ban chủ nhiệm CLB mới có thẩm quyền kiểm tra tài sản thực tế và xác nhận hoàn tiền cọc.
