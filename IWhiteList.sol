// SPDX-License-Identifier: GPL-3.0

pragma solidity >=0.7.0 <0.9.0;
//create an interface of whitelist for
//disregard the blacklist function
interface IWhiteList {
    function whitelist (address _addr) external payable;
    function blacklist (address _addr)  external;
    function checkIsWhiteList (address _addr) external view returns (bool status);
}