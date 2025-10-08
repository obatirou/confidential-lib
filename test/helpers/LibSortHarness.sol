// SPDX-License-Identifier: MIT
pragma solidity ^0.8.24;

import {FHE, euint128, euint64, euint32, euint16, euint8} from "@fhevm/solidity/lib/FHE.sol";
import {SepoliaConfig} from "@fhevm/solidity/config/ZamaConfig.sol";

import {LibSort} from "../../contracts/LibSort.sol";

/**
 * @notice Test harness exposing LibSort comparators for unit testing.
 *
 * The harness operates on clear uint values, encrypts them via `FHE.asEuint*`, and stores the sorted
 * results so the TypeScript suite can retrieve and decrypt the handles. Events were avoided to keep
 * the helper lightweight; persisting the last result is sufficient for assertions.
 */
contract LibSortHarness is SepoliaConfig {
    euint128 private _lastUint128Lower;
    euint128 private _lastUint128Upper;
    euint64 private _lastUint64Lower;
    euint64 private _lastUint64Upper;
    euint32 private _lastUint32Lower;
    euint32 private _lastUint32Upper;
    euint16 private _lastUint16Lower;
    euint16 private _lastUint16Upper;
    euint8 private _lastUint8Lower;
    euint8 private _lastUint8Upper;

    euint128[] private _sortedUint128;
    euint64[] private _sortedUint64;
    euint32[] private _sortedUint32;
    euint16[] private _sortedUint16;
    euint8[] private _sortedUint8;

    function orderUint128(uint128 a, uint128 b) external {
        (euint128 lower, euint128 upper) = LibSort.order(FHE.asEuint128(a), FHE.asEuint128(b));
        _lastUint128Lower = lower;
        _lastUint128Upper = upper;
        _allowPair(lower, upper);
    }

    function getLastUint128Lower() external view returns (euint128) {
        return _lastUint128Lower;
    }

    function getLastUint128Upper() external view returns (euint128) {
        return _lastUint128Upper;
    }

    function orderUint64(uint64 a, uint64 b) external {
        (euint64 lower, euint64 upper) = LibSort.order(FHE.asEuint64(a), FHE.asEuint64(b));
        _lastUint64Lower = lower;
        _lastUint64Upper = upper;
        _allowPair(lower, upper);
    }

    function getLastUint64Lower() external view returns (euint64) {
        return _lastUint64Lower;
    }

    function getLastUint64Upper() external view returns (euint64) {
        return _lastUint64Upper;
    }

    function orderUint32(uint32 a, uint32 b) external {
        (euint32 lower, euint32 upper) = LibSort.order(FHE.asEuint32(a), FHE.asEuint32(b));
        _lastUint32Lower = lower;
        _lastUint32Upper = upper;
        _allowPair(lower, upper);
    }

    function getLastUint32Lower() external view returns (euint32) {
        return _lastUint32Lower;
    }

    function getLastUint32Upper() external view returns (euint32) {
        return _lastUint32Upper;
    }

    function orderUint16(uint16 a, uint16 b) external {
        (euint16 lower, euint16 upper) = LibSort.order(FHE.asEuint16(a), FHE.asEuint16(b));
        _lastUint16Lower = lower;
        _lastUint16Upper = upper;
        _allowPair(lower, upper);
    }

    function getLastUint16Lower() external view returns (euint16) {
        return _lastUint16Lower;
    }

    function getLastUint16Upper() external view returns (euint16) {
        return _lastUint16Upper;
    }

    function orderUint8(uint8 a, uint8 b) external {
        (euint8 lower, euint8 upper) = LibSort.order(FHE.asEuint8(a), FHE.asEuint8(b));
        _lastUint8Lower = lower;
        _lastUint8Upper = upper;
        _allowPair(lower, upper);
    }

    function getLastUint8Lower() external view returns (euint8) {
        return _lastUint8Lower;
    }

    function getLastUint8Upper() external view returns (euint8) {
        return _lastUint8Upper;
    }

    function bubbleSortUint128(uint128[] calldata values) external {
        euint128[] memory arr = new euint128[](values.length);
        for (uint256 i = 0; i < values.length; ++i) {
            arr[i] = FHE.asEuint128(values[i]);
        }
        LibSort.bubbleSort(arr);
        delete _sortedUint128;
        for (uint256 i = 0; i < arr.length; ++i) {
            euint128 value = arr[i];
            FHE.allowThis(value);
            FHE.allow(value, msg.sender);
            _sortedUint128.push(value);
        }
    }

    function getSortedUint128Length() external view returns (uint256) {
        return _sortedUint128.length;
    }

    function getSortedUint128At(uint256 index) external view returns (euint128) {
        return _sortedUint128[index];
    }

    function bubbleSortUint64(uint64[] calldata values) external {
        euint64[] memory arr = new euint64[](values.length);
        for (uint256 i = 0; i < values.length; ++i) {
            arr[i] = FHE.asEuint64(values[i]);
        }
        LibSort.bubbleSort(arr);
        delete _sortedUint64;
        for (uint256 i = 0; i < arr.length; ++i) {
            euint64 value = arr[i];
            FHE.allowThis(value);
            FHE.allow(value, msg.sender);
            _sortedUint64.push(value);
        }
    }

    function getSortedUint64Length() external view returns (uint256) {
        return _sortedUint64.length;
    }

    function getSortedUint64At(uint256 index) external view returns (euint64) {
        return _sortedUint64[index];
    }

    function bubbleSortUint32(uint32[] calldata values) external {
        euint32[] memory arr = new euint32[](values.length);
        for (uint256 i = 0; i < values.length; ++i) {
            arr[i] = FHE.asEuint32(values[i]);
        }
        LibSort.bubbleSort(arr);
        delete _sortedUint32;
        for (uint256 i = 0; i < arr.length; ++i) {
            euint32 value = arr[i];
            FHE.allowThis(value);
            FHE.allow(value, msg.sender);
            _sortedUint32.push(value);
        }
    }

    function getSortedUint32Length() external view returns (uint256) {
        return _sortedUint32.length;
    }

    function getSortedUint32At(uint256 index) external view returns (euint32) {
        return _sortedUint32[index];
    }

    function bubbleSortUint16(uint16[] calldata values) external {
        euint16[] memory arr = new euint16[](values.length);
        for (uint256 i = 0; i < values.length; ++i) {
            arr[i] = FHE.asEuint16(values[i]);
        }
        LibSort.bubbleSort(arr);
        delete _sortedUint16;
        for (uint256 i = 0; i < arr.length; ++i) {
            euint16 value = arr[i];
            FHE.allowThis(value);
            FHE.allow(value, msg.sender);
            _sortedUint16.push(value);
        }
    }

    function getSortedUint16Length() external view returns (uint256) {
        return _sortedUint16.length;
    }

    function getSortedUint16At(uint256 index) external view returns (euint16) {
        return _sortedUint16[index];
    }

    function bubbleSortUint8(uint8[] calldata values) external {
        euint8[] memory arr = new euint8[](values.length);
        for (uint256 i = 0; i < values.length; ++i) {
            arr[i] = FHE.asEuint8(values[i]);
        }
        LibSort.bubbleSort(arr);
        delete _sortedUint8;
        for (uint256 i = 0; i < arr.length; ++i) {
            euint8 value = arr[i];
            FHE.allowThis(value);
            FHE.allow(value, msg.sender);
            _sortedUint8.push(value);
        }
    }

    function getSortedUint8Length() external view returns (uint256) {
        return _sortedUint8.length;
    }

    function getSortedUint8At(uint256 index) external view returns (euint8) {
        return _sortedUint8[index];
    }

    function _allowPair(euint128 lower, euint128 upper) private {
        FHE.allowThis(lower);
        FHE.allowThis(upper);
        FHE.allow(lower, msg.sender);
        FHE.allow(upper, msg.sender);
    }

    function _allowPair(euint64 lower, euint64 upper) private {
        FHE.allowThis(lower);
        FHE.allowThis(upper);
        FHE.allow(lower, msg.sender);
        FHE.allow(upper, msg.sender);
    }

    function _allowPair(euint32 lower, euint32 upper) private {
        FHE.allowThis(lower);
        FHE.allowThis(upper);
        FHE.allow(lower, msg.sender);
        FHE.allow(upper, msg.sender);
    }

    function _allowPair(euint16 lower, euint16 upper) private {
        FHE.allowThis(lower);
        FHE.allowThis(upper);
        FHE.allow(lower, msg.sender);
        FHE.allow(upper, msg.sender);
    }

    function _allowPair(euint8 lower, euint8 upper) private {
        FHE.allowThis(lower);
        FHE.allowThis(upper);
        FHE.allow(lower, msg.sender);
        FHE.allow(upper, msg.sender);
    }
}
