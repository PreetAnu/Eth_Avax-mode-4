// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

import "@openzeppelin/contracts/token/ERC20/ERC20.sol";
import "@openzeppelin/contracts/token/ERC20/extensions/ERC20Burnable.sol";
import "@openzeppelin/contracts/access/Ownable.sol";

contract DegenToken is ERC20, ERC20Burnable, Ownable {
    uint public totalTokenSupply;

    constructor(address initialOwner) ERC20("Degen", "DGN") Ownable(initialOwner) {
        uint initialTokenSupply = 1000 * 10**18;
       // _mint(initialOwner, initialTokenSupply);
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
