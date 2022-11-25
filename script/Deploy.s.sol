//SPDX-License-Identifier: MIT
pragma solidity 0.8.17;

import "forge-std/Script.sol";
import "../src/WalletFactory.sol";

contract DeployScript is Script {

    function run() external {
        uint256 deployerPrivateKey = vm.envUint("PRIVATE_KEY");
        address bicoForwarder = address(0xdfd);
        vm.broadcast(deployerPrivateKey);
        Factory walletFactory = new Factory(bicoForwarder);

        vm.stopBroadcast();
    }
}
