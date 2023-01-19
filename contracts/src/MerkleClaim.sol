// SPDX-License-Identifier: AGPL-3.0-only
pragma solidity >=0.8.0;

/// ============ Imports ============

import { IERC20 } from "@openzeppelin/token/ERC20/IERC20.sol"; // OZ: IERC20
import { MerkleProof } from "@openzeppelin/utils/cryptography/MerkleProof.sol"; // OZ: MerkleProof

/// @title MerkleClaim
/// @notice Tokens claimable by members of a merkle tree
/// @author Anish Agnihotri <contact@anishagnihotri.com>
contract MerkleClaim {

  /// ============ Immutable storage ============

  /// @notice claimant inclusion root
  bytes32 public immutable merkleRoot;

  /// @notice ERC20 token
  IERC20 public immutable token;

  /// @notice Source of funds address
  address public immutable fundingSource;

  /// ============ Mutable storage ============

  /// @notice Mapping of addresses who have claimed tokens
  mapping(address => bool) public hasClaimed;

  /// ============ Errors ============

  /// @notice Thrown if address has already claimed
  error AlreadyClaimed();
  /// @notice Thrown if address/amount are not part of Merkle tree
  error NotInMerkle();

  /// ============ Constructor ============

  /// @notice Creates a new MerkleClaimERC20 contract
  /// @param _token of token to be claimed
  /// @param _fundingSource of account containing disbursement funds
  /// @param _merkleRoot of claimants
  constructor(
    address _token,
    address _fundingSource,
    bytes32 _merkleRoot
  )  {
    token = IERC20(_token); // Update token
    fundingSource = _fundingSource; // Update fund source
    merkleRoot = _merkleRoot; // Update root
  }

  /// ============ Events ============

  /// @notice Emitted after a successful token claim
  /// @param to recipient of claim
  /// @param amount of tokens claimed
  event Claim(address indexed to, uint256 amount);

  /// ============ Functions ============

  /// @notice Allows claiming tokens if address is part of merkle tree
  /// @param to address of claimant
  /// @param amount of tokens owed to claimant
  /// @param proof merkle proof to prove address and amount are in tree
  function claim(address to, uint256 amount, bytes32[] calldata proof) external {
    // Throw if address has already claimed tokens
    if (hasClaimed[to]) revert AlreadyClaimed();

    // Verify merkle proof, or revert if not in tree
    bytes32 leaf = keccak256(abi.encodePacked(to, amount));
    bool isValidLeaf = MerkleProof.verify(proof, merkleRoot, leaf);
    if (!isValidLeaf) revert NotInMerkle();

    // Set address to claimed
    hasClaimed[to] = true;

    // Send tokens to cliamee from fund source
    token.transferFrom(fundingSource, to, amount);

    // Emit claim event
    emit Claim(to, amount);
  }
}

contract MerkleClaimFactory
{
  event ContractDeployed(address _merkleClaimAddress);

  constructor() {}

  function deployMerkleDrop(
      address _rewardToken, 
      address _fundingSource, 
      bytes32 _merkleRoot) 
    external returns (address)
  {
    MerkleClaim merkleClaim = new MerkleClaim(_rewardToken, _fundingSource, _merkleRoot);
    emit ContractDeployed(address(merkleClaim));
    return address(merkleClaim);
  }
}