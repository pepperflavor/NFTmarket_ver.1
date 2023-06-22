// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import './interfaces/IERC721Metadata.sol';
import './ERC165.sol';

contract ERC721Metadata is IERC721Metadata, ERC165{
    // KryptoBird에 있던 메타데이터 옮김
    string private _name;
    string private _symbol;

    constructor (string memory named, string memory symboled){
        _registerInterface(bytes4(keccak256('name(bytes4)')^
                                    keccak256('symbol(bytes4)')));

        _name = named;
        _symbol = symboled;
    }

    // 외부에서 메타데이터에 접근(조회만)할 수 있도록 external로 설정
    function name() external view override returns(string memory){
        return _name;
    }

    function symbol() external view override returns(string memory){
        return _symbol;
    }

}