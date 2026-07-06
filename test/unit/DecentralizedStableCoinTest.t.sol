// SPDX-License-Identifier: MIT

pragma solidity ^0.8.21;

import {Test} from "forge-std/Test.sol";
import {DecentralizedStableCoin} from "../../src/DecentralizedStableCoin.sol";
import {Ownable} from "@openzeppelin/contracts/access/Ownable.sol";

contract DecentralizedStableCoinTest is Test {
    DecentralizedStableCoin dsc;
    address dscOwner;

    function setUp() public {
        dscOwner = makeAddr("dscOwner");
        dsc = new DecentralizedStableCoin(dscOwner);
    }

    function testOnlyOwnerCanBurnTokens() public {
        vm.expectRevert(
            abi.encodeWithSelector(
                Ownable.OwnableUnauthorizedAccount.selector,
                address(this)
            )
        );
        dsc.burn(10);
    }

    function testBurnThrowsErrorWhenAmountIsLessOrEqualToZero() public {
        vm.prank(dscOwner);

        vm.expectRevert(
            DecentralizedStableCoin.DSC__MustBeMoreThanZero.selector
        );
        dsc.burn(0);
    }

    function testBurnThrowsErrorWhenUserDoesNotHaveEnoughtBalanceOnHisAccount()
        public
    {
        vm.prank(dscOwner);

        vm.expectRevert(
            DecentralizedStableCoin.DSC__BurnAmountExceedsBalance.selector
        );
        dsc.burn(10);
    }

    function testBurnReducesBalanceOfTokenOnTheUserAccount() public {
        uint256 amountToBurn = 10 ether;
        uint256 initialBalance = 100 ether;

        deal(address(dsc), dscOwner, initialBalance);

        vm.prank(dscOwner);
        dsc.burn(amountToBurn);

        assertEq(dsc.balanceOf(dscOwner), initialBalance - amountToBurn);
    }

    function testOnlyOwnerCanMintTokens() public {
        vm.expectRevert(
            abi.encodeWithSelector(
                Ownable.OwnableUnauthorizedAccount.selector,
                address(this)
            )
        );
        dsc.mint(makeAddr("user"), 10);
    }

    function testMintThrowsErrorWhenRecipientAddressIsIncorrect() public {
        vm.prank(dscOwner);

        vm.expectRevert(
            DecentralizedStableCoin.DSC__RecipientAddressIncorect.selector
        );
        dsc.mint(address(0), 10);
    }

    function testMintThrowsErrorWhenAmountIsLessOrEqualToZero() public {
        vm.prank(dscOwner);

        vm.expectRevert(
            DecentralizedStableCoin.DSC__MustBeMoreThanZero.selector
        );
        dsc.mint(makeAddr("user"), 0);
    }

    function testMintIncreasesBalanceOfTokensOnUserAccount() public {
        uint256 amountToMint = 10 ether;
        uint256 initialBalance = 100 ether;
        address userAddress = makeAddr("user");

        deal(address(dsc), userAddress, initialBalance);

        vm.prank(dscOwner);
        dsc.mint(userAddress, amountToMint);

        assertEq(dsc.balanceOf(userAddress), initialBalance + amountToMint);
    }
}
