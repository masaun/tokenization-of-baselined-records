# Tokenization Of Baselined Records

***
## 【Introduction of the Tokenization Of Baselined Records】
- This is a smart contract that enable organizations to tokenize the Baselined-Records (by using Baseline Protocol).

&nbsp;

***

## 【Workflow】
- ① A organization register as a member.
- ② A organization registered deposit ETH into the Organization Pool contract (OrgPool.sol) as organizations membership fees
- ③ A owner assign a manager via the ERC1820 Registry contract (ERC1820Registry.sol) that pick a manager in the organizations registerd.
- ④ A manager request the deployment of a new BrToken with parameters (Baselined-Records data, etc...) for the Tokenization contract the works as the factory of the Baselined-Records Token contract (BrToken.sol).
  - `BrToken` is the `Baseined-Record Token` that represents off-chain Baselined-Records
  - At that time, gas fees for the deployment is paid by a manager on behalf of organizations
- ⑤ A manager receive a new BrToken (Baselined-Records Token).
- ⑥ A manager request cost-sharing of the deployment for the Organization Pool contract (OrgPool.sol).
- ⑦ A manager receive the amount of ETH as fees paid for the deployment on behalf of behalf of organizations.
 
(※ OrgPool contract has the cost-sharing function. The OrgPool contract can transfer amount of ETH that a manager paid for the deployment on behalf of organizations into a manager. Transferred-ETH is ETH deposited by organizations as membership fees)   

↓

- The diagram of workflow
![【Diagram】Tokenization Of Baselined Records](https://user-images.githubusercontent.com/19357502/106000603-59cea880-60f2-11eb-82f8-51e84e8ece7b.jpg)


&nbsp;

***

## 【Remarks】
- Version for following the `baseline/core` smart contract
  - Solidity (Solc): v0.6.9 
  - Truffle: v5.1.60
  - web3.js: v1.2.9
  - openzeppelin-solidity: v3.1.0
  - ganache-cli: v6.9.1 (ganache-core: 2.10.2)


&nbsp;

***

## 【Setup】
### ① Install modules
- Install npm modules in the root directory
```
$ npm install
```

<br>

### ② Compile & migrate contracts (on local)
```
$ npm run migrate:local
```

<br>

### ③ Test (Mainnet-fork approach)
- 1: Start ganache-cli
```
$ ganache-cli
```

<br>

- 3: Execute test of the smart-contracts (on the local)
  - Test for the contract
    `$ npm run test:tokenization`  
    ($ truffle test ./test/test-local/Tokenization.test.js)

<br>


***

## 【References】
- Baseline Protocol   
  - Smart-contract of the Baseline Protocol:  
    https://github.com/ethereum-oasis/baseline/tree/master/core  

  - Workflow:  
    https://github.com/ethereum-oasis/baseline/tree/master/core#baseline-protocol  

  - The concept of `Tokenization Of Baselined Records` :  
    https://gitcoin.co/issue/ethereum-oasis/baseline-roadmap/163/100024426  
