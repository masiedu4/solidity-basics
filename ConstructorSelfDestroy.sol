pragma solidity ^0.5.11;

contract Constructor {
    address payable owner;

    constructor() public {
        owner = msg.sender;
    }

    function receiveFunds() public payable {}

    function checkBalance() public view returns (uint256) {
        return address(this).balance / 1 ether;
    }

    function getOwnerOfContract() public view returns (address) {
        return owner;
    }

    function destroyContract() public {
        require(msg.sender == owner, "You are not authorized");
        selfdestruct(owner);
    }
}
