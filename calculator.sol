// SPDX-License-Identifier: GPL-3.0

pragma solidity >=0.7.0 <0.9.0;

// create a contract calculator
//create an addition function that accepts 2 params and adds them up
// Import the IWhitelist.sol
// instanciate the interface
// check if user calling the addition function is whitelisted
// if user is !whitelisted, return false, and 0
import './IWhiteList.sol';
contract Calculator {
    IWhiteList isWhitelisted;
    constructor (address _addr) {
     isWhitelisted = IWhiteList(_addr);
    }
    function checkWhiteList (address _addr) internal view returns (bool) {
        return isWhitelisted.checkIsWhiteList(_addr);
    }
    function add(address _addr, uint a, uint b) external view returns (uint result, bool status) {
        if (checkWhiteList(_addr)) return (a+b, true);    
        else return (0, false);
    }
    function approveWhiteList (address _addr) payable external{
        isWhitelisted.whitelist{value:msg.value}(_addr);
    }
}