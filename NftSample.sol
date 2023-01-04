//  SPDX-License-Identifier: MIT

pragma solidity ^0.8.4;

import "@openzeppelin/contracts@4.7.3/token/ERC721/ERC721.sol";
import "@openzeppelin/contracts@4.7.3/token/ERC721/extensions/ERC721URIStorage.sol";
import "@openzeppelin/contracts@4.7.3/access/Ownable.sol";
import "@openzeppelin/contracts@4.7.3/utils/Counters.sol";

contract NGX is ERC721, ERC721URIStorage, Ownable {
    using Counters for Counters.Counter;

    Counters.Counter private_tokenIdCounter;

    constructor() ERC721("NightOwl", "NO") {}

    function _baseURI() internal pure override returns (string memory) {
        return
            "ipfs://bafkreidwx6v4vb4tkhhcjdjnmpndxqqcxp6bnowtkzehmncpknx3x2rfhi";
    }

    function tokenURI(
        uint256
    ) public pure override(ERC721, ERC721URIStorage) returns (string memory) {
        return _baseURI();
    }

    function safeMint() public {
        uint256 tokenId = _tokenIdCounter.current();
        _tokenIdCounter.increment();
        _safeMint(msg.sender, tokenId);
    }

    function burn(uint256 tokenid) internal override(ERC721, ERC721URIStorage) {
        super._burn(tokenid);
    }
}
