//SPDX-License-Identifier: MIT
pragma solidity 0.8.17;

interface IWallet{

    /**
     * Function to Facilitate Ether Claims
     */
    function claimEthers(uint256 _amount) external  returns(bool success);

    /**
     * @notice Function to facilitate ERC20 withdrawal
     * @param _ERC20 ERC20 Token to be withdrawn
     * @param _amount Amount of Token to  be withdrawn
     */
    function claimTokens(address _ERC20, uint256 _amount) external  returns(bool success);

}