// SPDX-License-Identifier: MIT

pragma solidity ^0.8.21;

import {Test} from "forge-std/Test.sol";
import {DeployDSC} from "../../script/DeployDSC.s.sol";
import {DecentralizedStableCoin} from "../../src/DecentralizedStableCoin.sol";
import {DSCEngine} from "../../src/DSCEngine.sol";
import {ERC20} from "@openzeppelin/contracts/mocks/token/ERC20Mock.sol";

contract HealthFactorOfTest is Test {
    DecentralizedStableCoin private dsc;
    DSCEngine private dscEngine;

    function setUp() public {
        DeployDSC deploy = new DeployDSC();
        (dsc, dscEngine,,) = deploy.run();
    }

    function test_GivenUserHasNoDebt() external {
        assertEq(dscEngine.healthFactorOf(makeAddr("user")), type(uint256).max);
    }

    function test_GivenUserHasDebt() external {
        // it should return the ratio of liquidation-adjusted collateral to debt
    }
}
