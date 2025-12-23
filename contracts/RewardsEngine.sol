// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

interface IPointsLedger {
    function addPoints(address user, uint256 amount) external;
}

/// @title Rewards Engine
/// @notice Assigns rewards for actions
contract RewardsEngine {
    address public owner;
    IPointsLedger public ledger;

    modifier onlyOwner() {
        require(msg.sender == owner, "Not owner");
        _;
    }

    constructor(address _ledger) {
        owner = msg.sender;
        ledger = IPointsLedger(_ledger);
    }

    function rewardUser(address user, uint256 points) external onlyOwner {
        ledger.addPoints(user, points);
    }
}
