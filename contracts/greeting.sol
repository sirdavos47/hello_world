// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

contract Greeting {
    string private _greeting = "Hello, World!";
    address private _owner;

    // Events
    event GreetingUpdated(string newGreeting);

    constructor() {
        _owner = msg.sender;
    }

    // Modifier to restrict access to the owner
    modifier onlyOwner() {
        require(msg.sender == _owner, "Not authorized");
        _;
    }

    // Update the greeting (owner-only)
    function setGreeting(string memory newGreeting) external onlyOwner {
        _greeting = newGreeting;
        emit GreetingUpdated(newGreeting);
    }

    // Retrieve the current greeting
    function getGreeting() external view returns (string memory) {
        return _greeting;
    }
}