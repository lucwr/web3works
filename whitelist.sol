// SPDX-License-Identifier: GPL-3.0

pragma solidity >=0.7.0 <0.9.0;

// Create a whitleist contract
// create a whitelist mapping from address to bool
// create a function to whitelist an Address
// create a function to blacklist an Address
//blacklisted addresses should return falf from the whitelist mapping
// only owner can blacklist a contract

contract WhiteList {
    address owner;
    constructor () {
        owner = msg.sender;
    }
    mapping(address =>bool) isWhitelisted;
    modifier onlyOwner () {
        require (owner == msg.sender, "Function can only be called by contract owner");
        _;
    }
    function whitelist (address _addr) external payable{
        require (msg.value >= 10000, "You need to pay at least 10000 wei to get whitelisted");
        isWhitelisted[_addr] = true;
    }

    function blacklist (address _addr) onlyOwner external {
        isWhitelisted[_addr] = false;
    }
    function checkIsWhiteList (address _addr) external view returns (bool status) {
        return isWhitelisted[_addr];
    }
}