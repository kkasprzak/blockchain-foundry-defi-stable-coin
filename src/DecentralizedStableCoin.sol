// SPDX-License-Identifier: MIT

pragma solidity ^0.8.18;

import {ERC20Burnable, ERC20} from "@openzeppelin/contracts/token/ERC20/extensions/ERC20Burnable.sol";
import {Ownable} from "@openzeppelin/contracts/access/Ownable.sol";

contract DecentralizedStableCoin is ERC20Burnable, Ownable {
    constructor(
        address initialOwner
    ) ERC20("DecentralizedStableCoin", "DSC") Ownable(initialOwner) {}

    function burn(uint256 value) public override onlyOwner {}
}
