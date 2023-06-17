// SPDX-License-Identifier: MIT
pragma solidity ^0.8.4;

/*
    배열선언법
    데이터타입 [] 가시성 배열이름
    pop : 배열의 마지막 요소를 제거하고 나머지 요소들을 반환한다
    push : 하나 또는 그이상의 요소를 배열의 마지막 부분에 추가한후 새로운 배열을 반환함
    length : 문자열 프로퍼티이며 문자열의 길이를 뜻함
    delete : 인덱스를 지정하면 해당 인덱스에 담긴 값을 삭제하지만 데이터가 담겼던 공간을 삭제하지는 않기때문에
                길이는 그대로임
*/ 

contract learnArray{
    uint[] public myArray1;
    uint[] public myArray2;
    uint[200] public fixedSizeArray;

    function push(uint number) public {
        myArray1.push(number);
    }

    function pop() public {
        myArray1.pop();
    }

    function getLength() public view returns (uint){
       return myArray1.length;
    }

    function remove(uint i) public {
        delete myArray1[i];
    }

    uint [] public changeArray;

    // 삭제하려는 요소의 인덱스 값을 가장 마지막 인덱스로 바꾼다음 마지막인덱스를 삭제한 것
    // ex) [1,2,3,4] -> [1,4,3,4] -> [1,4,3]
    function removeElement(uint i) public {
        changeArray[i] = changeArray[changeArray.length -1 ];
        changeArray.pop();
    }

    function getChangeArray() public view returns(uint[] memory){

    }
}