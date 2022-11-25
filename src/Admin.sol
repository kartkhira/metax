//SPDX-License-Identifier: MIT
pragma solidity 0.8.17;

abstract contract Admin {
    mapping(address => bool) public admins;

    error NotAdmin(address);
    error ZeroAddress(address);

    event NewAdminAdded(address);
    event AdminRemoved(address);

    modifier onlyAdmin() {
        if (!admins[msg.sender]) revert NotAdmin(msg.sender);
        _;
    }

    constructor() {
        admins[msg.sender] = true;
    }

    function setAdmin(address _newAdmin) public onlyAdmin {
        if (_newAdmin == address(0)) revert ZeroAddress(msg.sender);

        admins[_newAdmin] = true;
        emit NewAdminAdded(_newAdmin);
    }

    function removeAdmin(address _addr) public onlyAdmin {
        if (_addr == address(0)) revert ZeroAddress(msg.sender);

        admins[_addr] = false;
        emit AdminRemoved(_addr);
    }
}
