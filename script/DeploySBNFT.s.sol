// SPDX-License-Identifier: MIT
pragma solidity ^0.8.22;

import {Script} from "../lib/forge-std/src/Script.sol";
import {SBNFT} from "../src/SBNFT.sol";

contract DeploySBNFT is Script{

    function run() public {
        // Deploy the S7ANFT contract
        vm.startBroadcast();
        SBNFT sbnftcontract = new SBNFT(msg.sender);
        vm.stopBroadcast();
    }
}
