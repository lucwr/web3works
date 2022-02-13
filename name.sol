pragma solidity >=0.4.0 <0.9.0;

contract TestContract{

string public name;

function showName (string memory _name) public returns (string memory){
     name = _name;
     return name;
}
}