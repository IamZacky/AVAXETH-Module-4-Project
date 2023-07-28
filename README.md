# AVAXETH-Module-4-Project

## DEGEN Token Contract

DEGEN is an ERC-20 token contract that provides basic functionalities for a gaming platform. It allows the platform to create and distribute new tokens as rewards to players, enables token transfers between players, and supports token redemption for in-game items. Additionally, players can check their token balances and burn tokens they no longer need.

## Token Functionalities

1. **Minting new tokens:** The platform owner can create new tokens and distribute them to players as rewards.

2. **Transferring tokens:** Players can transfer their tokens to other addresses on the platform.

3. **Redeeming tokens:** Players can redeem their tokens for items in the in-game store. The redemption logic is handled by an external contract called `GameStore`.

4. **Checking token balance:** Players can check their token balance at any time using the `getBalance` function.

5. **Burning tokens:** Players can burn (destroy) tokens they own but no longer need, making them permanently unrecoverable.

## Smart Contract Details

The `DEGEN` contract extends the OpenZeppelin ERC20 and ERC20Burnable contracts. It also inherits from the `Ownable` contract to manage the ownership.

### Deployment

1. Deploy the `DEGEN` contract on the Ethereum blockchain.

2. Deploy the `GameStore` contract separately to handle the redemption logic.

3. Call the `setStoreAddress` function in the DEGEN contract, passing the address of the deployed `GameStore` contract. This step is crucial before players can start redeeming tokens.

### Functions

1. `mint(address to, uint256 amount) public onlyOwner`: Creates new tokens and assigns them to the specified address (`to`). Only the contract owner can mint tokens.

2. `transferTokens(address to, uint256 amount) public`: Allows players to transfer tokens to other addresses (`to`).

3. `redeemTokens(uint256 amount) public`: Allows players to redeem their tokens for in-game items. The tokens are transferred from the player to the external `GameStore` contract, and the redemption logic is executed there.

4. `getBalance(address account) public view returns (uint256)`: Allows players to check their token balance.

5. `burnTokens(uint256 amount) public`: Allows players to burn a specified amount of their tokens, making them unrecoverable.

### Events

1. `TokensRedeemed(address indexed player, uint256 amount)`: An optional event emitted when a player redeems tokens, indicating the player's address and the amount of tokens redeemed.

## Notes

- Before players can redeem tokens, ensure to deploy the `GameStore` contract and set its address using the `setStoreAddress` function in the DEGEN contract.

- The redemption logic and functionality for the `GameStore` contract are outside the scope of this contract and must be implemented separately.

- The DEGEN token contract should be thoroughly tested before deployment on the Ethereum mainnet or any other public network to ensure security and correctness.

---
