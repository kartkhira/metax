To load the variables in the .env file : 
source .env

To deploy and verify our contract:
forge script script/Deploy.s.sol:DeployScript --rpc-url $GOERLI_RPC_URL --broadcast --verify -vvvv

Contract Deployed Address:
Deployed COntract : https://api-goerli.etherscan.io/apiaddress/0xea068f2d97280a2457670fbe7d8adfe82665db4b

ERC20 Contract Deployed for testing : https://goerli.etherscan.io/address/0x005a32a2ba4516cfd6e999726262a8a1e2a8147b