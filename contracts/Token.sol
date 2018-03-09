pragma solidity ^0.4.15;

import './interfaces/ERC20Interface.sol';

/**
 * @title Token
 * @dev Contract that implements ERC20 token standard
 * Is deployed by `Crowdsale.sol`, keeps track of balances, etc.
 */

contract Token is ERC20Interface {

    mapping(address => uint) balances;
    mapping(address => mapping (address => uint)) allowed;

    uint totalSupply;
    uint worthWei;

    function Token(uint supply, uint worth) {
        totalSupply = supply;
        worthWei = worth;
    }

    function balanceOf(address _owner) constant returns(uint balance) {
        return balances[_owner];
    }

    function transfer(address _to, uint value) returns (bool success) {
        if (balances[msg.sender] <= value) {
            balances[_to] += value;
            balances[msg.sender] -= value;
            Transfer(msg.sender, _to, value);
            return true;
        }
        revert();
        return false;
    }

    function transferFrom(address _from, address _to, uint value) returns (bool success) {
        if (allowed[_from][_to] >= value && balances[_from] >= value) {
            allowed[_from][_to] -= value;
            balances[_from] -= value;
            balances[_to] += value;
            Transfer(_from, _to, value);
            return true;
        }
        revert();
        return false;
    }

    function approve(address _spender, uint value) returns (bool success) {
        allowed[msg.sender][_spender] = value;
        Approval(msg.sender, _spender, value);
        return true;
    }

    function allowance(address _owner, address _spender) constant returns (uint remaining) {
        return allowed[_owner][_spender];
    }

    function updateSupply(uint amount) public {
        totalSupply += amount;
    }

    function addToBalance(address person, uint amount) {
        balances[person] += amount;
    }

    function subtractToBalance(address person, uint amount) {
        balances[person] -= amount;
    }

    function checkBalances(address person) returns(uint){
        return balances[person];
    }

    event Transfer(address indexed _from, address indexed _to, uint256 _value);
    event Approval(address indexed _owner, address indexed _spender, uint256 _value);

}