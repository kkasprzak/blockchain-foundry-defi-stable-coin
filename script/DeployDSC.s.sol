// SPDX-License-Identifier: MIT

pragma solidity ^0.8.21;

import {Script} from "forge-std/Script.sol";
import {DecentralizedStableCoin} from "../src/DecentralizedStableCoin.sol";
import {DSCEngine} from "../src/DSCEngine.sol";

contract DeployDSC is Script {
    function run() public returns (DecentralizedStableCoin, DSCEngine) {
        address owner = makeAddr("owner");
        DecentralizedStableCoin dsc;
        DSCEngine dscEngine;

        vm.startBroadcast();
        dsc = new DecentralizedStableCoin(owner);
        dscEngine = new DSCEngine();
        vm.stopBroadcast();

        return (dsc, dscEngine);
    }
}