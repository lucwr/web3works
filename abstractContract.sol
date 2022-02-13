// SPDX-License-Identifier: GPL-3.0

pragma solidity >=0.7.0 <0.9.0;

// an abstract contract is a contract with at least 1 function without implementation
// and abstract contract can inherit another contract, but an interface can't
// but abstract contracts and interfaces do the exact same thing
// function definitions in abstract functions must have the virtual keyword
// while function definitions in inheritance are defaultly virtual.

import './IWhiteList.sol';
abstract contract WhiteList is IWhiteList{
    address public owner;
    uint public nums = 3;
    string public name = "juju";
    constructor (address _owner) {
        owner = _owner;
    }
    mapping(address =>bool) isWhitelisted;
    modifier onlyOwner () {
        require (owner == msg.sender, "Function can only be called by contract owner");
        _;
    }
    // function whitelist (address _addr) external payable{
    //     require (msg.value >= 10000, "You need to pay at least 10000 wei to get whitelisted");
    //     isWhitelisted[_addr] = true;
    // }
    // function whitelist (address _addr) external virtual payable;
    function blacklist (address _addr) onlyOwner virtual external {
        isWhitelisted[_addr] = false;
    }
    function checkIsWhiteList (address _addr) external virtual view returns (bool status);
}