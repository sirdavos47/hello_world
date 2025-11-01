// SPDX-License-Identifier: MIT
pragma solidity ^0.8.17;

import "@openzeppelin/contracts/access/Ownable.sol";

contract AddressBook is Ownable {
    uint private _nextId = 1;

    struct Contact {
        uint id;
        string firstName;
        string lastName;
        uint[] phoneNumbers;
    }

    // Mapping from contact ID to Contact struct
    mapping(uint => Contact) private _contacts;
    // Array to maintain contact IDs for iteration
    uint[] private _contactIds;

    // Custom error
    error ContactNotFound(uint id);

    // Events
    event ContactAdded(uint id, string firstName, string lastName);
    event ContactDeleted(uint id);

    // Constructor to set the initial owner
    constructor(address initialOwner) Ownable(initialOwner) {}

    function addContact(
        string memory _firstName,
        string memory _lastName,
        uint[] memory _phoneNumbers
    ) external onlyOwner {
        uint id = _nextId;
        _contacts[id] = Contact({
            id: id,
            firstName: _firstName,
            lastName: _lastName,
            phoneNumbers: _phoneNumbers
        });
        _contactIds.push(id);
        _nextId++;
        emit ContactAdded(id, _firstName, _lastName);
    }

    function deleteContact(uint _id) external onlyOwner {
        if (!_contactExists(_id)) {
            revert ContactNotFound(_id);
        }

        // Remove from mapping
        delete _contacts[_id];

        // Remove from array
        for (uint i = 0; i < _contactIds.length; i++) {
            if (_contactIds[i] == _id) {
                _contactIds[i] = _contactIds[_contactIds.length - 1];
                _contactIds.pop();
                break;
            }
        }

        emit ContactDeleted(_id);
    }

    function getContact(uint _id) external view returns (Contact memory) {
        if (!_contactExists(_id)) {
            revert ContactNotFound(_id);
        }
        return _contacts[_id];
    }

    function getAllContacts() external view returns (Contact[] memory) {
        uint count = 0;
        // First count valid contacts
        for (uint i = 0; i < _contactIds.length; i++) {
            if (_contactExists(_contactIds[i])) {
                count++;
            }
        }

        // Then create the array
        Contact[] memory contacts = new Contact[](count);
        uint index = 0;
        for (uint i = 0; i < _contactIds.length; i++) {
            uint id = _contactIds[i];
            if (_contactExists(id)) {
                contacts[index] = _contacts[id];
                index++;
            }
        }
        return contacts;
    }

    function _contactExists(uint _id) private view returns (bool) {
        return _contacts[_id].id == _id;
    }
}