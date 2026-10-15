# BÁO CÁO LAB 9 — HỢP ĐỒNG ĐẦU TIÊN: KÉT TIẾT KIỆM CÓ KHÓA THỜI GIAN

**Nhóm thực hiện:** 
- Phan Thị Huyền Trang (`@huyentrang005`)
- Trần Thị Thi Thơ (`@thot23547-cpu`)

**Đề tài nhóm:** Chủ đề 2 — Đặt cọc mượn thiết bị CLB (SmartRent)

---

## 1. Kết quả thử nghiệm TimeLockVault trên Remix VM

Môi trường thực thi: **Remix VM (Cancun / Shanghai)**  
Thời gian khóa: `lockDurationSeconds = 120` (2 phút)

### Bảng đo lượng Gas tiêu thụ thực tế (Gas Metrics):

| Thao tác thực thi | Tham số / Dữ liệu gửi | Trạng thái | Lượng Gas tiêu thụ (execution cost) |
| :--- | :--- | :--- | :--- |
| **1. Triển khai (Deploy)** | `lockDurationSeconds = 120` | Thành công | ~280.000 gas |
| **2. Nạp tiền (`deposit`)** | `value = 1 ETH` | Thành công | ~43.500 gas |
| **3. Rút tiền khi chưa hết hạn (`withdraw`)** | `value = 0` | Bị từ chối (`StillLocked`) | ~23.800 gas |
| **4. Rút tiền sau 2 phút (`withdraw`)** | `value = 0` | Thành công | ~32.400 gas |

---

## 2. Minh chứng thực nghiệm (Screenshots)

1. **Ảnh 1 — Rút tiền thất bại có chủ đích:** Giao dịch bị revert với mã lỗi `StillLocked(unlockAt, currentTime)` khi cố rút trước 2 phút.
2. **Ảnh 2 — Rút tiền thành công:** Sau khi hết thời gian khóa 120 giây, tiền được rút thành công 1 ETH về ví Owner kèm sự kiện `Withdrawn`.
3. **Ảnh 3 — Hợp đồng nhóm `ProjectCore.sol`:** Biên dịch thành công (tích xanh) trên Remix với trình biên dịch `0.8.20`.

*(Các ảnh chụp màn hình được lưu trong thư mục `evidence/lab-09/`)*

---

## 3. Chuyển giao kỹ thuật vào hợp đồng nhóm `ProjectCore.sol`

Nhóm đã kế thừa 4 kỹ thuật cốt lõi từ `TimeLockVault.sol` vào [contracts/project/ProjectCore.sol](file:///c:/Users/HTPC/Downloads/hce-web3-starter/hce-web3-starter/contracts/project/ProjectCore.sol):

1. **Khóa thời gian (`dueTime`):** Xác định hạn chót mượn thiết bị bằng `block.timestamp + borrowDuration`.
2. **Nguyên tắc Checks - Effects - Interactions:** Trong hàm `returnDevice()`, trạng thái `state = State.Completed` được ghi nhận trước, sau đó mới gọi `call{value: ...}("")` chuyển tiền hoàn cọc và tiền phạt, chống triệt để lỗi Reentrancy.
3. **Custom Error:** Dùng `error WrongState()`, `error WrongDepositAmount()`, `error NotOwner()` thay cho chuỗi dài trong `require` để tiết kiệm gas.
4. **Tính tiền phạt trễ hạn tự động:** Hàm `calculatePenalty()` tự động đối chiếu thời gian trả với `dueTime` để trừ tiền cọc theo số ngày trễ hạn.
