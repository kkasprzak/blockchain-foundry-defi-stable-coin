// SPDX-License-Identifier: MIT 

pragma solidity ^0.8.21;

import {Test} from "forge-std/Test.sol";
import {DeployDSC} from "../../script/DeployDSC.s.sol";
import {DecentralizedStableCoin} from "../../src/DecentralizedStableCoin.sol";
import {DSCEngine} from "../../src/DSCEngine.sol";

contract DSCEngineTest is Test {
    DecentralizedStableCoin private dsc;
    DSCEngine private dscEngine;

    function setUp() public {
        DeployDSC deploy = new DeployDSC();
        (dsc, dscEngine) = deploy.run();
    }
}