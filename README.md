# Name: Arya Phalke
# Roll: 2020CSB1107


1. I have used INFURA instead of GANACHE for setting up Ethereum Node point.
2. I have deployed both Doctor & Patient Contracts.


# Creating .env

ETHEREUM_NETWORK = "sepolia"
INFURA_API_KEY = "Infura Api Key"
SIGNER_PRIVATE_KEY = "Private Account Key"


# Steps to Run:

1. npm install                          // will install solc web3 dotenv modules
2. node compile_doc.js
3. node deploy_doc.js
4. Contract address can be seen
5. node compile_pat.js
6. node deploy_pat.js
7. Contract address can be seen
8. To remove node modules after use in windows use command: Remove-Item -Recurse -Force node_modules (Windows)


# Contract Address:

You can see address of deployed smart contract on terminal & etherscan sepolia network.