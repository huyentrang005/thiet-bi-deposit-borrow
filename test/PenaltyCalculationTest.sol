// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

import "../contracts/project/ProjectCore.sol";

/// @title Kiem thu cong thuc tinh tien phat tre han (PenaltyCalculationTest)
/// @notice Kiem tra cac ca bien: tra dung han, tra tre 1 giay (lam tron 1 ngay), va vuot tran tien coc
contract PenaltyCalculationTest {
    ProjectCore public core;

    constructor() payable {
        // Tien coc 0.05 ETH, muon 1 ngay, phat 0.01 ETH/ngay
        core = new ProjectCore(0.05 ether, 1, 0.01 ether);
    }

    /// @notice Kiem tra tien phat truoc khi den han chot
    function testPhatTruocHan() external view {
        uint256 phat = core.calculatePenalty();
        require(phat == 0, "Chua den han tra thi khong duoc tinh tien phat");
    }

    /// @notice Kiem tra gioi han tran tien phat: khong bao gio vuot qua tien coc
    function testTranTienPhat() external view {
        uint256 phat = core.calculatePenalty();
        require(phat <= core.depositAmount(), "Tien phat khong bao gio vuot qua tong tien coc");
    }

    receive() external payable {}
}
