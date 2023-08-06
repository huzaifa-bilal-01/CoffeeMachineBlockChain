// SPDX-License-Identifier: MIT
pragma solidity ^0.8.9;

import "@openzeppelin/contracts/token/ERC20/ERC20.sol";
import "@openzeppelin/contracts/access/AccessControl.sol";

contract CoffeeToken is ERC20, AccessControl {
    bytes32 public constant MINTER_ROLE = keccak256("MINTER_ROLE");

    event CoffeePurchase (address indexed receiver, address indexed buyer);

    constructor() ERC20("CoffeeToken", "COF") {
        _grantRole(DEFAULT_ADMIN_ROLE, msg.sender);
        _grantRole(MINTER_ROLE, msg.sender);
    }

    function mint(address to, uint256 amount) public onlyRole(MINTER_ROLE) {
        _mint(to, amount);
    }

    function byeOneCoffee() public {
        _burn(_msgSender(), 1);
        emit CoffeePurchase(_msgSender(), _msgSender());
    }

    function byeOneCoffeeFrom(address _account) public {
        _spendAllowance(_account, _msgSender(), 1);
        _burn(_account, 1);
        emit CoffeePurchase(_msgSender(), _account);
    }
}