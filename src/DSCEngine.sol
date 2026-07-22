// SPDX-License-Identifier: MIT

pragma solidity ^0.8.21;

import {IERC20} from "@openzeppelin/contracts/token/ERC20/IERC20.sol";

contract DSCEngine {
    error DSCEngine__TokenNotAllowed();
    error DSCEngine__NeedsMoreThanZero();
    error DSCEngine__TransferFailed();

    mapping(address token => bool supported) private s_supportedCollateralTokens;
    mapping(address user => mapping(address token => uint256 amount)) private s_depositedCollateral;

    event CollateralDeposited(address indexed user, address indexed token, uint256 amount);

    modifier moreThanZero(uint256 amount) {
        if (amount == 0) {
            revert DSCEngine__NeedsMoreThanZero();
        }
        _;
    }

    modifier isAllowedToken(address token) {
        if (!s_supportedCollateralTokens[token]) {
            revert DSCEngine__TokenNotAllowed();
        }
        _;
    }

    constructor (
        address[] memory supportedCollateralTokens
    ) {
        for (uint256 i = 0; i < supportedCollateralTokens.length; i++) {
            s_supportedCollateralTokens[supportedCollateralTokens[i]] = true;
        }
    }

    function depositCollateral(address collateralTokenAddress, uint256 collateralAmount) external isAllowedToken(collateralTokenAddress) moreThanZero(collateralAmount) {
        s_depositedCollateral[msg.sender][collateralTokenAddress] += collateralAmount;
        emit CollateralDeposited(msg.sender, collateralTokenAddress, collateralAmount);

        bool result = IERC20(collateralTokenAddress).transferFrom(msg.sender, address(this), collateralAmount);
        if (!result) {
            revert DSCEngine__TransferFailed();
        }
    }

    function depositedCollateralOf(address user, address collateralTokenAddress) external view returns (uint256) {
        return s_depositedCollateral[user][collateralTokenAddress];
    }

    function mintDsc(uint256 amount) external moreThanZero(amount) {
    }
}
