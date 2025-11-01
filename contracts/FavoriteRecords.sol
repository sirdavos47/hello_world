// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

contract FavoriteRecords {
    // Custom error for unapproved records
    error NotApproved(string recordName);

    // Mapping of approved records (album name => bool)
    mapping(string => bool) public approvedRecords;

    // Nested mapping of user favorites (user => (album name => bool))
    mapping(address => mapping(string => bool)) public userFavorites;

    // Array to maintain list of approved record names
    string[] private _approvedRecordNames;

    // Constructor to load approved records
    constructor() {
        string[] memory initialRecords = new string[](9);
        initialRecords[0] = "Thriller";
        initialRecords[1] = "Back in Black";
        initialRecords[2] = "The Bodyguard";
        initialRecords[3] = "The Dark Side of the Moon";
        initialRecords[4] = "Their Greatest Hits (1971-1975)";
        initialRecords[5] = "Hotel California";
        initialRecords[6] = "Come On Over";
        initialRecords[7] = "Rumours";
        initialRecords[8] = "Saturday Night Fever";

        for (uint i = 0; i < initialRecords.length; i++) {
            string memory record = initialRecords[i];
            approvedRecords[record] = true;
            _approvedRecordNames.push(record);
        }
    }

    // Returns list of all approved record names
    function getApprovedRecords() external view returns (string[] memory) {
        return _approvedRecordNames;
    }

    // Adds a record to user's favorites if approved
    function addRecord(string memory _recordName) external {
        if (!approvedRecords[_recordName]) {
            revert NotApproved(_recordName);
        }
        userFavorites[msg.sender][_recordName] = true;
    }

    // Returns list of a user's favorite records
    function getUserFavorites(address _user) external view returns (string[] memory) {
        // First count how many favorites the user has
        uint count = 0;
        for (uint i = 0; i < _approvedRecordNames.length; i++) {
            string memory record = _approvedRecordNames[i];
            if (userFavorites[_user][record]) {
                count++;
            }
        }

        // Create array of correct size
        string[] memory favorites = new string[](count);
        uint index = 0;

        // Populate the array
        for (uint i = 0; i < _approvedRecordNames.length; i++) {
            string memory record = _approvedRecordNames[i];
            if (userFavorites[_user][record]) {
                favorites[index] = record;
                index++;
            }
        }

        return favorites;
    }

    // Resets favorites for the calling user
    function resetUserFavorites() external {
        // Loop through all approved records and unset favorites
        for (uint i = 0; i < _approvedRecordNames.length; i++) {
            string memory record = _approvedRecordNames[i];
            userFavorites[msg.sender][record] = false;
        }
    }
}