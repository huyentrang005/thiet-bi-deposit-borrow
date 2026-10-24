# BÁO CÁO LAB 13 — THỰC NGHIỆM VỤ MẤT TIỀN VÀ KIỂM THỬ BẢO MẬT GIA CỐ HỢP ĐỒNG

**Tên dự án:** Hệ thống Quản lý Đặt cọc & Mượn trả Thiết bị CLB (SmartRent)  
**Mã lớp / Học phần:** ECO2432 — Tiền điện tử & Công nghệ Blockchain  
**Tệp hợp đồng thực nghiệm:** `contracts/training/VulnerableBank.sol`  
**Tệp hợp đồng nhóm đã gia cố:** `contracts/project/ProjectCore.sol` & `contracts/QuanLyThietBi.sol`

**Thành viên thực hiện:**
- Phan Thị Huyền Trang (MSSV: 23K4020050 - `@huyentrang005`)
- Trần Thị Thi Thơ (MSSV: 23K4300018 - `@thot23547-cpu`)

---

## 1. Dựng hiện trường và thực nghiệm tấn công Reentrancy (Bước 1 & 2)

Môi trường thực thi: **Remix VM (Cancun / Shanghai)**

### Bước dựng hiện trường:
1. Triển khai hợp đồng có lỗ hổng nghiêm trọng `VulnerableBank.sol`.
2. Dùng 3 tài khoản người dùng khác nhau, mỗi tài khoản gọi `deposit()` nạp **2 ETH**.
3. Tổng số dư ngân hàng: **6 ETH** (`bankBalance() = 6 ETH`).

### Kịch bản tấn công:
1. Triển khai hợp đồng `Attacker.sol` với tham số là địa chỉ của `VulnerableBank`.
2. Tài khoản kẻ tấn công gọi `attack()` gửi kèm **1 ETH**.
3. Hàm `withdraw()` của ngân hàng chuyển 1 ETH ra ngoài trước khi cập nhật số dư `balances[msg.sender] = 0`.
4. Hàm fallback `receive()` của hợp đồng tấn công tự động kích hoạt và gọi lại `withdraw()` liên tục trong khi số dư ngân hàng vẫn còn ghi nhận.
5. **Kết quả:** Ngân hàng bị rút sạch từ **7 ETH về 0 ETH** trong cùng 1 giao dịch duy nhất! Toàn bộ tiền rơi vào tay kẻ tấn công.

---

## 2. Vá lỗi hợp đồng bằng hai phương pháp chuẩn (Bước 4)

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

### Cách 2 — Sử dụng khóa chống gọi lại của OpenZeppelin (`ReentrancyGuard`):
```solidity
import "@openzeppelin/contracts/utils/ReentrancyGuard.sol";

contract SafeBank is ReentrancyGuard {
    function withdraw() external nonReentrant {
        uint256 bal = balances[msg.sender];
        require(bal > 0, "Khong co so du");
        balances[msg.sender] = 0;
        (bool ok, ) = msg.sender.call{value: bal}("");
        require(ok, "Chuyen that bai");
    }
}
```

---

## 3. Ba câu giải thích vì sao thứ tự dòng lệnh chặn được tấn công (Vấn đáp)

1. Khi ta đưa dòng `balances[msg.sender] = 0` lên trước lệnh `call`, số dư của kẻ tấn công trong sổ sách của hợp đồng đã ngay lập tức bị đưa về `0`.
2. Do đó, khi hàm `receive()` của kẻ tấn công cố tình gọi lại hàm `withdraw()` lần thứ hai, lệnh kiểm tra điều kiện `require(bal > 0)` sẽ phát hiện số dư bằng `0` và lập tức đảo ngược giao dịch (`revert`).
3. Thứ thực sự chặn đứng cuộc tấn công là **thứ tự thực thi logic của các dòng mã nguồn (Checks - Effects - Interactions)**, chứ không phụ thuộc hoàn toàn vào bất kỳ một từ khóa hay thư viện bên ngoài nào.

---

## 4. Danh sách các kịch bản kiểm thử tấn công & gian lận trên Hợp đồng Nhóm

### 💥 Ca 1: Tấn công Reentrancy (Rút tiền cọc lặp lại)
- **Mô tả kịch bản:** Kẻ tấn công tạo một Smart Contract độc hại để gọi hàm `returnDevice()` / `traVaHoanCoc()` nhiều lần liên tiếp trước khi trạng thái hoàn tất được cập nhật.
- **Kết quả kiểm thử:** ❌ **Thất bại (Hợp đồng tuyệt đối an toàn)**.
- **Cơ chế phòng thủ:** Đã áp dụng mẫu thiết kế **Checks-Effects-Interactions**: cập nhật trạng thái `state = State.Completed` và reset `borrower = address(0)` trước khi thực hiện chuyển ETH.

### 💥 Ca 2: Giả mạo quyền Ban quản lý (Unauthorized Access)
- **Mô tả kịch bản:** Sinh viên mượn đồ cố tình gọi hàm quản trị như `themThietBi()` hoặc `traVaHoanCoc()` để tự giải phóng cọc.
- **Kết quả kiểm thử:** ❌ **Thất bại (Giao dịch bị Revert ngay lập tức)**.
- **Cơ chế phòng thủ:** Modifier `onlyOwner` bắt buộc chỉ duy nhất ví Admin mới được quyền thực thi.

### 💥 Ca 3: Mượn đồ gửi thiếu tiền cọc (Insufficient Funds)
- **Mô tả kịch bản:** Người dùng gọi hàm `borrow()` / `muonThietBi()` nhưng gửi lượng ETH ít hơn mức cọc quy định (`msg.value < depositAmount`).
- **Kết quả kiểm thử:** ❌ **Thất bại (Giao dịch bị Revert)**.
- **Cơ chế phòng thủ:** Điều kiện kiểm tra `if (msg.value != depositAmount) revert WrongDepositAmount();` đã chặn đứng giao dịch.

---

## 5. Kết luận
Smart Contract của nhóm đã vượt qua 100% các ca kiểm thử bảo mật và gian lận kinh tế, đảm bảo an toàn tuyệt đối cho quỹ thiết bị của CLB và tiền ký quỹ của sinh viên.
