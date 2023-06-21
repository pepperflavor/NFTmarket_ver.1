// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

    /*
        mint 함수를 생성할때 고려해야 할 것
        1. nft가 주소를 가리키게
        2. 토큰 ID 추적
        3. 누가 어떤 NFT를 소요하는지 토큰 ID에 대한 소유자 주소 추적 => 이럴때 mapping 사용
        4. 소유자 주소에 몇개의 NFT가 있는지 추적
        5. 위의 정보 로그들을 방출해야함 -> 이벤트를 생성해서 전송로그
            계약 주소, 민팅된 위치, ID등
    */

    // solidity 에서 mapping은 키-값에 대한 해시 테이블이 된다
contract ERC721{

    // 전송할때는 1. 해당주소가 어디에서 오는지
    // 2. 해당주소가 어디로 가는지
    // 이벤트 생성
    event Transfer(
        address indexed from, 
        address indexed to, 
        uint256 indexed tokenId);

    


    // uint == uint256
    mapping (uint => address) private _tokenOwner;

    mapping (address => uint) private _OwnedTokensCount; 

    // 토큰 ID가 존재하는지 확인
    function _exist(uint tokenId) internal view returns(bool){
        // nft 소유자의 주소 확인, mapping 으로 토큰소유자의 주소 확인
        address owner = _tokenOwner[tokenId];
        // 주소값이 0이 아니라면 true
        return owner != address(0);
    }

    function _mint(address to, uint tokenId) internal {
        // 민팅 요청자의 주소가 0이 아니어야함
        require(to != address(0), 'ERC721: minting to the zero address');
        // 토큰ID가 민팅요청자에게 없어야 함
        require(!_exist(tokenId), 'ERC721: token already minted!'); 
        // mint에 대한 tokenID와 새 주소 추가
        _tokenOwner[tokenId] = to;
        _OwnedTokensCount[to] += 1;

        // Transfer로 생성한 로그이벤트를 방출
        emit Transfer(address(0), to, tokenId);
    } 
}