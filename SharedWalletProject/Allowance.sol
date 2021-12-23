// SPDX-License-Identifier: MIT

pragma solidity ^ 0.8.0;

import "./Ownable.sol";
import "./SafeMath.sol";
import "Context.sol";

contract Allowance is Ownable{

using SafeMath for uint;

// adding events 

event AllowanceChange ( address indexed _forWho , address indexed _fromWho , uint _oldAmount , uint newAmount);


 // returns a boolean for whether the executer is a owner or not
    function isOwner() internal view returns(bool) {
      return owner() == msg.sender;
    }


   //add allowance to benficaries (restricted)
    mapping(address => uint) public allowance;
    function addAllowance (address _who , uint _amount) public onlyOwner{
    emit AllowanceChange(_who , msg.sender , allowance[_who] , _amount); 
     allowance[_who] = _amount;
    }


   // reduce allowance of a particlaur benefiacry upon a succesfful transaction
   function reduceAllowance (address _who , uint _amount)  internal ownerOrAllowed(_amount) {
    emit AllowanceChange(_who , msg.sender , allowance[_who] , allowance[_who].sub(_amount));
       allowance[_who] = allowance[_who].sub( _amount);
   }


   // modifier for the withdrawal of funds.Restricted to only the owner and people with allowance installed
     modifier ownerOrAllowed(uint _amount) {
        require(isOwner() || allowance[msg.sender] >= _amount , "You are not authorized!");
        _;
     }

}
