// SPDX-License-Identifier: MIT

pragma solidity ^0.8.21;

contract DepositCollateralTest {
    function test_RevertWhen_TokenIsNotAllowed() external {
        // it should revert
    }

    modifier whenTokenIsAllowed() {
        _;
    }

    function test_RevertWhen_AmountIsZero() external whenTokenIsAllowed {
        // it should revert
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
