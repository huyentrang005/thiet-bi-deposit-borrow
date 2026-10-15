# Minh Chứng Thực Hành Lab 10 — Rà Soát Mã Nguồn & Đọc Ô Nhớ Storage

## 1. Thực Nghiệm Đọc Dữ Liệu Private trên Blockchain (VaultBuggy)
Hợp đồng `VaultBuggy.sol` khai báo biến `private uint256 emergencyPin`.

Thực hiện lệnh đọc trực tiếp slot bộ nhớ thứ 2 trên Browser Console:
```javascript
const pinHex = await window.ethereum.request({
  method: "eth_getStorageAt",
  params: ["0xDiaChiHopDongVaultBuggy", "0x2", "latest"]
});
console.log("Mã PIN đọc trực tiếp được từ ô nhớ:", parseInt(pinHex, 16));
```
**Kết luận thực nghiệm:** Dữ liệu dù để `private` trong Solidity vẫn được lưu trữ hoàn toàn công khai trên sổ cái phân tán. Không bao giờ lưu bí mật kinh doanh hoặc mật khẩu on-chain.

## 2. Kết Quả Audit ProjectCore.sol
Đã phát hiện 4 vấn đề và sửa đổi triệt để trong `contracts/project/ProjectCore.sol` (chi tiết xem tại `docs/AI_JOURNAL.md`).
