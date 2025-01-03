// SPDX-License-Identifier: MIT
pragma solidity ^0.8.19;

contract Will{
    uint startTime;
    uint tenYears;
    uint public lastVisited;
    address owner;
    address  payable recipient;
   
   constructor(address payable _recipient ){
    recipient= _recipient;
    tenYears=10;
    // 1 hours*24 *365*10;
    startTime= block.timestamp;
    lastVisited=block.timestamp;
    owner=msg.sender;
   }

   modifier onlyOwner(){
    require(owner == msg.sender);
        _; 
    }
    modifier onlyRecipent(){
        require(msg.sender == recipient);
        _; 
    }
  function deposit()public payable onlyOwner {
    lastVisited= block.timestamp;

  }
  function changeRecipent(address _recipient) onlyOwner public {
    recipient = payable(_recipient);
  }
  
  function ping() public onlyOwner {
    lastVisited=block.timestamp;
  }
  function claim() external onlyRecipent {
    require(lastVisited<block.timestamp-tenYears);
    payable (recipient).transfer(address(this).balance);
  }


}