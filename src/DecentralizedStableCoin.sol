// SPDX-License-Identifier: MIT

pragma solidity ^0.8.18;

import {ERC20Burnable, ERC20} from "@openzeppelin/contracts/token/ERC20/extensions/ERC20Burnable.sol";
import {Ownable} from "@openzeppelin/contracts/access/Ownable.sol";

contract DecentralizedStableCoin is ERC20Burnable, Ownable {
    error DSC__MustBeMoreThanZero();
    error DSC__BurnAmountExceedsBalance();
    error DSC__RecipientAddressIncorect();

    constructor(
        address initialOwner
    ) ERC20("DecentralizedStableCoin", "DSC") Ownable(initialOwner) {}

    function burn(uint256 amount) public override onlyOwner {
        if (amount <= 0) {
            revert DSC__MustBeMoreThanZero();
        }

        uint256 balance = balanceOf(msg.sender);
        if (amount > balance) {
            revert DSC__BurnAmountExceedsBalance();
        }
        super.burn(amount);
    }

    function mint(
        address to,
        uint256 amount
    ) external onlyOwner returns (bool) {
        if (address(0) == to) {
            revert DSC__RecipientAddressIncorect();
        }

        if (amount <= 0) {
            revert DSC__MustBeMoreThanZero();
        }
        _mint(to, amount);

        return false;
    }
}
