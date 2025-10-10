// SPDX-License-Identifier: MIT
pragma solidity ^0.8.24;

import {FHE, ebool, euint256, euint128, euint64, euint32, euint16, euint8} from "@fhevm/solidity/lib/FHE.sol";

/// @title SafeCastLib
/// @notice Downcasting helpers for encrypted unsigned integers.
/// @dev Each helper returns both the downcast value and an encrypted overflow flag. Callers can branch
///      or mask results using the overflow handle without ever decrypting the sensitive value.
/// @author Adapted from Solady (https://github.com/vectorized/solady/blob/main/src/utils/FixedPointMathLib.sol)
library SafeCastLib {
    /// @notice Downcasts an euint256 to euint128 and indicates whether truncation occurred.
    /// @param value Encrypted 256-bit unsigned integer.
    /// @return result The value cast down to 128 bits.
    /// @return overflow Encrypted flag set when the original value exceeds 128 bits.
    function toEuint128(euint256 value) internal returns (euint128 result, ebool overflow) {
        result = FHE.asEuint128(value);
        overflow = FHE.ne(value, FHE.asEuint256(result));
    }

    /// @notice Downcasts an euint128 to euint64 and indicates whether truncation occurred.
    /// @param value Encrypted 128-bit unsigned integer.
    /// @return result The value cast down to 64 bits.
    /// @return overflow Encrypted flag set when the original value exceeds 64 bits.
    function toEuint64(euint128 value) internal returns (euint64 result, ebool overflow) {
        result = FHE.asEuint64(value);
        overflow = FHE.ne(value, FHE.asEuint128(result));
    }

    /// @notice Downcasts an euint256 to euint64 and indicates whether truncation occurred.
    /// @param value Encrypted 256-bit unsigned integer.
    /// @return result The value cast down to 64 bits.
    /// @return overflow Encrypted flag set when the original value exceeds 64 bits.
    function toEuint64(euint256 value) internal returns (euint64 result, ebool overflow) {
        result = FHE.asEuint64(value);
        overflow = FHE.ne(value, FHE.asEuint256(result));
    }

    /// @notice Downcasts an euint64 to euint32 and indicates whether truncation occurred.
    /// @param value Encrypted 64-bit unsigned integer.
    /// @return result The value cast down to 32 bits.
    /// @return overflow Encrypted flag set when the original value exceeds 32 bits.
    function toEuint32(euint64 value) internal returns (euint32 result, ebool overflow) {
        result = FHE.asEuint32(value);
        overflow = FHE.ne(value, FHE.asEuint64(result));
    }

    /// @notice Downcasts an euint128 to euint32 and indicates whether truncation occurred.
    /// @param value Encrypted 128-bit unsigned integer.
    /// @return result The value cast down to 32 bits.
    /// @return overflow Encrypted flag set when the original value exceeds 32 bits.
    function toEuint32(euint128 value) internal returns (euint32 result, ebool overflow) {
        result = FHE.asEuint32(value);
        overflow = FHE.ne(value, FHE.asEuint128(result));
    }

    /// @notice Downcasts an euint256 to euint32 and indicates whether truncation occurred.
    /// @param value Encrypted 256-bit unsigned integer.
    /// @return result The value cast down to 32 bits.
    /// @return overflow Encrypted flag set when the original value exceeds 32 bits.
    function toEuint32(euint256 value) internal returns (euint32 result, ebool overflow) {
        result = FHE.asEuint32(value);
        overflow = FHE.ne(value, FHE.asEuint256(result));
    }

    /// @notice Downcasts an euint32 to euint16 and indicates whether truncation occurred.
    /// @param value Encrypted 32-bit unsigned integer.
    /// @return result The value cast down to 16 bits.
    /// @return overflow Encrypted flag set when the original value exceeds 16 bits.
    function toEuint16(euint32 value) internal returns (euint16 result, ebool overflow) {
        result = FHE.asEuint16(value);
        overflow = FHE.ne(value, FHE.asEuint32(result));
    }

    /// @notice Downcasts an euint64 to euint16 and indicates whether truncation occurred.
    /// @param value Encrypted 64-bit unsigned integer.
    /// @return result The value cast down to 16 bits.
    /// @return overflow Encrypted flag set when the original value exceeds 16 bits.
    function toEuint16(euint64 value) internal returns (euint16 result, ebool overflow) {
        result = FHE.asEuint16(value);
        overflow = FHE.ne(value, FHE.asEuint64(result));
    }

    /// @notice Downcasts an euint128 to euint16 and indicates whether truncation occurred.
    /// @param value Encrypted 128-bit unsigned integer.
    /// @return result The value cast down to 16 bits.
    /// @return overflow Encrypted flag set when the original value exceeds 16 bits.
    function toEuint16(euint128 value) internal returns (euint16 result, ebool overflow) {
        result = FHE.asEuint16(value);
        overflow = FHE.ne(value, FHE.asEuint128(result));
    }

    /// @notice Downcasts an euint256 to euint16 and indicates whether truncation occurred.
    /// @param value Encrypted 256-bit unsigned integer.
    /// @return result The value cast down to 16 bits.
    /// @return overflow Encrypted flag set when the original value exceeds 16 bits.
    function toEuint16(euint256 value) internal returns (euint16 result, ebool overflow) {
        result = FHE.asEuint16(value);
        overflow = FHE.ne(value, FHE.asEuint256(result));
    }

    /// @notice Downcasts an euint16 to euint8 and indicates whether truncation occurred.
    /// @param value Encrypted 16-bit unsigned integer.
    /// @return result The value cast down to 8 bits.
    /// @return overflow Encrypted flag set when the original value exceeds 8 bits.
    function toEuint8(euint16 value) internal returns (euint8 result, ebool overflow) {
        result = FHE.asEuint8(value);
        overflow = FHE.ne(value, FHE.asEuint16(result));
    }

    /// @notice Downcasts an euint32 to euint8 and indicates whether truncation occurred.
    /// @param value Encrypted 32-bit unsigned integer.
    /// @return result The value cast down to 8 bits.
    /// @return overflow Encrypted flag set when the original value exceeds 8 bits.
    function toEuint8(euint32 value) internal returns (euint8 result, ebool overflow) {
        result = FHE.asEuint8(value);
        overflow = FHE.ne(value, FHE.asEuint32(result));
    }

    /// @notice Downcasts an euint64 to euint8 and indicates whether truncation occurred.
    /// @param value Encrypted 64-bit unsigned integer.
    /// @return result The value cast down to 8 bits.
    /// @return overflow Encrypted flag set when the original value exceeds 8 bits.
    function toEuint8(euint64 value) internal returns (euint8 result, ebool overflow) {
        result = FHE.asEuint8(value);
        overflow = FHE.ne(value, FHE.asEuint64(result));
    }

    /// @notice Downcasts an euint128 to euint8 and indicates whether truncation occurred.
    /// @param value Encrypted 128-bit unsigned integer.
    /// @return result The value cast down to 8 bits.
    /// @return overflow Encrypted flag set when the original value exceeds 8 bits.
    function toEuint8(euint128 value) internal returns (euint8 result, ebool overflow) {
        result = FHE.asEuint8(value);
        overflow = FHE.ne(value, FHE.asEuint128(result));
    }

    /// @notice Downcasts an euint256 to euint8 and indicates whether truncation occurred.
    /// @param value Encrypted 256-bit unsigned integer.
    /// @return result The value cast down to 8 bits.
    /// @return overflow Encrypted flag set when the original value exceeds 8 bits.
    function toEuint8(euint256 value) internal returns (euint8 result, ebool overflow) {
        result = FHE.asEuint8(value);
        overflow = FHE.ne(value, FHE.asEuint256(result));
    }
}
