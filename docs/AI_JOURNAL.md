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
