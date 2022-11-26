//SPDX-License-Identifier: MIT
pragma solidity 0.8.17;

import "@openzeppelin/contracts/metatx/ERC2771Context.sol";
import {Admin} from './Admin.sol';
import {Wallet} from "./TimeLockedSCW.sol";
import {IWallet} from "./ITimeLockedWallet.sol";

contract Factory is  ERC2771Context, Admin {

    uint256 public lockDuration = 5 minutes;

    error WalletAlreadyExists(address);
    error NotForwarder(address);

    mapping(address => address) public registry;

    constructor(address _forwarder) Admin() ERC2771Context(_forwarder){

    }

    modifier onlyTrustedForwarder(){
        if(!(isTrustedForwarder(msg.sender))) revert NotForwarder(msg.sender);
        _;
    }

    /**
     * Public API to fetch wallet address
     */
    function getWallet() public view returns (address) {

        return registry[msg.sender];
    }

    /**
     * Funciton to Create New smart contract Wallets belonging to the sender
     * FLow :
     * 1) Check if the Wallet Exists or not
     * 2) If not, then deploy a new wallet. 
     */
    function createTLSCW() public {

        if(registry[msg.sender] !=address(0))
        {
            revert WalletAlreadyExists(registry[msg.sender]);
        }

        Wallet newWallet = new Wallet(msg.sender, block.timestamp + lockDuration);
        registry[msg.sender] = address(newWallet);

    }

    /**
     * Function to Facilitate Ether Claims
     */
    function claimEthers(uint256 _amount) external onlyTrustedForwarder returns(bool success){

        if(registry[_msgSender()]!= address(0)){
            success = IWallet(registry[_msgSender()]).claimEthers(_amount);
        }
        
    }

    /**
     * @notice Function to facilitate ERC20 withdrawal
     * @param _ERC20 ERC20 Token to be withdrawn
     * @param _amount Amount of Token to  be withdrawn
     */
    function claimTokens(address _ERC20, uint256 _amount) external onlyTrustedForwarder returns(bool success){
        
        if(registry[_msgSender()]!= address(0)){
            success = IWallet(registry[_msgSender()]).claimTokens(_ERC20, _amount);
        }

    }

}