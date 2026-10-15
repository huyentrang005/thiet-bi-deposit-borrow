# 📓 NHẬT KÝ LÀM VIỆC VỚI AI — ECO2432 (LAB 8 – LAB 15)

- **Đề tài:** Đặt cọc mượn trả thiết bị (Chủ đề 2)
- **Kho lưu trữ:** `https://github.com/huyentrang005/thiet-bi-deposit-borrow`
- **Thành viên:** Phan Thị Huyền Trang (`huyentrang005`) & Nhóm sinh viên

---

## Lab 8: Khởi Tạo Codebase Nhóm và Đặc Tả v0.1
- **Prompt:** "Đọc AGENTS.md và hỗ trợ thiết lập tài liệu đặc tả SPEC.md, ECONOMIC_RULES.md và PROJECT_PLAN.md cho hệ thống đặt cọc mượn trả thiết bị."
- **AI trả về:** Bộ tài liệu 3 phần mô tả luồng nạp cọc, giữ cọc (Escrow) và hoàn trả.
- **Đánh giá:** ⚠️ Phải sửa.
- **Chỗ sai/Thiếu:** AI ban đầu viết quy tắc phạt theo kiểu trừ cố định không theo thời gian trễ.
- **Cách sửa:** Sinh viên bổ sung công thức phạt lũy tiến theo số ngày trễ `SoNgayTre * PhiPhatMoiNgay` và khống chế trần phạt không vượt quá 100% tiền cọc.
- **Ai phát hiện:** Sinh viên phát hiện.

---

## Lab 9: Hợp Đồng Lõi Biên Dịch Được
- **Prompt:** "Viết hợp đồng ProjectCore.sol bằng Solidity 0.8.20 kế thừa Ownable theo đúng đặc tả docs/SPEC.md và AGENTS.md."
- **AI trả về:** Mã nguồn `ProjectCore.sol` quản lý danh sách thiết bị và nạp cọc.
- **Đánh giá:** ✅ Dùng được sau khi tinh chỉnh.
- **Chỗ sửa:** Đổi tên các hàm sang tiếng Việt không dấu, bổ sung sự kiện `ThietBiDuocMuon` và kiểm tra `msg.value == tienCoc`.
- **Ai phát hiện:** Sinh viên phát hiện.

---

## Lab 10: Rà Soát Mã Nguồn Do AI Sinh Ra (Audit ProjectCore)

### Bảng rà soát lỗi bắt buộc (Theo mẫu B.3 & Mục 25 Sổ tay):

| Lỗi | Mô tả lỗi | Ai phát hiện | Cách khắc phục |
| :---: | :--- | :---: | :--- |
| **1** | Sử dụng từ khóa `private` cho biến nhạy cảm tưởng rằng sẽ giấu được thông tin (giống biến `emergencyPin` trong `VaultBuggy.sol`). Thực tế web3 đọc được qua `eth_getStorageAt`. | **Sinh viên** | Không bao giờ lưu trữ mật khẩu/thông tin bí mật on-chain. Mọi dữ liệu trên Blockchain là công khai. |
| **2** | Quên kiểm tra trường hợp `_haoMonBps > 10_000` (100%), dẫn tới khả năng khấu trừ vượt quá số tiền cọc ban đầu. | **AI** | Thêm điều kiện `if (_haoMonBps > 10_000) revert KhauTruKhongHopLe(bps);` ngay đầu hàm. |
| **3** | Chuyển ETH bằng lệnh `transfer()` lỗi thời bị giới hạn cứng 2300 gas, có thể bị lỗi khi người nhận là ví đa chữ ký/hợp đồng thông minh. | **Sinh viên** | Thay thế bằng `payable(to).call{value: amount}("")` kèm kiểm tra kết quả trả về `bool success`. |
| **4** | Lỗi làm tròn số nguyên khi chia trước nhân sau trong phép tính khấu trừ phần trăm, gây thất thoát phí nhỏ. | **Sinh viên (Cộng điểm)** | Đổi thứ tự phép tính thành `(tongCoc * bps) / 10_000` (nhân trước, chia sau). |

---

## Lab 11: Cài Đặt Quy Tắc Kinh Tế & Kiểm Thử
- **Prompt:** "Cài đặt hàm tinhTienPhat(id, thoiDiemTra) tính tiền phạt theo ngày trễ và ca kiểm thử trên test/ProjectCoreTest.sol."
- **Đánh giá:** ✅ Dùng được.
- **Kết quả:** Kiểm thử thành công 2 kịch bản:
  - Ca 1 (Hợp lệ): Trả trước hoặc đúng hạn ➔ Phạt = 0, hoàn trả 100% cọc.
  - Ca 2 (Vi phạm/Trễ hạn): Trễ 2 ngày ➔ Tự động trừ `2 * phiPhatMoiNgay`, hoàn phần còn lại về đúng ví sinh viên.

---

## Lab 12: Đánh Giá Gate Review 1
- **Kết luận:** Đạt điều kiện thông qua (Passed).
- **Phạm vi chốt:** Giữ luồng nghiệp vụ cốt lõi: Nạp cọc ➔ Quản lý mượn ➔ Trả thiết bị và tính phạt tự động.
- **Tệp báo cáo:** [docs/GATE_REVIEW_1.md](file:///c:/Users/LAPTOP/Documents/TIEN%20DIEN%20TU/thiet-bi-deposit-borrow/docs/GATE_REVIEW_1.md).

---

## Lab 13: Thực Nghiệm Mất Tiền (Reentrancy) & Gia Cố Hợp Đồng
- **Phân tích hiện trường `VulnerableBank.sol`:**
  - Kẻ tấn công gọi hàm `withdraw()` ➔ Ngân hàng chuyển ETH ra ngoài trước khi cập nhật số dư `balances[msg.sender] = 0` ➔ Hàm `receive()` của kẻ tấn công kích hoạt gọi lại `withdraw()` liên tục cho đến khi rút cạn ngân hàng.
- **Ba câu giải thích vì sao thứ tự dòng lệnh là thứ chặn được tấn công:**
  1. Khi cập nhật trạng thái số dư về 0 trước (`balances[msg.sender] = 0`), nếu kẻ tấn công gọi lại lần 2, điều kiện kiểm tra `require(bal > 0)` sẽ ngay lập tức phát hiện số dư bằng 0 và đảo ngược giao dịch.
  2. Việc cập nhật số sách trước khi chuyển tiền tuân thủ triệt để nguyên tắc **Checks-Effects-Interactions (CEI)**.
  3. Thứ chặn đứng cuộc tấn công là thứ tự thực thi logic của các dòng mã nguồn, không phụ thuộc hoàn toàn vào bất kỳ từ khóa hỗ trợ nào.

---

## Lab 14: Xử Lý Kết Quả Audit Chéo
- Thực hiện rà soát hợp đồng nhóm bạn theo 10 tiêu chí bắt buộc (Phân quyền, CEI, điều kiện thời gian, phép chia, cách chuyển ETH, v.v.).
- Chi tiết ghi nhận tại [docs/AUDIT_REPORT.md](file:///c:/Users/LAPTOP/Documents/TIEN%20DIEN%20TU/thiet-bi-deposit-borrow/docs/AUDIT_REPORT.md). Hợp đồng `ProjectCore.sol` của nhóm đạt chuẩn an toàn, không có lỗ hổng nghiêm trọng.

---

## Lab 15: Hoàn Thiện Giao Diện Web DApp & Đưa Lên Mạng
- Nối giao diện `web/index.html` với hợp đồng `ProjectCore.sol` qua thư viện Ethers.js v5.
- Triển khai giao diện tĩnh trực tiếp lên mạng công khai thông qua **Vercel**: `https://thiet-bi-deposit-borrow.vercel.app`.
- Lập kịch bản phân công thuyết trình 5 phút tại [docs/PRESENTATION_PLAN.md](file:///c:/Users/LAPTOP/Documents/TIEN%20DIEN%20TU/thiet-bi-deposit-borrow/docs/PRESENTATION_PLAN.md).
