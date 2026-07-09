// SPDX-License-Identifier: MIT

pragma solidity ^0.8.21;

import {IERC20} from "@openzeppelin/contracts/token/ERC20/IERC20.sol";

contract DSCEngine {
    error DSCEngine__TokenNotAllowed();
    error DSCEngine__NeedsMoreThanZero();
    error DSCEngine__TransferFailed();

    mapping(address token => bool supported) private s_supportedCollateralTokens;

    constructor (
        address[] memory supportedCollateralTokens
    ) {
        for (uint256 i = 0; i < supportedCollateralTokens.length; i++) {
            s_supportedCollateralTokens[supportedCollateralTokens[i]] = true;
        }
    }

    function depositCollateral(address collateralTokenAddress, uint256 collateralAmount) external {
        if (!s_supportedCollateralTokens[collateralTokenAddress]) {
            revert DSCEngine__TokenNotAllowed();
        }

        if (collateralAmount == 0) {
            revert DSCEngine__NeedsMoreThanZero();
        }

        bool result = IERC20(collateralTokenAddress).transferFrom(msg.sender, address(this), collateralAmount);
        if (!result) {
            revert DSCEngine__TransferFailed();
        }
    }
}