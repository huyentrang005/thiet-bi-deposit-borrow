# 📋 BIÊN BẢN GATE REVIEW 1: DUYỆT CODEBASE VÀ PHẠM VI (LAB 12)

- **Học phần:** Tiền điện tử & Hợp đồng thông minh (ECO2432)
- **Tên đề tài:** Hệ thống Quản Lý Đặt Cọc Mượn Trả Thiết Bị (Chủ đề 2)
- **Repository:** `https://github.com/huyentrang005/thiet-bi-deposit-borrow`
- **Trưởng nhóm:** Phan Thị Huyền Trang (`huyentrang005`)

---

## 1. Tự Kiểm Tra Sức Khỏe Repo (Health Checklist)

- [x] **README.md:** Đã mô tả rõ ràng bài toán, chân dung người dùng (CLB & Sinh viên) và hướng dẫn chạy thực tế.
- [x] **Tài liệu đặc tả:** `docs/PROJECT_PLAN.md`, `docs/SPEC.md`, `docs/ECONOMIC_RULES.md` khớp hoàn toàn với mã nguồn.
- [x] **Hợp đồng thông minh lõi:** `contracts/project/ProjectCore.sol` biên dịch thành công không lỗi (dưới 150 dòng theo quy định).
- [x] **Kiểm thử quy tắc kinh tế:** Có ca thử nghiệm hợp lệ (hoàn cọc 100%) và ca vi phạm bị chặn (gửi sai cọc, trả sai người).
- [x] **Lịch sử Git:** Có đóng góp và commit theo đúng cấu trúc từng Lab của các thành viên.

---

## 2. Kịch Bản Demo 3 Phút Tại Buổi Review

| Thời gian | Nội dung trình bày | Người phụ trách |
| :---: | :--- | :--- |
| **0:00 – 0:30** | Giới thiệu bài toán: Sinh viên mượn thiết bị CLB cần cơ chế ký quỹ (escrow) tự động, minh bạch, tránh thất thoát tài sản. | Trưởng nhóm |
| **0:30 – 1:00** | Trình bày quy tắc kinh tế: Khóa cọc ETH, hoàn 100% nếu đúng hạn, tự động khấu trừ theo ngày nếu trễ hạn hoặc hỏng hóc. | Thành viên 2 |
| **1:00 – 2:00** | Mở `contracts/project/ProjectCore.sol`, chạy luồng thành công: nạp 0.05 ETH cọc mượn máy chiếu ➔ nghiệm thu hoàn cọc. | Trưởng nhóm |
| **2:00 – 2:30** | Chạy ca cố tình vi phạm: gửi thiếu ETH hoặc rút cọc trái phép ➔ hiển thị custom error bị đảo ngược giao dịch. | Thành viên 2 |
| **2:30 – 3:00** | Kế hoạch hoàn thiện tiếp theo: Kiểm thử an toàn Reentrancy (Lab 13), Audit chéo (Lab 14), và hoàn thiện DApp Vercel (Lab 15). | Trưởng nhóm |

---

## 3. Kết Luận Của Giảng Viên

- **Kết luận đánh giá:** ✅ **QUA (PASSED)**
- **Phạm vi chốt:** Giữ luồng nghiệp vụ cốt lõi: Nạp cọc ➔ Quản lý mượn ➔ Trả thiết bị và tính phạt tự động. Không mở rộng thêm tính năng ngoài phạm vi gây quá tải.
- **Ba việc bắt buộc hoàn thiện cho Lab 13–15:**
  1. Hoàn thành kiểm thử an toàn tấn công Reentrancy trên hợp đồng và báo cáo phân tích.
  2. Thực hiện rà soát chéo hợp đồng của nhóm bạn theo 10 tiêu chí tại Lab 14.
  3. Kết nối hoàn chỉnh giao diện DApp Web3 công khai qua link Vercel và hoàn thành kịch bản thuyết trình cuối kỳ.
