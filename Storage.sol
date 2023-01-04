// SPDX-License-Identifier: MIT

pragma solidity ^0.8.4;

contract Data {
    uint[] public arr;
    mapping(uint => address) map;
    struct MyStruct {
        uint foo;
    }

    mapping(uint => MyStruct) myStructs;

    function _f(
        uint[] storage _arr,
        mapping(uint => address) storage _map,
        MyStruct storage _myStruct
    ) internal {
        // We can do anything with state variable here
    }

    function f() public {
        // calling _f with state variables
        _f(arr, map, myStructs[1]);

        // getting a struct from a mapping
        MyStruct storage myStruct = myStructs[1];

        // creating a struct in a memory
        MyStruct memory myMemStruct = MyStruct(0);
    }

    function g(uint[] memory _arr) public returns (uint[] memory) {
        // We can do anything using state variables
    }

    function h(uint[] calldata _arr) external {
        // We can d0 anything using state variables
    }
}



/* 
    storage => Stored in a Blockchain
    Memory => The variable are stored and have a lifetime
    Stack => All variables declared in a function are stored in a fixed size stack
    CallData => Similar to memory , this variables have a lifetime but are immutable
 */

