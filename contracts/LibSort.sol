// SPDX-License-Identifier: MIT
pragma solidity ^0.8.24;

import {FHE, ebool, euint128, euint64, euint32, euint16, euint8} from "@fhevm/solidity/lib/FHE.sol";

/// @title LibSort
/// @notice Comparator helpers and sorting routines for encrypted integers.
library LibSort {
    /// @notice Returns two encrypted uint128 values ordered ascending.
    /// @param a First encrypted value.
    /// @param b Second encrypted value.
    /// @return newA The smaller encrypted value.
    /// @return newB The larger encrypted value.
    function order(euint128 a, euint128 b) internal returns (euint128 newA, euint128 newB) {
        ebool isGreater = FHE.gt(a, b);
        newA = FHE.select(isGreater, b, a);
        newB = FHE.select(isGreater, a, b);
    }

    /// @notice Returns two encrypted uint64 values ordered ascending.
    /// @param a First encrypted value.
    /// @param b Second encrypted value.
    /// @return newA The smaller encrypted value.
    /// @return newB The larger encrypted value.
    function order(euint64 a, euint64 b) internal returns (euint64 newA, euint64 newB) {
        ebool isGreater = FHE.gt(a, b);
        newA = FHE.select(isGreater, b, a);
        newB = FHE.select(isGreater, a, b);
    }

    /// @notice Returns two encrypted uint32 values ordered ascending.
    /// @param a First encrypted value.
    /// @param b Second encrypted value.
    /// @return newA The smaller encrypted value.
    /// @return newB The larger encrypted value.
    function order(euint32 a, euint32 b) internal returns (euint32 newA, euint32 newB) {
        ebool isGreater = FHE.gt(a, b);
        newA = FHE.select(isGreater, b, a);
        newB = FHE.select(isGreater, a, b);
    }

    /// @notice Returns two encrypted uint16 values ordered ascending.
    /// @param a First encrypted value.
    /// @param b Second encrypted value.
    /// @return newA The smaller encrypted value.
    /// @return newB The larger encrypted value.
    function order(euint16 a, euint16 b) internal returns (euint16 newA, euint16 newB) {
        ebool isGreater = FHE.gt(a, b);
        newA = FHE.select(isGreater, b, a);
        newB = FHE.select(isGreater, a, b);
    }

    /// @notice Returns two encrypted uint8 values ordered ascending.
    /// @param a First encrypted value.
    /// @param b Second encrypted value.
    /// @return newA The smaller encrypted value.
    /// @return newB The larger encrypted value.
    function order(euint8 a, euint8 b) internal returns (euint8 newA, euint8 newB) {
        ebool isGreater = FHE.gt(a, b);
        newA = FHE.select(isGreater, b, a);
        newB = FHE.select(isGreater, a, b);
    }

    /// @notice Sorts encrypted uint128 values in ascending order using bubble sort.
    /// @param arr Array of encrypted values to sort.
    /// @return Sorted array in ascending order.
    function bubbleSort(euint128[] memory arr) internal returns (euint128[] memory) {
        uint256 n = arr.length;
        if (n < 2) {
            return arr;
        }
        for (uint256 i = 0; i < n; ++i) {
            for (uint256 j = 0; j + 1 < n; ++j) {
                (arr[j], arr[j + 1]) = order(arr[j], arr[j + 1]);
            }
        }
        return arr;
    }

    /// @notice Sorts encrypted uint64 values in ascending order using bubble sort.
    /// @param arr Array of encrypted values to sort.
    /// @return Sorted array in ascending order.
    function bubbleSort(euint64[] memory arr) internal returns (euint64[] memory) {
        uint256 n = arr.length;
        if (n < 2) {
            return arr;
        }
        for (uint256 i = 0; i < n; ++i) {
            for (uint256 j = 0; j + 1 < n; ++j) {
                (arr[j], arr[j + 1]) = order(arr[j], arr[j + 1]);
            }
        }
        return arr;
    }

    /// @notice Sorts encrypted uint32 values in ascending order using bubble sort.
    /// @param arr Array of encrypted values to sort.
    /// @return Sorted array in ascending order.
    function bubbleSort(euint32[] memory arr) internal returns (euint32[] memory) {
        uint256 n = arr.length;
        if (n < 2) {
            return arr;
        }
        for (uint256 i = 0; i < n; ++i) {
            for (uint256 j = 0; j + 1 < n; ++j) {
                (arr[j], arr[j + 1]) = order(arr[j], arr[j + 1]);
            }
        }
        return arr;
    }

    /// @notice Sorts encrypted uint16 values in ascending order using bubble sort.
    /// @param arr Array of encrypted values to sort.
    /// @return Sorted array in ascending order.
    function bubbleSort(euint16[] memory arr) internal returns (euint16[] memory) {
        uint256 n = arr.length;
        if (n < 2) {
            return arr;
        }
        for (uint256 i = 0; i < n; ++i) {
            for (uint256 j = 0; j + 1 < n; ++j) {
                (arr[j], arr[j + 1]) = order(arr[j], arr[j + 1]);
            }
        }
        return arr;
    }

    /// @notice Sorts encrypted uint8 values in ascending order using bubble sort.
    /// @param arr Array of encrypted values to sort.
    /// @return Sorted array in ascending order.
    function bubbleSort(euint8[] memory arr) internal returns (euint8[] memory) {
        uint256 n = arr.length;
        if (n < 2) {
            return arr;
        }
        for (uint256 i = 0; i < n; ++i) {
            for (uint256 j = 0; j + 1 < n; ++j) {
                (arr[j], arr[j + 1]) = order(arr[j], arr[j + 1]);
            }
        }
        return arr;
    }
}
