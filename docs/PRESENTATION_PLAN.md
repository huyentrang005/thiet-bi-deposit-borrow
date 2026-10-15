# 🎤 KỊCH BẢN THUYẾT TRÌNH VÀ DEMO DỰ ÁN 5 PHÚT (LAB 15)

- **Đề tài:** Hệ Thống Quản Lý Đặt Cọc Mượn Trả Thiết Bị (Chủ đề 2)
- **Học phần:** ECO2432 — Tiền điện tử & Hợp đồng thông minh
- **DApp Live:** `https://thiet-bi-deposit-borrow.vercel.app`
- **Mã nguồn GitHub:** `https://github.com/huyentrang005/thiet-bi-deposit-borrow`

---

## 1. Phân Công Thành Viên & Thời Lượng (5 Phút Chuẩn)

| Thời gian | Nội dung trình bày | Người nói | Artifact / Bằng chứng phải mở |
| :---: | :--- | :---: | :--- |
| **0:00 – 0:30** (30s) | **Người dùng & Vấn đề:** Khó khăn của CLB trong việc quản lý tài sản (máy chiếu, máy ảnh); nguy cơ thất thoát và bất tiện khi giữ cọc tiền mặt. | Phan Thị Huyền Trang (Trưởng nhóm) | Mở [README.md](file:///c:/Users/LAPTOP/Documents/TIEN%20DIEN%20TU/thiet-bi-deposit-borrow/README.md) & Vercel live badge. |
| **0:30 – 1:15** (45s) | **Quy tắc kinh tế & Escrow:** Cơ chế khóa cọc ETH trên hợp đồng, tự động tính tiền phạt theo ngày trễ và khấu trừ hao mòn theo Basis Points. | Thành viên 2 | Mở [docs/SPEC.md](file:///c:/Users/LAPTOP/Documents/TIEN%20DIEN%20TU/thiet-bi-deposit-borrow/docs/SPEC.md) & [docs/ECONOMIC_RULES.md](file:///c:/Users/LAPTOP/Documents/TIEN%20DIEN%20TU/thiet-bi-deposit-borrow/docs/ECONOMIC_RULES.md). |
| **1:15 – 2:45** (90s) | **Demo trực tiếp luồng cốt lõi:** Kết nối ví MetaMask Sepolia trên DApp Vercel ➔ Đặt cọc 0.05 ETH mượn thiết bị ➔ Nghiệm thu và hoàn cọc tức thì về ví. | Phan Thị Huyền Trang | Trình duyệt mở DApp Vercel thực tế, thao tác và xem TxHash trên Sepolia Etherscan. |
| **2:45 – 3:30** (45s) | **Demo ca vi phạm bị chặn:** Thử gửi thiếu tiền cọc hoặc rút cọc trái phép ➔ Hợp đồng revert với Custom Error chính xác. | Thành viên 2 | Mở file [test/ProjectCoreTest.sol](file:///c:/Users/LAPTOP/Documents/TIEN%20DIEN%20TU/thiet-bi-deposit-borrow/test/ProjectCoreTest.sol) & log lỗi trong `evidence/lab-11/`. |
| **3:30 – 4:15** (45s) | **Audit & Quyết định an toàn:** Thực nghiệm lỗ hổng Reentrancy & Slot bộ nhớ private; giải thích thứ tự Checks-Effects-Interactions bảo vệ tài sản. | Phan Thị Huyền Trang | Mở [docs/AUDIT_REPORT.md](file:///c:/Users/LAPTOP/Documents/TIEN%20DIEN%20TU/thiet-bi-deposit-borrow/docs/AUDIT_REPORT.md) & [docs/AI_JOURNAL.md](file:///c:/Users/LAPTOP/Documents/TIEN%20DIEN%20TU/thiet-bi-deposit-borrow/docs/AI_JOURNAL.md). |
| **4:15 – 5:00** (45s) | **Giới hạn & Bài học phát triển:** Nhận thức về phí gas on-chain, tiềm năng mở rộng sang Layer 2 (Arbitrum/Optimism) và kết thúc bài thuyết trình. | Cả nhóm | Mở [docs/PROJECT_PLAN.md](file:///c:/Users/LAPTOP/Documents/TIEN%20DIEN%20TU/thiet-bi-deposit-borrow/docs/PROJECT_PLAN.md). |

---

## 2. Kế Hoạch Trả Lời Vấn Đáp Cá Nhân (Buổi 21)

Nhóm đã sẵn sàng trả lời bộ câu hỏi 3 tầng theo quy định:
- **Tầng 1 (Hiểu mã):** Giải thích chức năng hàm `traVaHoanCoc`, chỉ rõ kiểm tra quyền `onlyOwner` và dòng cập nhật `tb.trangThai` trước khi gọi `call{value}`.
- **Tầng 2 (Quyết định thiết kế):** Vì sao dùng điểm cơ bản (basis point 1% = 100), vì sao từ chối `transfer()` dùng `call{value}`.
- **Tầng 3 (Phản biện):** Cách thức tấn công Reentrancy và cách cơ chế Checks-Effects-Interactions chặn đứng mọi nỗ lực rút cạn tiền cọc.
