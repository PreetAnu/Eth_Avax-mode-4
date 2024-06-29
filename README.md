# Eth_Avax-mode-4
Created a ERC20 token 🪙 and deployed it on the Avalanche network for Degen Gaming🎮🎮.  Have  functionality:  Minting new tokens 🪙, Redeeming tokens🪙, Checking token balance💰, Burning tokens🪙. {Smart Contract}
## DegenToken
DegenToken is an ERC20 token designed for Degen Gaming on the Avalanche network. It allows for minting, transferring, redeeming, and burning tokens, providing a flexible system for in-game rewards and transactions.
### Features
* Minting Tokens: The owner can mint new tokens to distribute as rewards.
* Transferring Tokens: Users can transfer tokens to each other.
* Redeeming Tokens: Users can redeem tokens by burning them.
* Checking Balance: Users can check their token balance.
* Burning Tokens: Users can burn tokens they own.
## Deployment
### Step-by-Step Guide
1. Set Up MetaMask for Avalanche Fuji C-Chain:Open MetaMask and click on the network dropdown.Select "Add Network" and enter the following details:Network Name: Avalanche Fuji C-ChainNew RPC URL: https://api.avax-test.network/ext/bc/C/rpcChain ID: 43113Currency Symbol: AVAXBlock Explorer URL: https://testnet.snowtrace.io
2. Get Testnet AVAX:Go to the Avalanche Fuji Faucet and request AVAX for your MetaMask wallet.
3. Deploy the Contract Using Remix:
* Open Remix IDE.
* Create a new file named DegenToken.sol.Copy and paste the contract code into the file.
* Click on the "Solidity Compiler" tab and select the appropriate compiler version (0.8.20).
* Click "Compile DegenToken.sol".
* Click on the "Deploy & Run Transactions" tab.
* In the "Environment" dropdown, select "Injected Web3".
* Ensure MetaMask is connected to the Avalanche Fuji C-Chain network.
* In the "Contract" dropdown, select DegenToken.
* Enter the initial owner's address as the constructor argument.
* Click "Transact" to deploy the contract and confirm the transaction in MetaMask.
4. Verify the Contract on Snowtrace:
* Go to Snowtrace Testnet.
* Find your contract using the contract address provided after deployment.
* Click "Verify & Publish" and follow the instructions to verify your contract.
  ### Contract Code
  ```
  // SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

import "@openzeppelin/contracts/token/ERC20/ERC20.sol";
import "@openzeppelin/contracts/token/ERC20/extensions/ERC20Burnable.sol";
import "@openzeppelin/contracts/access/Ownable.sol";

contract DegenToken is ERC20, ERC20Burnable, Ownable {
    uint public totalTokenSupply;

    constructor(address initialOwner) ERC20("Degen", "DGN") Ownable(initialOwner) {
        uint initialTokenSupply = 1000 * 10**18;
        totalTokenSupply = initialTokenSupply; // Initialize totalTokenSupply
    }

    function MintTokens(address recipient, uint amount) public onlyOwner {
        _mint(recipient, amount);
        totalTokenSupply += amount;
    }

    function transferTokens(address recipient, uint amount) public {
        _transfer(msg.sender, recipient, amount);
    }

    function redeem(uint256 amount) public {
        _burn(msg.sender, amount);
        totalTokenSupply -= amount;
    }

    function getBalance(address account) public view returns (uint256) {
        return balanceOf(account);
    }

    function BurnTokens(uint amount) public {
        _burn(msg.sender, amount);
        totalTokenSupply -= amount;
    }
}
```
## Author
***Anupreet Kaur ***

## License
This project is licensed under the MIT License - see the LICENSE.md file for details.
