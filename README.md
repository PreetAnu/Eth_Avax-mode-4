# Eth_Avax-mode-4

Created a ERC20 token 🪙 and deployed it on the Avalanche network for Degen Gaming🎮🎮. Have functionality: Minting new tokens 🪙, Redeeming tokens🪙, Checking token balance💰, Burning tokens🪙. {Smart Contract}

## DegenToken

DegenToken is an ERC20 token designed for Degen Gaming on the Avalanche network. It allows for minting, transferring, redeeming, and burning tokens, providing a flexible system for in-game rewards and transactions.

### Features

* **Minting Tokens:** The owner can mint new tokens to distribute as rewards.
* **Transferring Tokens:** Users can transfer tokens to each other.
* **Redeeming Tokens:** Users can redeem tokens by burning them.
* **Checking Balance:** Users can check their token balance.
* **Burning Tokens:** Users can burn tokens they own.

## Deployment

### Step-by-Step Guide

1. **Set Up MetaMask for Avalanche Fuji C-Chain:**
    * Open MetaMask and click on the network dropdown.
    * Select "Add Network" and enter the following details:
      - Network Name: Avalanche Fuji C-Chain
      - New RPC URL: https://api.avax-test.network/ext/bc/C/rpc
      - Chain ID: 43113
      - Currency Symbol: AVAX
      - Block Explorer URL: https://testnet.snowtrace.io

2. **Get Testnet AVAX:**
    * Go to the Avalanche Fuji Faucet and request AVAX for your MetaMask wallet.

3. **Deploy the Contract Using Remix:**
    * Open Remix IDE.
    * Create a new file named `DegenToken.sol`.
    * Click on the "Solidity Compiler" tab.
    * Click "Compile `DegenToken.sol`".
    * Click on the "Deploy & Run Transactions" tab.
    * In the "Environment" dropdown, select "Injected Web3".
    * Ensure MetaMask is connected to the Avalanche Fuji C-Chain network.

4. **Verify the Contract on Snowtrace:**
    * Go to Snowtrace Testnet.
    * Find your contract using the contract address provided after deployment.
    * Click "Verify & Publish" and follow the instructions to verify your contract.

### Contract Code

```solidity
// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

import "@openzeppelin/contracts/token/ERC20/ERC20.sol";
import "@openzeppelin/contracts/token/ERC20/extensions/ERC20Burnable.sol";
import "@openzeppelin/contracts/access/Ownable.sol";

contract DegenToken is ERC20, ERC20Burnable, Ownable {
    uint public totalTokenSupply;

    constructor(address initialOwner) ERC20("Degen", "DGN") Ownable(initialOwner) {
        uint initialTokenSupply = 1000 * 10**18;
        _mint(initialOwner, initialTokenSupply);
        totalTokenSupply = initialTokenSupply; // Initialize totalTokenSupply
    }

    function MintTokens(address recipient, uint amount) public onlyOwner {
        _mint(recipient, amount);
        totalTokenSupply += amount;
    }

    function transferTokens(address recipient, uint amount) public {
        _transfer(msg.sender, recipient, amount);
    }

    function redeem(uint256 item) public {
        uint256 cost;
        string memory itemName;

        if (item == 1) {
            cost = 100 * 10**18;
            itemName = "Official Degen NFT";
        } else if (item == 2) {
            cost = 75 * 10**18;
            itemName = "Degen Gaming T-shirt";
        } else if (item == 3) {
            cost = 50 * 10**18;
            itemName = "Degen Gaming Hat";
        }else if (item == 4) {
            cost = 100 * 10**18;
            itemName = "Exclusive Degen Gaming NFT";
        }
         else {
            revert("Invalid item");
        } 
        require(balanceOf(msg.sender) >= cost, "Insufficient balance to redeem");
        _burn(msg.sender, cost);
        emit ItemRedeemed(msg.sender, itemName, cost);
    }
    //declare event
    event ItemRedeemed(address indexed user, string itemName, uint256 cost);

    function getBalance(address account) public view returns (uint256) {
        return balanceOf(account);
    }

    function BurnTokens(uint amount) public {
        _burn(msg.sender, amount);
        totalTokenSupply -= amount;
    }
    //returns a string listing the available items
    function ShopeItems() public pure returns (string memory) {
        return "The following items are available for purchase: \n1. Official Degen NFT \n2.Degen Gaming T-shirt \n 3.Degen Gaming Hat \n4. Exclusive Degen Merchandise";
    }
}

```
### Author
*  __*Anupreet Kaur*__ 
* anupreetk159@gmail.com
### Licence
This project is licensed under the MIT License - see the LICENSE.md file for details.
