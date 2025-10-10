// SPDX-License-Identifier: MIT
pragma solidity ^0.8.24;

import {SepoliaConfig} from "@fhevm/solidity/config/ZamaConfig.sol";
import {FHE, ebool, euint256, euint128, euint64, euint32, euint16, euint8} from "@fhevm/solidity/lib/FHE.sol";

import {SafeCastLib} from "../../contracts/SafeCastLib.sol";

/// @notice Test harness exposing SafeCastLib functions for encrypted downcasts.
contract SafeCastLibHarness is SepoliaConfig {
    euint128 private _lastUint128;
    ebool private _lastUint128Overflow;

    euint64 private _lastUint64;
    ebool private _lastUint64Overflow;

    euint32 private _lastUint32;
    ebool private _lastUint32Overflow;

    euint16 private _lastUint16;
    ebool private _lastUint16Overflow;

    euint8 private _lastUint8;
    ebool private _lastUint8Overflow;

    function castToEuint128(uint256 value) external {
        euint256 encrypted = FHE.asEuint256(value);
        (euint128 casted, ebool overflow) = SafeCastLib.toEuint128(encrypted);
        _record(casted, overflow);
    }

    function castToEuint64(uint128 value) external {
        euint128 encrypted = FHE.asEuint128(value);
        (euint64 casted, ebool overflow) = SafeCastLib.toEuint64(encrypted);
        _record(casted, overflow);
    }

    function castToEuint32(uint64 value) external {
        euint64 encrypted = FHE.asEuint64(value);
        (euint32 casted, ebool overflow) = SafeCastLib.toEuint32(encrypted);
        _record(casted, overflow);
    }

    function castToEuint16(uint32 value) external {
        euint32 encrypted = FHE.asEuint32(value);
        (euint16 casted, ebool overflow) = SafeCastLib.toEuint16(encrypted);
        _record(casted, overflow);
    }

    function castToEuint8(uint16 value) external {
        euint16 encrypted = FHE.asEuint16(value);
        (euint8 casted, ebool overflow) = SafeCastLib.toEuint8(encrypted);
        _record(casted, overflow);
    }

    function getLastUint128() external view returns (euint128) {
        return _lastUint128;
    }

    function getLastUint128Overflow() external view returns (ebool) {
        return _lastUint128Overflow;
    }

    function getLastUint64() external view returns (euint64) {
        return _lastUint64;
    }

    function getLastUint64Overflow() external view returns (ebool) {
        return _lastUint64Overflow;
    }

    function getLastUint32() external view returns (euint32) {
        return _lastUint32;
    }

    function getLastUint32Overflow() external view returns (ebool) {
        return _lastUint32Overflow;
    }

    function getLastUint16() external view returns (euint16) {
        return _lastUint16;
    }

    function getLastUint16Overflow() external view returns (ebool) {
        return _lastUint16Overflow;
    }

    function getLastUint8() external view returns (euint8) {
        return _lastUint8;
    }

    function getLastUint8Overflow() external view returns (ebool) {
        return _lastUint8Overflow;
    }

    function _record(euint128 value, ebool overflow) private {
        _lastUint128 = value;
        _lastUint128Overflow = overflow;
        _allow(value);
        _allow(overflow);
    }

    function _record(euint64 value, ebool overflow) private {
        _lastUint64 = value;
        _lastUint64Overflow = overflow;
        _allow(value);
        _allow(overflow);
    }

    function _record(euint32 value, ebool overflow) private {
        _lastUint32 = value;
        _lastUint32Overflow = overflow;
        _allow(value);
        _allow(overflow);
    }

    function _record(euint16 value, ebool overflow) private {
        _lastUint16 = value;
        _lastUint16Overflow = overflow;
        _allow(value);
        _allow(overflow);
    }

    function _record(euint8 value, ebool overflow) private {
        _lastUint8 = value;
        _lastUint8Overflow = overflow;
        _allow(value);
        _allow(overflow);
    }

    function _allow(euint128 value) private {
        FHE.allowThis(value);
        FHE.allow(value, msg.sender);
    }

    function _allow(euint64 value) private {
        FHE.allowThis(value);
        FHE.allow(value, msg.sender);
    }

    function _allow(euint32 value) private {
        FHE.allowThis(value);
        FHE.allow(value, msg.sender);
    }

    function _allow(euint16 value) private {
        FHE.allowThis(value);
        FHE.allow(value, msg.sender);
    }

    function _allow(euint8 value) private {
        FHE.allowThis(value);
        FHE.allow(value, msg.sender);
    }

    function _allow(ebool value) private {
        FHE.allowThis(value);
        FHE.allow(value, msg.sender);
    }
}
