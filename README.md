# ERC20 DEGEN TOKEN IMPLEMENTATION

This Solidity smart contract basically implements the ERC20 standards with a functioning token that will be deployed on the snowtrace network, its main
functions are, transfer, burn, and allows users to redeem swords for a hundred tokens while the minting function is exclusive to the contract owner.

## Description


This Solidity smart contract simply simulates a scenario where the contract owner will be able to mint tokens for himself/herself or for other users,
other contract owners may not be able to mint tokens for themselves, but will be able to transfer and also burn their tokens as well as allow users
to redeem swords for their tokens.


## Getting Started

### Executing program

To run this program, you can use Remix, an online Solidity IDE. To get started, go to the Remix website https://remix.ethereum.org/#lang=en&optimize=false&runs=200&evmVersion=null&version=soljson-v0.8.21+commit.d9974bed.js

Once you are on the Remix website, create a new file by right-clicking clicking on the window on the left and clicking on new file. Save the file with a .sol extension (e.g., ErrorHandling.sol). Copy and paste the following code into the file:

```javascript

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




```


First, go to https://remix.ethereum.org/#lang=en&optimize=false&runs=200&evmVersion=null&version=soljson-v0.8.21+commit.d9974bed.js

To successfully deploy the contract to snowtrace:

1. open vs code
2. enter: cd (your-project) 
3. enter: npm init -y
4. enter: npm install --save-dev hardhat
5. enter: npm install @openzeppelin/contracts
6. Delete the existing module.exports code and add the following code to your hardhat.config.js file. This will enable us to test our smart contracts on the local network with data from Avalanche Mainnet.

```javascript

const FORK_FUJI = false
const FORK_MAINNET = false
let forkingData = undefined;

if (FORK_MAINNET) {
  forkingData = {
    url: 'https://api.avax.network/ext/bc/C/rpcc',
  }
}
if (FORK_FUJI) {
  forkingData = {
    url: 'https://api.avax-test.network/ext/bc/C/rpc',
  }
}


```

7. replace the hardhat.config.js code with this code:

```javascript

require("@nomicfoundation/hardhat-toolbox");

const FORK_FUJI = false;
const FORK_MAINNET = false;
let forkingData = undefined;

if (FORK_MAINNET) {
  forkingData = {
    url: "https://api.avax.network/ext/bc/C/rpcc",
  };
}
if (FORK_FUJI) {
  forkingData = {
    url: "https://api.avax-test.network/ext/bc/C/rpc",
  };
}

/** @type import('hardhat/config').HardhatUserConfig */

module.exports = {
  solidity: "0.8.18",

  
  etherscan: {
    apiKey: "your snowtrace api key here",
  },

  networks: {
    hardhat: {
      gasPrice: 225000000000,
      chainId: !forkingData ? 43112 : undefined, //Only specify a chainId if we are not forking
      forking: forkingData
    },

    fuji: {
      url: 'https://api.avax-test.network/ext/bc/C/rpc',
      gasPrice: 225000000000,
      chainId: 43113,
      accounts: [

        "private key from metamask here"

      ]
    },

    mainnet: {
      url: 'https://api.avax.network/ext/bc/C/rpc',
      gasPrice: 225000000000,
      chainId: 43114,
      accounts: [

        "private key from metamask here"

      ]
    }
  }

};


```

8. enter this on vs code terminal: npx hardhat run scripts/deploy.js --network fuji
9. check on snowtrace if contract is successfully deployed on your snowtrace account




To get the code working, follow these steps:

1. on the left part of the website, right click and create new file and name the file DegenToken.sol
2. paste the code provided above
3. on the left, click on the icon below the magnifying glass icon and it should show another window and press the blue button with the compile
   DegenToken.sol written on it
4. click on the icon that is below the compile icon and input the address of the contract that you have deployed on the at address below the orange deploy button


## Authors

Metacrafter Kyle  
