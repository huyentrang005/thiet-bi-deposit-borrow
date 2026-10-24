// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

import "../contracts/QuanLyThietBi.sol";
import "../contracts/project/ProjectCore.sol";

/// @dev Gia lap tai khoan khong co quyen Admin
contract UnauthorizedUser {
    function tryThemThietBi(address target) external returns (bool success) {
        (success, ) = target.call(
            abi.encodeWithSignature("themThietBi(string,uint256)", "Thiet Bi Gia Mao", 0.1 ether)
        );
    }

    function tryReturnDevice(address target) external returns (bool success) {
        (success, ) = target.call(abi.encodeWithSignature("returnDevice()"));
    }
}

/// @title Kiem thu phan quyen truy cap Admin (AccessControlTest)
contract AccessControlTest {
    QuanLyThietBi public ql;
    ProjectCore public core;
    UnauthorizedUser public attacker;

    constructor() payable {
        ql = new QuanLyThietBi();
        core = new ProjectCore(0.05 ether, 3, 0.005 ether);
        attacker = new UnauthorizedUser();
    }

    /// @notice Kiem tra tai khoan la khong the them thiet bi vao kho
    function testBlockUnauthorizedThemThietBi() external {
        bool ok = attacker.tryThemThietBi(address(ql));
        require(!ok, "Nguoi dung khong phai Owner phai bi chan khi them thiet bi");
    }

    /// @notice Kiem tra tai khoan la khong the tu goi hoan cọc
    function testBlockUnauthorizedReturnDevice() external {
        bool ok = attacker.tryReturnDevice(address(core));
        require(!ok, "Nguoi dung khong phai Owner phai bi chan khi goi returnDevice");
    }

    receive() external payable {}
}
