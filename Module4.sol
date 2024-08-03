// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

import "@openzeppelin/contracts/token/ERC20/ERC20.sol";
import "@openzeppelin/contracts/token/ERC20/extensions/ERC20Burnable.sol";
import "@openzeppelin/contracts/access/Ownable.sol";

contract DegenToken is ERC20, ERC20Burnable, Ownable {
    uint public totalTokenSupply;

    // Mapping to track redeemed items by players
    mapping(address => string[]) private redeemedItems;

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
        } else if (item == 4) {
            cost = 100 * 10**18;
            itemName = "Exclusive Degen Gaming NFT";
        } else {
            revert("Invalid item");
        }

        require(balanceOf(msg.sender) >= cost, "Insufficient balance to redeem");

        // Burn the tokens
        _burn(msg.sender, cost);
        totalTokenSupply -= cost;

        // Record the redeemed item
        redeemedItems[msg.sender].push(itemName);

        emit ItemRedeemed(msg.sender, itemName, cost);
    }

    // Declare event
    event ItemRedeemed(address indexed user, string itemName, uint256 cost);

    function getBalance(address account) public view returns (uint256) {
        return balanceOf(account);
    }

    function BurnTokens(uint amount) public {
        _burn(msg.sender, amount);
        totalTokenSupply -= amount;
    }

    // Returns a string listing the available items
    function ShopItems() public pure returns (string memory) {
        return "The following items are available for purchase: \n1. Official Degen NFT \n2. Degen Gaming T-shirt \n3. Degen Gaming Hat \n4. Exclusive Degen Merchandise";
    }

    // Function to get redeemed items of a player
    function getRedeemedItems(address player) public view returns (string[] memory) {
        return redeemedItems[player];
    }
}
