// SPDX-License-Identifier: UNLICENSED
pragma solidity 0.8.0;

contract MintDscTest {
    function test_RevertWhen_AmountIsZero() external {
        // it should revert
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
