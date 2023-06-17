// SPDX-License-Identifier: MIT
pragma solidity ^0.8.4;
// 컴파일러 버전 명시 : 버전마다 구문 및 뉘앙스가 달라진다고 함
// ^ : 컴파일 버전의 범위를 0이 아닌 소수점 다음 증분까지로 지정한다.

// 솔리디티 자체가 계약에 대한 언어이기 때문에 모든 코드 내용은 contract안에서 이뤄져야한다

/*
    public
    private
    external : 외부에서만 가시성이 생김
    internal : 내부에서만 가시성이 생김

    mapping : 인덱스가 존재하는 데이터를 저장하는 테이블, 주소를 추적할때 등 사용함
    key와 value값이 필요하다
    mapping(key => value) public mapName;

    이벤트란? 클라이언트가 여러분이 선언한 특정 계약 변경 사항에 반응할 수 있도록 함
    event eventName()
*/
// uint : uassigned integer
// 클래스? 객체와 비슷하다고 보면 됨
// 객체 : 상속 능력을 갖는 추상적 데이터 타입
contract CryptoToken{

    mapping(address => uint) public balances;

    //uint public tokens = 400;
    uint private totalSupply = 7;
    address public sender;

    address public minter;

    event Sent(address from, address to, uint amount);

    // 민팅 함수 생성
    function mint(address receiver, uint amount) public{
        // require : 괄호안의 내용의 참 거짓 여부를 확인하는 메서드
        require(msg.sender == minter);

        // mint 함수 내부에서 mapping에 접근 할 수 있다.
        // 특정 주소에 보내는 수량을 설정.

        balances[receiver] += amount;
    }

    function send(address receiver, uint amount) public{
        // 이벤트 접근 키워드 emit
        balances[msg.sender] -= amount;
        balances[receiver] += amount;
        emit Sent(msg.sender, receiver, amount);
    }

    // 생성자는 배포하는 즉시 호출된다, 배포할때마다 즉시 호출됨
    constructor(){
        // msg.sender : 솔리디티 자체 전역변수이다. 계약 배포자의 주소인 듯함
        // 즉 minter 라는 변수에 무조건 계약 발행자의 주소를 집어넣고 시작한다는뜻
        minter = msg.sender; 
    }
}

contract LearningSolidity{

}
