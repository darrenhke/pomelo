//SPDX-License-Identifier: Unlicense
pragma solidity ^0.8.0;

import "@openzeppelin/contracts/token/ERC20/ERC20.sol";
import "@openzeppelin/contracts/access/Ownable.sol";
import "@openzeppelin/contracts/access/AccessControl.sol";
import "@openzeppelin/contracts/security/Pausable.sol";


//All methods use openzepplin library instead of rewriting of code

contract Pomelo is AccessControl,ERC20,Ownable,Pausable {
    bytes32 public constant ADMIN_ROLE = keccak256("ADMIN_ROLE");
    bytes32 public constant MINTER_ROLE = keccak256("MINTER_ROLE");
    bytes32 public constant BURNER_ROLE = keccak256("BURNER_ROLE");
    bytes32 public constant FREEZER_ROLE = keccak256("FREEZER_ROLE");


    constructor() ERC20("Pomelo", "POM") {
        //Create roles through inherited methods in AccessControl 
        _transferOwnership(_msgSender());
        _setupRole(MINTER_ROLE, _msgSender());
        _setupRole(BURNER_ROLE, _msgSender());
        _setupRole(FREEZER_ROLE,_msgSender());
    }

  
    function mint(address to, uint256 amount) public whenNotPaused onlyOwner{
        require(hasRole(MINTER_ROLE, msg.sender), "Caller is not a minter");
        _mint(to, amount);
    }

    function burn(address from, uint256 amount) public whenNotPaused onlyOwner{
        require(hasRole(BURNER_ROLE, msg.sender), "Caller is not a burner");
        _burn(from, amount);
    }

    function freeze() public whenNotPaused onlyOwner {
        require(hasRole(FREEZER_ROLE, msg.sender), "Caller is not a freezer");
        _pause();
    }

    function unfreeze() public whenPaused onlyOwner  {
        _unpause();
    }

    function getOwner() public view virtual {
        owner();
    }

    function transferOwner(address newOwner) public virtual whenNotPaused onlyOwner {
        transferOwnership(newOwner);
    }

}
