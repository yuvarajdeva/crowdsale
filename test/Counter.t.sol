// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

import "forge-std/Test.sol";
import "forge-std/Vm.sol"; // For cheatcodes

// Import your contract source files here
import "../src/Token.sol";
import "../src/crowdsale.sol";
import "../src/Vesting.sol";

contract CrowdsaleVestingTest is Test {

  // Replace these with your actual contract deployment addresses 
  Token public  tokenAddress;
  Crowdsale public crowdsaleAddress;
  Vesting public vestingAddress;

  function setUp() public {
    // Deploy your contracts here using Vm.deploy or other methods
    tokenAddress = new Token(1000000); // Assuming initial supply of 1 million tokens
    crowdsaleAddress = new Crowdsale(
        address(tokenAddress),
        address(this), // Replace with your wallet address if needed
        1 ether / 10000000000000000, // Set your exchange rate
        1 weeks // Change this to your desired crowdsale duration
      );

    vestingAddress = new Vesting(address(tokenAddress), 1 days, 1 weeks); // Deploy Vesting contract
    crowdsaleAddress.updateVestContract(address(vestingAddress));
    tokenAddress.transfer(address(crowdsaleAddress), 1000*10**18);
  }

  function testCrowdsaleContribution() public {
    vm.startBroadcast(); // Start block recording

    crowdsaleAddress.contribute{value: 0.5 ether}();
    uint256 initialVestedBalance = vestingAddress.vestedBalance(address(this));
    // crowdsaleAddress.haltSale();
    // uint256 finalVestedBalance = vestingAddress.vestedBalance(address(this));
    // assertGt(finalVestedBalance, initialVestedBalance, "Vested balance should increase after contributing to the crowdsale");
    
    vm.stopBroadcast(); // Stop block recording
  }

//   function testVestingClaimAfterCliff() public {
//     vm.startBroadcast();

//     // Simulate time passing beyond the cliff period
//     vm.warp(block.timestamp + 2 days); // Move time forward by 2 days

//     // Make a contribution (already tested in previous function)
//     vm.deal(address(this), 1 ether);
//     payable(address(crowdsaleAddress)).transfer(1 ether);

//     uint256 claimableTokens = Vesting(vestingAddress).vestedBalance(address(this));
//     assertEq(claimableTokens, 1000); // Should be fully vested after cliff period

//     // Claim vested tokens
//     Vesting(vestingAddress).claim();

//     // Check if tokens were transferred to the beneficiary
//     uint256 tokenBalance = Token(tokenAddress).balanceOf(address(this));
//     assertEq(tokenBalance, claimableTokens);

//     vm.stopBroadcast();
//   }

  // You can add more test cases here for different scenarios

}
