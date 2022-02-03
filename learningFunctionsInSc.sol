// SPDX-License-Identifier: GPL-3.0
pragma solidity ^0.8.10;

contract Counter {

    uint public count;
    uint8 public u8 = 1;
    int public i256 = 456; 
    bool public boo = true;

    //uint8 ranges from 0 to 2**8 - 1
    //unit256 ranges from 0 to 2**256 - 1

    //min and max of int range
    int public minInt = type(int).min;
    int public maxInt = type(int).max;
    address public addr = 0xCA35b7d915458EF540aDe6068dFe2F44E8fa733c;
    bytes1 a = 0xb5; //  [10110101]
    bytes1 b = 0x56; //  [01010110]
    uint public constant MY_UINT = 123; //declaring a constant
    //immutable variables are like constants. Values of immutable variables can be set inside the constructor but cannot be modified afterwards.
    function getCount() public view returns (uint) {
        return count;
    }
    function increaseCount () public {
        count ++;
    }
    function decreaseCount () public {
        count --;
    }
}