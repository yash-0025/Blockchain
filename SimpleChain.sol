// SPDX-License-Identifier:MIT

pragma solidity ^0.8.10;

contract SupplyChain {
    // Creating structure of the product
    struct Product {
        address currentOwner;
        uint[] previousOwners;
        string[] history;
    }

    //  Mapping the product ids with the Product
    mapping(uint => Product) public products;

    //  Function to add Products
    function addProduct(uint id, string memory historyItem) public {
        // Setting the initial product info
        products[id] = Product({
            currentOwner: msg.sender,
            previousOwners: new uint[](0),
            history: new string[](1)
        });
        // Adding the initial history item
        products[id].history[0] = historyItem;
    }

    //  Function to transfer owner of the Product
    function transferProduct(
        uint id,
        address newOwner,
        string memory historyItem
    ) public {
        // The one who is transferring must be the owner of the Product
        require(
            products[id].currentOwner == msg.sender,
            "You are not the owner,You didn't have authority to transfer."
        );
        //  Updating the product info
        products[id].currentOwner = newOwner;
        products[id].previousOwners.push(msg.sender);
        products[id].history.push(historyItem);
    }

    // Function to check the currrent owner of the Product
    function checkCurrentOwner(uint id) public view returns (address) {
        return products[id].currentOwner;
    }

    // Function to check Previous owner of the product
    function checkPreviousOwners(uint id) public view returns (uint[] memory) {
        return products[id].previousOwners;
    }

    // Function to get the history of the Product
    function getHistory(uint id) public view returns (string[] memory) {
        return products[id].history;
    }
}
