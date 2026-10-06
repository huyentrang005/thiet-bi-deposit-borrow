# QUY TẮC KINH TẾ — HỆ THỐNG KÝ QUỸ ĐẶT CỌC MƯỢN TRẢ THIẾT BỊ

Tài liệu này xác định các quy tắc kinh tế, dòng tiền, cơ chế chống lạm dụng và phản biện rủi ro cho hệ thống SmartRent (Lab 8).

---

## 1. Dòng tiền và Quyền lợi (Cashflow & Incentives)

- **Người mượn (Sinh viên):**
  - Đóng tiền ký quỹ (Escrow Deposit) bằng Native ETH đúng bằng mức quy định của thiết bị.
  - Tiền cọc được khóa an toàn trong Smart Contract, không một cá nhân nào (kể cả Owner) có thể tùy ý rút tiền ra tiêu xài.
  - Khi hoàn trả thiết bị nguyên vẹn, người mượn nhận lại 100% tiền cọc (`tienHoan = tongCoc`).
- **Bên cho thuê (Phòng Lab / Quản trị viên):**
  - Nhận lại thiết bị sau khi sử dụng để tiếp tục phục vụ các lượt mượn tiếp theo.
  - Nếu thiết bị bị làm rơi vỡ, trầy xước hoặc thiếu phụ kiện, Quản trị viên được nhận một khoản bồi thường khấu trừ từ tiền cọc (`tienKhauTru = (tongCoc * khauTruBps) / 10000`).

---

## 2. Giới hạn chống lạm dụng (Abuse Prevention Limits)

- **Giới hạn tỷ lệ phạt:** Tỷ lệ khấu trừ tối đa là 100% (`10_000 bps`). Smart contract chủ động từ chối bất kỳ giá trị nào lớn hơn 10,000 để chống tràn số hoặc phạt vượt mức tiền cọc.
- **Khóa trạng thái độc quyền:** Mỗi thiết bị tại một thời điểm chỉ có đúng một người mượn duy nhất (`TrangThai.DangMuon`). Người khác không thể nhảy vào mượn hoặc ghi đè địa chỉ người mượn.
- **Ràng buộc nộp cọc chính xác:** Buộc `msg.value == tb.tienCoc`. Người dùng không thể nộp thiếu (gây thất thoát cho phòng lab) hoặc nộp thừa (dẫn đến kẹt tiền dư không hoàn lại được).

---

## 3. Quyền quản trị (Governance / Admin Rights)

- **Quyền hạn của Owner (Chủ hợp đồng):**
  - Quyền khởi tạo danh mục thiết bị và định giá tiền cọc ban đầu.
  - Quyền tạm dừng thiết bị (`capNhatBaoTri`) khi cần bảo dưỡng hoặc kiểm kê.
  - Quyền kích hoạt hàm nghiệm thu và hoàn cọc (`traVaHoanCoc`).
- **Ranh giới quyền quản trị:**
  - Owner **không có hàm rút tiền tự do** (No backdoor withdraw). Tiền trong hợp đồng chỉ được di chuyển khi thực thi hàm hoàn cọc kèm theo sự thay đổi trạng thái trả thiết bị.

---

## 4. Tình huống người dùng bị thiệt (Worst-case Scenarios)

1. **Owner không phản hồi / bỏ quên nghiệm thu:** Người mượn đã mang trả thiết bị thực tế nhưng Quản trị viên quên hoặc cố tình không gọi hàm `traVaHoanCoc`, khiến tiền cọc của sinh viên bị giam trong hợp đồng.
2. **Owner áp đặt mức phạt khấu trừ quá cao:** Quản trị viên đánh giá thiết bị hỏng nặng hơn thực tế và nhập mức phạt cao (ví dụ phạt 50% - 100% cọc) mà người mượn không có cơ chế khiếu nại on-chain.
3. **Biến động giá ETH:** Trong thời gian mượn thiết bị kéo dài, giá trị fiat của đồng ETH có thể biến động lớn làm thay đổi giá trị kinh tế thực tế của khoản cọc.

---

## 5. Phản biện rủi ro kinh tế & Giải pháp của nhóm (Red Team Review)

Dựa trên yêu cầu phản biện của đề bài (5 cách lạm dụng quy tắc làm người khác bị thiệt):

### Phản biện 1: Quản trị viên cố tình phạt tối đa 100% tiền cọc của sinh viên
- *Lỗ hổng chỉ ra:* Quy tắc cho phép Owner toàn quyền quyết định tham số `_khauTruBps` (từ 0 đến 10,000 bps) khi hoàn cọc. Nếu gặp thủ kho ác ý, họ có thể phạt 100% để lấy trọn số tiền cọc về ví của mình.
- *Phản hồi của nhóm:* Nhóm ghi nhận rủi ro này trong v0.1. Vì đây là mô hình trường đại học nội bộ (sinh viên và thủ kho có danh tính thực ngoài đời), nếu có gian lận, sinh viên sẽ khiếu nại trực tiếp lên Ban chủ nhiệm khoa dựa trên TxHash minh bạch trên Blockchain. Ở phiên bản Lab 11, nhóm sẽ bổ sung cơ chế trọng tài bên thứ ba hoặc giới hạn mức phạt trần mặc định tối đa 20% trừ khi có sự xác nhận của cả hai bên.

### Phản biện 2: Sinh viên mượn thiết bị đắt tiền rồi "bùng" luôn thiết bị không trả
- *Lỗ hổng chỉ ra:* Nếu mức cọc quy định ban đầu thấp hơn giá trị thị trường thực tế của thiết bị, sinh viên có thể chấp nhận mất cọc để chiếm đoạt luôn thiết bị.
- *Phản hồi của nhóm:* Đã sửa đổi quy tắc định giá: Ở bước `themThietBi`, Quản trị viên bắt buộc phải thẩm định và đặt `tienCoc` tương đương tối thiểu 100% - 110% giá trị thay thế của thiết bị. Khi đó về mặt kinh tế, việc bùng thiết bị không mang lại lợi ích tài chính nào.

### Phản biện 3: Người mượn trả thiết bị nhưng Owner đi vắng không gọi hàm hoàn cọc
- *Lỗ hổng chỉ ra:* Người mượn không có hàm tự rút cọc (self-refund), hoàn toàn phụ thuộc vào việc Owner bấm nút. Tiền cọc có thể bị giam vô thời hạn nếu Owner làm mất khóa riêng (private key).
- *Phản hồi của nhóm:* Nhóm đưa vào kế hoạch Lab 11 một cơ chế **Thời gian ân hạn (Time-lock Grace Period)**: Người mượn có thể gọi hàm `yeuCauTraThietBi()`. Nếu sau 48 giờ mà Owner không phản hồi hoặc không chứng minh được hỏng hóc, hợp đồng sẽ cho phép người mượn tự động rút lại 100% cọc.

### Phản biện 4: Tấn công từ chối nhận tiền (DoS Refund) bằng Smart Contract
- *Lỗ hổng chỉ ra:* Một hợp đồng độc hại đóng vai trò người mượn, nhưng trong hàm `receive()` cố tình `revert`. Khi Owner gọi `traVaHoanCoc`, lệnh chuyển ETH `call` sẽ bị lỗi và làm treo toàn bộ giao dịch, khiến thiết bị không thể chuyển về trạng thái `SanSang`.
- *Phản hồi của nhóm:* Smart Contract hiện tại sử dụng nguyên tắc Checks-Effects-Interactions và tách bạch rõ ràng trạng thái. Nhóm sẽ cân nhắc chuyển sang mô hình **Pull over Push** (rút tiền chủ động) ở Lab 10: tiền hoàn lại sẽ được ghi nhận vào `soDuKhaDung[nguoiMuon]` để người mượn tự gọi hàm `rutTien()`, ngăn chặn hoàn toàn nguy cơ bị DoS.

### Phản biện 5: Tấn công Spam chiếm dụng thiết bị (Griefing Attack)
- *Lỗ hổng chỉ ra:* Một sinh viên có nhiều tiền ETH có thể mượn toàn bộ thiết bị trong kho và giữ mãi không trả (vì hệ thống hiện tại chưa tính phí thuê theo giờ/ngày), khiến các sinh viên khác không có thiết bị để thực hành.
- *Phản hồi của nhóm:* Nhóm bổ sung quy tắc kinh tế: Thiết lập giới hạn thời gian mượn tối đa (ví dụ: 7 ngày). Sau thời hạn này, mỗi ngày trễ hạn sẽ tự động trừ một tỷ lệ phạt cố định (ví dụ 500 bps/ngày) vào tiền cọc cho đến khi cọc về 0 thì thiết bị tự động bị niêm phong cảnh báo vi phạm.
