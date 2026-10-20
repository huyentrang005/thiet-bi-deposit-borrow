# BÁO CÁO LAB 13 — THỰC NGHIỆM MỘT VỤ MẤT TIỀN VÀ CÁCH KHẮC PHỤC

**Nhóm thực hiện:**
- Phan Thị Huyền Trang (`@huyentrang005`)
- Trần Thị Thi Thơ (`@thot23547-cpu`)

**Đề tài nhóm:** Chủ đề 2 — Đặt cọc mượn thiết bị CLB (SmartRent)  
**Tệp hợp đồng thực nghiệm:** `contracts/training/VulnerableBank.sol`  
**Tệp hợp đồng nhóm đã gia cố:** `contracts/project/ProjectCore.sol`

---

## 1. Dựng hiện trường và thực nghiệm tấn công Reentrancy (Bước 1 & 2)

Môi trường thực thi: **Remix VM (Cancun / Shanghai)**

### Bước dựng hiện trường:
1. Triển khai hợp đồng có lỗi `VulnerableBank.sol`.
2. Dùng 3 tài khoản khác nhau, mỗi tài khoản gọi `deposit()` nạp **2 ETH**.
3. Tổng số dư ngân hàng: **6 ETH** (`bankBalance() = 6 ETH`).

### Kịch bản tấn công:
1. Triển khai hợp đồng `Attacker.sol` với tham số là địa chỉ của `VulnerableBank`.
2. Tài khoản thứ 4 gọi `attack()` gửi kèm **1 ETH**.
3. Hàm `withdraw()` của ngân hàng chuyển 1 ETH ra ngoài trước khi cập nhật số dư `balances[msg.sender] = 0`.
4. Hàm `receive()` của hợp đồng tấn công tự động kích hoạt và gọi lại `withdraw()` liên tục trong khi số dư ngân hàng vẫn còn ghi nhận.
5. **Kết quả:** Ngân hàng bị rút sạch từ **7 ETH về 0 ETH** trong cùng 1 giao dịch duy nhất! Toàn bộ tiền rơi vào tay kẻ tấn công.

---

## 2. Vá lỗi hợp đồng bằng hai cách (Bước 4)

### Cách 1 — Đổi thứ tự lệnh (Checks – Effects – Interactions):
```solidity
function withdraw() external {
    uint256 bal = balances[msg.sender];
    require(bal > 0, "Khong co so du");

    // 1. Effects: Cập nhật sổ sách TRƯỚC
    balances[msg.sender] = 0;

    // 2. Interactions: Chuyển tiền sau cùng
    (bool ok, ) = msg.sender.call{value: bal}("");
    require(ok, "Chuyen that bai");
}
```

### Cách 2 — Dùng khóa chống gọi lại của OpenZeppelin (`ReentrancyGuard`):
```solidity
import "@openzeppelin/contracts/utils/ReentrancyGuard.sol";

contract SafeBank is ReentrancyGuard {
    function withdraw() external nonReentrant {
        // ...
    }
}
```

---

## 3. Ba câu giải thích vì sao thứ tự dòng lệnh là thứ chặn được tấn công (Vấn đáp)

1. Khi ta đưa dòng `balances[msg.sender] = 0` lên trước lệnh `call`, số dư của kẻ tấn công trong sổ sách của hợp đồng đã ngay lập tức bị đưa về `0`.
2. Do đó, khi hàm `receive()` của kẻ tấn công cố tình gọi lại hàm `withdraw()` lần thứ hai, lệnh kiểm tra điều kiện `require(bal > 0)` sẽ phát hiện số dư bằng `0` và lập tức đảo ngược giao dịch (`revert`).
3. Thứ thực sự chặn đứng cuộc tấn công là **thứ tự thực thi logic của các dòng mã nguồn (Checks - Effects - Interactions)**, chứ không phụ thuộc hoàn toàn vào bất kỳ một từ khóa hay thư viện bên ngoài nào.

---

## 4. Soi lại và gia cố hợp đồng nhóm `ProjectCore.sol` (Bước 5)

Hàm `returnDevice()` trong `ProjectCore.sol` đã áp dụng triệt để nguyên tắc CEI:
- Cập nhật trạng thái `state = State.Completed` trước.
- Xóa quyền mượn của sinh viên `borrower = address(0)` trước.
- Sau cùng mới gọi `(bool ok, ) = payable(borrower).call{value: refund}("")`.
- Nhờ vậy, nếu sinh viên sử dụng hợp đồng thông minh để mượn và cố tình thực hiện Reentrancy khi nhận hoàn cọc, giao dịch gọi lại sẽ bị từ chối với lỗi `WrongState()`.
