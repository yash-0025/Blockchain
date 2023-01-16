// SPDX-License-Identifier: MIT

pragma solidity ^0.8.13;


// Creating interface for the nft function which is going to be used

interface IERC721 {
    function transferFrom(address _from, address _to, uint _nftId) external;
}


contract DutchAuction {

    // Declaring duration of the auction after it gets started 
    uint private constant DURATION = 7 days;
    

    // Declaring instance of the NFT contract
    IERC721 public immutable nft;
    uint public immutable nftId;

    //  Variable for starting and ending auction
    address payable public immutable seller;
    uint public immutable startingPrice;
    uint public immutable startingTime;
    uint public immutable endingTime;

    // Discount rate at which the price decreases
    uint public immutable discountRate;


    // Event for selling
    event sold(address buyer, uint price);


    // Declaring constructor which will include starting price , discount rate , address of the nft and the nftid
    constructor(
        uint _startingPrice,
        uint _discountRate,
        address _nft,
        uint _nftId
    ) {
        seller = payable(msg.sender);
        startingPrice = _startingPrice;

        //  Declaring time variables
        startingTime = block.timestamp; // This will start the auction when the contract get deployed
        endingTime = block.timestamp + DURATION ;

        discountRate = _discountRate;

        // While giving discount we should also check whether the starting price is greater then the dicounted rate after the duration
        require(_startingPrice >= _discountRate * DURATION,"Starting price should be greater then the discounted price");
        nft = IERC721(_nft);
        nftId = _nftId;

    }

    function getPrice() public view returns(uint) {
        uint timeElapsed = block.timestamp - startingTime;
        uint discount = discountRate * timeElapsed;
        return startingPrice - discount;
    }

    function buy() external payable {
        require(block.timestamp < endingTime, "Auction is already ended");
        uint price = getPrice();

        require(msg.value >= price,"You should have more ETH then the price.");

        nft.transferFrom(seller,msg.sender, nftId);
        uint refund = msg.value - price;
        if (refund > 0) {
            payable(msg.sender).transfer(refund);
        } 
        emit sold(msg.sender, msg.value);

        // We can destroy the contract after the sale is completed
        selfdestruct(seller);
    }

}