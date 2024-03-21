## Foundry

**Foundry is a blazing fast, portable and modular toolkit for Ethereum application development written in Rust.**

Foundry consists of:

-   **Forge**: Ethereum testing framework (like Truffle, Hardhat and DappTools).
-   **Cast**: Swiss army knife for interacting with EVM smart contracts, sending transactions and getting chain data.
-   **Anvil**: Local Ethereum node, akin to Ganache, Hardhat Network.
-   **Chisel**: Fast, utilitarian, and verbose solidity REPL.

## Documentation

https://book.getfoundry.sh/

## Usage

### Build

```shell
$ forge build
```

### Test

```shell
$ forge test
```

### Format

```shell
$ forge fmt
```

### Gas Snapshots

```shell
$ forge snapshot
```

### Anvil

```shell
$ anvil
```

### Deploy

```shell
$ forge script script/Counter.s.sol:CounterScript --rpc-url <your_rpc_url> --private-key <your_private_key>
```

### Cast

```shell
$ cast <subcommand>
```

### Help

```shell
$ forge --help
$ anvil --help
$ cast --help
```

### Installation

1. Install rust "https://www.rust-lang.org/tools/install"
2. Install Foundry "https://book.getfoundry.sh/getting-started/installation"
3. Clone the Repository
4. npm i

### Deployement process

Preparation:

- Set ETHERSCAN_API_KEY in .env
- Set PRIVATE_KEY in .env
- Set RPC_URL in .env

```shell

### Compile
$ forge build

### Load env
$ source .env

### deploy and verify
$ forge script script/MissionControlContract.s.sol --rpc-url $RPC_URL --broadcast --private-key $PRIVATE_KEY  --verify $ETHERSCAN_API_KEY -vvvv