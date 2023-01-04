//  SPDX-License-Identifier:MIT

pragma solidity ^0.8.7;


contract VendingMachine {

    // Declare state variable of the contract 

    address public owner;
    mapping (address => uint) public cokeBalances;

    // Declaring constructor to define owner who is deploying and to make cokeBalance 100 for the owner

    constructor() {
        owner = msg.sender;
        cokeBalances[address(this)] = 100;
    }

    // Owner can refill the coke in the machine

    function refilling(uint256 amount) public {
        require(msg.sender == owner, "You cannot refill as you are not the owner.");
        cokeBalances[address(this)] += amount;
    }

    // Purchase function where anyonw can purchase cokes

    function purchase(uint256 amount) public payable {
        require(msg.value >= amount * 1 ether, "You have to pay atleast 1 ETH for 1 cupcake");
        require(cokeBalances[address(this)] >= amount, "Not enough coke is present in the stock ");
        cokeBalances[address(this)] -= amount;
        cokeBalances[msg.sender] += amount;
    }   

}