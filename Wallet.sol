// SPDX-License-Identifier:MIT

pragma solidity ^0.8.5;

contract SimpleWallet {

    //  Address of the wallet
    address public wallet;

    // function to initiliaze wallet
    function initialize() public {
        wallet = address(this);
    }

    // function to send Ether from wallet
    function sendEther(address _to, uint _value) public{
        require(msg.sender == wallet,"Only the wallet can send Ether.");
        _to.transfer(_value);
    }

    function receiveEther() public payable {
        require(msg.sender == wallet,"ONly wallet can receive ether");
    }

    function getBalance() public view returns(uint){
        return address(this).balance;
    }
}