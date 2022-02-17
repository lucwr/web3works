// SPDX-License-Identifier: GPL-3.0
pragma solidity >=0.4.0 <0.9.0;
import 'https://github.com/OpenZeppelin/openzeppelin-contracts/blob/master/contracts/token/ERC20/IERC20.sol';
 contract buyW3B{
    IERC20 web3BridgeToken;
    uint256 startDate = block.timestamp;
    uint246 endDate = startDate + 1 months;
    uint256 rate = 100;
    uint256b minimumBuy;
    uint256 maximumBuy;
    event Buy(address by, uint256 value);
    constructor(address _web3BridgeToken, uint _minBuy, uint _maxBuy){
        web3BridgeToken =_web3BridgeToken;
        minimumBuy = _minBuy;
        maximumBuy = _maxBuy;
    }

    function buy() public payable{
        require(block.timestamp>= startDate, "Token sales not started. Check back later");
        require(block.timestamp<= endDate, "Token sales ended. You missed an opportunity of a lifetime");
        require(msg.value >= minimumBuy, "Cheap skate! Buy more!");
        require(msg.value <= maximumBuy, "So, you want to roll with the big boys? Reduce that amount!");

        uint256 tokenBalance = checkTokenBalance();
        require(msg.value*rate <= tokenBalance, "Not enough token available. Try a lower value");
        web3BridgeToken.transfer(msg.sender, msg.value * rate);
        emit Buy(msg.sender, msg.value * rate)
    }

    function checkBalance () external view returns (uint256){
        return address(this).balance;
    }
    function checkTokenBalance () public view returns (uint256){
        return web3BridgeToken.balanceOf(address(this));
    }
 }