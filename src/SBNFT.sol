// SPDX-License-Identifier: MIT
// Compatible with OpenZeppelin Contracts ^5.0.0
pragma solidity ^0.8.22;

import {ERC721} from "../lib/openzeppelin-contracts/contracts/token/ERC721/ERC721.sol";
import {ERC721URIStorage} from "../lib/openzeppelin-contracts/contracts/token/ERC721/extensions/ERC721URIStorage.sol";
import {Ownable} from "../lib/openzeppelin-contracts/contracts/access/Ownable.sol";
import {IERC721Errors} from "../lib/openzeppelin-contracts/contracts/interfaces/draft-IERC6093.sol";

// @author : Elodie
// @notice: This contract is a simple ERC721 contract with URI storage and minting function. (from Oppenzeppelin Wizard template)

contract SBNFT is ERC721, ERC721URIStorage, Ownable {
    uint256 private _nextTokenId;

    constructor(address initialOwner)
        ERC721("TestSBNFT", "SBNFT")
        Ownable(initialOwner)
    {}

    function safeMint(address to, string memory uri)
        public
        onlyOwner
        returns (uint256)
    {
        uint256 tokenId = _nextTokenId++;
        _safeMint(to, tokenId);
        _setTokenURI(tokenId, uri);
        return tokenId;
    }

    // The following functions are overrides required by Solidity.

    function tokenURI(uint256 tokenId)
        public
        view
        override(ERC721, ERC721URIStorage)
        returns (string memory)
    {
        return super.tokenURI(tokenId);
    }

    function supportsInterface(bytes4 interfaceId)
        public
        view
        override(ERC721, ERC721URIStorage)
        returns (bool)
    {
        return super.supportsInterface(interfaceId);
    }

    // Get the code from the API _beforeTokenTransfer has been replaced by _update: https://docs.openzeppelin.com/contracts/3.x/api/token/erc721
    // we override _update fonction from the transferFrom function in ERC721.sol.
    // added the from address to the return value to be able to check if the sender is the owner of the token. to avoid the transfer of SBTs.

    function _update(address to, uint256 tokenId, address auth) internal override returns( address) {
        address from = super._update(to, tokenId, auth);
        if (from != address(0)) {
            revert IERC721Errors.ERC721InvalidSender(from); // SBTs are non-transferrable.
        }
        return from;
    }

    function getSupply() public view returns (uint256) {
        return _nextTokenId;
    }

}
