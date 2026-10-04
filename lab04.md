# BÁO CÁO NHẬN DIỆN HỢP ĐỒNG CÓ RỦI RO (LAB 4)

## Bảng đánh giá quyền đặc biệt và rủi ro

| Hợp đồng | Tên hàm | Số dòng | Rủi ro cho người nắm giữ | Kết luận |
| :--- | :--- | :--- | :--- | :--- |
| **ClubTokenA** | Không có | Dòng 7 - 11 | Không có quyền quản trị đặc biệt. Chỉ đúc token 1 lần lúc khởi tạo. | **An toàn** |
| **ClubTokenB** | `mint(address to, uint256 amount)` | Dòng 18 - 20 | Chủ sở hữu có thể tự ý đúc thêm token vô hạn, gây lạm phát nặng và nguy cơ xả hàng (Rug Pull). | **Rủi ro cao** |
| **ClubTokenC** | `setRestricted(address user, bool status)` | Dòng 23 - 38 | Chủ sở hữu có quyền cấm/đóng băng tài khoản bất kỳ, ngăn người dùng chuyển hoặc bán token. | **Rủi ro trung bình** |

*Ghi chú: Mọi kết luận đều được trích dẫn chính xác theo số dòng mã nguồn thực tế trong tệp ClubTokens.sol.*