// SPDX-License-Identifier: MIT

pragma solidity ^ 0.8.0;
import "./Allowance.sol";
contract SharedWallet is Allowance{

event MoneySent (address indexed _beneficiary , uint _amount);
event MoneyReceived (address indexed _from , uint _amount);

    function withdrawMoney (address payable _to , uint _amount) public ownerOrAllowed(_amount) {
        require(_amount <= address(this).balance, "Not enough balance in the smart contract");
        if(!isOwner()) {
            reduceAllowance (msg.sender , _amount);
        }
        emit MoneySent (_to , _amount);
        _to.transfer(_amount);
    }

// renounce ownership 

function renounceOwnership () public override view onlyOwner {
    revert("cant renounceOwnership here");
 }
    // fallback function to receive funds from anyone
     receive () external payable {
    emit MoneyReceived (msg.sender , msg.value);
      }

}