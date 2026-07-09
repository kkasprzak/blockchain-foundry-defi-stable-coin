// SPDX-License-Identifier: MIT

pragma solidity ^0.8.21;

import {Test} from "forge-std/Test.sol";
import {ERC20Mock} from "@openzeppelin/contracts/mocks/token/ERC20Mock.sol";
import {DeployDSC} from "../../script/DeployDSC.s.sol";
import {DecentralizedStableCoin} from "../../src/DecentralizedStableCoin.sol";
import {DSCEngine} from "../../src/DSCEngine.sol";
import {MockERC20TransferFrom} from "../mock/MockERC20TransferFrom.sol";

contract DepositCollateralTest is Test {

    DecentralizedStableCoin private dsc;
    DSCEngine private dscEngine;
    ERC20Mock private weth;

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
        dscEngine.depositCollateral(address(weth), 0);
    }

    modifier whenAmountIsGreaterThanZero() {
        _;
    }

    function test_RevertWhen_TransferFails() external whenTokenIsAllowed whenAmountIsGreaterThanZero {
        address mockERC20 = address(new MockERC20TransferFrom());
        address[] memory tokens = new address[](1);
        tokens[0] = mockERC20;

        dscEngine = new DSCEngine(tokens);

        vm.expectRevert(DSCEngine.DSCEngine__TransferFailed.selector);
        dscEngine.depositCollateral(mockERC20, 100);
    }

    function test_WhenTransferSucceeds() external whenTokenIsAllowed whenAmountIsGreaterThanZero {
        uint256 amount = 100;
        address user = makeAddr("user");

        weth.mint(user, amount);
        vm.startPrank(user);
        weth.approve(address(dscEngine), amount);
        dscEngine.depositCollateral(address(weth), amount);
        vm.stopPrank();

        // it should record the deposited collateral
        
        // it should emit CollateralDeposited event

        // it should transfer tokens to the engine
        assertEq(weth.balanceOf(address(dscEngine)), amount);
        assertEq(weth.balanceOf(user), 0);
    }
}
