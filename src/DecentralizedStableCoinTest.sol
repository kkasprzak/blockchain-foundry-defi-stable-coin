// SPDX-License-Identifier: MIT

pragma solidity ^0.8.21;

import {Test} from "forge-std/Test.sol";
import {DecentralizedStableCoin} from "../src/DecentralizedStableCoin.sol";

contract DecentralizedStableCoinTest is Test {
    DecentralizedStableCoin dsc;
    address dscOwner;

    function setUp() public {
        dscOwner = makeAddr("dscOwner");
        dsc = new DecentralizedStableCoin(dscOwner);
    }
}
