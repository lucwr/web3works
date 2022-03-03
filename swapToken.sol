interface IERC20{
    function transferFrom(address _from,address _to,uint256 _amount) external returns(bool);
    function transfer(address _to,uint256 _amount) external returns(bool);
}

contract Swapper{

struct Order{
address fromToken;
uint88 expiry;
bool done;
address toToken;
uint256 toTokenAmount;
uint256 fromTokenAmount;
uint256 amountAvailable;
address owner;
}

uint orderIndex=1;

mapping(uint=>Order) public orders;


function addOrder(address _fromToken,address _toToken,uint _amountIn,uint _amountOut,uint _secs) external{
    require(IERC20(_fromToken).transferFrom(msg.sender,address(this),_amountIn),"OGBENI!!!!!");
    Order storage o=orders[orderIndex];
o.fromToken = _fromToken;
o.toToken = _toToken;
o.toTokenAmount = _amountOut;
o.fromTokenAmount= _amountIn;
o.expiry=uint88(block.timestamp+_secs);
o.amountAvailable=_amountIn;
o.owner=msg.sender;
orderIndex++;
}

function executeOrder(uint _orderId,uint _amountIn) external{
    Order storage o=orders[_orderId];
    assert(!o.done);
    assert(o.toToken!=address(0));
assert(o.expiry>=block.timestamp);
(,uint debt)=calcRateAndAmountOut(_orderId,_amountIn);
assert(o.amountAvailable*1e8>=debt);
require(IERC20(o.toToken).transferFrom(msg.sender,o.owner,_amountIn));
require(IERC20(o.fromToken).transfer(msg.sender,debt/1e8));
o.amountAvailable-=debt;
o.done=o.amountAvailable==0?true:false;
}

function calcRateAndAmountOut(uint orderId,uint amountIn) internal returns(uint rate,uint amountOut){
uint out=orders[orderId].toTokenAmount;
uint rate=(out*1e8)/orders[orderId].fromTokenAmount;
amountOut=rate*amountIn;
}


}