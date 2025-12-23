// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

/// @title Points Ledger
/// @notice Non-transferable points system
contract PointsLedger {
    address public admin;

    mapping(address => uint256) public points;

    event PointsAdded(address indexed user, uint256 amount);

    modifier onlyAdmin() {
        require(msg.sender == admin, "Not admin");
        _;
    }

    constructor() {
        admin = msg.sender;
    }

    function addPoints(address user, uint256 amount) external onlyAdmin {
        points[user] += amount;
        emit PointsAdded(user, amount);
    }
}
