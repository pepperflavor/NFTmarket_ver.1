const KryptoBird = artifacts.require("KryptoBird"); // 계약의 이름
// 아티팩트 ABI를 새 변수로 설정해 주는 것
// 새로 변수를 생성하고 KryptoBird JSON 파일로부터 아티팩트를 가져옴(계약을 컴파일하면 생성됨)
//

// 배포할때는 익명으로 함수 실행
// truffle이 1.js를 실행한 후 이 스크립트를 실행해서 계약 배포를 실행한 뒤
// 이 deploy 메서드를 실행한다 == 배포할 내용을 찾음
module.exports = function(deployer) {
  deployer.deploy(KryptoBird);
};
