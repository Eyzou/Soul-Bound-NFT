// SPDX-License-Identifier: MIT
pragma solidity ^0.8.22;

import "forge-std/Test.sol";
import "../src/SBNFT.sol";

contract SBNFTTest is Test {
    SBNFT sbnft;
    address owner = address(0x1);
    address alice = address(0x2);
    address bob = address(0x3);

    function setUp() public {
        sbnft = new SBNFT(owner);
    }


    function testSafeMintOnlyOwner() public {
        vm.prank(owner);
        uint256 tokenId = sbnft.safeMint(alice, "ipfs://test-uri");
        assertEq(sbnft.getSupply(), tokenId + 1);
    }

    function testSafeMintRevertsIfNotOwner() public {
        vm.prank(alice);
        vm.expectRevert(); 
        sbnft.safeMint(alice, "ipfs://test-uri");
    }


    function testTransferReverts() public {
        vm.prank(owner);
        uint256 tokenId = sbnft.safeMint(alice, "ipfs://test-uri");

        vm.prank(alice);
        vm.expectRevert();
        sbnft.transferFrom(alice, bob, tokenId);
    }

    function testSafeTransferReverts() public {

        vm.prank(owner);
        uint256 tokenId = sbnft.safeMint(alice, "ipfs://test-uri");

  
        vm.prank(alice);
        vm.expectRevert(); 
        sbnft.safeTransferFrom(alice, bob, tokenId);
    }
}