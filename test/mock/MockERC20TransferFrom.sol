// SPDX-License-Identifier: MIT

pragma solidity ^0.8.21;

import {ERC20Mock} from "@openzeppelin/contracts/mocks/token/ERC20Mock.sol";

contract MockERC20TransferFrom is ERC20Mock {

    function transferFrom(address from, address to, uint256 amount) public override returns (bool) {
        return false;
    }
}