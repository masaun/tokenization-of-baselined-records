/// Using local network
const Web3 = require('web3');
const web3 = new Web3(new Web3.providers.WebsocketProvider('ws://localhost:8545'));

/// Artifact of smart contracts 
const Tokenization = artifacts.require("Tokenization");
const BaselinedRecords = artifacts.require("BaselinedRecords");
const ERC1820Registry = artifacts.require("ERC1820Registry");


/***
 * @dev - Execution COMMAND: $ truffle test ./test/test-local/Tokenization.test.js
 **/
contract("Tokenization", function(accounts) {
    /// Global Tokenization contract instance
    let tokenization;
    let baselinedRecords;
    let erc1820Registry;

    /// Global variable for each contract addresses
    let TOKENNIZATION;
    let BASELINED_RECORDS;
    let ERC1820_REGISTRY;

    describe("Check state in advance", () => {
        it("Check all accounts", async () => {
            console.log('\n=== accounts ===\n', accounts, '\n========================\n');
        }); 
    }); 

    describe("Setup smart-contracts", () => {
        it("Deploy the ERC1820Registry contract instance", async () => {
            erc1820Registry = await ERC1820Registry.new({ from: accounts[0] });
            ERC1820_REGISTRY = erc1820Registry.address;
        });

        it("Deploy the BaselinedRecords contract instance", async () => {
            baselinedRecords = await BaselinedRecords.new({ from: accounts[0] });
            BASELINED_RECORDS = baselinedRecords.address;
        });

        it("Deploy the Tokenization contract instance", async () => {
            tokenization = await Tokenization.new(BASELINED_RECORDS, ERC1820_REGISTRY, { from: accounts[0] });
        });
    });

    describe("[TK01]: The solution must support the deployment of one or many baselined assets within one single token contract.", () => {});

    describe("[TK02]: The solution must support the deployment of many token contracts in a cost-effective way.", () => {});

    describe("[TK03]: The solution must provide a mechanism to administer all deployed token contracts (i.e. revoke investor access, disable trading on all contracts etc).", () => {});

    describe("[TK04]: The solution must support the upgrade of an entire token contract or parts of it (having a cost efficient mechanism to batch upgrade all contracts is considered a plus).", () => {});

    describe("[TK05]: The solution must ensure consistency between the baselined asset state and the on-chain asset state.", () => {});

    describe("[TK06]: The solution must support many cost-sharing options for token contracts administration and deployment.", () => {});

    describe("[TK07]: Optional : the solution should ensure privacy of token deployment entity. Token ownership and parties involved in token transfer should remain private (i.e. who the owner is and who the token is transfered to and from should remain private).", () => {});

});
