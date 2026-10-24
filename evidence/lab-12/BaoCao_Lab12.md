# BÁO CÁO LAB 12 — GATE REVIEW 1 (ĐÁNH GIÁ CỘT MỐC DỰ ÁN & DUYỆT PHẠM VI)

**Tên dự án:** Hệ thống Quản lý Đặt cọc & Mượn trả Thiết bị CLB (SmartRent)  
**Mã lớp / Học phần:** ECO2432 — Tiền điện tử & Công nghệ Blockchain  
**Repo nhóm:** `https://github.com/huyentrang005/thiet-bi-deposit-borrow`  
**Tệp quyết định chính:** [docs/GATE_REVIEW_1.md](../../docs/GATE_REVIEW_1.md)

**Thành viên thực hiện:**
- Phan Thị Huyền Trang (MSSV: 23K4020050 - `@huyentrang005`)
- Trần Thị Thi Thơ (MSSV: 23K4300018 - `@thot23547-cpu`)

---

## 1. Tổng quan Dự án & Tiến độ Đạt được (Bước 1)

| Hạng mục | Tệp tài liệu / Code | Trạng thái | Ghi chú cụ thể |
| :--- | :--- | :---: | :--- |
| **Kế hoạch & Phân vai** | `docs/PROJECT_PLAN.md` | ✅ Hoàn thành | Phân chia 4 vai trò rõ ràng giữa 2 thành viên |
| **Đặc tả sản phẩm** | `docs/SPEC.md` | ✅ Hoàn thành | Chốt 4 quy tắc vận hành và máy trạng thái thiết bị |
| **Quy tắc kinh tế** | `docs/ECONOMIC_RULES.md` | ✅ Hoàn thành | Cơ chế xử lý ký quỹ, tính phạt trễ hạn & hao mòn |
| **Smart Contract Lõi** | `contracts/project/ProjectCore.sol` & `QuanLyThietBi.sol` | ✅ Hoàn thành | Đạt chuẩn Scope Filter (dưới 150 dòng), biên dịch 100% không lỗi |
| **Ca kiểm thử** | `test/ProjectCoreTest.sol` | ✅ Hoàn thành | Kiểm thử ca thành công và ca chặn gửi thiếu cọc |
| **Nhật ký AI** | `docs/AI_JOURNAL.md` | ✅ Hoàn thành | Lưu trữ đầy đủ prompt phản biện và bài học kinh nghiệm |

---

## 2. Kiểm tra Smart Contract Lõi & Tự đánh giá Repository

- [x] **README.md:** Đã có câu định vị sản phẩm (Checkpoint 1), mô tả đối tượng sử dụng, bài toán giải quyết và hướng dẫn chạy thật.
- [x] **Bộ tài liệu docs:** Đồng bộ 100% giữa tài liệu kiến trúc và mã nguồn Solidity.
- [x] **Chức năng chính đã cài đặt:**
  1. `taoThietBi()` / `themThietBi()`: Ban quản trị thêm thiết bị mới kèm mức tiền cọc ETH quy định.
  2. `muonThietBi()` / `borrow()`: Sinh viên gửi tiền ETH đặt cọc và chuyển trạng thái thiết bị sang `DangMuon`.
  3. `traThietBi()` / `returnDevice()`: BQL kiểm tra thiết bị nguyên vẹn, Smart Contract tự động trả lại tiền cọc cho sinh viên.
  4. `xuLyPhat()` / `traVaHoanCoc()`: Tự động khấu trừ tiền phạt trễ hạn theo ngày hoặc phí hao mòn vào quỹ CLB.
- [x] **Bảo mật & Audit (Lab 10):**
  - Đã áp dụng triệt để pattern **Checks-Effects-Interactions (CEI)** chống tấn công Reentrancy.
  - Sử dụng modifier `onlyOwner` kiểm soát quyền hạn quản trị nghiêm ngặt.

---

## 3. Bảng phân công công việc & Đóng góp thành viên (Lab 8 – 11)

| Thành viên | Vai trò Lab 8–11 | Đóng góp chính | Tỷ lệ đóng góp |
| :--- | :--- | :--- | :---: |
| **Phan Thị Huyền Trang** | Lập trình Smart Contract | Viết hợp đồng `QuanLyThietBi.sol` & `ProjectCore.sol`, thiết lập môi trường Remix / Hardhat | 50% |
| **Trần Thị Thi Thơ** | Đặc tả & Kinh tế & Frontend | Soạn thảo `SPEC.md`, `ECONOMIC_RULES.md`, xây dựng giao diện Web3 DApp và kiểm thử | 50% |

---

## 4. Kịch bản Demo 3 phút trước Giảng viên (Bước 2)

| Thời gian | Nội dung trình bày | Người phụ trách | Minh chứng mở |
| :--- | :--- | :---: | :--- |
| **0:00 – 0:30** (30s) | Giới thiệu bài toán: Sinh viên mượn thiết bị CLB cần cơ chế ký quỹ (escrow) tự động, minh bạch, tránh thất thoát tài sản. | Phan Thị Huyền Trang | Câu giới thiệu trong `README.md` |
| **0:30 – 1:00** (30s) | Quy tắc kinh tế: Khóa cọc ETH, hoàn 100% nếu đúng hạn, tự động khấu trừ theo số ngày nếu trễ hạn. | Trần Thị Thi Thơ | `docs/ECONOMIC_RULES.md` |
| **1:00 – 2:00** (60s) | Mở hợp đồng, chạy luồng mượn & trả cọc thành công trên Remix VM / Sepolia. | Phan Thị Huyền Trang | `ProjectCore.sol` & `QuanLyThietBi.sol` |
| **2:00 – 2:30** (30s) | Chạy ca cố tình vi phạm: gửi thiếu cọc ➔ hiển thị lỗi `WrongDepositAmount()` bị chặn. | Trần Thị Thi Thơ | Log lỗi từ chối giao dịch |
| **2:30 – 3:00** (30s) | Trình bày kế hoạch hoàn thiện tiếp theo: Kiểm thử Reentrancy (Lab 13), Audit chéo (Lab 14), Web DApp Vercel (Lab 15). | Cả nhóm | `docs/PROJECT_PLAN.md` |

---

## 5. Kết luận Gate Review & Kế hoạch tiếp theo (Lab 13 – 15)

- **Kết luận:** ✅ **ĐẠT (PASSED GATE REVIEW 1)**
- **Phạm vi chốt:** Giữ luồng nghiệp vụ cốt lõi: Nạp cọc ➔ Khóa cọc ➔ Trả thiết bị và tính phạt trễ hạn tự động. Không mở rộng thêm các tính năng ngoài phạm vi gây quá tải.
- **Kế hoạch hành động:**
  - **Lab 13:** Thực nghiệm kiểm thử lỗ hổng Reentrancy và gia cố hợp đồng với các ca tấn công gian lận.
  - **Lab 14:** Đổi repo với nhóm bạn để Audit chéo theo 10 tiêu chuẩn bắt buộc.
  - **Lab 15:** Hoàn thiện giao diện DApp Web3 (`web/index.html`), kết nối MetaMask và xuất bản URL công khai qua Vercel.
