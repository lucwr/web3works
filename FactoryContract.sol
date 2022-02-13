// SPDX-License-Identifier: GPL-3.0

pragma solidity ^0.8.7;

contract Another {
 function pureFunction ()  external view returns (string memory) {
     return "hello world";
 }
}
contract FactoryContract {
    address deployedAddress;
    Another another;
    string result;
    function callAnotherPureFunction () external returns (string memory) {
        another = new Another();
        result =  another.pureFunction();
        return result;
    }
    function showResult () view external returns (string memory){
        return result;
    }
}