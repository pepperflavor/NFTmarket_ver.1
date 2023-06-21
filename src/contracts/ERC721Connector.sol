// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import './ERC721Metadate.sol';
import './ERC721.sol';
import './ERC721Enumerable.sol';

// 커넥터가 메타데이터와 721 컨트랙트에 상속 ->
// ERC721Enumerable에서 ERC721을 상속중이기 때문에 ERC721Enumerable만 상속해도 
// 제대로 작동한다
contract ERC721Connector is ERC721Metadata, ERC721Enumerable{
    
    constructor(string memory name, string memory symbol) ERC721Metadata(name, symbol) {

    }
}