# BÁO CÁO LAB 12 — GATE REVIEW 1: DUYỆT CODEBASE VÀ PHẠM VI (TUẦN 4)

**Nhóm thực hiện:**
- Phan Thị Huyền Trang (`@huyentrang005`)
- Trần Thị Thi Thơ (`@thot23547-cpu`)

**Đề tài nhóm:** Chủ đề 2 — Đặt cọc mượn thiết bị CLB (SmartRent)  
**Tệp quyết định chính:** [docs/GATE_REVIEW_1.md](../../docs/GATE_REVIEW_1.md)

---

## 1. Tự kiểm tra sức khỏe Repository (Bước 1)

- [x] **README.md:** Đã có câu định vị sản phẩm (Checkpoint 1), mô tả người dùng, bài toán giải quyết và hướng dẫn chạy thật.
- [x] **Bộ tài liệu docs:** `PROJECT_PLAN.md`, `SPEC.md`, `ECONOMIC_RULES.md`, `AI_JOURNAL.md` đồng bộ 100% với mã nguồn.
- [x] **Hợp đồng chính:** `contracts/project/ProjectCore.sol` biên dịch đạt chuẩn (dưới 150 dòng theo quy định Bộ lọc phạm vi).
- [x] **Ca kiểm thử:** Đã có ca thử nghiệm thành công (trả đúng hạn) và ca gian lận bị chặn (gửi thiếu tiền cọc).
- [x] **Lịch sử Git:** Có đầy đủ các commit từ Lab 8 đến Lab 12 của các thành viên.

---

## 2. Kịch bản Demo 3 phút trước Giảng viên (Bước 2)

| Thời gian | Nội dung trình bày | Người phụ trách | Minh chứng mở |
| :--- | :--- | :---: | :--- |
| **0:00 – 0:30** (30s) | Giới thiệu bài toán: Sinh viên mượn thiết bị CLB cần cơ chế ký quỹ (escrow) tự động, minh bạch, tránh thất thoát tài sản. | Phan Thị Huyền Trang | Câu giới thiệu trong `README.md` |
| **0:30 – 1:00** (30s) | Quy tắc kinh tế: Khóa cọc ETH, hoàn 100% nếu đúng hạn, tự động khấu trừ theo số ngày nếu trễ hạn. | Trần Thị Thi Thơ | `docs/ECONOMIC_RULES.md` |
| **1:00 – 2:00** (60s) | Mở `contracts/project/ProjectCore.sol`, chạy một luồng mượn & trả cọc thành công trên Remix VM. | Phan Thị Huyền Trang | Hợp đồng `ProjectCore.sol` |
| **2:00 – 2:30** (30s) | Chạy ca cố tình vi phạm: gửi thiếu cọc ➔ hiển thị lỗi `WrongDepositAmount()` bị chặn. | Trần Thị Thi Thơ | Log lỗi từ chối |
| **2:30 – 3:00** (30s) | Trình bày kế hoạch hoàn thiện tiếp theo: Kiểm thử Reentrancy (Lab 13), Audit chéo (Lab 14), Web DApp Vercel (Lab 15). | Cả nhóm | `docs/PROJECT_PLAN.md` |

---

## 3. Kết luận của Giảng viên & Thu hẹp phạm vi (Bước 3)

- **Kết luận:** ✅ **QUA (PASSED)**
- **Phạm vi chốt:** Giữ luồng nghiệp vụ cốt lõi: Nạp cọc ➔ Khóa cọc ➔ Trả thiết bị và tính phạt trễ hạn tự động. Không mở rộng thêm các tính năng ngoài phạm vi gây quá tải.
- **Ba việc hoàn thiện tiếp theo:**
  1. Thực nghiệm kiểm thử lỗ hổng Reentrancy và gia cố hợp đồng (Lab 13).
  2. Thực hiện rà soát chéo hợp đồng của nhóm bạn theo 10 tiêu chuẩn (Lab 14).
  3. Hoàn thiện giao diện DApp Web3 công khai qua Vercel (Lab 15).
