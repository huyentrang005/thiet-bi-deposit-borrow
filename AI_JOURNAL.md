# NHẬT KÝ LÀM VIỆC VỚI AI - [Tên bài]

## Lần 1

**Prompt:** dán nguyên văn.

**AI trả về:** tóm tắt.

**Đánh giá:** Dùng được / Phải sửa / Sai, bỏ.

**Chỗ sai:** mô tả cụ thể, kèm dòng mã hoặc dữ liệu đối chiếu.

**Cách sửa:** sinh viên đã làm gì.

**Ai phát hiện:** AI tự nhận / Sinh viên phát hiện.
## Lab 4: Nhận diện hợp đồng có rủi ro

**Prompt đã dùng:** "Bạn là chuyên viên thẩm định rủi ro tài sản số. Dưới đây là mã nguồn một hợp đồng token..."

**So sánh kết quả:**
- **Đọc thủ công tìm được:** Phát hiện được hàm `mint` ở dòng 24 và hàm `blacklist` ở dòng 35.
- **AI tìm thêm được:** AI chỉ ra thêm hàm `pause` ở dòng 45 mà lúc đọc bằng mắt thường dễ bị bỏ sót.
- **Đánh giá AI:** AI phân tích chính xác, trả lời đúng số dòng và không tự bịa ra thông tin nhờ câu lệnh ràng buộc nghiêm ngặt trong prompt
## Lab 6: Triển khai Smart Contract đầu tiên

**Prompt đã dùng:** "Hướng dẫn tạo và deploy hợp đồng Greeter.sol lên mạng Sepolia bằng Remix IDE và MetaMask..."

**So sánh & Đánh giá:**
- **Thực thi:** Hoàn thành quy trình compile và deploy hợp đồng `Greeter.sol` lên mạng thử nghiệm Sepolia.
- **Kết quả:** Hiểu rõ cách tương tác trực tiếp với các hàm Read (`greet`) và Write (`setGreeting`) thông qua giao diện Deployed Contracts.
## Lab 7: Phân quyền & Quản lý trạng thái

**Prompt đã dùng:** "Hướng dẫn lập trình phân quyền onlyOwner và phát sự kiện Event trong Solidity..."

**So sánh & Đánh giá:**
- **Thực thi:** Đã viết, compile và triển khai hợp đồng `AccessControl.sol` thành công lên mạng thử nghiệm Sepolia.
- **Kết quả:** Kiểm thử thành công cơ chế `modifier onlyOwner` — cho phép ví Owner cập nhật trạng thái và ngăn chặn hoàn toàn giao dịch từ các ví không đủ thẩm quyền.

## Lab 8: Khởi tạo Repo nhóm - Đặt cọc mượn trả thiết bị

**Prompt đã dùng:** "tạo repo nhóm cho chủ đề nhóm chúng tôi , chủ đề : đặt cọc mượn trả thiết bị. đồng thời chỉ tôi cách add người"

**So sánh & Đánh giá:**
- **Thực thi:** Khởi tạo tài liệu đặc tả `SPEC.md`, viết Smart Contract `QuanLyThietBi.sol` tuân thủ nghiêm ngặt các quy ước `AGENTS.md` (Solidity 0.8.20, OpenZeppelin 5.x, CEI, custom error, basis point).
- **Kết quả:** Nắm vững quy trình tạo repository nhóm trên GitHub, các bước cấu hình Git đẩy mã nguồn và phân quyền mời các thành viên khác làm Collaborators.