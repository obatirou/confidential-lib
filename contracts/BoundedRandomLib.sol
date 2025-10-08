// SPDX-License-Identifier: MIT
pragma solidity ^0.8.24;

import {FHE, euint128, euint64, euint32, euint16, euint8} from "@fhevm/solidity/lib/FHE.sol";

/// @title BoundedRandomLib
/// @notice Utility helpers to draw encrypted random numbers within an inclusive range on top of the
///         FHEVM random primitives.
///
/// FHEVM exposes `randEuint*` helpers that accept an upper bound and return random values in the
/// `[0, upperBound)` interval. This library shifts the distribution so callers can request numbers in
/// a `[min, max]` range without rewriting the same boilerplate for every encrypted integer size.
///
/// @dev The functions revert with `BoundedRandom_InvalidRange` when `max < min`. When the range spans
///      the full domain of the type (e.g., `min = 0`, `max = 255` for uint8), the arithmetic
///      `max - min + 1` produces `256` (i.e., `2^8`). The FHE runtime accepts this power-of-two
///      upper bound, ensuring `FHE.randEuint8(256)` correctly returns values in `[0, 255]`.
///      The same applies for uint16 (2^16 = 65536), uint32 (2^32), etc.
///
/// NOTE: `euint256` is intentionally omitted because the current FHE library does not expose an
/// addition helper for that type.
library BoundedRandomLib {
    /// @dev Emitted when `min` is greater than `max`.
    error BoundedRandom_InvalidRange();

    /// @notice Returns a random encrypted uint8 uniformly distributed in `[min, max]`.
    /// @param min Lower bound of the range (inclusive).
    /// @param max Upper bound of the range (inclusive).
    /// @return Encrypted random value within the requested range.
    function boundedRandomEuint8(uint8 min, uint8 max) internal returns (euint8) {
        if (max < min) {
            revert BoundedRandom_InvalidRange();
        }
        euint8 minEncrypted = FHE.asEuint8(min);
        euint8 randomEncrypted = FHE.randEuint8(max - min + 1);
        return FHE.add(randomEncrypted, minEncrypted);
    }

    /// @notice Returns a random encrypted uint16 uniformly distributed in `[min, max]`.
    /// @param min Lower bound of the range (inclusive).
    /// @param max Upper bound of the range (inclusive).
    /// @return Encrypted random value within the requested range.
    function boundedRandomEuint16(uint16 min, uint16 max) internal returns (euint16) {
        if (max < min) {
            revert BoundedRandom_InvalidRange();
        }
        euint16 minEncrypted = FHE.asEuint16(min);
        euint16 randomEncrypted = FHE.randEuint16(max - min + 1);
        return FHE.add(randomEncrypted, minEncrypted);
    }

    /// @notice Returns a random encrypted uint32 uniformly distributed in `[min, max]`.
    /// @param min Lower bound of the range (inclusive).
    /// @param max Upper bound of the range (inclusive).
    /// @return Encrypted random value within the requested range.
    function boundedRandomEuint32(uint32 min, uint32 max) internal returns (euint32) {
        if (max < min) {
            revert BoundedRandom_InvalidRange();
        }
        euint32 minEncrypted = FHE.asEuint32(min);
        euint32 randomEncrypted = FHE.randEuint32(max - min + 1);
        return FHE.add(randomEncrypted, minEncrypted);
    }

    /// @notice Returns a random encrypted uint64 uniformly distributed in `[min, max]`.
    /// @param min Lower bound of the range (inclusive).
    /// @param max Upper bound of the range (inclusive).
    /// @return Encrypted random value within the requested range.
    function boundedRandomEuint64(uint64 min, uint64 max) internal returns (euint64) {
        if (max < min) {
            revert BoundedRandom_InvalidRange();
        }
        euint64 minEncrypted = FHE.asEuint64(min);
        euint64 randomEncrypted = FHE.randEuint64(max - min + 1);
        return FHE.add(randomEncrypted, minEncrypted);
    }

    /// @notice Returns a random encrypted uint128 uniformly distributed in `[min, max]`.
    /// @param min Lower bound of the range (inclusive).
    /// @param max Upper bound of the range (inclusive).
    /// @return Encrypted random value within the requested range.
    function boundedRandomEuint128(uint128 min, uint128 max) internal returns (euint128) {
        if (max < min) {
            revert BoundedRandom_InvalidRange();
        }
        euint128 minEncrypted = FHE.asEuint128(min);
        euint128 randomEncrypted = FHE.randEuint128(max - min + 1);
        return FHE.add(randomEncrypted, minEncrypted);
    }
}
