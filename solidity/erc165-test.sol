pragma solidity >= 0.7.0 < 0.9.0;

interface IERC165{
    // contract가 인터페이스와 호환이 되는지 확인하는 목적
    // bytes4 : 바이트 배열
    function supportsInterface(bytes4 interfaceId) external view returns(bool);

    // Keccak : 다목적 암호 함수 참고: https://keccak.team/keccak.html
}

// 추상적 계약으로 바꾸라는 오류는 현재 계약 ERC165에 아무 값이 없기때문
// 가스비 30000을 넘으면안된다는 규정이 있음
contract ERC165 is IERC165{

    // IERC165의 함수 서명을 바이트의 지문으로 계산
    //기본적인 계산 인터페이스 함수 알고리즘
    function calcFingerPrint() public view returns(bytes4){
        return bytes4(keccak256('supportInterface(bytes4)'));
        // function supportsInterface value : 0x75e79be6
        // supportsInterface &  balanceOf 까지 연산한 값 :0xff99ac62
    }

    // 지문 데이터 계약을 추적할 수 있음
    mapping(bytes4 => bool) private _supportedInterfaces;

    // 오버라이딩 : solidity에서는 어떤 함수를 오버라이딩하는지 표시해줘야한다
    // 지원여부 확인
    function supportsInterface(bytes4 interfaceId) external override view returns(bool){
       return _supportedInterfaces[interfaceId];
    }

    constructor(){
        _registerInterface(0x75e79be6);
    }

    // registering the interface
    // 지원내용 설정, 0xffffffff == 아무것도 없음 과 같은뜻
    function _registerInterface(bytes4 interfaceId) public {
        require(interfaceId != 0xffffffff, 'ERC165: Invalid Interface');
         _supportedInterfaces[interfaceId] = true;
    }

}