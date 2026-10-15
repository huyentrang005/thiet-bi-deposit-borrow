# BÁO CÁO LAB 11 — CÀI QUY TẮC KINH TẾ VÀO SẢN PHẨM

**Nhóm thực hiện:**
- Phan Thị Huyền Trang (`@huyentrang005`)
- Trần Thị Thi Thơ (`@thot23547-cpu`)

**Đề tài nhóm:** Chủ đề 2 — Đặt cọc mượn thiết bị CLB (SmartRent)

---

## 1. Quy tắc kinh tế nhóm đã chọn và cài đặt (Theo yêu cầu Sổ tay trang 45)

> **"Chủ đề 2: Đặt cọc mượn thiết bị | Việc nhóm phải tự làm thêm: Tính tiền phạt theo số ngày trễ"**

Nhóm đã cài đặt quy tắc kinh tế vào hàm `returnDevice()` và `calculatePenalty()` trong hợp đồng [contracts/project/ProjectCore.sol](file:///c:/Users/HTPC/Downloads/hce-web3-starter/hce-web3-starter/contracts/project/ProjectCore.sol):

1. **Khóa cọc ban đầu:** Người mượn gửi đúng số tiền cọc `depositAmount` (ví dụ: 1 ETH).
2. **Quy tắc thời hạn:** Thời hạn mượn kết thúc tại `dueTime = block.timestamp + borrowDuration`.
3. **Quy tắc tính phạt trễ hạn:**
   - Nếu trả trước hoặc đúng hạn (`block.timestamp <= dueTime`): Tiền phạt = `0`, hoàn lại **100% tiền cọc** cho người mượn.
   - Nếu trả trễ hạn (`block.timestamp > dueTime`): Tính số ngày trễ hạn `overdueDays = (overdueSeconds + 1 days - 1) / 1 days`.
   - Tiền phạt = `overdueDays * penaltyPerDay`.
   - Tiền cọc hoàn trả còn lại = `depositAmount - penalty` (chuyển về cho người mượn).
   - Phần tiền phạt được tự động trích nộp vào quỹ CLB (`owner`).

---

## 2. Kết quả kiểm thử thực tế trên Remix VM (Bước 4)

### Ca 1 — Ca hợp lệ (Happy Path): Trả đúng hạn
- **Kịch bản:** Sinh viên gọi `borrow()` gửi 1 ETH. Quản trị viên gọi `returnDevice()` trong thời hạn mượn.
- **Kết quả:** Giao dịch thành công, phát sự kiện `Returned(borrower, 1 ETH, 0 ETH)`.
- **Dòng tiền thực tế:** Người mượn nhận lại đủ 1 ETH, Quỹ CLB nhận 0 ETH phạt.
- *(Minh chứng lưu tại: `evidence/lab-11/ca_hop_le.png`)*

### Ca 2 — Ca vi phạm bị chặn (Negative Test): Gửi thiếu tiền cọc
- **Kịch bản:** Tiền cọc quy định là 1 ETH, nhưng người mượn cố tình chỉ gửi `0.5 ETH`.
- **Kết quả:** Giao dịch bị Revert ngay lập tức với mã lỗi tùy biến: **`WrongDepositAmount()`**.
- **Ý nghĩa kinh tế:** Ngăn chặn việc sinh viên cố tình đặt cọc không đủ giá trị để chiếm đoạt tài sản của CLB.
- *(Minh chứng lưu tại: `evidence/lab-11/ca_vi_pham.png`)*

---

## 3. Đối chiếu giữa Đặc tả (SPEC.md) và Mã nguồn (ProjectCore.sol)

Mã nguồn `ProjectCore.sol` đã khớp 100% với các quy tắc trong `docs/SPEC.md` và `docs/ECONOMIC_RULES.md`:
- Sử dụng Custom Error: `WrongDepositAmount()`, `WrongState()`, `NotOwner()`.
- Phát đầy đủ sự kiện `Borrowed` và `Returned`.
- Đảm bảo trật tự bảo mật Checks - Effects - Interactions.
