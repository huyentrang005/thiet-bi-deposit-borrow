# BÁO CÁO PHÂN TÍCH ON-CHAIN (LAB 3)

## 1. Mổ xẻ 10 trường dữ liệu giao dịch cá nhân (Sepolia)

- **TxHash:** `0xaf19fd7d2785b99ade5d5513a91e542956f23f7037b8e5096acf367270c341e0`

| Trường (Field) | Giá trị thực tế | Ý nghĩa nghiệp vụ |
| :--- | :--- | :--- |
| **Status** | Success | Giao dịch đã được ghi nhận thành công vào blockchain. |
| **Block** | 11784531 | Số thứ tự khối chứa giao dịch trên mạng Sepolia. |
| **Timestamp** | Sep-26-2026 06:45:00 AM +UTC | Mốc thời gian chính thức ghi nhận giao dịch. |
| **From** | `0xaa8B859167fBf267F9B8cd8f8Ba7013a89a19411` | Địa chỉ ví người gửi. |
| **To** | `0x64d60310243169f4120e63F4` | Địa chỉ ví người nhận. |
| **Value** | 0.01 Sepolia ETH | Số tiền ETH được chuyển giao giữa hai ví. |
| **Transaction Fee** | 0.0000315 ETH | Phí thực trả = Gas Used × Gas Price. |
| **Gas Price** | 1.5 Gwei | Đơn giá gas tại thời điểm giao dịch. |
| **Gas Limit / Used** | 21,000 / 21,000 | Mức gas tối đa cho phép và lượng gas thực tế tiêu tốn. |
| **Nonce** | 0 (hoặc số tương ứng) | Số thứ tự giao dịch của ví gửi để chống phát lại (replay). |

## 2. Trả lời 3 câu hỏi thu hoạch về Hợp đồng USDT

1. **Hợp đồng USDT có công bố mã nguồn đã xác thực (Verified Source Code) không?**
   - Có. Tab Contract có dấu tích xanh "Contract Source Code Verified", cho phép công khai đọc và kiểm tra toàn bộ mã nguồn Solidity.

2. **Tổng cung của đồng USDT là bao nhiêu? Đọc ra từ hàm nào?**
   - Được đọc ra từ hàm `totalSupply()` trong tab **Read Contract**.

3. **Trong tab Write Contract, có hàm nào cho phép địa chỉ đặc biệt đóng băng tài khoản người khác không? Tên hàm là gì?**
   - Có. Tên hàm là **`addBlackList(address : _clearedUser)`**. Hàm này cho phép chủ sở hữu hợp đồng (Owner/Admin) đưa địa chỉ ví bất kỳ vào danh sách đen, ngăn không cho ví đó chuyển hoặc nhận USDT.