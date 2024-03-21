// SPDX-License-Identifier: UNLICENSED

pragma solidity ^0.8.20;

interface IVesting {
    function deposit(address beneficiary, uint256 amount) external;
}