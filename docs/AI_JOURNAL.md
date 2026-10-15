# NHẬT KÝ LÀM VIỆC VỚI AI — ĐẶT CỌC MƯỢN TRẢ THIẾT BỊ (SMARTRENT)

- **Đề tài:** Hệ Thống Ký Quỹ Đặt Cọc Mượn Trả Thiết Bị (Chủ đề 2)
- **Học phần:** ECO2432 — Tiền điện tử & Hợp đồng thông minh
- **Nhóm sinh viên:** Phan Thị Huyền Trang (`huyentrang005`) & Trần Thị Thi Thơ (`thot23547-cpu`)

---

## Lab 8: Khởi tạo Codebase nhóm, Kế hoạch và Quy tắc kinh tế v0.1

**Prompt 1:** "tạo repo nhóm cho chủ đề nhóm chúng tôi , chủ đề : đặt cọc mượn trả thiết bị. đồng thời chỉ tôi cách add người"

**So sánh & Đánh giá:**
- **Thực thi:** Khởi tạo cấu trúc dự án nhóm, viết Smart Contract `QuanLyThietBi.sol` tuân thủ nghiêm ngặt các quy ước `AGENTS.md` (Solidity 0.8.20, OpenZeppelin 5.x, CEI, custom error, basis point).
- **Kết quả:** Nắm vững quy trình tạo repository nhóm trên GitHub, các bước cấu hình Git đẩy mã nguồn và phân quyền mời các thành viên khác làm Collaborators.

**Prompt 2 (Phản biện kinh tế theo yêu cầu Lab 8):** "Bạn là người dùng thận trọng. Chỉ dựa trên SPEC và ECONOMIC_RULES dưới đây, hãy nêu 5 cách một người có thể lạm dụng quy tắc hoặc làm người khác bị thiệt. Với mỗi cách, chỉ rõ quy tắc nào chưa đủ chặt. Không viết mã."

**So sánh & Đánh giá:**
- **Thực thi:** AI đã phân tích và chỉ ra 5 góc độ rủi ro (Owner phạt cọc quá tay, sinh viên bùng đồ giá trị cao, kẹt cọc nếu Owner offline, DoS khi hoàn cọc, và spam mượn đồ dài hạn).
- **Kết quả:** Nhóm đã xây dựng các phương án đối phó cụ thể trong `docs/ECONOMIC_RULES.md` (như định giá cọc chuẩn, thời gian ân hạn time-lock, và mô hình Pull over Push) để chuẩn bị hiện thực hóa ở các Lab tiếp theo.

---

## Lab 9: Hợp Đồng Lõi Biên Dịch Được

**Prompt:** "Viết hợp đồng ProjectCore.sol bằng Solidity 0.8.20 theo đúng đặc tả docs/SPEC.md và AGENTS.md, kế thừa mẫu SimpleEscrow tính tiền phạt theo số ngày trễ."

**So sánh & Đánh giá:**
- **Thực thi:** AI sinh mã hợp đồng lõi với máy trạng thái (`State.Created`, `Borrowed`, `Completed`) và hàm `calculatePenalty()`.
- **Kết quả:** Biên dịch thành công trên Remix IDE, áp dụng kỹ thuật Checks-Effects-Interactions học từ `TimeLockVault.sol`.

---

## Lab 10: Rà Soát Mã Nguồn Do AI Sinh Ra (Audit ProjectCore.sol)

**Prompt đã dùng ở Bước 2 & 4:**  
"Bạn là kiểm toán viên hợp đồng thông minh. Rà soát hợp đồng ProjectCore.sol đối chiếu với SPEC.md dưới đây và liệt kê mọi lỗ hổng, xếp theo mức nghiêm trọng. Với mỗi lỗ hổng, nêu: dòng số mấy, khai thác thế nào, sửa ra sao."

### Bảng bắt buộc rà soát lỗ hổng (Theo chuẩn Trang 25 Sổ tay ECO2432):

| Lỗi | Mô tả | Ai phát hiện | Cách khắc phục |
| :--- | :--- | :---: | :--- |
| **1** | **Nguy cơ DoS khi hoàn cọc trực tiếp:** Trong hàm `returnDevice()`, nếu ví người mượn là một hợp đồng thông minh không có hàm `receive()` hoặc cố tình `revert`, lệnh `call` chuyển ETH thất bại làm toàn bộ giao dịch nghiệm thu của Owner bị treo, thiết bị không thể chuyển trạng thái sang `Completed`. | **AI** | Tách cơ chế rút cọc theo mô hình **Pull over Push**: lưu số dư `pendingRefund[borrower]` để người mượn tự gọi hàm rút hoặc không chặn luồng hoàn tất của Owner. |
| **2** | **Thiếu kiểm tra tham số đầu vào trong constructor:** Khi khởi tạo, chưa ràng buộc `_borrowDurationDays > 0` và `_penaltyPerDay <= _depositAmount`. Nếu Owner nhập nhầm `_penaltyPerDay` quá lớn, người mượn vừa trễ vài phút đã mất sạch cọc. | **AI** | Bổ sung kiểm tra `require(_borrowDurationDays > 0)` và `require(_penaltyPerDay <= _depositAmount)`. |
| **3** | **Biến `dueTime` không được reset khi khởi tạo lại:** Nếu sau khi trả thiết bị mà không xóa trắng `dueTime = 0` và `borrower = address(0)`, các hàm đọc dữ liệu `timeLeft()` có thể trả về thông tin rác gây hiểu lầm cho giao diện DApp. | **AI** | Thêm lệnh gán lại `dueTime = 0;` và `borrower = address(0);` sau khi hoàn tất chu trình mượn. |
| **4** | **Lỗi trạng thái một chiều (Không thể tái sử dụng thiết bị):** *(Lỗi nghiệp vụ được cộng điểm)* Sau khi kết thúc lượt mượn (`state = State.Completed`), hợp đồng bị "chết" trạng thái và không có hàm nào để cho người khác mượn tiếp chiếc máy ảnh đó ở các lần sau. Mỗi chiếc máy ảnh trong CLB phải mượn được nhiều lần. | **Sinh viên (Trang & Thơ)** | Thêm hàm `resetDevice()` cho phép Owner đưa trạng thái về `State.Created` sau khi kiểm tra xong để sẵn sàng cho sinh viên tiếp theo mượn thiết bị mà không cần deploy lại hợp đồng mới. |

---

## Lab 11: Cài Đặt Quy Tắc Kinh Tế & Kiểm Thử
- **Prompt:** "Cài đặt hàm tính tiền phạt theo số ngày trễ hạn `calculatePenalty()` và ca kiểm thử trên test/ProjectCoreTest.sol."
- **Đánh giá:** ✅ Dùng được.
- **Kết quả:** Kiểm thử thành công 2 kịch bản:
  - Ca 1 (Hợp lệ): Trả trước hoặc đúng hạn ➔ Phạt = 0, hoàn trả 100% cọc.
  - Ca 2 (Vi phạm/Trễ hạn): Trễ hạn ➔ Tự động trừ tiền phạt tương ứng theo số ngày trễ, hoàn phần còn lại về đúng ví sinh viên.

---

## Lab 12: Đánh Giá Gate Review 1
- **Kết luận:** Đạt điều kiện thông qua (Passed).
- **Phạm vi chốt:** Giữ luồng nghiệp vụ cốt lõi: Nạp cọc ➔ Quản lý mượn ➔ Trả thiết bị và tính phạt tự động.
- **Tệp báo cáo:** [docs/GATE_REVIEW_1.md](GATE_REVIEW_1.md).

---

## Lab 13: Thực Nghiệm Mất Tiền (Reentrancy) & Gia Cố Hợp Đồng
- **Phân tích hiện trường `VulnerableBank.sol`:**
  - Kẻ tấn công gọi hàm `withdraw()` ➔ Ngân hàng chuyển ETH ra ngoài trước khi cập nhật số dư `balances[msg.sender] = 0` ➔ Hàm `receive()` của kẻ tấn công kích hoạt gọi lại `withdraw()` liên tục cho đến khi rút cạn ngân hàng.
- **Ba câu giải thích vì sao thứ tự dòng lệnh là thứ chặn được tấn công:**
  1. Khi cập nhật trạng thái số dư về 0 trước (`balances[msg.sender] = 0`), nếu kẻ tấn công gọi lại lần 2, điều kiện kiểm tra `require(bal > 0)` sẽ ngay lập tức phát hiện số dư bằng 0 và đảo ngược giao dịch.
  2. Việc cập nhật số sách trước khi chuyển tiền tuân thủ triệt để nguyên tắc **Checks-Effects-Interactions (CEI)**.
  3. Thứ chặn đứng cuộc tấn công là thứ tự thực thi logic của các dòng mã nguồn, không phụ thuộc hoàn toàn vào bất kỳ từ khóa hỗ trợ nào.

---

## Lab 14: Xử Lý Kết Quả Audit Chéo
- Thực hiện rà soát hợp đồng nhóm bạn theo 10 tiêu chí bắt buộc (Phân quyền, CEI, điều kiện thời gian, phép chia, cách chuyển ETH, v.v.).
- Chi tiết ghi nhận tại [docs/AUDIT_REPORT.md](AUDIT_REPORT.md). Hợp đồng `ProjectCore.sol` của nhóm đạt chuẩn an toàn, không có lỗ hổng nghiêm trọng.

---

## Lab 15: Hoàn Thiện Giao Diện Web DApp & Đưa Lên Mạng
- Nối giao diện `web/index.html` với hợp đồng qua thư viện Ethers.js v5.
- Triển khai giao diện tĩnh trực tiếp lên mạng công khai thông qua **Vercel**: `https://thiet-bi-deposit-borrow.vercel.app`.
- Lập kịch bản phân công thuyết trình 5 phút tại [docs/PRESENTATION_PLAN.md](PRESENTATION_PLAN.md).
