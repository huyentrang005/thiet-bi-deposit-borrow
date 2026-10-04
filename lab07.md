# BÁO CÁO PHÂN QUYỀN & QUẢN LÝ TRẠNG THÁI TRONG SMART CONTRACT (LAB 7)

## 1. Thông tin Triển khai Hợp đồng

- **Tên Hợp đồng:** `AccessControl.sol`
- **Địa chỉ Hợp đồng (Contract Address):** `0xC61d78A92B7DfdF85fAB1c22135977721dd96F4c` *(Thay đoạn 0x... bằng Địa chỉ hợp đồng bạn vừa copy từ Remix)*
- **Mã băm giao dịch triển khai (Deploy TxHash):** `0xc3b3da37ab12ba21104070a2bfc3c0f46b451214682c994239d077bf12ba90c7` *(Thay đoạn 0x... bằng mã TxHash bạn vừa copy từ Remix)*
- **Mạng thử nghiệm:** Sepolia Testnet

## 2. Kết quả Kiểm thử Phân quyền (Access Control)

| Trường hợp | Ví thực thi | Hàm gọi | Kết quả kỳ vọng | Kết quả thực tế |
| :--- | :--- | :--- | :--- | :--- |
| **Trường hợp 1** | Ví Owner (Chủ hợp đồng) | `setSystemStatus("Dang bao tri")` | Thành công, trạng thái hệ thống cập nhật | **Thành công** (Đã phát sự kiện `StatusUpdated`) |
| **Trường hợp 2** | Ví phụ (Không phải Owner) | `setSystemStatus("Thay doi")` | Bị từ chối (Revert) | **Thành công** (Giao dịch bị chặn với lỗi "Chi Owner moi co quyen") |

## 3. Trả lời câu hỏi thu hoạch

**Câu hỏi 1:** Tại sao cần sử dụng `modifier` thay vì viết lệnh `require` lặp đi lặp lại trong từng hàm?  
**Trả lời:** Việc sử dụng `modifier` (như `onlyOwner`) giúp tái sử dụng mã nguồn, hạn chế tối đa nguy cơ sót lỗi phân quyền, làm code gọn gàng, dễ bảo trì và tiết kiệm phí Gas khi biên dịch.

**Câu hỏi 2:** Sự kiện (`event`) trong Solidity có vai trò gì đối với ứng dụng Web3 Front-end?  
**Trả lời:** `Event` cho phép ghi nhật ký sự kiện lên Blockchain (Logs). Các ứng dụng Front-end (Web3/React) dựa vào `Event` để lắng nghe (listen) và cập nhật giao diện người dùng theo thời gian thực mà không cần phải liên tục truy vấn toàn bộ trạng thái Blockchain.