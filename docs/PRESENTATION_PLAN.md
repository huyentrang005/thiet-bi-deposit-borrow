# KỊCH BẢN TRÌNH BÀY ĐỒ ÁN NHÓM (5 PHÚT) — CHỦ ĐỀ 2: ĐẶT CỌC MƯỢN THIẾT BỊ

Tài liệu này chuẩn bị theo khung chuẩn Mục C.4 của Sổ tay thực hành ECO2432 để bảo vệ Gate Review và Vấn đáp cuối kỳ.

---

## 1. Phân vai và Thời lượng trình bày

| Thời gian | Nội dung trình bày | Người phụ trách | Artifact (Minh chứng) bắt buộc mở |
| :--- | :--- | :--- | :--- |
| **0:00 – 0:30** (30s) | **Bài toán & Người dùng:** Ai gặp vấn đề gì, vì sao sổ sách truyền thống thất bại | Phan Thị Huyền Trang | Câu giới thiệu trong `README.md` |
| **0:30 – 1:15** (45s) | **Quy tắc kinh tế cốt lõi:** Cơ chế ký quỹ, điều kiện mượn, phạt trễ hạn theo ngày | Trần Thị Thi Thơ | `docs/SPEC.md`, `docs/ECONOMIC_RULES.md` |
| **1:15 – 2:45** (90s) | **Demo luồng cốt lõi:** Nhận thiết bị ➔ Nạp cọc ETH ➔ Trả đúng hạn nhận lại cọc | Phan Thị Huyền Trang | Giao diện Web3 DApp & Etherscan TxHash thật |
| **2:45 – 3:30** (45s) | **Demo ca vi phạm bị chặn:** Cọc thiếu, không phải Owner mà đòi hoàn tiền | Trần Thị Thi Thơ | Log lỗi từ chối trong `evidence/lab-11/` |
| **3:30 – 4:15** (45s) | **Audit & An toàn bảo mật:** Thứ tự Checks-Effects-Interactions chống Reentrancy | Phan Thị Huyền Trang | `docs/AUDIT_REPORT.md` & `contracts/project/ProjectCore.sol` |
| **4:15 – 5:00** (45s) | **Giới hạn, Bài học & Hướng mở rộng:** Kinh nghiệm làm việc với AI, kế hoạch L2 | Trần Thị Thi Thơ | `docs/PRESENTATION_PLAN.md` & `docs/AI_JOURNAL.md` |

---

## 2. Nguyên tắc trình bày
- Không dùng Slide PowerPoint. Trình chiếu trực tiếp các tệp mã nguồn, tài liệu Markdown và DApp đang chạy thật trên Sepolia Testnet.
- Mỗi thành viên đều phải nói và chỉ tay trực tiếp vào artifact do mình phụ trách.
