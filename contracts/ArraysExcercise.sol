// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

contract ArraysExercise {
    uint[] public numbers = [1, 2, 3, 4, 5, 6, 7, 8, 9, 10];
    address[] public senders;
    uint[] public timestamps;

    // Returns the complete numbers array
    function getNumbers() external view returns (uint[] memory) {
        return numbers;
    }

    // Resets numbers to [1, 2, ..., 10] without using .push()
    function resetNumbers() external {
        numbers = [1, 2, 3, 4, 5, 6, 7, 8, 9, 10];
    }

    // Appends _toAppend array to numbers (gas-efficient version)
    function appendToNumbers(uint[] calldata _toAppend) external {
        uint newLength = numbers.length + _toAppend.length;
        uint[] memory newArray = new uint[](newLength);

        // Copy existing numbers
        for (uint i = 0; i < numbers.length; i++) {
            newArray[i] = numbers[i];
        }

        // Append new numbers
        for (uint i = 0; i < _toAppend.length; i++) {
            newArray[numbers.length + i] = _toAppend[i];
        }

        numbers = newArray;
    }

    // Saves caller's address and timestamp
    function saveTimestamp(uint _unixTimestamp) external {
        senders.push(msg.sender);
        timestamps.push(_unixTimestamp);
    }

    // Returns timestamps after Y2K (946702800) and corresponding senders
    function afterY2K() external view returns (uint[] memory, address[] memory) {
        uint[] memory recentTimestamps = new uint[](senders.length);
        address[] memory recentSenders = new address[](senders.length);
        uint count = 0;

        for (uint i = 0; i < timestamps.length; i++) {
            if (timestamps[i] > 946702800) {
                recentTimestamps[count] = timestamps[i];
                recentSenders[count] = senders[i];
                count++;
            }
        }

        // Resize arrays to actual count
        uint[] memory resultTimestamps = new uint[](count);
        address[] memory resultSenders = new address[](count);

        for (uint i = 0; i < count; i++) {
            resultTimestamps[i] = recentTimestamps[i];
            resultSenders[i] = recentSenders[i];
        }

        return (resultTimestamps, resultSenders);
    }

    // Reset functions
    function resetSenders() external {
        delete senders;
    }

    function resetTimestamps() external {
        delete timestamps;
    }
}