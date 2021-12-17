pragma solidity <= 0.5.10;

contract MappingStructExample {

    mapping(address => uint) public balancedSent;

    function checkBalance () public view returns(uint){
        return address(this).balance;
    }

    function sendMoney() public payable {
           balancedSent[msg.sender] += msg.value;
    } 
// check if conditions are met and withdraw partial amount to a specific address by taking an input
    function withdrawPartialAmount(address payable _to , uint _amount) public {
        require(balancedSent[msg.sender] >= _amount , "Not enough funds to perform this transac");
        balancedSent[msg.sender] -= _amount;
        _to.transfer(_amount);
    }    
 // withdraw all funds to an input address     
    function withdrawMoney(address payable _to) public {
        uint balancedToSend = balancedSent[msg.sender];
        balancedSent[msg.sender] = 0;
        _to.transfer(balancedToSend);
    }
}

// note: ALl withdrawals from the contract can be initiated only by the addresses that made depoaits earlier , as from the code