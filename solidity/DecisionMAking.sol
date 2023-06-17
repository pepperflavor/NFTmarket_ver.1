pragma solidity ^0.8.4;

/*
    solidity의 if-else문
*/
contract DecisionMaking{
    uint oranges = 5;
    // 오렌지가 5개가 맞는지 확인하기
    function validateOranges()public view returns(bool){
        if(oranges == 5){
            return true;
        }
    }

    uint stakingWallet = 10;

    function airDrop() public view returns(uint){
        if(stakingWallet == 10){
            return stakingWallet + 10;
        }else{
            stakingWallet+1;
        }
    }
}