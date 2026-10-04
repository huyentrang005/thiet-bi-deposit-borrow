# BÁO CÁO TƯƠNG TÁC TOKEN TRÊN SEPOLIA (LAB 5)

## 1. Thông tin hợp đồng & Tương tác

- **Địa chỉ Hợp đồng Token:** `0x1f9840a85d5aF5bf1D1762F925BDADdC4201F984`
- **Mã băm đúc Token (Mint TxHash):** `0x620c670646ae87d24bc86a7f266e184a340e4b9b5cf9bcb963b1f4d2ca5dc0d2`
- **Mã băm chuyển Token (Transfer TxHash):** `0xaf19fd7d2785b99ade5d5513a91e542956f23f7037b8e5096acf367270c341e0`

## 2. Bảng kiểm tra tương tác On-chain

| Thao tác | Tên hàm sử dụng | Tab thực hiện | Kết quả thực thi |
| :--- | :--- | :--- | :--- |
| **Tương tác đúc Token** | `mint()` / `delegate()` | Write Contract | Thành công (Xác nhận giao dịch tương tác hợp đồng trên Sepolia) |
| **Chuyển Token** | `transfer()` | Write Contract / MetaMask | Thành công (Đã chuyển token/ETH sang ví mục tiêu) |
| **Kiểm tra số dư** | `balanceOf()` | Read Contract | Hiển thị chính xác trạng thái số dư thực tế |

## 3. Trả lời câu hỏi thu hoạch

**Câu hỏi:** Tại sao hàm `balanceOf()` khi gọi không tốn phí Gas, còn hàm `transfer()` lại tốn phí Gas?

**Trả lời:**
- Hàm `balanceOf()` chỉ đọc (Read) dữ liệu từ trạng thái (state) hiện tại của Blockchain mà không làm thay đổi hay ghi dữ liệu mới, do đó nút (node) có thể trả về kết quả ngay lập tức mà không cần tạo giao dịch hay đóng khối.
- Hàm `transfer()` là hàm ghi (Write), làm cập nhật và thay đổi số dư của các tài khoản trong sổ xố Blockchain. Bắt buộc phải tạo giao dịch, được validator xác thực và ghi vào khối nên phải chi trả phí Gas.