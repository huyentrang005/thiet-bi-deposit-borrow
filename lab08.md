# BÁO CÁO THIẾT LẬP REPOSITORY NHÓM VÀ PHÂN QUYỀN CỘNG TÁC (LAB 8)

## 1. Thông tin Kho lưu trữ Nhóm (Repository Info)

- **Tên Đề tài Nhóm:** Hệ thống Quản Lý Đặt Cọc Mượn Trả Thiết Bị
- **Đường dẫn Repository GitHub:** `https://github.com/huyentrang005/thiet-bi-deposit-borrow`
- **Trưởng nhóm (Người tạo Repo):** `huyentrang005`
- **Mạng Blockchain thử nghiệm:** Sepolia Testnet

## 2. Danh sách Thành viên & Phân quyền (Collaborators)

| STT | Họ và tên | GitHub Username | Vai trò trong dự án | Trạng thái quyền |
| :--- | :--- | :--- | :--- | :--- |
| 1 | Phan Thị Huyền Trang | `huyentrang005` | Trưởng nhóm / Quản trị Repo / Smart Contract | Owner (Chủ sở hữu) |
| 2 | [Tên thành viên 2] | [username_thành_viên_2] | Thành viên / Front-end DApp & Kiểm thử | Collaborator (Cộng tác viên) |

## 3. Cấu trúc Tài nguyên Đã triển khai trên Repo

- `contracts/QuanLyThietBi.sol`: Hợp đồng thông minh Ký quỹ (Escrow) đặt cọc mượn trả thiết bị (Solidity 0.8.20, OpenZeppelin 5.x, CEI, custom error, basis point).
- `SPEC.md`: Tài liệu đặc tả kỹ thuật và phân tích nghiệp vụ 6 mục chuẩn mực của đề tài.
- `web/index.html`: Giao diện Web3 DApp kết nối MetaMask, nạp rút cọc và bảng điều khiển Quản trị viên.
- `AI_JOURNAL.md`: Nhật ký phối hợp và thẩm định mã nguồn với AI cho từng giai đoạn của đồ án.

## 4. Quy trình Cộng tác Nhóm (Git Workflow)

1. **Khởi tạo & Đồng bộ:** Trưởng nhóm khởi tạo repository gốc, đẩy mã nguồn ban đầu lên nhánh `main`, sau đó gửi lời mời thành viên thông qua tính năng *Collaborators* trên GitHub.
2. **Phân chia nhiệm vụ:** Mỗi thành viên phụ trách một module độc lập (Smart Contract / Web3 Front-end / Tài liệu & Test case) để hạn chế xung đột mã nguồn (Merge Conflict).
3. **Quy tắc làm việc với Git:**
   - Luôn chạy `git pull origin main` trước khi bắt đầu phiên làm việc mới để cập nhật code mới nhất từ đồng đội.
   - Sau khi hoàn thành một tính năng, thực hiện `git add .`, `git commit -m "feat: ..."` và `git push origin main` (hoặc tạo Pull Request) để đồng bộ hóa mã nguồn lên GitHub.
