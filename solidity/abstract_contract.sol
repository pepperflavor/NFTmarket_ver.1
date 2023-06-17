// SPDX-License-Identifier: MIT
pragma solidity ^0.8.4;

// 추상적계약 - abstract

abstract contract X{
    function y() public view returns(string memory){
        return 'hello';
    }

}