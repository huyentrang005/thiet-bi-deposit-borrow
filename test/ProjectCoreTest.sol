// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

import "../contracts/project/ProjectCore.sol";

/// @title Ca kiem thu don vi hop dong ProjectCore
/// @notice Kiem thu cac quy tac kinh te: dat coc, tra dung han, tra tre han, khau tru hao mon va chong gian lan
contract ProjectCoreTest {
    ProjectCore public core;
    address payable public admin;
    address payable public sinhVien1;

    event Log(string message, uint256 value);

    constructor() payable {
        admin = payable(address(this));
        sinhVien1 = payable(address(0x1111111111111111111111111111111111111111));
        core = new ProjectCore();
    }

    /// @notice Test Case 1: Admin them thiet bi thanh cong
    function testThemThietBi() external {
        // Tien coc 0.05 ETH, muon toi da 3 ngay (259200s), phi phat tre 0.005 ETH/ngay
        core.themThietBi("May chieu Sony HD", 0.05 ether, 259200, 0.005 ether);
        (uint256 id, string memory ten, uint256 tienCoc,,,,,,) = core.danhSachThietBi(1);
        require(id == 1, "ID thiet bi phai la 1");
        require(tienCoc == 0.05 ether, "Tien coc phai la 0.05 ETH");
        emit Log("Test Case 1 Passed: Them thiet bi thanh cong", id);
    }

    /// @notice Test Case 2: Tinh tien phat dung han = 0
    function testTinhPhatDungHan() external view {
        uint256 phat = core.tinhTienPhat(1, block.timestamp);
        require(phat == 0, "Dung han thi tien phat phai bang 0");
    }

    /// @notice Test Case 3: Nhan ETH de test hoan coc
    receive() external payable {}
}
