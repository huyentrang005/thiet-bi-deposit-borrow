// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

/// @title Dat coc muon thiet bi CLB - Tinh tien phat theo so ngay tre (Chu de 2 - ECO2432)
/// @notice Da duoc audit va va loi o Lab 10, do dai duoi 150 dong theo quy dinh Bo loc pham vi
contract ProjectCore {
    enum State { Created, Borrowed, Completed }

    address public owner;              // Ban chu nhiem CLB quan ly thiet bi
    address public borrower;           // Nguoi muon thiet bi
    uint256 public depositAmount;       // Tien coc yeu cau (wei)
    uint256 public borrowDuration;      // Thoi gian cho phep muon (giay)
    uint256 public penaltyPerDay;       // Muc phat moi ngay tre han (wei/ngay)
    uint256 public dueTime;             // Han chot phai tra thiet bi
    State public state;                 // May trang thai

    // Cac su kien ghi nhan thay doi trang thai tren blockchain
    event Borrowed(address indexed borrower, uint256 deposit, uint256 dueTime);
    event Returned(address indexed borrower, uint256 refundAmount, uint256 penaltyAmount);
    event DeviceReset();

    // Cac custom error tiet kiem gas
    error NotOwner();
    error NotBorrower();
    error WrongState();
    error WrongDepositAmount();
    error TransferFailed();
    error InvalidParameters();

    modifier onlyOwner() {
        if (msg.sender != owner) revert NotOwner();
        _;
    }

    modifier inState(State _state) {
        if (state != _state) revert WrongState();
        _;
    }

    constructor(
        uint256 _depositAmount,
        uint256 _borrowDurationDays,
        uint256 _penaltyPerDay
    ) {
        if (_depositAmount == 0 || _borrowDurationDays == 0 || _penaltyPerDay > _depositAmount) {
            revert InvalidParameters();
        }
        owner = msg.sender;
        depositAmount = _depositAmount;
        borrowDuration = _borrowDurationDays * 1 days;
        penaltyPerDay = _penaltyPerDay;
        state = State.Created;
    }

    /// @notice Nguoi muon nop du tien coc de nhan thiet bi
    function borrow() external payable inState(State.Created) {
        if (msg.value != depositAmount) revert WrongDepositAmount();

        borrower = msg.sender;
        dueTime = block.timestamp + borrowDuration;
        state = State.Borrowed;

        emit Borrowed(msg.sender, msg.value, dueTime);
    }

    /// @notice CLB xac nhan nhan lai thiet bi va hoan coc (co tru tien phat neu tre han)
    function returnDevice() external onlyOwner inState(State.Borrowed) {
        uint256 penalty = calculatePenalty();
        uint256 refund = depositAmount > penalty ? depositAmount - penalty : 0;
        uint256 actualPenalty = depositAmount - refund;

        // Checks - Effects - Interactions: Cap nhat trang thai truoc khi chuyen tien
        state = State.Completed;

        emit Returned(borrower, refund, actualPenalty);

        // Chuyen tien hoan lai cho nguoi muon
        if (refund > 0) {
            (bool okRefund, ) = payable(borrower).call{value: refund}("");
            if (!okRefund) revert TransferFailed();
        }

        // Chuyen tien phat vao quy CLB (owner)
        if (actualPenalty > 0) {
            (bool okPenalty, ) = payable(owner).call{value: actualPenalty}("");
            if (!okPenalty) revert TransferFailed();
        }
    }

    /// @notice Tinh tien phat dua tren so ngay tre han thuc te
    function calculatePenalty() public view returns (uint256) {
        if (block.timestamp <= dueTime) {
            return 0; // Tra dung han hoac som hon thi khong bi phat
        }
        uint256 overdueSeconds = block.timestamp - dueTime;
        // Lam tron len: tre trong vong 1 ngay van tinh 1 ngay phat
        uint256 overdueDays = (overdueSeconds + 1 days - 1) / 1 days;
        uint256 totalPenalty = overdueDays * penaltyPerDay;

        // Tien phat khong duoc vuot qua tong tien coc da dong
        return totalPenalty > depositAmount ? depositAmount : totalPenalty;
    }

    /// @notice Dat lai trang thai de cho sinh vien tiep theo muon (Sua loi o Lab 10)
    function resetDevice() external onlyOwner inState(State.Completed) {
        state = State.Created;
        borrower = address(0);
        dueTime = 0;
        emit DeviceReset();
    }

    /// @notice Kiem tra thoi gian con lai truoc khi het han
    function timeLeft() external view returns (uint256) {
        if (block.timestamp >= dueTime) return 0;
        return dueTime - block.timestamp;
    }
}
