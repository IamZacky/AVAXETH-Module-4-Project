// SPDX-License-Identifier: MIT
pragma solidity ^0.8.9;

/* 
1. Minting new tokens: The platform should be able to create new tokens and distribute them to players as rewards. Only the owner can mint tokens.
2. Transferring tokens: Players should be able to transfer their tokens to others.
3. Redeeming tokens: Players should be able to redeem their tokens for items in the in-game store.
4. Checking token balance: Players should be able to check their token balance at any time.
5. Burning tokens: Anyone should be able to burn tokens, that they own, that are no longer needed.

*/

import "@openzeppelin/contracts/token/ERC20/ERC20.sol";
import "@openzeppelin/contracts/token/ERC20/extensions/ERC20Burnable.sol";
import "@openzeppelin/contracts/access/Ownable.sol";

// Import the external store contract interface
interface GameStore {
    function redeemItems(address player, uint256 amount) external;
}

contract DEGEN is ERC20, ERC20Burnable, Ownable {
    // Store the address of the external store contract
    address public storeAddress;

    constructor() ERC20("Degen", "DGN") {}

    // Minting new tokens, only the owner can mint
    function mint(address to, uint256 amount) public onlyOwner {
        _mint(to, amount);
    }

    // Transferring tokens
    function transferTokens(address to, uint256 amount) public {
        _transfer(_msgSender(), to, amount);
    }

    // Set the address of the external store contract
    function setStoreAddress(address _storeAddress) external onlyOwner {
        storeAddress = _storeAddress;
    }

    // Redeeming tokens for items in the in-game store
    function redeemTokens(uint256 amount) public {
        require(storeAddress != address(0), "Store address not set");
        require(amount > 0, "Amount must be greater than zero");

        // Transfer tokens from the player to the store contract
        _transfer(_msgSender(), storeAddress, amount);

        // Call the redeemItems function in the external store contract
        GameStore(storeAddress).redeemItems(_msgSender(), amount);

        // Emit an event to indicate the redemption (optional)
        emit TokensRedeemed(_msgSender(), amount);
    }

    // Checking token balance
    function getBalance(address account) public view returns (uint256) {
        return balanceOf(account);
    }

    // Burning tokens
    function burnTokens(uint256 amount) public {
        _burn(_msgSender(), amount);
    }

    // Event to indicate the redemption (optional)
    event TokensRedeemed(address indexed player, uint256 amount);
}
