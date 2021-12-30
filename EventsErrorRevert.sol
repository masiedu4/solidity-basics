// SPDX-License-Identifier: GPL-3.0
pragma solidity ^0.8.4;

/// Insufficient balance for transfer. Needed `required` but only
/// `available` available.
/// @param available balance available.
/// @param required requested amount to transfer.
error InsufficientBalance(uint256 available, uint256 required);

contract TestToken {
   event Deposit(
        address indexed _from,
        address indexed to,
        uint _value
    );

    address public owner;

    constructor() {
        owner = msg.sender;
    }

    modifier onlyOwner() {
        require(msg.sender == owner, "Not authorized to carry this out");
        _;
    }

    function getBalance() public view returns (uint256) {
        return address(this).balance;
    }

    function sendEther(address payable to, uint256 amount) public onlyOwner {
        if (amount > getBalance()) {
            revert InsufficientBalance({
                available: getBalance(),
                required: amount
            });
        }
        to.transfer(amount);
          emit Deposit(msg.sender, to, amount);
    }

    receive() external payable {}
}
