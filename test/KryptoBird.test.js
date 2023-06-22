const { assert } = require("chai");
/*
    차이 : 단언 라이브러리
*/

const KryptoBird = artifacts.require("./KryptoBird");

// 차이 / 블록체인과 비동시적으로 작업하기 때문에 promise로 요청한것
require("chai")
  .use(require("chai-as-promised"))
  .should();

contract("KryptoBird", (account) => {
  let contract;

  // 테스트 컨테이너
  // 1. 배포가 잘됐는지 확인
  describe("deployment", async () => {
    it("deploys successfuly", async () => {
      contract = await KryptoBird.deployed();
      const address = contract.address;

      assert.notEqual(address, "");
      assert.notEqual(address, null);
      assert.notEqual(address, undefined);
      assert.notEqual(address, 0x0);
    });
  });
});
