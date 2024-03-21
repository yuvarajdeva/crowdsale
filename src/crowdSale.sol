// SPDX-License-Identifier: UNLICENSED

pragma solidity ^0.8.20;

import "@openzeppelin/contracts/token/ERC20/IERC20.sol"; // Import ERC20 interface
import "@openzeppelin/contracts/access/Ownable.sol";
import "./interfaces/IVesting.sol";

contract Crowdsale is Ownable {
    IERC20 public token; // Instance of the ERC-20 token
    address payable public wallet; // Address to receive Ether
    uint256 public rate; // Exchange rate (Ether per token)
    uint256 public deadline; // Crowdsale end date
    bool public paused; // Crowdsale paused flag
    IVesting public vesting; 

    constructor(
        address _token,
        address _wallet,
        uint256 _rate,
        uint256 _duration
    ) Ownable(_wallet){
        token = IERC20(_token);
        wallet = payable(_wallet);
        rate = _rate;
        deadline = block.timestamp + _duration;
        paused = false;
    }

    function updateVestContract(address _vestContract) public onlyOwner {
        vesting = IVesting(_vestContract);
    } 

    function contribute() public payable {
        require(!paused, "Crowdsale is paused");
        require(block.timestamp < deadline, "Crowdsale has ended");

        uint256 tokens = msg.value * rate;
        require(token.balanceOf(address(this)) >= tokens, "Insufficient tokens for sale");

        vesting.deposit(msg.sender, tokens); // Deposit tokens for vesting in the separate contract

    }

    function withdraw() public {
        require(wallet == msg.sender, "Invalid User");
        wallet.transfer(address(this).balance);
    }

    function haltSale() public onlyOwner {
        paused = true;
    }

    fallback() external payable {
        // custom function code
    }

    receive() external payable {
        // custom function code
    }
}