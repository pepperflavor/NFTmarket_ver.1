// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0; 
// 참고
// https://eips.ethereum.org/EIPS/eip-721

import './ERC721Connector.sol';

// KryptoBird가 커넥터를 상속하니
// 커넥터가 상속하는 메타데이터, 721 컨트랙트의 함수등도 사용할 수 있게됨
contract KryptoBird is ERC721Connector{

    // nft 저장할 배열
    string[] public kryptoBirdz;

    // 이미 존재하는 이미지에대한 민팅이 이루어지지 않도록
    // id가 존재하는지 여부를 확인하는 매핑
    // 민팅 할때마다 민팅하는 크립토버드에 문자열을 부여하고 그 값이 참이면 map에 저장
    mapping(string => bool) _kryptoBirdzExists;

    // 상속한 _mint 함수를 호출하고 배열에 nft에 대한 정보 추가
    function mint(string memory _kryptoBird) public{
        // 존재하지 않아야 함
        require(!_kryptoBirdzExists[_kryptoBird], 'Error - kryptoBird already exists');
        // push 메서드는 0.6 버전 이후로 사용되지 않는다
        // .push : 배열의 길이를 변경하지 않고추가된 요소에 대한 참조만을 반환함, 길이값을 반환해주지 않도록 바뀌었다
        // uint _id = KryptoBirdz.push(_kryptoBird);

        kryptoBirdz.push(_kryptoBird);
        uint _id = kryptoBirdz.length - 1;

        _mint(msg.sender, _id);

        _kryptoBirdzExists[_kryptoBird] = true;
    }

    constructor() ERC721Connector('KryptoBird', 'KBIRDZ') {

    }

}