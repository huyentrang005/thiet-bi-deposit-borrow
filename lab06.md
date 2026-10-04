# BÁO CÁO TRIỂN KHAI SMART CONTRACT TRÊN SEPOLIA (LAB 6)

## 1. Thông tin Triển khai (Deployment Info)

- **Tên Hợp đồng:** `Greeter.sol`
- **Địa chỉ Hợp đồng (Contract Address):** `0x3062acbd10e2B5D32A7c3492B7454Ce11092F24F` *(Dán địa chỉ hợp đồng thu được ở Mục Deployed Contracts)*
- **Mã băm giao dịch triển khai (Deploy TxHash):** `0xbcec6c7843f767a046ccfa50b2c116a84e8e2cedc59c774c3b268f53fa035f2f` *(Dán mã TxHash thu được ở Bước 3)*
- **Mạng thử nghiệm:** Sepolia Testnet

## 2. Nhật ký Tương tác Hợp đồng

| Thao tác | Hàm sử dụng | Dữ liệu đầu vào | Kết quả thực thi |
| :--- | :--- | :--- | :--- |
| **Khởi tạo (Deploy)** | `constructor()` | `"Xin chao Hue University!"` | Triển khai hợp đồng thành công lên Sepolia |
| **Đọc dữ liệu** | `greet()` | Không có | Trả về chuỗi `"Xin chao Hue University!"` |
| **Ghi dữ liệu** | `setGreeting()` | `"Lop Kinh te so Web3"` | Cập nhật trạng thái câu chào mới thành công |

## 3. Bài học rút ra

- Nắm vững quy trình phát triển Smart Contract: Viết code Solidity -> Compile kiểm tra lỗi -> Deploy thông qua ví MetaMask.
- Phân biệt rõ hàm đọc dữ liệu (`view`) không tốn phí Gas và hàm thay đổi trạng thái (`setGreeting`) phải tốn phí Gas để xác thực giao dịch trên Blockchain.