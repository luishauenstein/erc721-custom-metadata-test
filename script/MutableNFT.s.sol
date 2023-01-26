// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import "@forge-std/Script.sol";
import "../src/MutableNFT.sol";

contract MyScript is Script {

    function run() external {

        string memory name = "Luis' Mutable NFTs";
        string memory symbol = "MUTALUIS";
        string memory baseURI = "https://nft.luish.xyz/";
        address owner = 0xeFfF014686EAff6406dEAd423511fA608e1CBfe8;
        
        vm.startBroadcast(owner);
        new MutableNFT(name, symbol, baseURI);  
        vm.stopBroadcast();
    }
}
