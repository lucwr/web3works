// SPDX-License-Identifier: GPL-3.0

pragma solidity >=0.7.0 <0.9.0;

contract SingleUser {
    address pulic owner;
    //owner here s the smart contract
    address public userAddress;
    //stores tha address of this particular user's smart contract
    uint public Id
    // stores id of user
    string public name;
    uint public age;
    string public location;
    mapping(string => uint) tokenBalance;
    mapping(string => bool) tokenAdded;

    constructor (uint _id, string memory _name, uint _age, string memory _location) {
        owner = msg.sender;
        Id = _id;
        name =_name;
        age = _age;
        location = _location;
        tokenBalance['ETH']= 0;
        tokenAdded['ETH']= true;
        tokenBalance['BTC']= 0;
        tokenAdded['BTC']= true;
        tokenBalance['USDT']= 0;
        tokenAdded['USDT']= true;
    }
    modifier onlyOwner () {
        require (owner == msg.sender, "Only owner can call this function");
        _;
    }
    modifier tokenAddedAlready () {
        
    }

}