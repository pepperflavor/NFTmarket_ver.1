// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;


import './ERC165.sol';
import './interfaces/IERC721.sol';

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
// ERC721은 반드시 ERC165의 인터페이스를 구현해야한다
contract ERC721 is ERC165, IERC721{

    // 전송할때는 1. 해당주소가 어디에서 오는지
    // 2. 해당주소가 어디로 가는지
    // 이벤트 생성
    // event Transfer(
    //     address indexed from, 
    //     address indexed to, 
    //     uint256 indexed tokenId
    //     );
    
    // uint == uint256
    // 토큰ID와 소유자에 관한 매핑
    mapping (uint => address) private _tokenOwner;

    // 토큰 소유자와 소유 토큰갯수에 대한 매핑
    mapping (address => uint) private _OwnedTokensCount; 

    // 토큰ID와 승인된 주소에 대한 매핑
    mapping(uint256 => address) private _tokenApprovals;

    constructor(){
        _registerInterface(bytes4(keccak256('balanceOf(bytes4)')^
                                    keccak256('ownerOd(bytes4)')^
                                    keccak256('transferFrom(bytes4)')));
    }

    // 지갑 주소에 속해있는 nft의 총 개수를 반환
    function balanceOf(address _owner) public override view returns(uint256){
        require(_owner != address(0), 'owner query for NONEexist token');
        return _OwnedTokensCount[_owner];
    } 

    // NFT 소유자를 찾고 0 주소가 부여된 nft는 무효이다
    function ownerOf(uint256 _tokenId) public override view returns(address){
        address owner = _tokenOwner[_tokenId];
        require(owner != address(0), 'owner query for NONE-exist token');
        return owner;
    }


    // 토큰 ID가 존재하는지 확인하는 함수
    // internal로 설정해서 truffle console에서 함수실행이 안된다 => balanceOf 함수 사용
    function _exist(uint tokenId) internal view returns(bool){
        // nft 소유자의 주소 확인, mapping 으로 토큰소유자의 주소 확인
        address owner = _tokenOwner[tokenId];
        // 주소값이 0이 아니라면 true
        return owner != address(0); 
    }

    // 오버라이드를 한 경우 상속해준 함수임을 표현해야함
    function _mint(address to, uint256 tokenId) internal virtual {
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

    // NFT 전송 함수
    // _from이 현재 소유자가 아니면 오류발생
    // _to 가 0이라면 오류발생
    function _transferFrom(address _from, address _to, uint256 _tokenId) internal {
        // 토큰ID를 토큰받는 주소로 추가
        // _to의 잔액 업데이트 하기 
        // 전송하는 주소가 실제로 토큰을 갖고있는지 검증
        require(_to != address(0), 'ERROR - ERC721 Transfer to the zero address!');
        //require(_from == _tokenOwner[_tokenId], 'ERROR - you are Not token owner');
        require(ownerOf(_tokenId) == _from, 'Trying to transfer a token the address dose not own!');
       
        _OwnedTokensCount[_from] -= 1;
        _OwnedTokensCount[_to] += 1;
        _tokenOwner[_tokenId] = _to;

        emit Transfer(_from, _to, _tokenId);
    }

    function transferFrom(address _from,address _to,uint256 _tokenId) override public {
        _transferFrom(_from, _to, _tokenId);
    }

}