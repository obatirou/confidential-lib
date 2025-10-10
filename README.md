# FHEVM Confidential Library

Building blocks for developing Fully Homomorphic Encryption (FHE) enabled Solidity smart contracts on top of the Fhevm.

## Contracts

```ml
contracts
├── BoundedRandomLib.sol
├── LibSort.sol
├── SafeCastLib.sol
```

- `BoundedRandomLib.sol`: helpers that produce encrypted random numbers constrained to a `[min, max]` range.
- `LibSort.sol`: comparator routines that order encrypted integers across multiple bit widths.
- `SafeCastLib.sol`: FHE casting helpers with overflow guards.

## Prerequisites

- **Node.js**: Version 20 or higher
- **npm or yarn/pnpm**: Package manager

| Script             | Description              |
| ------------------ | ------------------------ |
| `npm install`      | Install dependencies     |
| `npm run compile`  | Compile all contracts    |
| `npm run test`     | Run all tests            |
| `npm run coverage` | Generate coverage report |
| `npm run lint`     | Run linting checks       |
| `npm run clean`    | Clean build artifacts    |
