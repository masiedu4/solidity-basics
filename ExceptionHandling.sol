pragma solidity ^0.5.11;

contract RequireExample {
    mapping(address => uint256) public balancedSent;

    function getBalance() public view returns (uint256) {
        return address(this).balance;
    }

    function sendMoney() public payable {
        balancedSent[msg.sender] += msg.value;
    }

    function withdrawPartialFunds(address payable _to, uint256 _amount) public {
        // require is exception handling in solidity. If conditions are met, code on the nextline is executed
        require(_amount <= balancedSent[msg.sender], "Not enough funds");
        balancedSent[msg.sender] -= _amount;
        _to.transfer(_amount);
    }
}

contract AssertExample {
    // Assert ensures that internal declared states are not violated

    // uint64 can store a maximum of 18eth, sending abpve will throw
    mapping(address => uint64) public balancedSent;

    function getBalance() public view returns (uint256) {
        return address(this).balance;
    }

    function sendMoney() public payable {
        assert(
            balancedSent[msg.sender] + uint64(msg.value) >=
                balancedSent[msg.sender]
        );
        balancedSent[msg.sender] += uint64(msg.value);
    }

    function withdrawPartialFunds(address payable _to, uint64 _amount) public {
        require(_amount <= balancedSent[msg.sender], "Not enough funds");
        assert(balancedSent[msg.sender] >= balancedSent[msg.sender] - _amount);
        balancedSent[msg.sender] -= _amount;
        _to.transfer(_amount);
    }
}
