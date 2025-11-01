// SPDX-License-Identifier: MIT
pragma solidity ^0.8.17;

contract EmployeeStorage {
    // State variables optimized for storage packing
    uint128 private shares;       // Private - only accessible through viewShares()
    uint128 private salary;       // Private - only accessible through viewSalary()
    uint256 public idNumber;      // Public
    string public name;           // Public

    // Custom errors
    error TooManyShares(uint totalShares);
    error DirectAccessNotAllowed();  // For any attempt to access private vars directly

    // Constructor with required values
    constructor() {
        shares = 1000;
        name = "Pat";
        salary = 50000;
        idNumber = 112358132134;
    }

    // Public accessor for private salary variable
    function viewSalary() public view returns (uint) {
        return salary;
    }

    // Public accessor for private shares variable
    function viewShares() public view returns (uint) {
        return shares;
    }

    
    // Function to grant additional shares to the employee
    function grantShares(uint16 _newShares) public {
        // Check if the requested shares exceed the limit
        if (_newShares > 5000) {
            revert("Too many shares"); // Revert with error message
        } else if (shares + _newShares > 5000) {
            revert TooManyShares(shares + _newShares); // Revert with custom error message
        }
        shares += _newShares; // Grant the new shares
    }

    /**
    * Do not modify this function. It is used to enable the unit test
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