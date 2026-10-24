// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

import "../contracts/project/ProjectCore.sol";

/// @title Ca kiem thu don vi hop dong ProjectCore (Lab 11 & Lab 13)
/// @notice Kiem thu cac quy tac kinh te: dat coc, tra dung han, tra tre han va kiem soat trang thai
contract ProjectCoreTest {
    ProjectCore public core;
    address payable public admin;

    event Log(string message, uint256 value);

    constructor() payable {
        admin = payable(address(this));
        // Khoi tao: Tien coc 0.05 ETH, thoi gian muon 3 ngay, phi phat 0.005 ETH/ngay
        core = new ProjectCore(0.05 ether, 3, 0.005 ether);
    }

    /// @notice Test Case 1: Kiem tra tham so khoi tao hop dong
    function testKhoiTaoHopDong() external view {
        require(core.owner() == address(this), "Owner phai la dia chi deploy");
        require(core.depositAmount() == 0.05 ether, "Tien coc phai la 0.05 ETH");
        require(core.penaltyPerDay() == 0.005 ether, "Phi phat phai la 0.005 ETH/ngay");
        require(uint8(core.state()) == uint8(ProjectCore.State.Created), "Trang thai phai la Created");
    }

    /// @notice Test Case 2: Tinh tien phat truoc han chot phai bang 0
    function testTinhPhatDungHan() external view {
        uint256 phat = core.calculatePenalty();
        require(phat == 0, "Chua het han hoac dung han thi tien phat phai bang 0");
    }

    /// @notice Test Case 3: Thao tac muon thiet bi kem dat coc ETH
    function testMuonThietBi() external {
        core.borrow{value: 0.05 ether}();
        require(core.borrower() == address(this), "Nguoi muon phai la dia chi goi");
        require(uint8(core.state()) == uint8(ProjectCore.State.Borrowed), "Trang thai phai la Borrowed");
        require(core.dueTime() > block.timestamp, "Han chot tra phai lon hon block.timestamp");
        emit Log("Test Case 3 Passed: Muon thiet bi thanh cong", core.depositAmount());
    }

    /// @notice Test Case 4: Nghiệm thu tra thiet bi va nhan lai tien coc
    function testTraThietBiDungHan() external {
        uint256 balanceBefore = address(this).balance;
        core.returnDevice();
        require(uint8(core.state()) == uint8(ProjectCore.State.Completed), "Trang thai phai la Completed");
        require(address(this).balance >= balanceBefore, "Phai nhan lai tien hoan coc");
        emit Log("Test Case 4 Passed: Hoan coc thanh cong", address(this).balance - balanceBefore);
    }

    /// @notice Test Case 5: Reset thiet bi de cho luot muon tiep theo
    function testResetThietBi() external {
        core.resetDevice();
        require(uint8(core.state()) == uint8(ProjectCore.State.Created), "Trang thai sau reset phai la Created");
        require(core.borrower() == address(0), "Borrower phai tro ve 0");
        require(core.dueTime() == 0, "DueTime phai tro ve 0");
    }

    /// @notice Nhan ETH hoan coc tu hop dong
    receive() external payable {}
}
