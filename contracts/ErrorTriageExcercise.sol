// SPDX-License-Identifier: MIT
pragma solidity ^0.8.17;

contract ErrorTriageExercise {
    uint[] arr;

    /**
     * Finds the absolute difference between each uint with its neighbor
     */
    function diffWithNeighbor(
        uint _a,
        uint _b,
        uint _c,
        uint _d
    ) public pure returns (uint[] memory) {
        uint[] memory results = new uint[](3);

        results[0] = _a > _b ? _a - _b : _b - _a;
        results[1] = _b > _c ? _b - _c : _c - _b;
        results[2] = _c > _d ? _c - _d : _d - _c;

        return results;
    }

    /**
     * Changes the _base by the value of _modifier with validation
     */
function applyModifier(
    uint _base,
    int _modifier
) public pure returns (uint) {
    require(_base >= 1000, "Base must be >= 1000");
    require(_modifier >= -100 && _modifier <= 100, "Modifier must be between -100 and 100");

    if (_modifier < 0) {
        int modValue = _modifier;
        require(_base >= uint(-modValue), "Result would underflow");
        return _base - uint(-modValue);
    }
    return _base + uint(_modifier);
}

    /**
     * Pop the last element and return it
     */
    function popWithReturn() public returns (uint) {
        require(arr.length > 0, "Array is empty");
        uint lastValue = arr[arr.length - 1];
        arr.pop();
        return lastValue;
    }

    // Utility functions (unchanged)
    function addToArr(uint _num) public {
        arr.push(_num);
    }

    function getArr() public view returns (uint[] memory) {
        return arr;
    }

    function resetArr() public {
        delete arr;
    }
}