// SPDX-License-Identifier: GPL-3.0
pragma solidity >=0.8.0 <0.9.0;
import 'https://github.com/OpenZeppelin/openzeppelin-contracts/blob/master/contracts/token/ERC20/extensions/IERC20Metadata.sol';
contract NewErcToken is IERC20Metadata{
    string private _name;
    string private _symbol;
    uint8 private _decimal;
    uint256 private _totalSupply;
    mapping(address=> uint) private _balances;
    mapping(address=> mapping(address => uint)) private allowances;
    constructor (string memory name_, string memory symbol_, uint8 decimal_, uint256 totalSupply_) {
        _name = name_;
        _symbol =symbol_;
        _decimal = decimal_;
        _totalSupply = totalSupply_ * 10 ** decimal_;
        _balances[msg.sender] = _totalSupply;
        emit Transfer(address(0), msg.sender, _totalSupply);
    }
    function name() external override view returns (string memory){
        return _name;
    }
    function symbol() external override view returns (string memory){
        return _symbol;
    }
    function decimals() external override view returns (uint8){
        return _decimal;
    }

    function totalSupply() external override view returns (uint256) {
        return _totalSupply;
    }
    function balanceOf(address account) external override view returns (uint256){
        return _balances[account];
    }

    function transfer(address to, uint256 amount) external override returns (bool){
        _transfer(msg.sender, to, amount);
        return true;
    }
    function _transfer (address from, address to, uint256 amount) internal {
         require(_balances[from] >= amount,"Insuficient Balance");
        _balances[from] -= amount;
        _balances[to] += amount;
             emit Transfer(msg.sender, to, amount);
    }
    function allowance(address owner, address spender) public override view returns (uint256){
        return allowances[owner][spender];
    }
    function approve(address spender, uint256 amount) external override returns (bool){
        allowances[msg.sender][spender] = amount;
        emit Approval(msg.sender, spender, amount);
        return true;

    }
    function transferFrom(
        address from,
        address to,
        uint256 amount
    ) external override returns (bool){
        uint _allowance = allowance(from, to);
        require (_allowance >= amount, "Insufficient allowance");
        allowances[from][msg.sender] -= amount;
       _transfer(from, to, amount);
       return true;
    }

}