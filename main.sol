// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract MotorbikeRacing {
    struct Rider {
        string name;
        uint8 speed;     // 1–100
        uint8 control;   // 1–100
        bool registered;
    }

    struct Race {
        address[] participants;
        bool isActive;
        address winner;
    }

    mapping(address => Rider) public riders;
    Race public currentRace;
    address public owner;

    constructor() {
        owner = msg.sender;
    }

    modifier onlyUnregistered() {
        require(!riders[msg.sender].registered, "Already registered");
        _;
    }

    modifier onlyRegistered() {
        require(riders[msg.sender].registered, "Not registered");
        _;
    }

    function registerRider(string memory _name, uint8 _speed, uint8 _control) external onlyUnregistered {
        require(_speed >= 1 && _speed <= 100, "Speed must be 1-100");
        require(_control >= 1 && _control <= 100, "Control must be 1-100");

        riders[msg.sender] = Rider(_name, _speed, _control, true);
    }

    function joinRace() external onlyRegistered {
        require(!currentRace.isActive, "Race already started");

        currentRace.participants.push(msg.sender);
    }

    function startRace() external {
        require(!currentRace.isActive, "Race already active");
        require(currentRace.participants.length >= 2, "At least 2 racers");

        currentRace.isActive = true;

        address winner = determineWinner();
        currentRace.winner = winner;
        currentRace.isActive = false;
    }

    function determineWinner() internal view returns (address) {
        uint highestScore = 0;
        address winner;

        for (uint i = 0; i < currentRace.participants.length; i++) {
            address racer = currentRace.participants[i];
            Rider memory r = riders[racer];

            // Random-like score: speed * control + pseudo-random bonus
            uint score = uint(r.speed) * uint(r.control) + uint(keccak256(abi.encodePacked(block.timestamp, racer))) % 1000;

            if (score > highestScore) {
                highestScore = score;
                winner = racer;
            }
        }

        return winner;
    }

    function getParticipants() external view returns (address[] memory) {
        return currentRace.participants;
    }

    function resetRace() external {
        require(msg.sender == owner, "Only owner can reset");
        delete currentRace;
    }
}
