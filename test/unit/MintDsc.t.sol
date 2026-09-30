// SPDX-License-Identifier: MIT

pragma solidity ^0.8.21;

import {Test} from "forge-std/Test.sol";
import {ERC20Mock} from "@openzeppelin/contracts/mocks/token/ERC20Mock.sol";
import {DeployDSC} from "../../script/DeployDSC.s.sol";
import {DecentralizedStableCoin} from "../../src/DecentralizedStableCoin.sol";
import {DSCEngine} from "../../src/DSCEngine.sol";

contract MintDscTest is Test {
    DecentralizedStableCoin private dsc;
    DSCEngine private dscEngine;
    ERC20Mock private weth;

    function setUp() public {
        DeployDSC deploy = new DeployDSC();
        (dsc, dscEngine, weth,) = deploy.run();
    }

    function test_RevertWhen_AmountIsZero() external {
        vm.expectRevert(DSCEngine.DSCEngine__NeedsMoreThanZero.selector);
        dscEngine.mintDsc(0);
    }

    modifier whenAmountIsGreaterThanZero() {
        _;
    }

    function test_RevertGiven_UserHasNoCollateral() external whenAmountIsGreaterThanZero {
        vm.expectRevert(DSCEngine.DSCEngine__HealthFactorBroken.selector);
        dscEngine.mintDsc(100);
    }

    function test_RevertGiven_UserHasInsufficientCollateral() external whenAmountIsGreaterThanZero {
        // it should revert
    }

    modifier givenUserHasEnoughCollateral() {
        _;
    }

    function test_RevertWhen_MintFails() external whenAmountIsGreaterThanZero givenUserHasEnoughCollateral {
        // it should revert
    }

    function test_WhenMintSucceeds() external whenAmountIsGreaterThanZero givenUserHasEnoughCollateral {
        uint256 amount = 1e18; // It's about 2000$ with chainlink mock setup
        address user = makeAddr("user");

        // it should record the minted DSC as user debt
        weth.mint(user, amount);
        vm.startPrank(user);
        weth.approve(address(dscEngine), amount);
        dscEngine.depositCollateral(address(weth), amount);
        dscEngine.mintDsc(500e18); // It should pass with HF = 2.0, comfortable headroom
        vm.stopPrank();

        assertEq(dscEngine.debtOf(user), 500e18);
        // it should credit user with DSC tokens
        // it should emit a DscMinted event
    }
}
