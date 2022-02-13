// SPDX-License-Identifier: GPL-3.0

pragma solidity >=0.7.0 <0.9.0;
import 'abstractContract.sol';

contract AbstractExtended is  WhiteList{
uint num;
constructor (address _addr) WhiteList(_addr){
 num = 2;
}
 function whitelist (address _addr) external payable{
        require (msg.value >= 10000, "You need to pay at least 10000 wei to get whitelisted");
        isWhitelisted[_addr] = true;
    }
    function checkIsWhiteList (address _addr) external override view returns (bool status) {
        return isWhitelisted[_addr];
    }
}

