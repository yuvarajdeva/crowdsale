// SPDX-License-Identifier: UNLICENSED

pragma solidity ^0.8.20;

import "@openzeppelin/contracts/token/ERC20/IERC20.sol"; // Import ERC20 interface
import "./interfaces/IVesting.sol";

contract Vesting is IVesting {
  IERC20 public token; // Reference to the ERC-20 token
  mapping(address => uint256) public vestedTokens; // Vested token balances per address
  uint256 public cliff; // Cliff period in seconds
  uint256 public vestingDuration; // Vesting duration in seconds

  constructor(
    address _token,
    uint256 _cliff,
    uint256 _vestingDuration
  ) {
    token = IERC20(_token);
    cliff = block.timestamp + _cliff;
    vestingDuration = _vestingDuration;
  }

  function deposit(address beneficiary, uint256 amount) public {
    require(beneficiary != address(0), "Invalid beneficiary address");
    vestedTokens[beneficiary] += amount;
  }

  function claim() public {
    uint256 claimable = vestedBalance(msg.sender);
    require(claimable > 0, "No claimable tokens");
    vestedTokens[msg.sender] -= claimable;
    token.transfer(msg.sender, claimable);
  }

  function vestedBalance(address beneficiary) public view returns (uint256) {
    uint256 elapsedTime = block.timestamp - cliff;
    if (elapsedTime < vestingDuration) {
      return 0; // No tokens vested before cliff
    } else {
      uint256 vestedAmount = vestedTokens[beneficiary] * elapsedTime / vestingDuration;
      return vestedAmount > vestedTokens[beneficiary] ? vestedTokens[beneficiary] : vestedAmount; // Prevent overflow
    }
  }
}
