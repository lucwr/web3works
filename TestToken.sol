// SPDX-License-Identifier: GPL-3.0

pragma solidity >=0.4.0 <0.9.0;

contract TestToken {
    mapping(address=> uint) public balances;
    string public name;
    string public symbol;
    uint256 public totalSupply;

    constructor (string memory _naame, string memeory symbol, uint256 _totalSupply) {
        name = _name;
        symbol = _symbol;
        totalSupply = _totalSupply;
        balances[msg.sender] = _totalSupply;
    }

    function transfer (address _to, uint _amount) public returns bool {
        uint userBal = balances[msg.sender];
        require(_amount <= userBal, 'Insufficient balance');
        balances[msg.sender] -= amount;
        balances[_to]+= _amount;
        return true;
    }
}