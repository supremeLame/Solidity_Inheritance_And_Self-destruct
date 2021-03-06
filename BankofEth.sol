// SPDX-License-Identifier: MIT
pragma solidity 0.7.5;
// Simple bank code examaple

import "./Ownable.sol";

contract BankofEth is Ownable {

    mapping (address => uint) private balances;
    

    //////////////////////////////////////////////////////////////////////////////////
    // Adding events for logging and interacting better with dapps
    ///////////////////////////////////////////////////////////////////////////////////
    
    event logDepositMade(address indexed comeFromAddress, uint indexed amount); // Logging deposit made
    
    event logWithdrawMade(uint indexed amount); // Logging withdrawal made
    
    //////////////////////////////////////////////////////////////////////////////////
    // Private functions
    ///////////////////////////////////////////////////////////////////////////////////
    
    function _withdraw(uint _withdrawAmount) private {
        // Check enough balance available, otherwise just return balance
        require(_withdrawAmount <= balances[msg.sender]);
        balances[msg.sender] -= _withdrawAmount;
        msg.sender.transfer(_withdrawAmount);
        
    }
    
    function _destroyContract() private { 
        selfdestruct(owner); 
    }
    //////////////////////////////////////////////////////////////////////////////////
    // Public functions
    ///////////////////////////////////////////////////////////////////////////////////
    
    function getBalance() public view returns (uint) {
        return balances[msg.sender];
    }


    function deposit() public payable returns (uint) {
        balances[msg.sender] += msg.value;
        emit logDepositMade(msg.sender, msg.value);
        return balances[msg.sender];
    }

    function depositsBalance() public  onlyOwner returns (uint) {
        emit logWithdrawMade(address(this).balance);
        return address(this).balance;
    }

    function withdraw(uint withdrawAmount) public returns (uint remainingBal) {
        _withdraw(withdrawAmount);
        return balances[msg.sender];
    }
    
    function destroyContract() public onlyOwner {
        _destroyContract();
    }


}

