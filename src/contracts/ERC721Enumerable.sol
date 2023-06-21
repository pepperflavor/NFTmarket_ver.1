// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import './ERC721.sol';


// enumerable - enum을 의미하는게 아닌 수학적인 열거를 의미한다. 
// 즉 이뉴머레이팅은 '한 집합 내 모든 항목이 완전히 순서가 매겨진 것'
contract ERC721Enumerable is ERC721 {

    uint256[] private _allTokens;

    // public external로 설정해야하는 정보가 아니면 기본적으로 private로 한다
    // tokenId에서 _allTokens의 위치로 매핑
    // ex) 첫번째 토큰이 몇번째 인덱스에 있을지 가리킴
    mapping(uint256 => uint256) private _allTokensIndex;

    // 지갑에 속한 모든 tokenid 들을 목록에 매핑- 토큰을 몇개 가졌는지 알아낼 수 있다.
    mapping (address => uint256[]) private _ownedTokens;

    // 토큰소유자의 목록(배열)에서 토큰의 인덱스 매핑
    // 토큰ID에서 소유자 토큰목록의 인덱스로 매핑
    // 토큰ID를 가져와서 인덱스 값을 확인
    mapping(uint256 => uint256) private _ownedTokensIndex;


    function tokenByIndex(uint256 _index) external view returns (uint256){

    }


    function tokenOfOwnerByIndex(address _owner, uint256 _index) external view returns (uint256){

    }

    // ERC721에 있는 _mint 오버라이드
    function _mint(address to, uint256 tokenId) internal override(ERC721){
        super._mint(to, tokenId);

        // 1. 기본적으로 민팅할때 소유자에게 토큰추가
        // 2. totalSupply에 토큰 추가 - allTokens에
        _addTokensToToatalSupply(tokenId);
    }

    function _addTokensToToatalSupply(uint256 tokenId) private {
        _allTokens.push(tokenId);
    }

    // public으로 설정했기 때문에 private로 설정해놓은 _allTokens로 한 연산값이 보임
    function totalSupply() public view returns(uint256){
        return _allTokens.length;
    }

}