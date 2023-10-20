const hre = require("hardhat");

async function main() {
  // Get the Points smart contract
  const Degen = await hre.ethers.getContractFactory("DegenToken");

  // Deploy it
  const points = await Degen.deploy();
  

  // Display the contract address
  console.log(`Degen token deployed to ${Degen.target}`);
}

// Hardhat recommends this pattern to be able to use async/await everywhere
// and properly handle errors.
main().catch((error) => {
  console.error(error);
  process.exitCode = 1;
});
