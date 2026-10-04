# BÁO CÁO LAB 2: VÍ VÀ GIAO DỊCH ĐẦU TIÊN

## 1. Bảng đối chiếu giao dịch

| Trường thông tin | Giao dịch thành công | Giao dịch thất bại |
| :--- | :--- | :--- |
| **Mã băm giao dịch (TxHash)** | `0xaf19fd7d2785b99ade5d5513a91e542956f23f7037b8e5096acf367270c341e0` | Bị MetaMask từ chối (Không sinh ra TxHash) |
| **Số tiền chuyển** | 0.01 Sepolia ETH | 2.0 Sepolia ETH |
| **Phí giao dịch thực trả** | 0.0000315 ETH | 0 ETH |
| **Trạng thái (Status)** | Success | Rejected / Failed (Insufficient funds) |
| **Nguyên nhân (nếu thất bại)** | N/A | Nhập số tiền vượt quá số dư khả dụng và không đủ phí Gas |

## 2. Câu hỏi thu hoạch

**Câu hỏi:** Nếu bạn chuyển nhầm tiền cho người lạ trên Blockchain, có lấy lại được tiền không? Vì sao?

**Trả lời:**
- Không thể lấy lại được.
- Vì tính chất cốt lõi của công nghệ Blockchain là tính phi tập trung và bất biến (Immutability). Khi một giao dịch đã được các nút xác nhận và ghi vào khối thành công, không một cá nhân, tổ chức hay tổng đài nào có quyền đảo ngược hoặc hủy bỏ.
- Cách duy nhất là người nhận nhầm tự nguyện gửi lại cho bạn một giao dịch mới.