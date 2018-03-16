pragma solidity ^0.4.15;

import './Queue.sol';
import './Token.sol';

/**
 * @title Crowdsale
 * @dev Contract that deploys `Token.sol`
 * Is timelocked, manages buyer queue, updates balances on `Token.sol`
 */

contract Crowdsale {
    // YOUR CODE HERE
    Token public token;
    Queue public queue;

    uint startTime;
    uint endTime;
    uint funds;
    uint tokensSold;
    address owner;

    function Crowdsale(uint start, uint end, uint supply, uint worth, uint time) public {
        owner = msg.sender;
        startTime = start;
        endTime = end;
        token = new Token(supply, worth);
        queue = new Queue(time);
    }

    function mint(uint amount) public ownerOnly() {
        token.updateSupply(amount);
    }

    function burn(uint amount) public ownerOnly() {
        token.updateSupply(amount);
    }

    function getFunds() public ownerOnly() returns(uint) {
        return funds;
    }

    function buyTokens(uint amount) saleOpen() firstInLine() someoneBehind() {
        token.addToBalance(msg.sender, amount);
        tokensSold += amount;
        TokenPurchased(msg.sender, amount);
    }

    function refundTokens(uint amount) saleOpen() {
        if (token.checkBalances(msg.sender) >= amount) {
            msg.sender.transfer(amount);
            token.subtractToBalance(msg.sender, amount);
            token.updateSupply(amount);
            tokensSold -= amount;
            TokenRefunded(msg.sender, amount);
        }
    }

    modifier forwardFunds() {
        if (now < endTime) {
            throw;
        }
        for (uint i = 0; i < token.; i++) {
            token.transfer(token.balances);
        }

    }

    modifier ownerOnly() {
        if (msg.sender != owner) {
            throw;
        }
        _;
    }

    modifier saleOpen() {
        if (now >= endTime) {
            throw;
        }
        _;
    }

    modifier firstInLine() {
        if (queue.getFirst() != msg.sender) {
            throw;
        }
        _;
    }

    modifier someoneBehind() {
        if (queue.getSecond() == 0) {
            throw;
        }
        _;
    }

    event TokenPurchased(address buyer, uint256 amount);
    event TokenRefunded(address buyer, uint256 amount);
}
