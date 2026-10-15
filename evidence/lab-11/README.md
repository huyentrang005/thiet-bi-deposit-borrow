# Minh Chứng Thực Hành Lab 11 — Quy Tắc Kinh Tế & Kiểm Thử Hợp Đồng

## 1. Kiểm Thử Ca Hợp Lệ (Trả Đúng Hạn)
- **Tình huống:** Sinh viên nạp cọc 0.05 ETH mượn máy chiếu trong 3 ngày.
- **Thời điểm trả:** Trước thời hạn `hanChotTra`.
- **Kết quả:** Tiền phạt = 0 ETH. Hoàn cọc 100% (0.05 ETH) về ví sinh viên. Hợp đồng phát sự kiện `ThietBiDaTra` thành công.

## 2. Kiểm Thử Ca Vi Phạm (Trả Trễ Hạn & Hao Mòn)
- **Tình huống:** Sinh viên trả thiết bị trễ 2 ngày và có trầy xước nhẹ (khấu trừ 500 bps = 5%).
- **Công thức tính toán:**
  - Tiền phạt trễ: `2 ngày * 0.005 ETH = 0.01 ETH`.
  - Khấu trừ hao mòn: `(0.05 - 0.01) * 500 / 10000 = 0.002 ETH`.
  - Tổng trừ: `0.012 ETH` (chuyển về ví CLB/Owner).
  - Tiền hoàn lại cho sinh viên: `0.05 - 0.012 = 0.038 ETH`.
- **Kết quả:** Giao dịch xử lý chính xác, số dư ví sinh viên tăng 0.038 ETH và ví Owner tăng 0.012 ETH.

## 3. Kiểm Thử Ca Gian Lận Bị Chặn
- Gửi cọc thiếu: Gọi `muonThietBi(1)` với 0.02 ETH ➔ Bị revert với lỗi `KhongDungTienCoc(20000000000000000, 50000000000000000)`.
