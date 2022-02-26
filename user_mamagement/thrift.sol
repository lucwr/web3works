// SPDX-License-Identifier: GPL-3.0
pragma solidity ^0.8.10;
// a struct for a thrift
// things our struct should contain
// a number of people 
// amount per contribution
// array of addresses of thrifters
// total amount in ajo
// contribution period
// approved

// AJO

//The Ajo should accept moeny
//Accepts a limited number of thrifter 
//thrifters should contribute at set interval
//Ajo keeps track of each thrifter's contributions
//A feature that marks true when each thrifter has contributed for current round
//Confirm that amount contributed is == agreed amount
//at the end of the contribution period, check if each thrifter balance is more than the amount per contributions 
// check the next person to receive 
//the next collector should be determined by their index.
//Reset thrift round when last thrifter has collected


//THRIFTER
//User should be able to pay in installments 
// User should be able to withdraw at their turn
//user should be able to check their contributions to see if they paid 



contract Ajo{

    uint thriftIndex =0;
    struct Thrift{
        uint startPoint;
        uint maturityDate;
        string name;
        address[] addrOfThrifters;
        bool status;
        uint joinFee;
        uint amountPerContribution;
        uint totalAmount;
        uint contributionPeriod;
        uint thriftRound;
        mapping(address => Participant) thrifter;
        
    }

    struct Participant {
        string name;
        uint balance;

    }
    address owner;

    constructor(){
        owner = msg.sender;
    }

    modifier onlyOwner() {
        require (owner == msg.sender,"only owner");
        _;
    } 
    mapping(uint => Thrift) ThriftRecords;
    function addnewThrift(string memory _name, uint _amountPerContribution, uint _contributionPeriod) external{
        thriftIndex++;
        Thrift storage t = ThriftRecords[thriftIndex];
        t.name = _name;
        t.joinFee = _amountPerContribution/100 * 2; 
        t.amountPerContribution = _amountPerContribution;
        t.contributionPeriod = _contributionPeriod;
        t.thriftRound = 0;
    }

    function joinThrift(uint _thriftIndex, string memory _name) payable public {
        Thrift storage t = ThriftRecords[_thriftIndex];
          require(msg.value >= t.joinFee);
        require(t.addrOfThrifters.length <= 10, "Alaye pack your money go anoda place, we no geh space for late comers");
        t.addrOfThrifters.push(msg.sender);
        t.name = _name;
        if (t.addrOfThrifters.length == 10){
            t.status = true;
            t.startPoint = block.timestamp;
            startThrift(_thriftIndex);
        }
    }

    function payInThrift (uint _thriftIndex) payable external{
       Thrift storage t = ThriftRecords[_thriftIndex];
       require (t.status == true, "Ajo neva  start, calm down");
       t.totalAmount += msg.value;
       t.thrifter[msg.sender].balance += msg.value;
    }

    function startThrift(uint _thriftIndex) internal {
        Thrift storage t = ThriftRecords[_thriftIndex];
        t.thriftRound++;
        t.maturityDate = t.startPoint + (t.contributionPeriod * t.thriftRound);
        uint amountToSend = t.amountPerContribution * t.addrOfThrifters.length;
        if(t.totalAmount >= amountToSend){
            (bool status, ) = t.addrOfThrifters[t.thriftRound-1].call{value:amountToSend}("");
            require (status == true, "Transfer failed");
        }
    }

}