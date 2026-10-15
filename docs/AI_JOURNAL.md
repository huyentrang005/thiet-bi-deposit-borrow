# NHẬT KÝ LÀM VIỆC VỚI AI - ĐẶT CỌC MƯỢN TRẢ THIẾT BỊ (SMARTRENT)

## Lab 8: Khởi tạo Codebase nhóm, Kế hoạch và Quy tắc kinh tế v0.1

**Prompt 1:** "tạo repo nhóm cho chủ đề nhóm chúng tôi , chủ đề : đặt cọc mượn trả thiết bị. đồng thời chỉ tôi cách add người"

**So sánh & Đánh giá:**
- **Thực thi:** Khởi tạo cấu trúc dự án nhóm, viết Smart Contract `QuanLyThietBi.sol` tuân thủ nghiêm ngặt các quy ước `AGENTS.md` (Solidity 0.8.20, OpenZeppelin 5.x, CEI, custom error, basis point).
- **Kết quả:** Nắm vững quy trình tạo repository nhóm trên GitHub, các bước cấu hình Git đẩy mã nguồn và phân quyền mời các thành viên khác làm Collaborators.

**Prompt 2 (Phản biện kinh tế theo yêu cầu Lab 8):** "Bạn là người dùng thận trọng. Chỉ dựa trên SPEC và ECONOMIC_RULES dưới đây, hãy nêu 5 cách một người có thể lạm dụng quy tắc hoặc làm người khác bị thiệt. Với mỗi cách, chỉ rõ quy tắc nào chưa đủ chặt. Không viết mã."

**So sánh & Đánh giá:**
- **Thực thi:** AI đã phân tích và chỉ ra 5 góc độ rủi ro (Owner phạt cọc quá tay, sinh viên bùng đồ giá trị cao, kẹt cọc nếu Owner offline, DoS khi hoàn cọc, và spam mượn đồ dài hạn).
- **Kết quả:** Nhóm đã xây dựng các phương án đối phó cụ thể trong `docs/ECONOMIC_RULES.md` (như định giá cọc chuẩn, thời gian ân hạn time-lock, và mô hình Pull over Push) để chuẩn bị hiện thực hóa ở các Lab tiếp theo.

## Lab 10: Rà soát mã nguồn do AI sinh ra (Audit ProjectCore.sol)

**Prompt đã dùng ở Bước 2 & 4:**  
"Bạn là kiểm toán viên hợp đồng thông minh. Rà soát hợp đồng ProjectCore.sol đối chiếu với SPEC.md dưới đây và liệt kê mọi lỗ hổng, xếp theo mức nghiêm trọng. Với mỗi lỗ hổng, nêu: dòng số mấy, khai thác thế nào, sửa ra sao."

### Bảng bắt buộc rà soát lỗ hổng (Theo chuẩn Trang 25 Sổ tay ECO2432):

| Lỗi | Mô tả | Ai phát hiện | Cách khắc phục |
| :--- | :--- | :--- | :--- |
| **1** | **Nguy cơ DoS khi hoàn cọc trực tiếp:** Trong hàm `returnDevice()`, nếu ví người mượn là một hợp đồng thông minh không có hàm `receive()` hoặc cố tình `revert`, lệnh `call` chuyển ETH thất bại làm toàn bộ giao dịch nghiệm thu của Owner bị treo, thiết bị không thể chuyển trạng thái sang `Completed`. | **AI** | Tách cơ chế rút cọc theo mô hình **Pull over Push**: lưu số dư `pendingRefund[borrower]` để người mượn tự gọi hàm rút hoặc không chặn luồng hoàn tất của Owner. |
| **2** | **Thiếu kiểm tra tham số đầu vào trong constructor:** Khi khởi tạo, chưa ràng buộc `_borrowDurationDays > 0` và `_penaltyPerDay <= _depositAmount`. Nếu Owner nhập nhầm `_penaltyPerDay` quá lớn, người mượn vừa trễ vài phút đã mất sạch cọc. | **AI** | Bổ sung kiểm tra `require(_borrowDurationDays > 0)` và `require(_penaltyPerDay <= _depositAmount)`. |
| **3** | **Biến `dueTime` không được reset khi khởi tạo lại:** Nếu sau khi trả thiết bị mà không xóa trắng `dueTime = 0` và `borrower = address(0)`, các hàm đọc dữ liệu `timeLeft()` có thể trả về thông tin rác gây hiểu lầm cho giao diện DApp. | **AI** | Thêm lệnh gán lại `dueTime = 0;` và `borrower = address(0);` sau khi hoàn tất chu trình mượn. |
| **4** | **Lỗi trạng thái một chiều (Không thể tái sử dụng thiết bị):** *(Lỗi nghiệp vụ được cộng điểm)* Sau khi kết thúc lượt mượn (`state = State.Completed`), hợp đồng bị "chết" trạng thái và không có hàm nào để cho người khác mượn tiếp chiếc máy ảnh đó ở các lần sau. Mỗi chiếc máy ảnh trong CLB phải mượn được nhiều lần. | **Sinh viên (Trang & Thơ)** | Thêm hàm `resetDevice()` cho phép Owner đưa trạng thái về `State.Created` sau khi kiểm tra xong để sẵn sàng cho sinh viên tiếp theo mượn thiết bị mà không cần deploy lại hợp đồng mới. |

