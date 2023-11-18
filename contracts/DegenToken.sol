// SPDX-License-Identifier: MIT
pragma solidity ^0.8.18;

import "@openzeppelin/contracts/token/ERC20/ERC20.sol";
import "@openzeppelin/contracts/access/Ownable.sol";

contract DegenToken is ERC20, Ownable {
    
    // Default redemption rate for the "sword"
    uint256 public constant SWORD_REDEMPTION_RATE = 100;

    // Mapping to track the number of swords each user owns
    mapping(address => uint256) public swordsOwned;

    constructor() ERC20("Degen", "DGN") {
        // Mint initial tokens to the contract owner
        _mint(msg.sender, 10 * (10 ** uint256(decimals())));
    }

    // Function to allow players to redeem tokens for a "sword"
    function redeemSword(uint256 quantity) public {
        uint256 cost = SWORD_REDEMPTION_RATE * quantity;
        require(balanceOf(msg.sender) >= cost, "Not enough tokens to redeem for a sword");

        // Increment the number of swords the user owns
        swordsOwned[msg.sender] += quantity;

        // Deduct tokens from the user's balance
        _burn(msg.sender, cost);
    }

    // Function to check how many swords a user has
    function checkSwordsOwned(address user) public view returns (uint256) {
        return swordsOwned[user];
    }

    // Function to allow the owner to mint additional tokens
    function mintTokens(address to, uint256 amount) public onlyOwner {
        _mint(to, amount);
    }

    // Function to check a player's token balance
    function checkBalance(address account) public view returns (uint256) {
        return balanceOf(account);
    }

    // Function to allow anyone to burn their own tokens
    function burnTokens(uint256 amount) public {
        require(balanceOf(msg.sender) >= amount, "Not enough tokens to burn");
        _burn(msg.sender, amount);
    }

    // Function to transfer tokens to another address
    function transferTokens(address to, uint256 amount) public {
        require(to != address(0), "Invalid address");
        require(balanceOf(msg.sender) >= amount, "Not enough tokens to transfer");
        _transfer(msg.sender, to, amount);
    }
}
