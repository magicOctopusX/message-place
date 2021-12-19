//SPDX-License-Identifier: UNLICENSED

pragma solidity ^0.8.0;

import "hardhat/console.sol";

contract MessagePortal {
    uint totalMessage; //solidity will initialize totalMessage to zero
    // uint seed;

    event NewMessage(address indexed from, uint timestamp, string message);

    //a struct is a custom data type where we can customise what we want to hold inside it
    struct Message {
        string message; //the message the user sent
        address waver;  //the address of the user who waved
        uint timestamp; //timestamp when the user waved
    }

    //declared a variable messages that lets us store an array of structs
    //holds all the messages anyone ever sends
    Message[] messages;


    mapping(address => uint) public lastMessageAt;

    constructor() payable {
        console.log("we have been constructed!, MessagePortal.sol contract MessagePortal");
    }

    //this is a state changing function because it will change the variable and save it on to the blockchain
    function message(string memory _message) public {
        //to prevent spamming
        require(lastMessageAt[msg.sender] + 5 minutes < block.timestamp, "You gotta wait 5 minutes!!");

        totalMessage += 1;
        console.log("%s messaged with message: %s", msg.sender, _message); 
        messages.push(Message(_message, msg.sender, block.timestamp));

        //emit the event
        emit NewMessage(msg.sender, block.timestamp, _message);

    }

    //view means it's a readonly
    //
    function getAllMessages() view public returns (Message[] memory) {
        return messages;
    }

    function getTotalMessages() view public returns (uint) {
        console.log("We have %d total waves!", totalMessage);
        return totalMessage;
    }
}