# Chính Sách Bảo Mật (Security Policy)

Hệ thống **SmartRent** (Đồ án học phần ECO2432) đặt tiêu chuẩn an toàn tài sản ký quỹ của sinh viên và thiết bị CLB lên hàng đầu.

---

## 1. Các phiên bản được hỗ trợ

| Phiên bản Smart Contract | Trạng thái bảo mật | Mạng hỗ trợ |
| :--- | :---: | :--- |
| `contracts/project/ProjectCore.sol` | 🛡️ Được bảo vệ | Sepolia Testnet |
| `contracts/QuanLyThietBi.sol` | 🛡️ Được bảo vệ | Sepolia Testnet |
| `contracts/training/*` | ⚠️ Môi trường thử nghiệm lỗ hổng (Lab 10, Lab 13) | Không dùng cho production |

---

## 2. Tiêu chuẩn Bảo mật đã áp dụng

Hệ thống tuân thủ nghiêm ngặt các hướng dẫn bảo mật Solidity:
1. **Checks-Effects-Interactions (CEI):** Mọi trạng thái (`state`, `borrower`, `dueTime`) được cập nhật trước khi thực hiện chuyển ETH (`call{value: ...}("")`).
2. **Reentrancy Protection:** Sử dụng `ReentrancyGuard` của OpenZeppelin và cơ chế khóa logic chống tấn công rút tiền lặp.
3. **Phân quyền nghiêm ngặt (`onlyOwner`):** Chỉ ví quản trị viên CLB mới có quyền thêm thiết bị và quyết định mức khấu trừ bồi thường hao mòn.
4. **Kiểm tra biên an toàn:** Ngăn chặn các lỗi tràn số, chia làm tròn về 0 và giới hạn khấu trừ tối đa 10,000 bps (100%).

---

## 3. Quy trình Báo cáo Lỗ hổng (Vulnerability Reporting)

Nếu phát hiện bất kỳ vấn đề bảo mật nào trong mã nguồn hợp đồng thông minh hoặc giao diện DApp:
1. **Không mở Issue công khai** trên GitHub để tránh rủi ro khai thác.
2. Gửi email trực tiếp đến nhóm phát triển:
   - Phan Thị Huyền Trang: `trang@hueuni.edu.vn` / `phanthihuyentrangg55@gmail.com`
   - Trần Thị Thi Thơ: `thot23547@gmail.com`
3. Nhóm cam kết phản hồi trong vòng 24–48 giờ và phát hành bản vá kiểm thử trên Sepolia Testnet.
