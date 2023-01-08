// SPDX-License-Identifier: AGPL-3.0-only
pragma solidity >=0.8.0;

import "./MerkleClaim.sol";
import { ERC20 } from "@solmate/tokens/ERC20.sol"; // Solmate: ERC20

contract RewardToken is ERC20
{
  constructor() ERC20("Reward Token", "RTK", 18) 
  {
    _mint(msg.sender, (10**6)*(10**18));
  }
}

contract DemoMerkleClaim
{
  event ContractsDeployed(address _rewardToken, address _merkleClaim);

  ERC20 public rewardToken;
  MerkleClaim public merkleClaim;

  constructor(bytes32 _merkleRoot)
  {
    rewardToken = new RewardToken();
    merkleClaim = new MerkleClaim(address(rewardToken), address(this), _merkleRoot);
    rewardToken.approve(address(merkleClaim), (10**6)*(10**18));

    emit ContractsDeployed(address(rewardToken), address(merkleClaim));
  }
}
