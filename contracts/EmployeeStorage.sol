// SPDX-License-Identifier: MIT
pragma solidity ^0.8.17;

contract EmployeeStorage {
    // State variables optimized for storage packing
    uint128 private shares;       // 16 bytes (max 2^128-1, enough for shares)
    uint128 private salary;       // 16 bytes (max 1,000,000 fits in 20 bits)
    uint256 public idNumber;      // 32 bytes (full range needed)
    string public name;           // dynamic storage

    // Custom error
    error TooManyShares(uint totalShares);

    // Constructor with required values
    constructor() {
        shares = 1000;
        name = "Pat";
        salary = 50000;
        idNumber = 112358132134;
    }

    // View functions
    function viewSalary() public view returns (uint) {
        return salary;
    }

    function viewShares() public view returns (uint) {
        return shares;
    }

function grantShares(uint _newShares) public {
    if (_newShares > 5000) {
        revert("Too many shares");
    }

    uint newTotal = shares + _newShares;
    if (newTotal > 5000) {
        revert TooManyShares(newTotal);
    }

    shares = uint128(newTotal);  // ✅ Fixed with explicit conversion
}

    /**
    * Do not modify this function. It is used to enable the unit test for this pin
    * to check whether or not you have configured your storage variables to make
    * use of packing.
    */
    function checkForPacking(uint _slot) public view returns (uint r) {
        assembly {
            r := sload(_slot)
        }
    }

    /**
    * Warning: Anyone can use this function at any time!
    */
    function debugResetShares() public {
        shares = 1000;
    }
}