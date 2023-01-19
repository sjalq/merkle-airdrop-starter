# How to distribute funds with the Merkle claim factory. 

## Notes:
* Please read the instruction below in full before the process.
* Ideally, test the process on an Ethereum test net first and on the mainnet with smaller amounts before doing a large deploy. 

## Fresh deployment 
0. Collect the address of the hardware wallet used for payout distribution and the contract address of the distributed token (IE USDC's address on the relevant network). Also, ensure the hardware wallet is funded with sufficient USDC to complete the distribution. 
1. Deploy the "MerkleFactory" contract in "contracts/flat.sol" to the desired network via "remix.ethereum.org". Make sure to enable optimisations when compiling. 
2. Save the factory contract from the "deployed" segment in Remix.
3. In the "generator/" subfolder, edit the config.json file to contain the list of recipient addresses and amounts. 
4. From the "generator/" subfolder, run "npm run start". This will alter the "merkle.json" file, generating a new "root" value.
5. Copy the root value from "generator/merkle.json" 
6. In Remix, under deployed contracts, in the MerkleFactory, in the "deployMerkleDrop" function, add the root value into the "_merkleRoot" parameter. Also, fill in the "_rewardToken" and "_fundingSource" from step one. Clicking transact will create a new Merkle claim contract. Copy the "_merkleClaimAddress" value from the debug information associated with that instruction; this is the contract the front end will need to interact with.  
7. Next, you will need to approve this contract to distribute the desired amount. You do this by calling the "approve" function on the reward token (USDC) contract. 
8. From the Remix deployment tab, you can select the "IERC20" contract, and in the "At address" field, you can fill in the reward token (USDC) contract address. This will add the contract to the Remix interface.
9. You can then call the "approve" function on USDC by providing the "_merkleClaimAddress" as the "spender" field and the total amount you wish to distribute and then calling it using the hardware wallet address responsible for the distribution. You need to make sure that the hardware wallet address contains sufficient funds. 
10.  The Merkle drop distribution is now ready on-chain. 

## Repeat deployment.
Instead of steps 1 and 2 above, you connect Remix to the desired network and then in the Deployment tab, select "MerkleClaimFactory" and provide the address stored in step 2. Then you can follow step 3 above. 

## Using the UI to test if deployments work
0. Collect the deployed merkleClaimAddress (step 6), the chain Id the contract is deployed on (1 in the case of Ethereum mainnet), and the RPC endpoint details from Infura.   
1. Copy the contents from your "generator/config.json" file into the "const json = " field in config.ts file in "frontend/" folder.
2.  Copy "frontend/.env.sample" to "frontend/.env.local", filling in the fields collected above into NEXT_PUBLIC_CONTRACT_ADDRESS, NEXT_PUBLIC_RPC_NETWORK and NEXT_PUBLIC_RPC_URL.
3. From "frontend/" run "npm install" and then "npm run dev". This will host the distribution app on "http://localhost:3000/"
4. From there, you can connect Metamask using an address included in the "config.json" file to see if you can claim the correct amount of tokens. 