// SPDX-License-Identifier: MIT

pragma solidity ^0.8.13;

contract DutchAuction {
    
    //  Variable for starting and ending auction
    address payable public immutable seller;
    uint public immutable startingPrice;
    uint public immutable startingTime;
    uint public immutable endingTime;

    // Discount rate at which the price decreases
    uint public immutable discountRate;


    // Event for selling
    event sold(address buyer, uint price);
}