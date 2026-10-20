# BÁO CÁO LAB 15 — GIAO DIỆN WEB DAPP VÀ ĐƯA SẢN PHẨM LÊN MẠNG

**Nhóm thực hiện:**
- Phan Thị Huyền Trang (`@huyentrang005`)
- Trần Thị Thi Thơ (`@thot23547-cpu`)

**Đề tài nhóm:** Chủ đề 2 — Đặt cọc mượn thiết bị CLB (SmartRent)  
**Địa chỉ DApp trực tuyến:** [https://thiet-bi-deposit-borrow.vercel.app](https://thiet-bi-deposit-borrow.vercel.app)  
**Phiên bản phát hành:** Tag Git `v0.1-demo`

---

## 1. Bảng ánh xạ kết nối giao diện với hợp đồng (Bước 1)

| Thành phần | Giá trị của nhóm |
| :--- | :--- |
| **Địa chỉ Smart Contract** | `0x47666Fab8bd0Ac7003bce3f5C3585383F09486E2` (Sepolia Testnet) |
| **ABI lấy từ đâu** | Remix IDE ➔ Tab Solidity Compiler ➔ Nút sao chép ABI của `ProjectCore.sol` |
| **Hàm đọc không tốn phí (View)** | `calculatePenalty()`, `timeLeft()`, `state()`, `depositAmount()`, `dueTime()` |
| **Hàm ghi cần xác nhận ví (Write)** | `borrow()` (gửi kèm tiền cọc ETH), `returnDevice()`, `resetDevice()` |

---

## 2. Kiểm thử toàn bộ luồng nghiệp vụ trên DApp (Bước 2)

1. **Kết nối ví:** Người dùng bấm *"Kết nối ví MetaMask"*, DApp nhận diện địa chỉ ví và kiểm tra mạng Sepolia (Chain ID `11155111`).
2. **Thao tác thành công:** Sinh viên bấm *"Mượn thiết bị"* ➔ MetaMask mở ra yêu cầu xác nhận nạp tiền cọc ➔ Hợp đồng khóa cọc và cập nhật hạn chót trả.
3. **Thao tác bị từ chối:** Nếu sinh viên cố tình mượn thiết bị đang có người sử dụng hoặc gửi thiếu tiền cọc ➔ Giao diện bắt lỗi từ khối `try/catch` và hiển thị thông báo thân thiện bằng tiếng Việt qua `addLog()`.

---

## 3. Triển khai lên mạng công khai qua Vercel (Bước 3)

- Đã cấu hình tệp `vercel.json` ở thư mục gốc để Vercel tự động build và phục vụ mã nguồn tĩnh từ thư mục `web/`.
- **URL công khai:** [https://thiet-bi-deposit-borrow.vercel.app](https://thiet-bi-deposit-borrow.vercel.app)
- Đã kiểm tra mở được trên điện thoại thông minh kết nối với ứng dụng MetaMask Mobile.

---

## 4. Kịch bản thuyết trình và phân vai 5 phút (Bước 5)

Đã hoàn thành chi tiết tại tệp [docs/PRESENTATION_PLAN.md](../../docs/PRESENTATION_PLAN.md):
- **Phan Thị Huyền Trang (3 phút):** Trình bày vấn đề & người dùng, trực tiếp demo luồng nạp cọc/hoàn cọc trên DApp Vercel, giải thích bảo mật CEI chống Reentrancy.
- **Trần Thị Thi Thơ (2 phút):** Trình bày quy tắc phạt trễ hạn theo ngày, demo ca vi phạm gửi thiếu cọc bị chặn, chia sẻ bài học rút ra và hướng phát triển.
