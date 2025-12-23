// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

interface IPointsLedgerView {
    function points(address user) external view returns (uint256);
}

/// @title Leaderboard
/// @notice Ranks users by points from PointsLedger
contract Leaderboard {
    address public owner;
    IPointsLedgerView public ledger;

    uint256 public constant MAX_LEADERS = 10;

    struct Entry {
        address user;
        uint256 points;
    }

    Entry[] public leaders;

    modifier onlyOwner() {
        require(msg.sender == owner, "Not owner");
        _;
    }

    constructor(address _ledger) {
        owner = msg.sender;
        ledger = IPointsLedgerView(_ledger);
    }

    /// @notice Update leaderboard for a user
    function update(address user) external onlyOwner {
        uint256 userPoints = ledger.points(user);
        _update(user, userPoints);
    }

    function _update(address user, uint256 pts) internal {
        uint256 len = leaders.length;

        for (uint256 i = 0; i < len; i++) {
            if (leaders[i].user == user) {
                leaders[i].points = pts;
                _sort();
                return;
            }
        }

        if (len < MAX_LEADERS) {
            leaders.push(Entry(user, pts));
            _sort();
            return;
        }

        if (pts > leaders[len - 1].points) {
            leaders[len - 1] = Entry(user, pts);
            _sort();
        }
    }

    function _sort() internal {
        uint256 len = leaders.length;
        for (uint256 i = 0; i < len; i++) {
            for (uint256 j = i + 1; j < len; j++) {
                if (leaders[j].points > leaders[i].points) {
                    Entry memory temp = leaders[i];
                    leaders[i] = leaders[j];
                    leaders[j] = temp;
                }
            }
        }
    }

    function getLeaders() external view returns (Entry[] memory) {
        return leaders;
    }
}
