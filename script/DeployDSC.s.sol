// SPDX-License-Identifier: MIT

pragma solidity ^0.8.21;

import {Script} from "forge-std/Script.sol";
import {DecentralizedStableCoin} from "../src/DecentralizedStableCoin.sol";
import {DSCEngine} from "../src/DSCEngine.sol";
import {ERC20Mock} from "@openzeppelin/contracts/mocks/token/ERC20Mock.sol";
import {MockV3Aggregator} from "@chainlink/contracts/src/v0.8/tests/MockV3Aggregator.sol";

contract DeployDSC is Script {
    function run() public returns (DecentralizedStableCoin, DSCEngine, ERC20Mock) {
        address owner = makeAddr("owner");
        DecentralizedStableCoin dsc;
        DSCEngine dscEngine;
        ERC20Mock weth;
        MockV3Aggregator priceFeed;

        vm.startBroadcast();
        weth = new ERC20Mock();
        address[] memory tokens = new address[](1);
        tokens[0] = address(weth);

        priceFeed = new MockV3Aggregator(8, 2000e8);
        address[] memory feeds = new address[](1);
        feeds[0] = address(priceFeed);

        dsc = new DecentralizedStableCoin(owner);
        dscEngine = new DSCEngine(tokens, feeds);
        vm.stopBroadcast();

        return (dsc, dscEngine, weth);
    }
}