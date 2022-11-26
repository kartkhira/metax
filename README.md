# To load the variables in the .env file
source .env

# To deploy and verify our contract
forge script script/Deploy.s.sol:DeployScript --rpc-url $GOERLI_RPC_URL --broadcast --verify -vvvv

Deployed COntract : https://api-goerli.etherscan.io/apiaddress/0xea068f2d97280a2457670fbe7d8adfe82665db4b