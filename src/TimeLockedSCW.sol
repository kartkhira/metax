//SPDX-License-Identifier: MIT
pragma solidity 0.8.17;

import "@openzeppelin/contracts/token/ERC20/IERC20.sol";


contract Wallet {

    uint256 public unlockAt;
    address public factory;

    address payable immutable owner;
    
    error InvalidAccess(address);
    error TokensLocked(uint);
    error InvalidToken(address);

    event TokenDeposited(address, address, uint);
    event EtherReceived(address, uint);
    event TokenClaimed(address, uint);
    event EtherClaimed(uint);

    constructor(address _owner,
                uint256 _unlockAt){

        factory = msg.sender;
        owner = payable(_owner);
        unlockAt = _unlockAt;
    }

    modifier onlyFactory(){
        if(msg.sender != factory) revert InvalidAccess(msg.sender);
        _;
    }

    /**
     * @notice Function to facilitate ERC20 deposit
     * @param _ERC20 ERC20 Token to be deposited
     * @param _amount Amount of Token to  be deposited
     */
    function deposit(address _ERC20, uint256 _amount) external returns(bool success){

        IERC20(_ERC20).transferFrom(msg.sender, address(this), _amount);
        emit TokenDeposited(msg.sender, _ERC20, _amount);
        success = true;
        
    }
    
    receive() external payable {
        emit EtherReceived(msg.sender, msg.value);
    }

    /**
     * Function to Facilitate Ether Claims
     */
    function claimEthers(uint256 _amount) public onlyFactory returns(bool success){

        if(block.timestamp < unlockAt) revert TokensLocked(unlockAt);

        owner.transfer(_amount);
        emit EtherClaimed(_amount);
        success = true;
    }

    /**
     * @notice Function to facilitate ERC20 withdrawal
     * @param _ERC20 ERC20 Token to be withdrawn
     * @param _amount Amount of Token to  be withdrawn
     */
    function claimTokens(address _ERC20, uint256 _amount) public onlyFactory returns(bool success){
        
        if(block.timestamp < unlockAt) revert TokensLocked(unlockAt);
        if(_ERC20 == address(0)) revert InvalidToken(_ERC20);

        IERC20(_ERC20).transfer(owner, _amount);
        emit TokenClaimed(_ERC20, _amount);
        success =  true;

    }

}
