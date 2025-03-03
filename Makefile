include .env

deploy-sepolia :; @forge script script/DeploySBNFT.s.sol:DeploySBNFT --rpc-url $(URL_SEPOLIA) --private-key $(PRIVATE_KEY) --broadcast --verify --etherscan-api-key $(ETHERSCAN) -vvvv

verify-contract :; @forge verify-contract 0x9Ee0d7f408299794429FdFa6d2Fc40AE200B5B68 src/SBNFT.sol:SBNFT --etherscan-api-key $(ETHERSCAN) --rpc-url $(URL_SEPOLIA) --show-standard-json-input > json.json
