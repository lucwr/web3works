// SPDX-License-Identifier: GPL-3.0
pragma solidity >=0.8.0 <0.9.0;
import 'https://github.com/OpenZeppelin/openzeppelin-contracts/blob/master/contracts/utils/math/SafeMath.sol';
contract MyMathOperation {

using safeMath for uint256;
function addMyNum(uint256 a, uint256 b) public returns(uint256) {
    return a.add(b);
}
function subMyNum(uint256 a, uint256 b) public returns(uint256) {
    return a.sub(b);
}
}
// Design patterns are patterns in solidity to mitigate against popular errors
//1. Access Control i.e onlyOwners
//2. if you want to make your state variable visible, just make it public 
//3. circuit breaker
//4.Avoid nested loops
// 5. Multisignature wallet
    interface IERC20 {
        function transfer(address receipient, uint256 amount) external returns (bool);
    }
contract TestCircuitBreaker {
    // Circuit breakers are functions that help pause major functions
    // to avoid re enterancy
    // check where the money coming in, and where it is going out
    IERC20 token;
    bool paused;
    constructor (address _tokenAddress) {
        token = IERC20(_tokenAddress);
    }
    function claim() public {
        require(paused == false, "This function is currently not available");
        token.transfer(msg.sender, 20);
    }
    function pauseContract()
}