# Architecture

This system separates concerns:

- PointsLedger → stores user points
- RewardsEngine → assigns rewards
- RewardVault → stores ETH incentives

This modular design allows easy upgrades.

## Leaderboard Integration

The Leaderboard contract reads user points directly from PointsLedger.
This avoids duplicated storage and keeps rankings consistent.

Only an authorized updater triggers leaderboard refreshes.
