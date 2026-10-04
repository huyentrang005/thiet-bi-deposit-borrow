// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

contract AccessControlDemo {
    address public owner;
    string public systemStatus;

    event OwnerChanged(address indexed previousOwner, address indexed newOwner);
    event StatusUpdated(string newStatus, address updatedBy);

    modifier onlyOwner() {
        require(
            msg.sender == owner,
            "Lay chao! Chi Owner moi co quyen thuc hien."
        );
        _;
    }

    constructor() {
        owner = msg.sender;
        systemStatus = "Hoat dong binh thuong";
    }

    function setSystemStatus(string memory _newStatus) public onlyOwner {
        systemStatus = _newStatus;
        emit StatusUpdated(_newStatus, msg.sender);
    }

    function transferOwnership(address _newOwner) public onlyOwner {
        require(_newOwner != address(0), "Dia chi vi moi khong hop le!");
        emit OwnerChanged(owner, _newOwner);
        owner = _newOwner;
    }
}
