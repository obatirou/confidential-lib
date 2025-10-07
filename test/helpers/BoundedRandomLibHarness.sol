// SPDX-License-Identifier: MIT
pragma solidity ^0.8.24;

import {FHE, euint128, euint64, euint32, euint16, euint8} from "@fhevm/solidity/lib/FHE.sol";
import {SepoliaConfig} from "@fhevm/solidity/config/ZamaConfig.sol";

import {BoundedRandomLib} from "../../contracts/BoundedRandomLib.sol";

/**
 * @notice Test-only wrapper around `BoundedRandomLib`.
 *
 * Each helper method stores the generated encrypted value in a state slot so
 * that the test suite can retrieve the handle with a cheap `view` call and
 * decrypt it off-chain. Returning the value directly would not expose the
 * handle to the caller because Hardhat only provides a transaction response
 * for state-changing functions, so persisting it is the simplest way to make
 * assertions about the random range without modifying the library under test.
 *
 * Emitting the handles in events would also expose them, but that was discarded
 * to avoid bloating the contract ABI and log data—tests only need to read a
 * single handle per call, so storing it transiently is enough.
 */
contract BoundedRandomLibHarness is SepoliaConfig {
    /// @dev Cache slots used by the tests to read back the encrypted handles after each transaction.
    euint8 private _lastUint8;
    euint16 private _lastUint16;
    euint32 private _lastUint32;
    euint64 private _lastUint64;
    euint128 private _lastUint128;

    function boundedRandomUint8(uint8 minValue, uint8 maxValue) external returns (euint8) {
        euint8 randomValue = BoundedRandomLib.boundedRandomEuint8(minValue, maxValue);
        _lastUint8 = randomValue;
        FHE.allowThis(randomValue);
        FHE.allow(randomValue, msg.sender);
        return randomValue;
    }

    function getLastUint8() external view returns (euint8) {
        return _lastUint8;
    }

    function boundedRandomUint16(uint16 minValue, uint16 maxValue) external returns (euint16) {
        euint16 randomValue = BoundedRandomLib.boundedRandomEuint16(minValue, maxValue);
        _lastUint16 = randomValue;
        FHE.allowThis(randomValue);
        FHE.allow(randomValue, msg.sender);
        return randomValue;
    }

    function getLastUint16() external view returns (euint16) {
        return _lastUint16;
    }

    function boundedRandomUint32(uint32 minValue, uint32 maxValue) external returns (euint32) {
        euint32 randomValue = BoundedRandomLib.boundedRandomEuint32(minValue, maxValue);
        _lastUint32 = randomValue;
        FHE.allowThis(randomValue);
        FHE.allow(randomValue, msg.sender);
        return randomValue;
    }

    function getLastUint32() external view returns (euint32) {
        return _lastUint32;
    }

    function boundedRandomUint64(uint64 minValue, uint64 maxValue) external returns (euint64) {
        euint64 randomValue = BoundedRandomLib.boundedRandomEuint64(minValue, maxValue);
        _lastUint64 = randomValue;
        FHE.allowThis(randomValue);
        FHE.allow(randomValue, msg.sender);
        return randomValue;
    }

    function getLastUint64() external view returns (euint64) {
        return _lastUint64;
    }

    function boundedRandomUint128(uint128 minValue, uint128 maxValue) external returns (euint128) {
        euint128 randomValue = BoundedRandomLib.boundedRandomEuint128(minValue, maxValue);
        _lastUint128 = randomValue;
        FHE.allowThis(randomValue);
        FHE.allow(randomValue, msg.sender);
        return randomValue;
    }

    function getLastUint128() external view returns (euint128) {
        return _lastUint128;
    }
}
