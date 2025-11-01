// SPDX-License-Identifier: MIT
pragma solidity ^0.8.17;

import {SillyStringUtils} from "./SillyStringUtils.sol";

contract ImportsExercise {
    using SillyStringUtils for string;

    SillyStringUtils.Haiku public haiku;

    // Saves a new haiku with the provided lines
    function saveHaiku(
        string memory _line1,
        string memory _line2,
        string memory _line3
    ) public {
        haiku = SillyStringUtils.Haiku({
            line1: _line1,
            line2: _line2,
            line3: _line3
        });
    }

    // Returns the current haiku as a Haiku struct
    function getHaiku() public view returns (SillyStringUtils.Haiku memory) {
        return haiku;
    }

    // Returns a modified haiku with 🤷 added to line3 without changing the original
    function shruggieHaiku() public view returns (SillyStringUtils.Haiku memory) {
        return SillyStringUtils.Haiku({
            line1: haiku.line1,
            line2: haiku.line2,
            line3: haiku.line3.shruggie()
        });
    }
}