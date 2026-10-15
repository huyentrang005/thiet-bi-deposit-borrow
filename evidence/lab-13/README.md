# Minh Chứng Thực Hành Lab 13 — Thực Nghiệm Tấn Công Reentrancy & Gia Cố

## 1. Hiện Trường Tấn Công trên VulnerableBank.sol
- **Trạng thái ban đầu:** 3 ví người dùng nạp tổng cộng 6 ETH vào ngân hàng.
- **Tiến hành tấn công:** Ví thứ tư triển khai hợp đồng `Attacker`, nạp 1 ETH mồi và kích hoạt `attack()`.
- **Kết quả:** Ngân hàng bị rút sạch từ 7 ETH về 0 ETH trong cùng một giao dịch.

## 2. Bản Vá và Chứng Minh Tấn Công Thất Bại
Áp dụng mẫu **Checks-Effects-Interactions (CEI)**:
```solidity
// Cập nhật sổ sách trước
balances[msg.sender] = 0;
// Sau đó mới chuyển tiền
(bool ok, ) = msg.sender.call{value: bal}("");
require(ok, "Chuyen that bai");
```
Sau khi vá, kẻ tấn công kích hoạt lại hàm `attack()` ➔ Bị chặn ngay lập tức vì số dư đã bị đưa về 0 từ lần lặp đầu tiên.

## 3. Gia Cố Hợp Đồng ProjectCore.sol
Trong hàm `traVaHoanCoc`, thông tin `tb.trangThai`, `tb.nguoiMuon` và thời gian mượn đều được xóa về giá trị mặc định trước khi bất kỳ lệnh `call{value}` nào được kích hoạt.
