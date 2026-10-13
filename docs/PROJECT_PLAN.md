# PROJECT PLAN — ĐẶT CỌC MƯỢN THIẾT BỊ

## 1. Tên đề tài

Đặt cọc mượn thiết bị

## 2. Mục tiêu

Xây dựng một DApp sử dụng Smart Contract để quản lý tiền đặt
cọc khi mượn thiết bị.

Hệ thống hỗ trợ:

- Người mượn gửi tiền đặt cọc.
- Smart Contract khóa tiền đặt cọc trong thời gian mượn.
- Người mượn trả thiết bị đúng hạn hoặc trễ hạn.
- Trả đúng hạn: hoàn lại toàn bộ tiền đặt cọc.
- Trả trễ: tính tiền phạt theo số ngày trễ và khấu trừ vào tiền
  đặt cọc.
- Hoàn lại phần tiền đặt cọc còn lại cho người mượn.

## 3. Người dùng

### Người mượn

- Nhận thiết bị.
- Gửi tiền đặt cọc.
- Trả thiết bị.
- Nhận lại tiền đặt cọc hoặc phần tiền còn lại sau khi trừ phạt.

### Người quản lý thiết bị

- Tạo giao dịch mượn thiết bị.
- Thiết lập số tiền đặt cọc.
- Thiết lập thời hạn trả.
- Thiết lập mức phạt mỗi ngày trễ.
- Xác nhận việc trả thiết bị.

## 4. Luồng nghiệp vụ chính

Tạo giao dịch
→ Người mượn gửi tiền đặt cọc
→ Smart Contract khóa tiền
→ Người mượn sử dụng thiết bị
→ Trả thiết bị
→ Kiểm tra thời hạn
→ Trả đúng hạn: hoàn toàn bộ tiền cọc
→ Trả trễ: tính phạt và hoàn phần tiền còn lại.

## 5. Các quy tắc chính

1. Người mượn phải gửi đúng số tiền đặt cọc được yêu cầu.

2. Tiền đặt cọc được giữ trong Smart Contract trong thời gian
   giao dịch đang hoạt động.

3. Nếu trả thiết bị đúng hạn, người mượn được hoàn lại toàn bộ
   tiền đặt cọc.

4. Nếu trả thiết bị trễ, tiền phạt được tính theo số ngày trễ.

5. Tiền phạt không được vượt quá số tiền đặt cọc.

6. Một giao dịch không được hoàn tiền hai lần.

7. Các thao tác quản trị chỉ được thực hiện bởi tài khoản có
   quyền.

## 6. Quy tắc tính tiền phạt

Tiền phạt = Số ngày trễ × Mức phạt mỗi ngày.

Nếu tiền phạt tính được lớn hơn tiền đặt cọc thì tiền phạt tối đa
bằng tiền đặt cọc.

Ví dụ:

- Tiền đặt cọc: 0.01 ETH
- Mức phạt: 0.001 ETH/ngày
- Trễ 2 ngày

Tiền phạt = 2 × 0.001 = 0.002 ETH

Tiền được hoàn lại:

0.01 - 0.002 = 0.008 ETH

## 7. Kế hoạch thực hiện

### Lab 8
- Xác định người dùng và vấn đề.
- Đặc tả nghiệp vụ.
- Xác định quy tắc kinh tế.
- Phân tích các trường hợp lạm dụng.

### Lab 9
- Xây dựng Smart Contract lõi.
- Cài đặt luồng đặt cọc.
- Cài đặt luồng hoàn cọc.
- Cài đặt tính phạt khi trả trễ.

### Lab 10
- Audit Smart Contract.
- Tìm và sửa các lỗi.
- Ghi lại bằng chứng kiểm chứng.

### Lab 11
- Viết và chạy các test case.
- Kiểm thử các quy tắc kinh tế.
- Kiểm thử trường hợp trả đúng hạn và trả trễ.

### Lab 12
- Gate Review.
- Kiểm tra mức độ hoàn thiện của dự án.

### Lab 13
- Kiểm thử các tình huống gian lận và tấn công.

### Lab 14
- Audit chéo.
- Rà soát lại Smart Contract.

### Lab 15
- Hoàn thiện DApp.
- Chuẩn bị demo và báo cáo.