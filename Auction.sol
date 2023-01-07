// SPDX-License-Identifier: MIT

pragma solidity ^0.8.4;

contract Auction {
    
    //  Address of the auction owner
    address public owner;
//  The item which is going to be auctioned
    string public item;

//  Variable for highest  bid for the item
    Bid public highestBid;

    //  Struct of the BId
    struct Bid {
        address bidder;
        uint256 amount;
    }


    // To check whether the auction is still going on or not
    bool public auctionOnGoing = true;

    //  Event to emit when new bid is made
    event NewBid(address bidder, uint amount);

    // Constructor to set the owner and item for the auction
    constructor(string memory _item) public {
        owner=msg.sender;
        item=_item;
    }

    // Creating function to bid on the item
    function bid() public payable {
        require(auctionOnGoing, "Auction is over.");
        require(msg.value > highestBid.amount,"Bid amount should be more than the current highest bid");

        // Setting the new highest bid 
        highestBid = Bid({
            bidder: msg.sender,
            amount: msg.value
        });

        // Emiting the event which we created named as newBid
        emit NewBid(msg.sender, msg.value);
    }


    // Function to end the auction and sending the item to the highest bidder
    function endAuction() public {
        require(auctionOnGoing, "Auction is over.");
        require(msg.sender == owner, "Only the owner can end the auction");

        // Sending the funds from the highest bidder
        highestBid.bidder.transfer(highestBid.amount);


        // Set the auctionOnGoing flag to false
        auctionOnGoing = false;
    }
}