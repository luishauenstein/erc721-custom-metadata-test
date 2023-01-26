// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import "@forge-std/Script.sol";
import "../src/MutableNFT.sol";

contract MyScript is Script {

    function run() external {
        uint256 deployerPrivateKey = vm.envUint("PRIVATE_KEY");

        //
        // TOKEN METADATA
        //

        string memory name = "Luis' Mutable NFTs";
        string memory symbol = "MUTALUIS";
        string memory baseURI = "https://nft.luish.xyz/";
        //address owner = 0xA7695a6Fb16B0d20d7aA4Eb6615ED86f33c3e01a;
        
        vm.startBroadcast(deployerPrivateKey);
        MutableNFT nft = new MutableNFT(name, symbol, baseURI);  
        vm.stopBroadcast();
    }
}
