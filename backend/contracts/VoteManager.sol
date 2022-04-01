pragma solidity ^0.8.7;

import "hardhat/console.sol";
import "@openzeppelin/contracts/utils/Counters.sol";

contract VoteManager {

    struct Candidate {
        uint id;
        uint totalVote;
        string name;
        string imageHash;
        address candidateAddress;

    }
    using Counters for Counters.Counter;
    Counters.Counter private candidatesIds;

    mapping(address => Candidate) private candidates;
    mapping(uint=> address) private accounts;

    function registerCandidate(string calldata _name, string calldata _imageHash) external {
        require(msg.sender != address(0), "Sender address must be valid"); 
        candidatesIds.increment();
        uint candidateId = candidatesIds.current();
        address _address = address(msg.sender);
        Candidate memory newCandidate = Candidate(candidateId, 0, _name, _imageHash, _address);  
        candidates[_address] = newCandidate;  
        accounts[candidateId] = msg.sender;
        emit candidateCreated(_address, _name);
    }
}

