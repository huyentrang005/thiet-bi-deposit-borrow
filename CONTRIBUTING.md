# Hướng Dẫn Đóng Góp (Contributing Guide)

Chào mừng bạn đến với dự án **SmartRent — Hệ thống Ký quỹ Đặt cọc Mượn trả Thiết bị CLB (ECO2432)**.

---

## 1. Quy chuẩn Đặt tên Nhánh & Cam kết (Git Workflow)

Nhóm áp dụng mô hình phân nhánh đơn giản và quy ước **Conventional Commits**:

- `feat:` Thêm tính năng mới (Smart contract, hàm xử lý, giao diện Web3).
- `fix:` Sửa lỗi logic, sửa lỗi hiển thị hoặc xử lý ngoại lệ.
- `docs:` Cập nhật tài liệu kỹ thuật, báo cáo lab hoặc hướng dẫn sử dụng.
- `test:` Bổ sung kịch bản kiểm thử (unit test, fuzzing, attack simulation).
- `refactor:` Tối ưu mã nguồn, giảm tiêu thụ Gas mà không đổi logic nghiệp vụ.
- `style:` Cải thiện giao diện CSS, format mã nguồn.
- `chore:` Cấu hình môi trường, script tự động, package dependencies.

---

## 2. Tiêu chuẩn Mã nguồn Hợp đồng Thông minh (Solidity)

1. **Phiên bản trình biên dịch:** Khóa cứng phiên bản `pragma solidity 0.8.20;`.
2. **Quy tắc CEI:** Luôn tuân thủ Checks ➔ Effects ➔ Interactions.
3. **Phân quyền:** Sử dụng modifier `onlyOwner` cho các hàm thay đổi dữ liệu nhạy cảm.
4. **Custom Errors:** Sử dụng `error ErrorName()` thay cho `require(..., "string")` để tiết kiệm Gas triển khai và giao dịch.
5. **Độ dài hợp đồng:** Giữ mã nguồn hợp đồng chính dưới 150 dòng để thỏa mãn Bộ lọc phạm vi (Scope Filter).

---

## 3. Quy trình Kiểm thử trước khi Cam kết (Pre-commit Testing)

Trước khi commit và push code lên GitHub:
1. Mở Remix IDE hoặc chạy Hardhat kiểm tra biên dịch hợp đồng không có cảnh báo (`0 warnings, 0 errors`).
2. Chạy toàn bộ các ca thử nghiệm trong thư mục `test/`.
3. Kiểm tra giao diện `web/index.html` trên trình duyệt để đảm bảo tương tác ví MetaMask hoạt động bình thường.
