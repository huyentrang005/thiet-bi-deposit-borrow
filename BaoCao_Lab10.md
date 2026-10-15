# BÁO CÁO LAB 10 — RÀ SOÁT MÃ NGUỒN DO AI SINH RA (AUDIT SMART CONTRACT)

**Nhóm thực hiện:**
- Phan Thị Huyền Trang (`@huyentrang005`)
- Trần Thị Thi Thơ (`@thot23547-cpu`)

**Đề tài nhóm:** Chủ đề 2 — Đặt cọc mượn thiết bị CLB (SmartRent)

---

## PHẦN 1: KẾT QUẢ RÀ SOÁT HỢP ĐỒNG BÀI LUYỆN (VaultBuggy.sol)

### 1. Bảng phân tích 4 lỗi cài sẵn trong VaultBuggy.sol:

| STT | Tên lỗi & Vị trí | Mức độ nghiêm trọng | Hậu quả khi bị khai thác | Cách khắc phục |
| :--- | :--- | :--- | :--- | :--- |
| **1** | **Sai dấu so sánh thời gian** (Dòng 19: `block.timestamp <= unlockTime`) | 🔴 Nghiêm trọng (Critical) | Tiền chỉ được rút TRƯỚC KHI đến hạn. Khi đã quá thời gian khóa, tiền trong két bị khóa vĩnh viễn không ai rút được. | Đổi thành `>=` (`block.timestamp >= unlockTime`). |
| **2** | **Lỗ hổng phân quyền** (Dòng 18: hàm `withdraw()` thiếu `onlyOwner`) | 🔴 Nghiêm trọng (Critical) | Bất kỳ ai gọi `withdraw()` cũng có thể rút cạn toàn bộ số dư của két về ví của mình (`payable(msg.sender)`). | Thêm điều kiện kiểm tra: `if (msg.sender != owner) revert NotOwner();`. |
| **3** | **Hiểu lầm về biến `private`** (Dòng 8: `uint256 private emergencyPin`) | 🟡 Trung bình (Medium) | Tưởng rằng mã PIN được bí mật, nhưng thực tế toàn bộ dữ liệu on-chain đều công khai và đọc được trực tiếp từ ô nhớ. | Không lưu mã PIN hoặc dữ liệu nhạy cảm dạng rõ (plain text) trên Blockchain. |
| **4** | **Dùng `transfer` & Thiếu Event** (Dòng 16, 20) | 🟢 Thấp (Low) | `transfer` giới hạn cứng 2.300 gas dễ gây lỗi khi bên nhận là Smart Contract. Hàm nạp/rút không phát sự kiện khiến DApp không theo dõi được. | Dùng `call{value: ...}("")` và phát event `Deposited`, `Withdrawn`. |

---

## PHẦN 2: THỰC NGHIỆM CHỨNG MINH LỖ HỔNG Ô NHỚ (Bước 3)

### Lệnh thực thi trong Console của trình duyệt (Console / Ethers.js):
```javascript
// Đọc trực tiếp ô nhớ (storage slot) thứ 2 của hợp đồng VaultBuggy
await window.ethereum.request({
  method: "eth_getStorageAt",
  params: ["<dia_chi_hop_dong_VaultBuggy>", "0x2", "latest"]
});
```

### Kết quả thu được:
- Trả về giá trị thập lục phân (Hex): `0x000000000000000000000000000000000000000000000000000000000001e240`
- Đổi từ Hex sang Decimal: `0x1e240` = **`123456`** (chính xác là giá trị `_pin` đã nhập khi khởi tạo!).

### 💡 BÀI HỌC CỐT LÕI (Dành cho vấn đáp):
> **Từ khóa `private` trong Solidity chỉ có tác dụng giới hạn quyền truy cập giữa các hợp đồng với nhau (hợp đồng khác không thể gọi trực tiếp biến này qua code). Nó HOÀN TOÀN KHÔNG LÀM DỮ LIỆU TRỞ NÊN BÍ MẬT. Mọi trạng thái ghi lên Blockchain đều công khai 100% đối với bất kỳ ai.**

---

## PHẦN 3: AUDIT VÀ SỬA LỖI TRÊN HỢP ĐỒNG NHÓM (ProjectCore.sol)

Bảng rà soát chi tiết 4 lỗi và giải pháp khắc phục đã được ghi nhận vào `docs/AI_JOURNAL.md`. Nhóm đã tiến hành vá lỗi và tối ưu hóa hợp đồng [contracts/project/ProjectCore.sol](file:///c:/Users/HTPC/Downloads/hce-web3-starter/hce-web3-starter/contracts/project/ProjectCore.sol).
