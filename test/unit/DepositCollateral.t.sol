// SPDX-License-Identifier: MIT

pragma solidity ^0.8.21;

import {Test} from "forge-std/Test.sol";
import {DeployDSC} from "../../script/DeployDSC.s.sol";
import {DecentralizedStableCoin} from "../../src/DecentralizedStableCoin.sol";
import {DSCEngine} from "../../src/DSCEngine.sol";

contract DepositCollateralTest is Test {

    DecentralizedStableCoin private dsc;
    DSCEngine private dscEngine;
    address private weth;

    function setUp() public {
        DeployDSC deploy = new DeployDSC();
        (dsc, dscEngine, weth) = deploy.run();
    }

    function test_RevertWhen_TokenIsNotAllowed() external {
        address badToken = makeAddr("randomToken");

        vm.expectRevert(DSCEngine.DSCEngine__TokenNotAllowed.selector);
        dscEngine.depositCollateral(badToken, 100);
    }

    modifier whenTokenIsAllowed() {
        _;
    }

    function test_RevertWhen_AmountIsZero() external whenTokenIsAllowed {
        vm.expectRevert(DSCEngine.DSCEngine__NeedsMoreThanZero.selector);
        dscEngine.depositCollateral(weth, 0);
    }

    modifier whenAmountIsGreaterThanZero() {
        _;
    }

    function test_RevertWhen_TransferFails() external whenTokenIsAllowed whenAmountIsGreaterThanZero {
        // it should revert
    }

    function test_WhenTransferSucceeds() external whenTokenIsAllowed whenAmountIsGreaterThanZero {
        // it should record the deposited collateral
        // it should emit CollateralDeposited event
        // it should transfer tokens to the engine
    }
}
