//Seperate the owner from the initial contract
// SPDX-License-Identifier: MIT
pragma solidity 0.7.5;

contract Ownable {


    address payable public   owner;

    constructor(){
        
        owner = msg.sender; // Adding owner to the initilizer
        
    }

    
    modifier onlyOwner { // Add modifier for the owner 
        require(msg.sender == owner);
        _;
    }
    
}
