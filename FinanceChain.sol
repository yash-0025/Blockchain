// SPDX-License-Identifier: MIT

pragma solidity ^0.8.5;

contract FinanceChain {

    // Structure for the finance Request
    struct FinanceRequester {
        address payable borrower;
        uint amount;
        bool funded;
    }
    // Structure for the finance offer
    struct FinanceOfferer {
        address lender;
        uint amount;
        uint interestRate;
        bool funded;
    }
    //  mapping the finance request id to finance request info
    mapping(uint => FinanceRequester) public financeRequests;

    // Mapping the offer id with the finance offer
    mapping(uint => FinanceOfferer) public financeOffers;

    //  Function for requesting funds
    function requestFinance(uint amount) public {
        //  Generating the unique id for the finance request
        uint id = uint256(keccak256(abi.encodePacked(msg.sender,block.timestamp,amount)));
    // Updating the finance request info
    financeRequests[id]  = FinanceRequester({
        borrower:payable(msg.sender),
        amount: amount,
        funded: false
    });

    }
    //  Function for offering funds
    function offerFinance(uint amount, uint interestRate) public {
        // Generating unique id for the finance offer

        uint id = uint256(keccak256(abi.encodePacked(msg.sender,block.timestamp,amount,interestRate)));

        // Setting up the offer 
        financeOffers[id] = FinanceOfferer({
            lender: msg.sender,
            amount: amount,
            interestRate: interestRate,
            funded: false
        });
    }
    //  Function to fund that finance request
    function fundFinanceRequest(uint requestId, uint offerId) public {
        require(financeRequests[requestId].funded == false, "Finacne is already done to this requester");
        require(financeOffers[offerId].funded == false,"Finance is already done by this offer");
        require(financeRequests[requestId].amount <= financeOffers[offerId].amount,"Finance is not sufficient to fund this finance request");
        //  Transfer the funds if everything is checked
        financeRequests[requestId].borrower.transfer(financeRequests[requestId].amount);
        // Now after sending the funds make the funded flag value to true
        financeRequests[requestId].funded=true;
        financeRequests[requestId].funded=true;

    }

    //  Function to get the borrower for a finance request
    function getBorrower(uint id) public view returns(address){
        return financeRequests[id].borrower;
    }

}
