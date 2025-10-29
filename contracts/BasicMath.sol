// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

contract BasicMath {
    // Adds two uint256 numbers and checks for overflow.
    // Returns (sum, error) where error is true if overflow occurs.
    function adder(uint256 _a, uint256 _b) external pure returns (uint256 sum, bool error) {
        // Solidity 0.8+ has built-in overflow checks, but we explicitly handle it for clarity.
        unchecked {
            sum = _a + _b;
        }
        // Check if sum is smaller than either input (indicates overflow).
        if (sum < _a || sum < _b) {
            return (0, true);
        }
        return (sum, false);
    }

    // Subtracts two uint256 numbers and checks for underflow.
    // Returns (difference, error) where error is true if underflow occurs.
    function subtractor(uint256 _a, uint256 _b) external pure returns (uint256 difference, bool error) {
        // Solidity 0.8+ has built-in underflow checks, but we explicitly handle it for clarity.
        if (_a < _b) {
            return (0, true); // Underflow would occur.
        }
        difference = _a - _b;
        return (difference, false);
    }
}