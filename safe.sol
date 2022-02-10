// SPDX-License-Identifier: GPL-3.0

pragma solidity >=0.7.0 <0.9.0;

contract Safe {
    //admin should be able to set admin's address once when deploying the contract
    //admin's address should be immutable
    //User should be able to deposit money in the safe
    //Money deposited should reflect in user's account and safe's account
    //When starting safe, set a time line and goal amount
    // Enable a force withdrawal from user's account and safe's account with a percent off
    // After set timeline/ target is met, money is to be automatically sent bank to user's set Address
    //Admin only should be able to get safe's balance
    //user should be able to check their balance
    //tx.origin

    address immutable private admin;
    uint safe_balance;
    uint ID = 0;
    struct User {
        uint start_time;
        uint time;
        uint id;
        uint goal_amount;
    }
    mapping(address=>uint) user_balance;
    mapping(address => User) user_details;
    User[] users;
    constructor (address _admin) {
        admin = _admin;
    }
    function userDeposit () payable external {
        user_balance[msg.sender] += msg.value;
        safe_balance += msg.value;
    }

    function startSafe (uint _time, uint _amount) external {
        User memory newUser = User ({
            start_time:block.timestamp,
            time: _time,
            id: ID,
            goal_amount: _amount
            });

        ID++;
        users.push(newUser);
        user_details[msg.sender]= newUser;
    }

    modifier checkSavings() {
        require(user_balance[msg.sender] >= user_details[msg.sender].goal_amount, "You haven't reached your target  amount");
        require(block.timestamp >= user_details[msg.sender].start_time + user_details[msg.sender].time, "You haven't reached your set time frame");
        _;
    }

    function refundAfterSvaings (uint _amount) external checkSavings returns(bool){
        require (user_balance[msg.sender] >= _amount, "Thief!!!");
        user_balance[msg.sender] -= _amount;
        safe_balance -= _amount;
        (bool sent,) = address(this).call{value: _amount}("");
        return sent;
    }

    modifier onlyAdmin (){
        require(admin == msg.sender, "This can only be accessed by admin");
        _;
    }
 
     function checkSafeBalance() view external onlyAdmin returns (uint) {
        return safe_balance;
    }

    function getUserBalance () external  view returns (uint) {
        return user_balance[msg.sender];
    }
    function forceWithdrawal (uint _amount) external returns (bool sent){
        if(user_balance[msg.sender] <= user_details[msg.sender].goal_amount || block.timestamp >= user_details[msg.sender].start_time + user_details[msg.sender].time) {
            require (user_balance[msg.sender] >= _amount, "Thief!!!");
            uint interest = _amount *5/100 ;
        user_balance[msg.sender] -= (_amount+ interest);
        safe_balance -= (_amount+ interest);
        (sent,) = address(this).call{value: _amount + interest}("");
        return sent;
        }
    }
}