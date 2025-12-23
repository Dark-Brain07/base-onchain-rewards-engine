# Architecture

This system separates concerns:

- PointsLedger → stores user points
- RewardsEngine → assigns rewards
- RewardVault → stores ETH incentives

This modular design allows easy upgrades.
