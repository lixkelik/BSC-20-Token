pragma solidity ^0.8.2;

contract myToken {
    mapping(address => uint) public balances; // To show balances
    mapping(address => mapping(address => uint)) public allowance;

    uint public totalSupply = 10000 * (10 ** 18); // Determine how much total supply that i wanted 
                                                 // the *10 *18 is determined by the decimals
    string public name = "Shrimp Token"; // Token name
    string public symbol = "SHRIMPY"; // The symbol that appear like on exchange
    uint public decimals = 18; // Smallest token fraction that we can transfer

    event Transfer(address indexed from, address indexed to, uint value);
    event Approval(address indexed owner, address indexed spender, uint value);

    constructor(){ //only executed once when we deploy the smart contract
        balances[msg.sender] = totalSupply; //this will the admin of the token because we send all the token to this address
    }
    function balancesOf(address owner) public view returns(uint){
        return balances[owner];
    }

    function transfer(address to, uint value) public returns(bool){
        require(balancesOf(msg.sender) >= value, 'balance too low');
        balances[to] += value;
        balances[msg.sender] -= value;
        emit Transfer(msg.sender, to, value);
        return true;
    }

    function transferFrom(address from, address to, uint value) public returns(bool){
        require(balancesOf(from) >= value, 'balance too low');
        require(allowance[from][msg.sender] >= value, 'allowance too low');
        balances[to] += value;
        balances[from] -= value;
        emit Transfer(from, to, value);
        return true;
    }

    function approve(address spender, uint value) public returns(bool){
        allowance[msg.sender][spender] = value;
        emit Approval(msg.sender, spender, value);
        return true;
    }
}
