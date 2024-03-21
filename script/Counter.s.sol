// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.20;

import {Script, console} from "forge-std/Script.sol";
import '../src/Token.sol';
import '../src/crowdSale.sol';
import '../src/Vesting.sol';

contract CounterScript is Script {
    Token public token;
    Crowdsale public crowdSale;
    Vesting public vest;
    function setUp() public {}

    function run() public {
        uint privateKey = vm.envUint('PRIVATE_KEY');
        address account = vm.addr(privateKey);
        vm.startBroadcast();
        token = new Token(10000000);
        console.log("Token Contract Deployed to %s", address(token));
        crowdSale = new Crowdsale(address(token), account, 10000*10**18, 864000);
        console.log("Crowdsale Contract Deployed to %s", address(crowdSale));
        vest = new Vesting(address(token), 172800, 86400);
        console.log("Vesting Contract Deployed to %s", address(crowdSale));
        crowdSale.updateVestContract(address(vest));
        vm.stopBroadcast();
    }
}
