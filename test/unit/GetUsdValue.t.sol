// SPDX-License-Identifier: UNLICENSED

pragma solidity ^0.8.21;

import {Test} from "forge-std/Test.sol";
import {DeployDSC} from "../../script/DeployDSC.s.sol";
import {DecentralizedStableCoin} from "../../src/DecentralizedStableCoin.sol";
import {DSCEngine} from "../../src/DSCEngine.sol";
import {ERC20} from "@openzeppelin/contracts/mocks/token/ERC20Mock.sol";

contract GetUsdValueTest is Test {
    DecentralizedStableCoin private dsc;
    DSCEngine private dscEngine;
    ERC20 private weth;

    function setUp() public {
        DeployDSC deploy = new DeployDSC();
        (dsc, dscEngine, weth) = deploy.run();
    }

    function test_RevertWhen_TokenIsNotAllowed() external {
        address badToken = makeAddr("randomToken");

        vm.expectRevert(DSCEngine.DSCEngine__TokenNotAllowed.selector);
        dscEngine.getUsdValue(badToken, 1 ether);
    }

    modifier whenTokenIsAllowed() {
        _;
    }

    function test_WhenAmountIsOneWholeToken() external whenTokenIsAllowed {
        assertEq(dscEngine.getUsdValue(address(weth), 1 ether), 2000e18);
    }

    function test_WhenAmountIsMoreThanOneToken() external whenTokenIsAllowed {
        assertEq(dscEngine.getUsdValue(address(weth), 2 ether), 4000e18);
    }

    function test_WhenAnotherTokenHasADifferentPrice() external whenTokenIsAllowed {
        // it should use the price feed of the given token
    }
}
