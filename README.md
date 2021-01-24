# Tokenization Of Baselined Records

***
## 【Introduction of the Tokenization Of Baselined Records】
- This is a smart contract that ...

&nbsp;

***

## 【Workflow】
- 


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
  - Smart-contract of the Baseline Protocol：
    https://github.com/ethereum-oasis/baseline/tree/master/core 

  - Workflow：
    https://github.com/ethereum-oasis/baseline/tree/master/core#baseline-protocol  

  - Concept of `Tokenization Of Baselined Records` ：
    https://gitcoin.co/issue/ethereum-oasis/baseline-roadmap/163/100024426  
