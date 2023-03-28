# Deploy to the zkEVM using Truffle

This guide will show you how to get started with using Truffle to deploy to the zkEVM. Here's a [video](https://lenstube.xyz/watch/0x27c2-0x04) that shows all these steps visually.

## Pre-requisites
Before we begin, you need to have:
- A Wallet
- Bridged L1 Eth to the zkEVM (so you can pay for gas). To learn how to do this [here](https://wiki.polygon.technology/docs/zkEVM/develop/)
- Installed Truffle. Learn to do that [here](https://trufflesuite.com/docs/truffle/how-to/install/)
- RPC URL to the zkEVM. You can get this from your preferred RPC provider or using the RPC urls provided [here](https://wiki.polygon.technology/docs/zkEVM/develop/) 

## 1. Create New Truffle Project
To get started, you need to create a new Truffle project. Open up your favorite CLI tool and type in the command

```
npm truffle init polygonzkevm
```

This should create a new Truffle project. Now let's look at the code. The command below should open up a new Truffle project in your Visual Studio Code. You can replace this step with your preferred text editor.

```
cd polygonzkevm && code .
```

You should now see 3 folders `contracts`, `migrations` and `tests` and a file named `truffle_config.js`


## 2. Create new Contract
You can create new contracts using a text editor by creating a file with the extension `.sol` in the `contracts` folder, or you could use the command 

```
truffle create contract Coruscant
```

This should create a new contract `Coruscant` (slight nod to Star Wars here). In your text editor, you can paste in the same contract that's available in this repo. See `contracts/Coruscant.sol`

## 3. Create a migration
Migrations tell Truffle which order to deploy your contracts. We can tell Truffle to deploy our Coruscant contract by creating a file in the migrations folder called `1_deploy_Coruscant.js`.

Open `1_deploy_Coruscant.js` and paste in the following code
```
const Coruscant = artifacts.require("Coruscant");

module.exports = function (deployer) {
  deployer.deploy(Coruscant);
};
```

## 4. Deploy 
Truffle has two options for deploying a contract. The first is using the Truffle CLI and the other is the Truffle CLI. We'll cover how to do both.

### 4.1 Truffle Dashboard
This is the simplest of the two options. All you need to do is open up two CLI windows. 

In the first CLI, run `truffle dashboard` wish should open your browser. You should see an interface that allows you to sign transactions.

In another CLI windows, run `truffle migrate --network dashboard`. Check your browser window and click Confirm to sign the transaction and the deployment should work normally once the trasnaction is successful.

### 4.2 Truffle CLI
The first step to deploying your contract using the CLI is to add a few developer dependencies. Run the following commands.

```
npm i -D dotenv @truffle/hdwallet-provider
```
and then add a regular dependency
```
npm i @truffle/hdwallet-provider
```

You now need to create a .env file. Use the `.env-example` to see an example of what variables are required. You only need to add the mnemonic of your Ethereum account.

Once you have added a .env, open up the `truffle-config.js` let's make some changes.


Add this code to the top of your file.
```
require("dotenv").config();
const { MNEMONIC } = process.env;
const HDWalletProvider = require("@truffle/hdwallet-provider");
```

Secondly, replace the contents of the `module.exports.networks` object with 

```
polygonzkevm: {
  provider: () => {
    return new HDWalletProvider(
      MNEMONIC,
      `https://rpc.public.zkevm-test.net`
    );
  },
  network_id: "1442",
  production: false,
},
```
Save the file and in a new CLI window run `truffle migrate --network polygonzkevm` to start the deployment.

Deployment might take some time but this should be all you need to do to deploy to the zkEVM using Truffle CLI.

I hope this guide was useful, if you have any questions with any of these steps, reach out to me on [Twitter](https://twitter.com/tonyolendo)



