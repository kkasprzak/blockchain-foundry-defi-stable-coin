// SPDX-License-Identifier: MIT

pragma solidity ^0.8.21;

import {IERC20} from "@openzeppelin/contracts/token/ERC20/IERC20.sol";

contract DSCEngine {
    error DSCEngine__TokenNotAllowed();
    error DSCEngine__NeedsMoreThanZero();
    error DSCEngine__TransferFailed();
    error DSCEngine__HealthFactorBroken();

    uint256 constant private FEED_PRECISION = 1e8;
    uint256 constant private PRECISION = 1e18;
    uint256 constant private ADDITIONAL_FEED_PRECISION = PRECISION / FEED_PRECISION;

    mapping(address token => address priceFeed) private s_priceFeeds;
    mapping(address user => mapping(address token => uint256 amount)) private s_depositedCollateral;
    address[] private s_collateralTokens;

    event CollateralDeposited(address indexed user, address indexed token, uint256 amount);

    modifier moreThanZero(uint256 amount) {
        if (amount == 0) {
            revert DSCEngine__NeedsMoreThanZero();
        }
        _;
    }

    modifier isAllowedToken(address token) {
        if (s_priceFeeds[token] == address(0)) {
            revert DSCEngine__TokenNotAllowed();
        }
        _;
    }

    constructor (
        address[] memory tokens,
        address[] memory priceFeeds
    ) {
        for (uint256 i = 0; i < tokens.length; i++) {
            s_priceFeeds[tokens[i]] = priceFeeds[i];
            s_collateralTokens.push(tokens[i]);
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
        if (totalCollateralValueOf(msg.sender) == 0) {
            revert DSCEngine__HealthFactorBroken();
        }
    }

    function totalCollateralValueOf(address user) private view returns (uint256) {
        return 0;
    }

    function getUsdValue(address token, uint256 amount) external view isAllowedToken(token) returns (uint256) {
        uint256 tokenPrice = 2000e8;
        uint256 adjustedTokenPrice = tokenPrice * ADDITIONAL_FEED_PRECISION;

        return (adjustedTokenPrice * amount) / PRECISION;
    }
}
