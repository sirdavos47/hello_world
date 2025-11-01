// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

contract ControlStructures {
    // Custom error for after-hours revert
    error AfterHours(uint256 time);

    // FizzBuzz implementation
    function fizzBuzz(uint256 _number) external pure returns (string memory) {
        if (_number % 15 == 0) {
            return "FizzBuzz";  // Divisible by both 3 and 5
        } else if (_number % 3 == 0) {
            return "Fizz";
        } else if (_number % 5 == 0) {
            return "Buzz";
        } else {
            return "Splat";
        }
    }

    // DoNotDisturb implementation with time validation
    function doNotDisturb(uint256 _time) external pure returns (string memory) {
        // Input validation (panic for invalid time)
        if (_time >= 2400) {
            assert(false);  // Triggers panic (invalid opcode)
        }

        // After-hours check
        if (_time >= 2200 || _time < 800) {
            revert AfterHours(_time);
        }

        // Lunch break check
        if (_time >= 1200 && _time <= 1259) {
            revert("At lunch!");
        }

        // Time-based greetings
        if (_time >= 800 && _time <= 1159) {
            return "Morning!";
        } else if (_time >= 1300 && _time <= 1759) {
            return "Afternoon!";
        } else if (_time >= 1800 && _time <= 2200) {
            return "Evening!";
        }

        // Fallback (should theoretically never be reached due to prior checks)
        revert("Invalid time");
    }
}