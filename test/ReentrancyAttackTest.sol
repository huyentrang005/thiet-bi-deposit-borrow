// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

import "../contracts/project/ProjectCore.sol";

/// @dev Hop dong gia lap ke tan cong co tinh goi lai reentrancy
contract MaliciousBorrower {
    ProjectCore public target;
    uint256 public attackCount;

    constructor(address payable _target) payable {
        target = ProjectCore(_target);
    }

    function borrowDevice() external payable {
        target.borrow{value: msg.value}();
    }

    /// @notice Khi nhan duoc hoan coc, ke tan cong lap tuc goi lai de rut tien tiep
    receive() external payable {
        attackCount++;
        if (attackCount < 5) {
            // Co tinh goi lai: se bi chan do state da duoc cap nhat sang Completed truoc do
            try target.returnDevice() {} catch {}
        }
    }
}

/// @title Kiem thu chong tan cong Reentrancy tren hop dong ProjectCore
contract ReentrancyAttackTest {
    ProjectCore public core;
    MaliciousBorrower public attacker;

    event AttackResult(string result, uint256 attackAttempts);

    constructor() payable {
        // Khoi tao ProjectCore voi tien coc 0.1 ETH
        core = new ProjectCore(0.1 ether, 7, 0.01 ether);
        attacker = new MaliciousBorrower(payable(address(core)));
    }

    /// @notice Kiem tra hop dong an toan truoc cuoc tan cong goi lai
    function testReentrancyDefense() external payable {
        // Ke tan cong muon thiet bi
        attacker.borrowDevice{value: 0.1 ether}();
        require(uint8(core.state()) == uint8(ProjectCore.State.Borrowed), "Da muon thiet bi");

        // Admin nghiem thu tra thiet bi, kich hoat ham receive() cua ke tan cong
        core.returnDevice();

        // Kiem tra trang thai sau khi tra: chi duoc hoan dung 1 lan duy nhat
        require(uint8(core.state()) == uint8(ProjectCore.State.Completed), "Trang thai hoan tat hop le");
        require(address(core).balance == 0, "So du hop dong ProjectCore da duoc xu ly sach");

        emit AttackResult("Bao ve thanh cong: Logic CEI da ngan chan cuoc tan cong Reentrancy", attacker.attackCount());
    }

    receive() external payable {}
}
