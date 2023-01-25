// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import "@forge-std/Test.sol";
import "../src/MutableNFT.sol";

contract MutableNFTTest is Test {

    MutableNFT nft;

    function setUp() public {
        
        string memory name = "Luis' Mutable NFTs";
        string memory symbol = "MUTALUIS";
        string memory baseURI = "https://nft.luish.xyz/";

        nft = new MutableNFT(name, symbol, baseURI);
    }

    function testMintTo() public {
        // test that owner can mint NFTs (also tests ownerOf() and balanceOf())
        nft.mintTo(msg.sender);
        assertEq(nft.ownerOf(1), msg.sender);
        
        nft.mintTo(address(1));
        assertEq(nft.ownerOf(2), address(1));
    }

    function testFailMintTo() public {
        // check that non-owner can't mint any NFTs
        vm.prank(address(0));
        nft.mintTo(msg.sender);
    }

    function testBalanceOf() public {
        nft.mintTo(address(1));
        nft.mintTo(address(1));
        nft.mintTo(address(1));
        assertEq(nft.balanceOf(address(1)), 3);
    }

    function testTransferOwnership() public {
        nft.transferOwnership(address(2));
        assertEq(nft.owner(), address(2));
        
        vm.prank(address(2));
        nft.transferOwnership(address(1));
        assertEq(nft.owner(), address(1));
    }

    function testFailTransferOwnership() public {
        vm.prank(address(1));
        nft.transferOwnership(address(1));
    }

    function testTokenURI() public {
        nft.mintTo(address(1));
        assertEq(nft.tokenURI(1),"https://nft.luish.xyz/1.json");

        nft.mintTo(address(1));
        assertEq(nft.tokenURI(2),"https://nft.luish.xyz/2.json");
    }

    function testSetBaseURI() public {
        nft.mintTo(address(1));
        nft.setBaseURI("https://abc.xyz/");
        assertEq(nft.tokenURI(1),"https://abc.xyz/1.json");
    }
}
