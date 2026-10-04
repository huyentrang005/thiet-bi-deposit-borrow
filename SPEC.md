# SPEC - Quản Lý Đặt Cọc Mượn Trả Thiết Bị (Lab 8)

## 1. Mục đích

Hệ thống quản lý và tự động hóa quy trình đặt cọc, mượn và hoàn trả thiết bị bằng Smart Contract minh bạch trên Blockchain Sepolia, giúp phòng thực hành/lab và sinh viên tránh thất thoát tài sản và giải quyết tranh chấp tiền cọc tự động.

## 2. Đầu vào

- `themThietBi(string ten, uint256 tienCoc)`: Quản trị viên (Owner) cung cấp tên thiết bị và mức tiền đặt cọc quy định (tính theo wei).
- `muonThietBi(uint256 idThietBi)`: Người mượn cung cấp ID thiết bị muốn mượn và gửi kèm giao dịch `msg.value` đúng bằng số tiền cọc quy định.
- `traThietBi(uint256 idThietBi)`: Người đang mượn cung cấp ID thiết bị để tiến hành trả lại cho kho.
- `xacNhanNhanVaHoanCoc(uint256 idThietBi, uint256 khauTruBps)`: Quản trị viên cung cấp ID thiết bị và tỷ lệ khấu trừ (basis point: 1% = 100) nếu thiết bị bị hao mòn/hỏng hóc, phần cọc còn lại tự động chuyển về ví người mượn.

## 3. Quy tắc nghiệp vụ

- **R1:** Chỉ có Quản trị viên (`Owner`) mới có quyền thêm mới thiết bị vào hệ thống và kích hoạt trạng thái bảo trì/ngưng sử dụng.
- **R2:** Người mượn chỉ được phép mượn khi thiết bị đang ở trạng thái sẵn sàng (`SanSang`) và gửi kèm tiền đặt cọc chính xác bằng `tienCoc` quy định.
- **R3:** Toàn bộ tiền cọc của người mượn được ký quỹ (escrow) trực tiếp trên hợp đồng thông minh, không ai có thể rút tự ý trong thời gian đang mượn.
- **R4:** Khi thiết bị được trả về kho, hệ thống hoàn trả tiền cọc cho đúng địa chỉ ví người mượn theo nguyên tắc Checks-Effects-Interactions, sử dụng `call{value: ...}("")` và kiểm tra kết quả giao dịch.

## 4. Đầu ra

- Các sự kiện minh bạch phát lên Blockchain: `ThietBiDaThem`, `ThietBiDuocMuon`, `ThietBiDaTra`, `TienCocDaHoan`.
- Hàm tra cứu công khai `layThongTinThietBi(uint256 idThietBi)` hiển thị tên, mức cọc, trạng thái hiện tại, và địa chỉ người đang mượn.

## 5. Trường hợp ngoại lệ

- **E1:** Nếu người mượn gửi thiếu hoặc thừa tiền cọc so với quy định, giao dịch lập tức bị đảo ngược (revert) với mã lỗi tùy biến `KhongDungTienCoc(uint256 guiVao, uint256 yeuCau)`.
- **E2:** Nếu người dùng cố gắng mượn thiết bị đang có người khác mượn hoặc đang bảo trì, giao dịch bị đảo ngược với lỗi `ThietBiKhongKhaDung(uint256 idThietBi)`.
- **E3:** Nếu người không phải là người đang mượn cố tình gọi trả thiết bị hoặc rút tiền cọc, giao dịch bị từ chối với lỗi `KhongPhaiNguoiMuon(address nguoiGoi, address nguoiMuonThucTe)`.

## 6. Ngoài phạm vi

- Không định vị GPS hoặc theo dõi vị trí vật lý ngoại đời của thiết bị.
- Không tích hợp tính năng sinh lãi/lending từ số dư ETH tiền cọc đang lưu ký.

