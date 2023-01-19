//  SPDX-License-Identifier: MIT

pragma solidity ^0.8.10;

contract Game {

    // Address of the game owner
    address public owner;

    // Mapping from player address to their game state
    mapping (address => Player) public players;

    //  Creating of the struct of Player
    struct Player{
        bool active;
        uint score;
    }

    //  Boolean to check the game is still active or not
    bool public gameOnGoing = true;

    // Event to emit when player score is updated
    event ScoreUpdated(address player, uint score);
    
    // Declaring the constructor to set the game owner
    constructor() public {
        owner = msg.sender;
    }

    //  Function to join game 

    function joinGame() public {
        require(gameOnGoing, "Game is over");
        require(!players[msg.sender].active,"Player has already joined the game");
        
        //  Set the player game state
        players[msg.sender] = Player({
            active : true,
            score : 0
        });
    }
    //  Function to Play game
    function play() public {
        require(gameOnGoing,"Game is over");
        require(players[msg.sender].active,"Player has not joined the game");
       // Update the players score
       players[msg.sender] .score++;

       // Emit a ScoreUpdated event 
       emit ScoreUpdated(msg.sender, players[msg.sender].score);
    }
    //  Function to end game

    function endGame() public {
        require(gameOnGoing, "Game is already over");
        require(msg.sender == owner, "You are not the owner you cannot end the game ");

        // Set the ongoing game to false to stop the game
        gameOnGoing = false;




     //  Determining the winner
     address winner;
     uint maxScore =0;
     for (address player in players) {
        if(players[player].score > maxScore){
            winner = player;
            maxScore = players[player].score;
        }
     }

     // Award the winner
     winner.transfer(this.balance);
    }

}