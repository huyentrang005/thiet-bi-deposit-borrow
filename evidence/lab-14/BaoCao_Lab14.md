# BÁO CÁO LAB 14 — AUDIT CHÉO NỘI BỘ (CROSS-AUDIT REPORT)

**Nhóm thực hiện audit:** Nhóm Đặt cọc Mượn trả Thiết bị CLB
**Thành viên:**
- Phan Thị Huyền Trang (MSSV: 23K4020050 - `@huyentrang005`)
- Trần Thị Thi Thơ (`@thot23547-cpu`)

**Tên nhóm được Audit:** [Điền tên nhóm bạn hoặc Repo được audit]
**Link Repo được Audit:** [Dán URL Repo của nhóm bạn]

---

## 1. Kết quả Đánh giá & Phát hiện Lỗi (Audit Findings)

| STT | Tệp tin / Hàm kiểm tra | Mức độ rủi ro | Mô tả lỗ hổng / Vấn đề | Đề xuất khắc phục |
| :--- | :--- | :--- | :--- | :--- |
| **1** | Smart Contract (`.sol`) | 🟡 Trung bình | Thiếu sự kiện (`event`) khi cập nhật trạng thái quan trọng. | Thêm `event` để giao diện Web3 dễ dàng lắng nghe dữ liệu. |
| **2** | Quản lý quyền (`Access`) | 🔴 Cao / 🟢 Thấp | Hàm kiểm tra quyền hạn Admin hoạt động tốt, không bị giả mạo. | Giữ nguyên modifier `onlyOwner`. |
| **3** | Tài liệu (`docs/`) | 🟢 Thấp | Cấu trúc file `SPEC.md` và `ECONOMIC_RULES.md` rõ ràng. | Bổ sung thêm ví dụ minh họa dòng tiền. |

---

## 2. Tổng kết & Đánh giá chung

- **Đánh giá chung:** Smart Contract của nhóm bạn đáp ứng tốt các tiêu chuẩn logic cơ bản, không mắc các lỗi bảo mật nghiêm trọng (như Reentrancy hay Overflow).
- **Điểm khuyến nghị:** Cần tối ưu thêm lượng Gas tiêu thụ cho các hàm khởi tạo.