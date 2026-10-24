# Hướng Dẫn Triển Khai Smart Contract Lên Sepolia (DEPLOYMENT_GUIDE.md)

Hệ thống **SmartRent** được thiết kế để triển khai trên mạng thử nghiệm **Ethereum Sepolia Testnet**.

---

## 1. Chuẩn bị môi trường & Tài nguyên

1. **Ví Web3:** Cài đặt tiện ích mở rộng **MetaMask** trên trình duyệt (Chrome, Brave, Edge).
2. **Mạng mạng:** Chuyển ví sang **Sepolia Testnet** (Chain ID: `11155111`).
3. **ETH Testnet:** Nhận Sepolia ETH miễn phí từ các vòi (faucets):
   - [Google Cloud Sepolia Faucet](https://cloud.google.com/application/web3/faucet/ethereum/sepolia)
   - [Alchemy Sepolia Faucet](https://sepoliafaucet.com/)
   - [Infura Sepolia Faucet](https://www.infura.io/faucet/sepolia)

---

## 2. Triển khai qua Remix IDE (Cách 1 - Trực quan)

1. Mở trình duyệt và truy cập [Remix IDE](https://remix.ethereum.org/).
2. Tạo thư mục `contracts/` và tải lên hai tệp:
   - `contracts/QuanLyThietBi.sol`
   - `contracts/project/ProjectCore.sol`
3. Tại tab **Solidity Compiler**:
   - Chọn Compiler version: `0.8.20`.
   - Bật Enable optimization (200 runs).
   - Nhấn **Compile QuanLyThietBi.sol**.
4. Tại tab **Deploy & Run Transactions**:
   - Environment: Chọn **Injected Provider - MetaMask**.
   - Xác nhận ví MetaMask đã kết nối đúng mạng Sepolia.
   - Nhấn **Deploy**.
   - Ký xác nhận giao dịch trên cửa sổ MetaMask.
5. Sao chép địa chỉ hợp đồng đã deploy (ví dụ: `0xC61d78A92B7Dfdf85fAB1c22135977721dd96F4c`).

---

## 3. Triển khai qua Hardhat (Cách 2 - Tự động hóa)

```bash
# Cài đặt các gói phụ thuộc
npm install

# Biên dịch hợp đồng
npx hardhat compile

# Triển khai lên Sepolia
npx hardhat run scripts/deploy.js --network sepolia
```

---

## 4. Xác thực Hợp đồng (Contract Verification)

Sau khi deploy thành công, xác thực mã nguồn trên trình duyệt khối:
- **Etherscan Sepolia:** `https://sepolia.etherscan.io/address/<CONTRACT_ADDRESS>`
- **Blockscout:** `https://eth-sepolia.blockscout.com/address/<CONTRACT_ADDRESS>`

---

## 5. Cập nhật Địa chỉ vào Giao diện DApp

Mở tệp `web/index.html` và cập nhật hằng số `DEFAULT_CONTRACT_ADDRESS`:
```javascript
const DEFAULT_CONTRACT_ADDRESS = "0xC61d78A92B7Dfdf85fAB1c22135977721dd96F4c";
```
