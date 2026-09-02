// SPDX-License-Identifier: MIT
pragma solidity ^0.8.21;

import {Test} from "forge-std/Test.sol";
import {DeployDSC} from "../../script/DeployDSC.s.sol";
import {DecentralizedStableCoin} from "../../src/DecentralizedStableCoin.sol";
import {DSCEngine} from "../../src/DSCEngine.sol";
import {ERC20Mock} from "@openzeppelin/contracts/mocks/token/ERC20Mock.sol";

contract TotalCollateralValueOfTest is Test {
    DecentralizedStableCoin private dsc;
    DSCEngine private dscEngine;
    ERC20Mock private weth;
    ERC20Mock private wbtc;

    function setUp() public {
        DeployDSC deploy = new DeployDSC();
        (dsc, dscEngine, weth, wbtc) = deploy.run();
    }

    function test_GivenUserHasNoCollateral() external {
        address user = makeAddr("user");

        assertEq(dscEngine.totalCollateralValueOf(user), 0);    
    }

    function test_GivenUserDepositedASingleCollateralToken() external {
        address user = makeAddr("user");

        weth.mint(user, 10e18);
        vm.startPrank(user);
        weth.approve(address(dscEngine), 1e18);
        dscEngine.depositCollateral(address(weth), 1e18);
        vm.stopPrank();

        assertEq(dscEngine.totalCollateralValueOf(user), 2000e18);
    }

    function test_GivenUserDepositedMultipleCollateralTokens() external {
        address user = makeAddr("user");

        weth.mint(user, 10e18);
        wbtc.mint(user, 10e18);
        vm.startPrank(user);
        weth.approve(address(dscEngine), 1e18);
        wbtc.approve(address(dscEngine), 2e18);
        dscEngine.depositCollateral(address(weth), 1e18);
        dscEngine.depositCollateral(address(wbtc), 2e18);
        vm.stopPrank();

        assertEq(dscEngine.totalCollateralValueOf(user), 2000e18 + 2 * 1000e18);
    }
}
