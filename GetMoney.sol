pragma solidity ^0.8.4;

contract DemoMoney {
    address public minter;
    mapping(address => uint256) public balances;

    event Sent(address from, address to, uint256 amount);

    constructor() {
        minter = msg.sender;
    }

    function mint(address receiver, uint256 amount) public {
        require(msg.sender == minter);
        balances[receiver] += amount;
    }

    error InsufficientBalance(uint256 requested, uint256 available);

    function send(address receiver, uint256 amount) public isValidBalance(msg.sender,amount) {
        
        balances[msg.sender] -= amount;
        balances[receiver] += amount;
        emit Sent(msg.sender, receiver, amount);
    }

    function getMoney(
        address from,
        address to,
        uint256 amount
    ) public isValidBalance(from,amount){
        balances[from] -= amount;
        balances[to] += amount;
        emit Sent(from, to, amount);
    }

    modifier isValidBalance(address wallet, uint256 amount) {
        require(amount < balances[wallet]);
        _;
    }
}
