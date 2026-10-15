# 🎤 KỊCH BẢN TRÌNH BÀY ĐỒ ÁN NHÓM (5 PHÚT) — CHỦ ĐỀ 2: ĐẶT CỌC MƯỢN THIẾT BỊ

Tài liệu này chuẩn bị theo khung chuẩn Mục C.4 của Sổ tay thực hành ECO2432 để bảo vệ Gate Review và Vấn đáp cuối kỳ.

- **Đề tài:** Hệ Thống Ký Quỹ Đặt Cọc Mượn Trả Thiết Bị (SmartRent - Chủ đề 2)
- **Học phần:** ECO2432 — Tiền điện tử & Hợp đồng thông minh
- **DApp Live (Vercel):** `https://thiet-bi-deposit-borrow.vercel.app`
- **Mã nguồn GitHub:** `https://github.com/huyentrang005/thiet-bi-deposit-borrow`

---

## 1. Phân vai và Thời lượng trình bày (5 Phút Chuẩn)

| Thời gian | Nội dung trình bày | Người phụ trách | Artifact (Minh chứng) bắt buộc mở |
| :--- | :--- | :---: | :--- |
| **0:00 – 0:30** (30s) | **Bài toán & Người dùng:** Khó khăn của CLB trong việc quản lý tài sản (máy chiếu, máy ảnh); nguy cơ thất thoát và bất tiện khi giữ cọc tiền mặt. | **Phan Thị Huyền Trang** | Mở câu giới thiệu trong [README.md](../README.md) & Vercel live badge. |
| **0:30 – 1:15** (45s) | **Quy tắc kinh tế cốt lõi:** Cơ chế khóa cọc ETH trên hợp đồng, phạt trễ hạn theo số ngày và khấu trừ hư hại theo Basis Points. | **Trần Thị Thi Thơ** | Mở [docs/SPEC.md](SPEC.md) & [docs/ECONOMIC_RULES.md](ECONOMIC_RULES.md). |
| **1:15 – 2:45** (90s) | **Demo trực tiếp luồng cốt lõi:** Kết nối ví MetaMask Sepolia trên DApp Vercel ➔ Đặt cọc ETH mượn thiết bị ➔ Nghiệm thu và hoàn cọc tức thì về ví. | **Phan Thị Huyền Trang** | Trình duyệt mở DApp Vercel thực tế, thao tác và xem TxHash thật trên Sepolia Etherscan. |
| **2:45 – 3:30** (45s) | **Demo ca vi phạm bị chặn:** Thử gửi thiếu tiền cọc hoặc rút cọc trái phép ➔ Hợp đồng revert với Custom Error chính xác. | **Trần Thị Thi Thơ** | Mở file [test/ProjectCoreTest.sol](../test/ProjectCoreTest.sol) & log lỗi trong `evidence/lab-11/`. |
| **3:30 – 4:15** (45s) | **Audit & An toàn bảo mật:** Thực nghiệm lỗ hổng Reentrancy & Slot bộ nhớ private; giải thích thứ tự Checks-Effects-Interactions bảo vệ tài sản. | **Phan Thị Huyền Trang** | Mở [docs/AUDIT_REPORT.md](AUDIT_REPORT.md) & `contracts/project/ProjectCore.sol`. |
| **4:15 – 5:00** (45s) | **Giới hạn, Bài học & Hướng mở rộng:** Kinh nghiệm làm việc với AI, tiềm năng phát triển sang Layer 2 (Arbitrum/Optimism). | **Trần Thị Thi Thơ** | Mở [docs/PRESENTATION_PLAN.md](PRESENTATION_PLAN.md) & [docs/AI_JOURNAL.md](AI_JOURNAL.md). |

---

## 2. Nguyên tắc trình bày
- Không dùng Slide PowerPoint. Trình chiếu trực tiếp các tệp mã nguồn, tài liệu Markdown và DApp đang chạy thật trên Sepolia Testnet.
- Mỗi thành viên đều phải nói và chỉ tay trực tiếp vào artifact do mình phụ trách.
- Sẵn sàng trả lời bộ câu hỏi 3 tầng khi giảng viên phỏng vấn cá nhân (Buổi 21).
