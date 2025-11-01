// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

contract EmployeeStorage {
    error TooManyShares(uint256 totalShares);

    uint128 private shares;       // Max 5000 (fits in uint16, but aligned to uint128)
    uint128 private salary;       // Max 1,000,000 (fits in uint24, but aligned to uint128)
    uint256 public idNumber;      // Full 256-bit range
    string public name;           // Dynamic storage

    constructor() {
        shares = 1000;
        name = "Pat";
        salary = 50000;
        idNumber = 112358132134;
    }

    function viewSalary() external view returns (uint256) {
        return salary;
    }

    function viewShares() external view returns (uint256) {
        return shares;
    }

    function grantShares(uint256 _newShares) public {
        // Revert if _newShares itself is too large (even if shares=0)
        if (_newShares > 5000) {
            revert("Too many shares");
        }

        // Revert if granting would exceed 5000 shares
        if (shares + _newShares > 5000) {
            revert TooManyShares(shares + _newShares);
        }

        // Safe to add (casting is safe due to prior checks)
        shares += uint128(_newShares);
    }

    // DO NOT MODIFY (for testing)
    function checkForPacking(uint _slot) public view returns (uint r) {
        assembly { r := sload(_slot) }
    }

    // DO NOT MODIFY (for testing)
    function debugResetShares() public {
        shares = 1000;
    }
}