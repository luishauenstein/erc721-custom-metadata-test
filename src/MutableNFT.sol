// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import "@oz-contracts/access/Ownable.sol";
import "@solmate/tokens/ERC721.sol";
import "@oz-contracts/utils/Strings.sol";

contract MutableNFT is Ownable, ERC721 {
    
    using Strings for uint256;
    string public baseURI;
    uint256 public currentTokenId;
    
    constructor(
        string memory name_,
        string memory symbol_,
        string memory baseURI_
    ) ERC721 (name_, symbol_){
        baseURI = baseURI_;
    }

    //
    // TOKEN URI
    //

    function tokenURI(uint256 tokenId)
    public
    view
    override
    returns (string memory)
    {
        return
        bytes(baseURI).length > 0
        ? string(abi.encodePacked(baseURI, tokenId.toString(), ".json"))
        : "";
    }

    function setBaseURI (string memory newBaseURI_) public onlyOwner {
        baseURI = newBaseURI_;
    }

    //
    // MINT & SUPPLY
    //

    function mintTo(address recipient) public onlyOwner returns (uint256) {
        uint256 newTokenId = ++currentTokenId;
        _safeMint(recipient, newTokenId);
        return newTokenId;
    }

    function totalSupply() public view returns (uint256) {
        return currentTokenId;
    }
}
