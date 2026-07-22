// SPDX-License-Identifier: MIT

pragma solidity ^0.8.21;

import {Test} from "forge-std/Test.sol";
import {DeployDSC} from "../../script/DeployDSC.s.sol";
import {DecentralizedStableCoin} from "../../src/DecentralizedStableCoin.sol";
import {DSCEngine} from "../../src/DSCEngine.sol";
import {ERC20} from "@openzeppelin/contracts/mocks/token/ERC20Mock.sol";

contract MintDscTest is Test {
    DecentralizedStableCoin private dsc;
    DSCEngine private dscEngine;
    ERC20 private weth;

    function setUp() public {
        DeployDSC deploy = new DeployDSC();
        (dsc, dscEngine, weth) = deploy.run();
    }

    function test_RevertWhen_AmountIsZero() external {
        vm.expectRevert(DSCEngine.DSCEngine__NeedsMoreThanZero.selector);
        dscEngine.mintDsc(0);
    }

    modifier whenAmountIsGreaterThanZero() {
        _;
    }

    function test_RevertGiven_UserHasNoCollateral() external whenAmountIsGreaterThanZero {
        // it should revert
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
        // it should record the minted DSC as user debt
        // it should credit user with DSC tokens
        // it should emit a DscMinted event
    }
}
