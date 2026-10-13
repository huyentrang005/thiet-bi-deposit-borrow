# SPEC — ĐẶT CỌC MƯỢN THIẾT BỊ

## 1. Mục đích

Hệ thống hỗ trợ sinh viên đặt cọc để mượn thiết bị và tự động
xử lý việc hoàn cọc hoặc khấu trừ tiền khi trả thiết bị trễ hạn.

## 2. Đầu vào

- Người mượn: địa chỉ ví của sinh viên.
- Thiết bị: mã hoặc tên thiết bị được mượn.
- Tiền đặt cọc: số tiền ETH người mượn phải gửi.
- Thời hạn trả: thời điểm người mượn phải trả thiết bị.
- Mức phạt: số ETH bị trừ cho mỗi ngày trả trễ.
- Thời điểm trả thực tế: thời điểm người mượn trả thiết bị.

## 3. Quy tắc nghiệp vụ

### R1 — Đặt cọc

Người mượn phải gửi đúng số tiền đặt cọc được yêu cầu.

Nếu số tiền gửi khác số tiền đặt cọc thì giao dịch phải bị từ chối.

### R2 — Khóa tiền đặt cọc

Sau khi đặt cọc thành công, Smart Contract phải giữ tiền
đặt cọc cho đến khi giao dịch được xử lý hoàn tất.

Người mượn không được tự ý rút tiền đặt cọc trong thời gian
mượn thiết bị.

### R3 — Trả đúng hạn

Nếu người mượn trả thiết bị trước hoặc đúng thời hạn thì:

- Không phát sinh tiền phạt.
- Người mượn được hoàn lại toàn bộ tiền đặt cọc.
- Giao dịch chuyển sang trạng thái hoàn tất.

### R4 — Trả trễ hạn

Nếu người mượn trả thiết bị sau thời hạn thì:

- Xác định số ngày trễ.
- Tính tiền phạt theo số ngày trễ.
- Khấu trừ tiền phạt từ tiền đặt cọc.
- Hoàn lại phần tiền đặt cọc còn lại cho người mượn.

### R5 — Giới hạn tiền phạt

Tiền phạt không được lớn hơn tiền đặt cọc.

Nếu tiền phạt tính được lớn hơn tiền đặt cọc thì tiền phạt
thực tế chỉ bằng tiền đặt cọc.

### R6 — Không hoàn cọc hai lần

Một giao dịch đã hoàn tất không được phép thực hiện thao tác
hoàn tiền lần thứ hai.

### R7 — Kiểm soát quyền

Chỉ tài khoản có quyền quản lý mới được tạo hoặc thay đổi
các thông tin quản lý của giao dịch.

Người mượn chỉ được thực hiện các thao tác thuộc quyền của mình.

## 4. Đầu ra

Hệ thống phải hiển thị:

- Trạng thái giao dịch mượn thiết bị.
- Số tiền đặt cọc.
- Thời hạn trả.
- Số ngày trả trễ nếu có.
- Tiền phạt nếu có.
- Số tiền được hoàn lại cho người mượn.

Sau khi giao dịch hoàn tất, Smart Contract phải xử lý tiền
đặt cọc theo đúng quy tắc đã xác định.

## 5. Trường hợp ngoại lệ

### E1 — Gửi sai tiền đặt cọc

Nếu người mượn gửi số tiền khác với số tiền đặt cọc yêu cầu,
Smart Contract phải từ chối giao dịch.

### E2 — Trả thiết bị trễ

Nếu thời điểm trả thực tế sau thời hạn trả, hệ thống phải tính
tiền phạt dựa trên số ngày trễ.

### E3 — Tiền phạt lớn hơn tiền đặt cọc

Nếu tiền phạt tính được lớn hơn tiền đặt cọc, hệ thống chỉ được
khấu trừ tối đa bằng số tiền đặt cọc.

### E4 — Hoàn tiền lần thứ hai

Nếu giao dịch đã hoàn tất mà có yêu cầu hoàn tiền lần nữa,
Smart Contract phải từ chối thao tác.

### E5 — Người không có quyền

Nếu tài khoản không có quyền quản lý cố gắng thay đổi thông tin
quản lý, thao tác phải bị từ chối.

## 6. Ngoài phạm vi

- Không quản lý thông tin cá nhân của sinh viên.
- Không quản lý tình trạng vật lý của thiết bị.
- Không xử lý việc sửa chữa hoặc bồi thường hư hỏng thiết bị.
- Không tích hợp hệ thống quản lý kho thiết bị thực tế.
- Không sử dụng tiền Việt Nam; các khoản tiền trong Smart Contract
  được tính bằng ETH.