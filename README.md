# FHEVM Confidential Library

This repository provides reusable building blocks for developing Fully Homomorphic Encryption (FHE) enabled Solidity
smart contracts on top of the FHEVM protocol by Zama. It extends the original Hardhat template with production-focused
utilities, libraries, and accompanying test harnesses that can be composed to accelerate FHE contract development.

Key reusable components shipped in this repository:

- `contracts/BoundedRandomLib.sol`: helper routines for drawing encrypted random numbers within a bounded range.
- Additional libraries and utilities will be added over time as the collection of FHE building blocks grows.

## Quick Start

For the broader setup steps refer to the
[FHEVM Hardhat Quick Start Tutorial](https://docs.zama.ai/protocol/solidity-guides/getting-started/quick-start-tutorial).

## Prerequisites

- **Node.js**: Version 20 or higher
- **npm or yarn/pnpm**: Package manager

## 📜 Available Scripts

| Script             | Description              |
| ------------------ | ------------------------ |
| `npm install`      | Install dependencies     |
| `npm run compile`  | Compile all contracts    |
| `npm run test`     | Run all tests            |
| `npm run coverage` | Generate coverage report |
| `npm run lint`     | Run linting checks       |
| `npm run clean`    | Clean build artifacts    |
