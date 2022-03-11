Study case of Source of Randomness hack, from Solidity by example site [Solidity by Example, Source of Randomness](https://solidity-by-example.org/hacks/randomness/)

I use brownie to compile and deploy into hardhat in order to have the console.log feature.
You should start the hardhat node in another terminal and folder (`hh node`), then, in a terminal :

```
brownie compile
brownie run scripts/deploy.py
```

After deploying from brownie :
![Deployment from brownie](randomness_deploy.png)

The result in the hardhat console :

![Hardhat console ](randomness_console.png)

Don't use blockhash and block.timestamp as source of randomness.
