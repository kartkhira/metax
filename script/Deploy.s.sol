//SPDX-License-Identifier: MIT
pragma solidity 0.8.17;

import "forge-std/Script.sol";
import "../src/WalletFactory.sol";

contract DeployScript is Script {

    function run() external {
        uint256 deployerPrivateKey = vm.envUint("PRIVATE_KEY");
        vm.broadcast(deployerPrivateKey);
        Factory walletFactory = new Factory(0xE041608922d06a4F26C0d4c27d8bCD01daf1f792);
        vm.stopBroadcast();
    }
}
