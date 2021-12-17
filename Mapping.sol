pragma solidity ^ 0.5.11;

contract Mapping {
    mapping (address => uint) public balancedSentByAddress;

// smart contract can now receive money
    function smartContractReceive () public payable {
        balancedSentByAddress[msg.sender] += msg.value; 
    }

// get balance of the contract
    function balanceOfSmartContract() public view returns(uint) {
        return address(this).balance;
    }

// withdraw all money to any address by using accounts that has made deposits only
  function withDrawAllMoney (address payable _to) public {
     uint balanceToSend = balancedSentByAddress[msg.sender];
     balancedSentByAddress[msg.sender] = 0;
     _to.transfer(balanceToSend); 
  }
}