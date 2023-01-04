// SPDX-License-Identifier: MIT

pragma solidity ^0.8.4;

contract Crud {

    uint256 public coins = 0;
   
    function add() public {
        coins+=1;
    }

    function subtract() public {
        coins-=1;
    }

    function set(uint256 _coins) public {
        coins = _coins;
    }

}
