// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

contract GarageManager {
    // Custom error for invalid car index
    error BadCarIndex(uint index);

    // Car struct definition
    struct Car {
        string make;
        string model;
        string color;
        uint256 numberOfDoors;
    }

    // Mapping from address to dynamic array of Cars
    mapping(address => Car[]) public garage;

    // Adds a new car to the caller's garage
    function addCar(
        string memory _make,
        string memory _model,
        string memory _color,
        uint256 _numberOfDoors
    ) external {
        garage[msg.sender].push(Car({
            make: _make,
            model: _model,
            color: _color,
            numberOfDoors: _numberOfDoors
        }));
    }

    // Returns all cars owned by the calling user
    function getMyCars() external view returns (Car[] memory) {
        return garage[msg.sender];
    }

    // Returns all cars owned by any user
    function getUserCars(address _user) external view returns (Car[] memory) {
        return garage[_user];
    }

    // Updates a car at the specified index
    function updateCar(
        uint256 _index,
        string memory _make,
        string memory _model,
        string memory _color,
        uint256 _numberOfDoors
    ) external {
        // Check if the index is valid
        if (_index >= garage[msg.sender].length) {
            revert BadCarIndex(_index);
        }

        // Update the car
        garage[msg.sender][_index] = Car({
            make: _make,
            model: _model,
            color: _color,
            numberOfDoors: _numberOfDoors
        });
    }

    // Resets the calling user's garage
    function resetMyGarage() external {
        delete garage[msg.sender];
    }
}