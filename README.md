# 🏍️ Motorbike Racing: On-Chain Speed Challenge

**Motorbike Racing** is a fully on-chain motorbike racing game written in pure Solidity. Players register bikes, enter races, and compete based on stats and randomness — all on the blockchain. No tokens, no NFTs, no off-chain logic — just gas-efficient fun on Ethereum-compatible networks.

---

## 🚦 Gameplay Overview

- 🛠️ **Register** your custom motorbike with speed and control stats  
- 🏁 **Join** open races against other registered players  
- 🎲 **Race** outcome is calculated with a mix of stats and randomness  
- 👑 **Winner** is automatically selected and recorded on-chain   

---

## 🎮 Game Flow

1. Rider registers their bike with a name, speed (1–100), and control (1–100)  
2. Multiple riders join a race  
3. Race starts when any player or the contract owner calls `startRace()`  
4. The winner is determined by a formula involving stats and pseudo-randomness  
5. Race data is stored on-chain for transparency  

---

## 💻 Smart Contract

```solidity
function registerRider(string memory name, uint8 speed, uint8 control) external
function joinRace() external
function startRace() external
function getParticipants() external view returns (address[])
function resetRace() external
