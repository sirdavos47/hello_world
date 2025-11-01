// SPDX-License-Identifier: MIT
pragma solidity ^0.8.17;

import "./AddressBook.sol";

contract AddressBookFactory {
    event AddressBookDeployed(address addr, address owner);

    function deploy() external returns (address) {
        AddressBook newBook = new AddressBook(msg.sender);
        emit AddressBookDeployed(address(newBook), msg.sender);
        return address(newBook);
    }
}