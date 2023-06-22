// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import './ERC721.sol';
import './interfaces/IERC721Enumerable.sol';


// enumerable - enum을 의미하는게 아닌 수학적인 열거를 의미한다. 
// 즉 이뉴머레이팅은 '한 집합 내 모든 항목이 완전히 순서가 매겨진 것'
contract ERC721Enumerable is IERC721Enumerable, ERC721 {

    uint256[] private _allTokens;

    // public external로 설정해야하는 정보가 아니면 기본적으로 private로 한다
    // tokenId에서 _allTokens의 위치로 매핑
    // ex) 첫번째 토큰이 몇번째 인덱스에 있을지 가리킴
    mapping(uint256 => uint256) private _allTokensIndex;

    // 지갑에 속한 모든 tokenid 들을 목록에 매핑- 토큰을 몇개 가졌는지 알아낼 수 있다.
    // 지갑주소 - 토큰ID들이 담긴 배열 - 배열의 길이== 소유한 NFT갯수
    mapping (address => uint256[]) private _ownedTokens;

    // 토큰소유자의 목록(배열)에서 토큰의 인덱스 매핑
    // 토큰ID에서 소유자 토큰목록의 인덱스로 매핑
    // 토큰ID를 가져와서 인덱스 값을 확인
    mapping(uint256 => uint256) private _ownedTokensIndex;

        constructor(){
        _registerInterface(bytes4(keccak256('totalSupply(bytes4)')^
                                    keccak256('tokenByIndex(bytes4)')^
                                    keccak256('tokenOfOwnerByIndex(bytes4)')));
    }

    // ERC721에 있는 _mint 오버라이드
    function _mint(address to, uint256 tokenId) internal override(ERC721){
        super._mint(to, tokenId);

        // 1. 기본적으로 민팅할때 소유자에게 토큰추가
        // 2. totalSupply에 토큰 추가 - allTokens에
        _addTokensToAllTokenEnumeration(tokenId);
        _addTokensToOwnerEnumeration(to, tokenId);
    }

    // 총 곱급량에 토큰추가, 모든 토큰을 토큰 이뉴머레이션에 추가
    // _allTokens 배열에 토큰을 추가하고 토큰 인덱스의 위치를 설정
    function _addTokensToAllTokenEnumeration(uint256 tokenId) private {
        _allTokensIndex[tokenId] = _allTokens.length;
        _allTokens.push(tokenId);
    }

    function _addTokensToOwnerEnumeration(address to, uint256 tokenId) private {
        // 1. _ownedTokens에 주소와 토큰ID 추가하기
        // 2. _ownedTokensIndex에 tokenId를 위치 주소로 설정하고 
        // 3. 민팅함수와 함께 실행
        _ownedTokensIndex[tokenId] = _ownedTokens[to].length;
        _ownedTokens[to].push(tokenId);
    }

    // tokenByIndex를 반환하는 함수, tokenByOwnerIndex를 반환하는 함수
    // 인덱스를 통해 검색해서 토큰ID를 반환받을 함수
    function tokenByIndex(uint256 index) public override view returns(uint256){
        // 총 공급량< 인덱스 가 되지않도록 조건 설정
        require(index < totalSupply(), 'global index is not of bounds!');
        return _allTokens[index];
    }

    function tokenOfOwnerByIndex(address owner, uint256 index) public override view returns (uint256){
       // 지갑에 속한 nft 개수 > 인덱스 가 되지 않도록 조건 설정
       require(index < balanceOf(owner), 'owner index is not of bounds!');
       return _ownedTokens[owner][index];
    }

    // public으로 설정했기 때문에 private로 설정해놓은 _allTokens로 한 연산값이 보임
    // _allTokens 배열의 길이 == 총 공급량을 반환
    function totalSupply() public override view returns(uint256){
        return _allTokens.length;
    }

}