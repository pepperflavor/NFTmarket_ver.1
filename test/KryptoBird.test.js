const { assert } = require("chai");
/*
    차이 : 단언 라이브러리
    참고 : https://www.chaijs.com/
*/

const KryptoBird = artifacts.require("./KryptoBird");

// 차이 / 블록체인과 비동시적으로 작업하기 때문에 promise로 요청한것
require("chai")
  .use(require("chai-as-promised"))
  .should();
// accounts : 여기서 받는 인자가 Ganache에 있는 계정들이 담긴 배열
contract("KryptoBird", (accounts) => {
  let contract;
  // before : 이 훅을 사용해 비동기 패턴 사용, 가장 최우선으로 contract부분을
  // 실행할 수 있게해준다
  before(async () => {
    contract = await KryptoBird.deployed();
  });

  // 테스트 컨테이너
  // 1. 배포가 잘됐는지 확인
  describe("deployment", async () => {
    it("deploys successfuly", async () => {
      const address = await contract.address;
      assert.notEqual(address, "");
      assert.notEqual(address, null);
      assert.notEqual(address, undefined);
      assert.notEqual(address, 0x0);
    });

    it("check name & symbol", async () => {
      const name = await contract.name();
      const symbol = await contract.symbol();
      assert.equal(name, "KryptoBird");
      assert.equal(symbol, "KBIRDZ");
    });
  });

  describe("minting! ", async () => {
    it("create a new token", async () => {
      const result = await contract.mint("http...1");
      const totalSupply = await contract.totalSupply();
      // 성공시
      assert.equal(totalSupply, 1);
      // result 는 계약의 민팅이기때문에 이벤트에 엑세스할 수 있다.
      // .args : ???
      const event = result.logs[0].args;

      assert.equal(
        event._from,
        "0x0000000000000000000000000000000000000000",
        "from is the contract"
      );
      assert.equal(event._to, accounts[0], "to is msg.sender");

      // 실패하는 경우
      // should : 해야만한다.
      //await contract.mint("https...1").should.be.rejected;
    });
  });
});
