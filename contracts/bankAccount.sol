// SPDX-License-Identifier: MIT
pragma solidity ^0.8.24;

/*
* @title: Bank Account Smart Contract.
* @author: deelight.
* @notice: A smart contract that simulates behavior
* of a bank.
*/

contract Bank {

  mapping(address => uint) private accountBalances;
  address [] private registeredAccounts;
  // TODO: Function createAccount, hasRegistered, 
  // deposit, withdraw.
  
  /**
   * @notice Function to check if account is already registered.
   * @return bool if the account is registerd or not.
   */
  function hasRegistered(address _address) internal view returns (bool) {
    // Loop through registeredAccounts to find if
    // address is there or not.
    for(uint i = 0; i < registeredAccounts.length; i++) {
      if (_address == registeredAccounts[i]) {
        return true;
      }
    }
    return false;
    //TODO: Use mapping instead.
  }

  /**
   * @notice Function to register an account in the bank.
   */
  function registerAccount() public {
    require(hasRegistered(msg.sender) == false, "Account has been registered before.");
    registeredAccounts.push(msg.sender);
  }

  /**
   * @notice deposit - Function to deposit into an account.
   */
  function deposit() public payable {
    require(hasRegistered(msg.sender) == true, 'Your account has not been registered.\n Proceed to registration');
    accountBalances[msg.sender] += msg.value;
  }

  /**
   * @notice withdraw value from your account, provided you have sufficient funds.
   */

  function withdraw() public payable {
    require(hasRegistered(msg.sender) == true, 'Your account has not been registered.\n Proceed to registration');
    require(accountBalances[msg.sender] <= msg.value, 'Insufficient balance');
    accountBalances[msg.sender] -= msg.value;
  }

  /**
   * @notice transfer some amount from one account to another account.
   * @param _recepient : Address of the recepient of the contract.
   */

  function transfer(address _recepient) public payable {
    require(hasRegistered(msg.sender) == true, 'Your account has not been registered.\n Proceed to registration');
    require(hasRegistered(_recepient) == true, 'Recepient account has not been registered.\n Tell them to register');
    require(accountBalances[msg.sender] <= msg.value, 'Insufficient balance');
    accountBalances[msg.sender] -= msg.value;
    accountBalances[_recepient] += msg.value;
  }
  // TODO: assign 1 wei to every user as they come in. This will reduce number of data struct used.
}
