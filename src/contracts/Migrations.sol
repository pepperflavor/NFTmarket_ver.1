// SPDX-License-Identifier: MIT
pragma solidity >=0.4.22 <0.9.0;

// msg.sender : 현재 호출자
// 가상의 내 지갑으로 연결하기
contract Migrations {
  address public owner = msg.sender;
  uint public last_completed_migration;

// modifier : 제어자, 함수에 커스터마이징 가능한 제한을 하는 것
// 계약의 소유자를 호출자(나)로 제한한 것
  modifier restricted() {
    require(
      msg.sender == owner, 
      "This function is restricted to the contract's owner!"
    );
    _; // _ : 언더바는 함수를 계속해서 실행한다는 의미이다
  }

  // restricted : 제어범위를 제한
  // setCompleted 함수의 역할은 마지막으로 완료된 각 이전의 정보를 추적함
  function setCompleted(uint completed) public restricted {
    last_completed_migration = completed;
  }

  // 새 주소를 Migrations의 새 계약으로 설정한다
  function upgrade(address new_address) public restricted {
    // 클래스처럼 작동하는 것으로 이해하면 편할 듯
    Migrations upgraded = Migrations(new_address);
    upgraded.setCompleted(last_completed_migration);
  }
}
