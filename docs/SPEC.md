# SPEC — Quản Lý Đặt Cọc Mượn Trả Thiết Bị (v0.1)

## 1. Mục đích

Hệ thống quản lý và tự động hóa quy trình đặt cọc, mượn và hoàn trả thiết bị bằng Smart Contract minh bạch trên Blockchain Sepolia, giúp phòng thực hành/lab trường học và sinh viên tránh thất thoát tài sản, loại bỏ gian lận và giải quyết tranh chấp tiền cọc tự động.

---

## 2. Đầu vào

- `themThietBi(string calldata _tenThietBi, uint256 _tienCoc)`: Quản trị viên (Owner) cung cấp tên thiết bị và số tiền cọc yêu cầu (đơn vị: wei).
- `capNhatBaoTri(uint256 _id, bool _laBaoTri)`: Quản trị viên cung cấp ID thiết bị và trạng thái chuyển sang bảo trì hoặc sẵn sàng.
- `muonThietBi(uint256 _id)`: Người mượn cung cấp ID thiết bị và gửi kèm giá trị `msg.value` (ETH) đúng bằng tiền cọc quy định.
- `traVaHoanCoc(uint256 _id, uint256 _khauTruBps)`: Quản trị viên cung cấp ID thiết bị và tỷ lệ phạt khấu trừ hao mòn/hỏng hóc theo Basis Point (1% = 100).

---

## 3. Quy tắc nghiệp vụ có thể kiểm thử (Tối thiểu 4 quy tắc)

- **Quy tắc 1 (Ai được làm gì):** 
  - Chỉ có tài khoản Quản trị viên (`owner`) mới có quyền thêm mới thiết bị vào kho và chuyển đổi trạng thái bảo trì của thiết bị.
  - *Kiểm thử:* Ví không phải Owner gọi `themThietBi` hoặc `capNhatBaoTri` phải bị từ chối với lỗi quyền `OwnableUnauthorizedAccount`.

- **Quy tắc 2 (Khi nào được mượn):** 
  - Người mượn chỉ được phép mượn khi thiết bị đang ở trạng thái sẵn sàng (`TrangThai.SanSang == 0`) và gửi kèm chính xác số tiền cọc quy định (`msg.value == tb.tienCoc`).
  - *Kiểm thử:* Mượn thiết bị đang có người mượn hoặc đang bảo trì phải báo lỗi `ThietBiKhongKhaDung(id)`.

- **Quy tắc 3 (Giới hạn bao nhiêu):** 
  - Toàn bộ tiền cọc ETH được ký quỹ an toàn trực tiếp trên hợp đồng trong suốt quá trình mượn.
  - Tỷ lệ khấu trừ khi hoàn cọc tối đa không được vượt quá 100% (`_khauTruBps <= 10_000`).
  - *Kiểm thử:* Owner truyền `_khauTruBps > 10000` phải bị chặn với lỗi `KhauTruKhongHopLe`.

- **Quy tắc 4 (Lỗi thì sao & Xử lý hoàn tiền):** 
  - Mọi hàm thay đổi trạng thái nếu không thỏa mãn điều kiện đều bị revert ngay lập tức và hoàn trả nguyên vẹn lượng gas chưa sử dụng bằng các custom error.
  - Khi hoàn cọc, trạng thái thiết bị và người mượn phải được xóa trước (Effects), sau đó mới thực hiện chuyển ETH hoàn cọc qua lệnh `call` (Interactions). Nếu chuyển tiền thất bại, toàn bộ giao dịch phải revert với lỗi `ChuyenTienThatBai()`.

---

## 4. Đầu ra

- Phát sự kiện on-chain minh bạch cho mọi giao dịch thay đổi trạng thái:
  - `ThietBiDaThem(uint256 indexed id, string tenThietBi, uint256 tienCoc)`
  - `TrangThaiCapNhat(uint256 indexed id, TrangThai trangThaiMoi)`
  - `ThietBiDuocMuon(uint256 indexed id, address indexed nguoiMuon, uint256 tienCoc)`
  - `ThietBiDaTra(uint256 indexed id, address indexed nguoiMuon)`
  - `TienCocDaHoan(uint256 indexed id, address indexed nguoiMuon, uint256 soTienHoan, uint256 soTienKhauTru)`
- Hàm tra cứu công khai `layThongTinThietBi(uint256 _id)` trả về toàn bộ dữ liệu thiết bị, trạng thái và địa chỉ người đang mượn.

---

## 5. Trường hợp ngoại lệ

- **E1:** Người dùng gửi thừa hoặc thiếu tiền cọc khi gọi `muonThietBi` -> Revert `KhongDungTienCoc(uint256 daGui, uint256 yeuCau)`.
- **E2:** Người dùng gọi thao tác trên một ID thiết bị không tồn tại (`_id == 0` hoặc `_id > tongSoThietBi`) -> Revert `ThietBiKhongTonTai(uint256 id)`.
- **E3:** Kẻ tấn công cố tình gọi `traVaHoanCoc` của thiết bị chưa từng được mượn -> Revert `ThietBiKhongKhaDung(uint256 id)`.
- **E4:** Địa chỉ ví người mượn là hợp đồng từ chối nhận ETH khi hoàn tiền -> Revert `ChuyenTienThatBai()`.

---

## 6. Ngoài phạm vi

- Hệ thống không định vị GPS vị trí vật lý ngoại đời của thiết bị.
- Hệ thống không tự động thẩm định mức độ hư hại phần cứng (phải do Thủ kho kiểm tra thực tế rồi nhập tỷ lệ khấu trừ).
- Chưa hỗ trợ đặt cọc bằng ERC20 token đa dạng (chỉ sử dụng Native ETH trên Sepolia).
