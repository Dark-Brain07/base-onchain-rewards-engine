// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

/// @title Reward Vault
/// @notice Stores ETH rewards for campaigns
contract RewardVault {
    address public owner;

    constructor() {
        owner = msg.sender;
    }

    receive() external payable {}

    function withdraw(address to, uint256 amount) external {
        require(msg.sender == owner, "Not owner");
        payable(to).transfer(amount);
    }
}
