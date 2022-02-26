// SPDX-License-Identifier: GPL-3.0
pragma solidity ^0.8.10;
contract Purse {

    struct thriftOrg {
        address[] thrifters;
        uint256 duration;
        address lastCollector;
        mapping(address=>uint) collections;
        bool valid;
    }
    uint thriftIndex =0;
    mapping(uint=> thriftOrg) public thrifts;
    function addThrifts () external returns (uint tOndex) {
        thriftOrg storage t = thrifts[thriftIndex];
        t.duration = block.timestamp+ 100;
        t.valid = true;
    }

    function joinThrift (uint _thriftID) external {
        confirm(_thriftID);
        thriftOrg storage t = thrifts[thriftIndex];
    }

    function confirm () internal {
        assert(thrifts[_id].valid)
    }
}