# QUY TẮC KINH TẾ VÀ QUẢN TRỊ DÒNG TIỀN (ECONOMIC_RULES.md)

Hệ thống Ký Quỹ Đặt Cọc Mượn Trả Thiết Bị (SmartRent - Chủ đề 2)

---

## 1. Dòng tiền và Quyền lợi các bên

- **Người mượn (Sinh viên):**
  - Nộp tiền đặt cọc bằng Native ETH vào hợp đồng khi bắt đầu mượn.
  - Được hoàn trả 100% tiền cọc nếu thiết bị được hoàn trả đúng hạn và còn nguyên vẹn.
  - Nếu trả trễ hạn, tiền phạt được tính theo công thức: $\text{Tiền phạt} = \text{Số ngày trễ} \times \text{Mức phạt mỗi ngày}$.
  - Nhận lại phần tiền cọc còn lại sau khi khấu trừ tiền phạt/hư hại: $\text{Tiền hoàn lại} = \text{Tiền cọc} - \text{Tiền phạt} - \text{Phí hao mòn}$.
- **Bên cho mượn (Ban quản lý Lab / Chủ sở hữu):**
  - Không được quyền rút hoặc chiếm dụng tiền cọc của sinh viên trong thời gian hợp đồng đang ở trạng thái `Borrowed`.
  - Được nhận phần tiền phạt/khấu trừ bồi thường chuyển thẳng vào ví Quản trị viên (`owner`) khi nghiệm thu thiết bị hỏng hoặc trễ hạn.

---

## 2. Bảng Mô Phỏng Kịch Bản Dòng Tiền Thực Tế

| Kịch bản | Tiền cọc ban đầu | Tình trạng trả thiết bị | Tiền phạt trễ | Khấu trừ hao mòn | Sinh viên nhận lại | Quỹ CLB thu |
| :--- | :---: | :--- | :---: | :---: | :---: | :---: |
| **1. Chuẩn mẫu** | 0.050 ETH | Đúng hạn (0 ngày), nguyên vẹn | 0 ETH | 0 ETH (0%) | **0.050 ETH** (100%) | 0 ETH |
| **2. Trễ hạn nhẹ** | 0.050 ETH | Trễ 2 ngày (0.005 ETH/ngày) | 0.010 ETH | 0 ETH (0%) | **0.040 ETH** (80%) | 0.010 ETH |
| **3. Hao mòn nhẹ** | 0.050 ETH | Đúng hạn, trầy xước vỏ ngoài | 0 ETH | 0.010 ETH (20%) | **0.040 ETH** (80%) | 0.010 ETH |
| **4. Trễ + Hư hại** | 0.050 ETH | Trễ 3 ngày + bể màn hình (40%)| 0.015 ETH | 0.020 ETH (40%) | **0.015 ETH** (30%) | 0.035 ETH |
| **5. Vi phạm tối đa** | 0.050 ETH | Quá hạn > 14 ngày hoặc làm mất | 0.050 ETH | Không tính thêm | **0 ETH** (0%) | **0.050 ETH** (100%) |

---

## 3. Giới hạn chống lạm dụng

1. **Khóa cọc bất khả xâm phạm:** Không ai (kể cả Owner) có thể rút tiền cọc khi giao dịch đang diễn ra. Tiền chỉ thoát khỏi hợp đồng tại thời điểm nghiệm thu trả thiết bị.
2. **Khống chế trần tiền phạt:** Tổng số tiền phạt và khấu trừ hư hại tối đa bằng 100% tiền cọc đã đóng (`actualPenalty <= depositAmount`). Tiền phạt không bao giờ vượt quá tiền cọc khiến số dư bị âm.
3. **Mỗi thiết bị một người mượn:** Máy trạng thái (`State`) đảm bảo một thiết bị chỉ có thể được mượn bởi một người tại một thời điểm, loại bỏ việc ghi đè hoặc mượn trùng lặp.
4. **Quyền quản trị tối thiểu:** Quyền của Owner chỉ giới hạn ở việc thêm thiết bị, nghiệm thu hoàn cọc và bảo trì; không có quyền can thiệp vào ví sinh viên.

---

## 4. Năm phản biện rủi ro và cách khắc phục (Bước 4 Lab 8)

### Phản biện 1: Tranh chấp mức độ hư hỏng thiết bị
- *Lỗ hổng chỉ ra:* Chủ sở hữu có thể cố tình báo thiết bị hỏng nặng để khấu trừ tối đa 100% tiền cọc của sinh viên nhằm chiếm đoạt tài sản.
- *Phản hồi của nhóm:* Nhóm ghi nhận rủi ro này. Trong phiên bản hiện tại, để đơn giản hóa luồng demo, hệ thống dựa trên sự thỏa thuận trực tiếp khi bàn giao tại bàn thủ kho. Ở phiên bản mở rộng (Mức B), nhóm sẽ bổ sung cơ chế trọng tài bên thứ ba (Arbitrator) hoặc yêu cầu chữ ký xác nhận kép từ cả hai phía.

### Phản biện 2: Người mượn cố tình không trả thiết bị
- *Lỗ hổng chỉ ra:* Giá trị tiền cọc thấp hơn giá trị thị trường của thiết bị, sinh viên có thể ôm thiết bị bỏ trốn và chấp nhận mất cọc.
- *Phản hồi của nhóm:* Ban quản lý quy định mức tiền cọc phải tương đương tối thiểu 80% – 100% giá trị thực tế của thiết bị đối với các tài sản giá trị cao (máy ảnh, laptop), kết hợp chế tài xử lý học vụ của nhà trường nếu quá hạn 14 ngày.

### Phản biện 3: Biến động giá ETH
- *Lỗ hổng chỉ ra:* Giá ETH biến động mạnh. Sinh viên đặt cọc lúc ETH giá cao, khi nhận lại tiền cọc giá trị quy đổi sang VNĐ có thể bị sụt giảm.
- *Phản hồi của nhóm:* Nhóm định hướng nâng cấp sử dụng stablecoin (USDC/USDT) ở phiên bản tương lai để giữ nguyên giá trị kinh tế thực tế.

### Phản biện 4: Tấn công Reentrancy khi hoàn cọc
- *Lỗ hổng chỉ ra:* Kẻ xấu sử dụng hợp đồng thông minh độc hại để mượn thiết bị, sau đó tấn công gọi lại (reentrancy) khi nhận hoàn cọc để rút cạn ETH trong kho.
- *Phản hồi của nhóm:* Hợp đồng tuân thủ nghiêm ngặt nguyên tắc **Checks-Effects-Interactions (CEI)**: trạng thái `state = State.Completed` được ghi nhận trước khi lệnh chuyển tiền `call{value}` được kích hoạt.

### Phản biện 5: Tấn công chiếm dụng thiết bị (Griefing Attack)
- *Lỗ hổng chỉ ra:* Một người mượn thiết bị và giữ mãi không trả nếu không có chế tài theo thời gian.
- *Phản hồi của nhóm:* Hợp đồng tự động áp dụng mức phạt lũy tiến theo số ngày trễ hạn `penaltyPerDay`. Càng giữ lâu thì số tiền cọc được hoàn lại càng giảm dần về 0.
