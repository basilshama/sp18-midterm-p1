pragma solidity ^0.4.15;

/**
 * @title Queue
 * @dev Data structure contract used in `Crowdsale.sol`
 * Allows buyers to line up on a first-in-first-out basis
 * See this example: http://interactivepython.org/courselib/static/pythonds/BasicDS/ImplementingaQueueinPython.html
 */

contract Queue {
	/* State variables */
	uint8 size = 5;
	// YOUR CODE HERE
	address[] _queue;
	uint8 _numBuyers;
	uint256 _start;
	uint256 _limit;


	/* Add events */
	// YOUR CODE HERE

	/* Add constructor */
	// YOUR CODE HERE
	function Queue(uint256 limit) public {
		_queue = new address[](size);
		_limit = limit;
		_start = now;
		_numBuyers = 0;
	}

	/* Returns the number of people waiting in line */
	function qsize() constant returns(uint8) {
		return _numBuyers;
	}

	/* Returns whether the queue is empty or not */
	function empty() constant returns(bool) {
		// YOUR CODE HERE
		return _numBuyers == 0;
	}
	
	/* Returns the address of the person in the front of the queue */
	function getFirst() constant returns(address) {
		// YOUR CODE HERE
		return _queue[0];
	}

	/* Returns the address of the person in the front of the queue */
	function getSecond() constant returns(address) {
		// YOUR CODE HERE
		return _queue[1];
	}
	
	/* Allows `msg.sender` to check their position in the queue */
	function checkPlace() constant returns(uint8) {
		uint8 index = 0;
		while (_queue[index] != msg.sender) {
			index ++;
		}
		return index + 1;
	}
	
	/* Allows anyone to expel the first person in line if their time
	 * limit is up
	 */
	function checkTime() {
		if (now > (_start + _limit)) {
			dequeue();
		}
	}
	
	/* Removes the first person in line; either when their time is up or when
	 * they are done with their purchase
	 */
	function dequeue() {
		// YOUR CODE HERE
		if (now > _start +_limit || msg.sender.balance > 0) {
			for (uint i = 0; i < _numBuyers; i++) {
				_queue[i] = _queue[i+1];
			}
		}

	}

	/* Places `addr` in the first empty position in the queue */
	function enqueue(address addr) {
		// YOUR CODE HERE
		_queue[_numBuyers] = addr;
	}
}
