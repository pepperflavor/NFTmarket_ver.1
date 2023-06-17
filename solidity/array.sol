pragma solidity ^0.8.4;

/*
    배열선언법
    데이터타입 [] 가시성 배열이름
    pop
    push
    length
*/ 

contract learnArray{
    uint[] public myArray1;
    uint[] public myArray2;
    uint[200] public fixedSizeArray;

    function push(uint number) public {
        myArray1.push(number);
    }
}