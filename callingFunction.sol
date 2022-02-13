// SPDX-License-Identifier: GPL-3.0

pragma solidity >=0.7.0 <0.9.0;
contract A {
 address addrB;
 function setAddressB( address _addrB) external {
     addrB = _addrB;
 }
 function callHello() external view returns(string memory){
     B b = B(addrB);
     return b.sayHello();
 }
}

contract B {
  function sayHello() pure external returns (string memory) {
      return "Hello World";
  }
}