pragma solidity ^0.7.6;

import 'github/OpenZeppelin/openzeppelin-contracts/contracts/token/ERC20/ERC20.sol';

contract Token is ERC20 {

    constructor () ERC20("HypeToken", "HYP") {
        _mint(msg.sender, 10000* (10 ** (uint256(decimals()))));
    }
}