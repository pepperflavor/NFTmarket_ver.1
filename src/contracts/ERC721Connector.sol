// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import './ERC721Metadate.sol';
import './ERC721.sol';

// 커넥터가 메타데이터와 721 컨트랙트에 상속
contract ERC721Connector is ERC721Metadata, ERC721{
    
    constructor(string memory name, string memory symbol) ERC721Metadata(name, symbol) {

    }
}