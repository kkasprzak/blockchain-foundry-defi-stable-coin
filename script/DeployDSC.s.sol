// SPDX-License-Identifier: MIT

pragma solidity ^0.8.21;

import {Script} from "forge-std/Script.sol";
import {DecentralizedStableCoin} from "../src/DecentralizedStableCoin.sol";
import {DSCEngine} from "../src/DSCEngine.sol";
import {ERC20Mock} from "@openzeppelin/contracts/mocks/token/ERC20Mock.sol";
import {MockV3Aggregator} from "@chainlink/contracts/src/v0.8/tests/MockV3Aggregator.sol";

contract DeployDSC is Script {
    function run() public returns (DecentralizedStableCoin, DSCEngine, ERC20Mock, ERC20Mock) {
        address owner = makeAddr("owner");
        DecentralizedStableCoin dsc;
        DSCEngine dscEngine;
        ERC20Mock weth;
        ERC20Mock wbtc;
        MockV3Aggregator wethPriceFeed;
        MockV3Aggregator wbtcPriceFeed;

        vm.startBroadcast();
        weth = new ERC20Mock();
        wbtc = new ERC20Mock();
        address[] memory tokens = new address[](2);
        tokens[0] = address(weth);
        tokens[1] = address(wbtc);

        wethPriceFeed = new MockV3Aggregator(8, 2000e8);
        wbtcPriceFeed = new MockV3Aggregator(8, 1000e8);
        address[] memory feeds = new address[](2);
        feeds[0] = address(wethPriceFeed);
        feeds[1] = address(wbtcPriceFeed);

        dsc = new DecentralizedStableCoin(owner);
        dscEngine = new DSCEngine(tokens, feeds);
        vm.stopBroadcast();

        return (dsc, dscEngine, weth, wbtc);
    }
}