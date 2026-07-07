// SPDX-License-Identifier: MIT

pragma solidity ^0.8.21;

contract DSCEngine {
    error DSCEngine__TokenNotAllowed();
    error DSCEngine__NeedsMoreThanZero();

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
    }
}