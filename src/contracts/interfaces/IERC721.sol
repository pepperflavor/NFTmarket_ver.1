// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

// 인터페이스의 모든 함수를 상속받는 곳에서 사용하지 않으면 contract가 깨지기 때문에
// 사용하지 않는 것은 주석처리
interface IERC721{

    event Transfer(address indexed _from, address indexed _to, uint256 indexed _tokenId);

    //event Approval(address indexed _owner, address indexed _approved, uint256 indexed _tokenId);


    function balanceOf(address _owner) external view returns (uint256);

    function ownerOf(uint256 _tokenId) external view returns (address);

    // safeTransferFrom - 이 함수가 왜 두개인지 공식문서 참고
    //function safeTransferFrom(address _from, address _to, uint256 _tokenId, bytes data) external payable;

    // 전송이 완료되었을때 스마트 컨트랙트에서 우리가 전송하는 두 주소의 코드 크기를 확인함
    //function safeTransferFrom(address _from, address _to, uint256 _tokenId) external payable;


    function transferFrom(address _from, address _to, uint256 _tokenId) external;

    //function approve(address _approved, uint256 _tokenId) external payable;

    //function setApprovalForAll(address _operator, bool _approved) external;

    //function getApproved(uint256 _tokenId) external view returns (address);

    //function isApprovedForAll(address _owner, address _operator) external view returns (bool);
}