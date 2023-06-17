pragma solidity ^0.8.4;

/*
    변수 :  정보를 저장할 공간, 실제로 메모리 공간을 차지한다.

    주요 자료형 3가지 : Booleans, Integers, Strings
    Booleans - keyword: bool / Value : true/false 
    Integers keyword: uint 
    Strings keyword: string  
*/

contract LearnVariable{
    uint eggs = 10;
    bool isEmpty = true;
    string errorMessage = 'Sorry, we failed :(';
}

contract Excercise{
    uint wallet = 500;
    bool spend = false;
    string notifySpend = 'you have spent money to notifySpend';
}