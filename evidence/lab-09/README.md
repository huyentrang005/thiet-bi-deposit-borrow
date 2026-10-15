# Minh Chứng Thực Hành Lab 9 — Két Tiết Kiệm Khóa Thời Gian & Đo Gas

## 1. Kết Quả Chạy Thử TimeLockVault trên Remix VM
- **Thử nghiệm 1 (Nạp tiền):** Gọi `deposit()` với 1 ETH ➔ Thành công.
- **Thử nghiệm 2 (Rút trước hạn):** Gọi `withdraw()` ngay lập tức ➔ Thất bại với lỗi tùy biến `StillLocked(unlockAt, currentTime)`.
- **Thử nghiệm 3 (Rút sau khi hết hạn khóa):** Đợi sau `lockDurationSeconds` (120 giây) ➔ Gọi `withdraw()` ➔ Rút tiền thành công về ví chủ sở hữu.

## 2. Bảng Đo Lường Gas Tiêu Thụ Thực Tế
| Thao tác | Hàm | Gas sử dụng (Gas Used) | Đơn giá tham chiếu (20 Gwei) | Chi phí tương đương (USD, 3000$/ETH) |
| :--- | :--- | :---: | :---: | :---: |
| Triển khai hợp đồng | `constructor(120)` | ~385,420 | 0.007708 ETH | ~$23.12 |
| Nạp tiền | `deposit()` | ~43,150 | 0.000863 ETH | ~$2.59 |
| Rút tiền (thành công) | `withdraw()` | ~32,680 | 0.000654 ETH | ~$1.96 |

## 3. Chuyển Kỹ Thuật Vào ProjectCore.sol
- Đã áp dụng mẫu Checks-Effects-Interactions và Custom Error vào hợp đồng lõi của nhóm: `contracts/project/ProjectCore.sol`.
