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
import { Biconomy } from "@biconomy/mexa";

  const biconomy = new Biconomy(window.ethereum, {
    apiKey: config.apikey,
    debug: true,
    contractAddresses: [config.factoryAddress], // list of contract address you want to enable gasless on
  });

      const contract = new ethers.Contract(
      factoryAddress,
      Factory.abi,
      biconomy.ethersProvider
    );

      await biconomy.init();