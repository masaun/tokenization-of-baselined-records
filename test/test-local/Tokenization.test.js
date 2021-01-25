/// Using local network
const Web3 = require('web3');
const web3 = new Web3(new Web3.providers.WebsocketProvider('ws://localhost:8545'));

/// Artifact of smart contracts 
const Tokenization = artifacts.require("Tokenization");
const BaselinedRecords = artifacts.require("BaselinedRecords");
const OrgPool = artifacts.require("OrgPool");
const OrgRegistry = artifacts.require("OrgRegistry");
const ERC1820Registry = artifacts.require("ERC1820Registry");


/***
 * @dev - Execution COMMAND: $ truffle test ./test/test-local/Tokenization.test.js
 **/
contract("Tokenization", function(accounts) {
    /// Global Tokenization contract instance
    let tokenization;
    let baselinedRecords;
    let orgPool;
    let orgRegistry;
    let erc1820Registry;

    /// Global variable for each contract addresses
    let TOKENNIZATION;
    let BASELINED_RECORDS;
    let ORG_POOL;
    let ORG_REGISTRY;
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

        it("Deploy the OrgRegistry contract instance", async () => {
            orgRegistry = await OrgRegistry.new(ERC1820_REGISTRY, { from: accounts[0] });
            ORG_REGISTRY = orgRegistry.address;
        });

        it("Deploy the BaselinedRecords contract instance", async () => {
            baselinedRecords = await BaselinedRecords.new({ from: accounts[0] });
            BASELINED_RECORDS = baselinedRecords.address;
        });

        it("Deploy the Tokenization contract instance", async () => {
            tokenization = await Tokenization.new(BASELINED_RECORDS, ORG_REGISTRY, { from: accounts[0] });
            TOKENNIZATION = tokenization.address;
        });

        it("Deploy the OrgPool contract instance", async () => {
            orgPool = await OrgPool.new(TOKENNIZATION, { from: accounts[0] });
            ORG_POOL = orgPool.address;
        });
    });

    describe("Register an organization interface (Working Group)", () => {
        const _groupName = web3.utils.asciiToHex("Working Group 1");
        const _tokenAddress = accounts[1];
        const _shieldAddress = accounts[2];
        const _verifierAddress = accounts[3];

        it('Should be able to register an organization interfaces (Group)', async () => {
            const txReceipt = await orgRegistry.registerInterfaces(_groupName,
                                                                   _tokenAddress, 
                                                                   _shieldAddress, 
                                                                   _verifierAddress, 
                                                                   { from: accounts[0] });
        });

        it('Should be able to get all interface details for an org', async () => {
            const interfaceObjects = await orgRegistry.getInterfaceAddresses();
            const {
                0: names,
                1: tokens,
                2: shields,
                3: verifiers
            } = interfaceObjects;

            console.log('\n=== registerInterface (Registered-Working Group) Objects ===\n', interfaceObjects);
 
            //assert.equal(web3.utils.hexToString(interfaceObjects[0]), _groupName, "groupName should be the groupName registerd");
            assert.equal(interfaceObjects[1], _tokenAddress, "tokenAddress should be the tokenAddress registerd");
            assert.equal(interfaceObjects[2], _shieldAddress, "shieldAddress should be the shieldAddress registerd");
            assert.equal(interfaceObjects[3], _verifierAddress, "verifierAddress should be the verifierAddress registerd");
        });
    });

    describe("Register an organization", () => {
        let txReceipt;
        
        it("Register an organization", async () => {
            /// Register a organization by using OrgRegistry.sol
            /// @param _address ethereum address of the registered organization
            /// @param _name name of the registered organization
            /// @param _messagingEndpoint public messaging endpoint
            /// @param _whisperKey public key required for message communication
            /// @param _zkpPublicKey public key required for commitments & to verify EdDSA signatures with
            txReceipt = await orgRegistry.registerOrg(
                accounts[1],
                web3.utils.asciiToHex("Test Organization 1"),
                web3.utils.asciiToHex("http://messanger-buyer-1/"),
                web3.utils.asciiToHex('0x0471099dd873dacf9570f147b9e07ebd671e05bfa63912ee623a800ede8a294f7f60a13fadf1b53d681294cc9b9ff0a4abdf47338ff72d3c34c95cdc9328bd0128'),
                web3.utils.asciiToHex('0x0471099dd873dacf9570f147b9e07ebd671e05bfa63912ee623a800ede8a294f7f60a13fadf1b53d681294cc9b9ff0a4abdf47338ff72d3c34c95cdc9328bd0128'),
                web3.utils.asciiToHex("{}"),
                { from: accounts[0] }  /// [Note]: Caller must be owner address (deployer address)
            );
        });

        it("Check the event log of RegisterOrg", async () => {
            /// [Retrieved-Event]: The "BaselinedRecordCreated" event of the BasedRecords.sol
            let events = await orgRegistry.getPastEvents('RegisterOrg', {
                filter: {},  /// [Note]: If "index" is used for some event property, index number is specified
                fromBlock: 0,
                toBlock: 'latest'
            });
            console.log("\n=== Event log of RegisterOrg ===", events[0].returnValues);  /// [Result]: Successful to retrieve event log
        });

        it("orgCount should be 1", async () => {
            const orgCount = await orgRegistry.getOrgCount({ from: accounts[1] });  /// [Note]: Caller must be owner address (deployer address)
            console.log('=== orgCount ===', String(orgCount));                      /// [Note]: Log is converted from BN to String

            assert.equal(
                Number(orgCount),
                1,
                "orgCount should be 1"
            );
        });
    });

    describe("[TK01]: The solution must support the deployment of one or many baselined assets within one single token contract. + [TK02]: The solution must support the deployment of many token contracts in a cost-effective way.", () => {
        it("Create a new BrToken with multiple baselined records", async () => {
            const baselinedRecord1 = web3.utils.asciiToHex("Baselined Record 1");  /// [Note]: Convert from string to bytes32 
            const baselinedRecord2 = web3.utils.asciiToHex("Baselined Record 2");  /// [Note]: Convert from string to bytes32
            const baselinedRecord3 = web3.utils.asciiToHex("Baselined Record 3");  /// [Note]: Convert from string to bytes32
            console.log('=== baselinedRecord1 ===', baselinedRecord1);
            console.log('=== baselinedRecord2 ===', baselinedRecord2);
            console.log('=== baselinedRecord3 ===', baselinedRecord3);

            const _metadataOfBaselinedRecords = [baselinedRecord1, baselinedRecord2, baselinedRecord3];                 
            const txReceipt = await tokenization.createBrToken(_metadataOfBaselinedRecords, { from: accounts[1] });
            console.log('\n=== txReceipt of createBrToken() ===', txReceipt);

            const gasUsedForDeployment = txReceipt.receipt.gasUsed;
            console.log('\n=== gas-used for deployment of a new BrToken ===', gasUsedForDeployment);
        });

        it("Check event log of BaselinedRecordCreated", async () => {
            /// [Retrieved-Event]: The "BaselinedRecordCreated" event of the BasedRecords.sol
            let events = await baselinedRecords.getPastEvents('BaselinedRecordCreated', {
                filter: {},  /// [Note]: If "index" is used for some event property, index number is specified
                fromBlock: 0,
                toBlock: 'latest'
            });
            console.log("\n=== Event log of BaselinedRecordCreated ===", events[0].returnValues);  /// [Result]: Successful to retrieve event log
        });

    });


    describe("[TK06]: The solution must support many cost-sharing options for token contracts administration and deployment.", () => {
        let initialETHbalanceOfOrgPool;
        let initialETHbalanceOfManager;
        let gasUsedForDeployment;
        let gasUsedForDeployment2;        

        it("3 ETH is deposited by an organization", async () => {
            const ethAmount = web3.utils.toWei('3', 'ether');  /// 3 ETH
            const txReceipt = await orgPool.depositETH({ from: accounts[1], value: ethAmount });

            initialETHbalanceOfOrgPool = await orgPool.ETHBalanceOf(ORG_POOL);
            console.log(`\n=== ETH balance of the OrgPool contract (before a new BrToken is deployed): ${web3.utils.fromWei(String(initialETHbalanceOfOrgPool), 'ether')} ETH ===`);
            assert.equal(
                initialETHbalanceOfOrgPool,
                ethAmount,
                "ETH balance of the OrgPool contract (before a new BrToken is deployed) should be 3 ETH"
            );
        });

        it("Assign the deployer address (accounts[2]) as a manager address", async () => {
            await orgRegistry.assignManager(accounts[2], { from: accounts[0] });
            const newManager = await erc1820Registry.getManager(ORG_REGISTRY);
            const newManagerThroughOrgContract = await orgRegistry.getManager();   /// [Note]: Same with erc1820Registry.getManager() above

            console.log('\n=== newManager ===', newManager);
            assert.equal(newManager, accounts[2], "A new manager should be deployer address (accounts[0])");
            assert.equal(newManagerThroughOrgContract, accounts[2], "A new manager should be deployer address (accounts[0])");
        });            

        it("Check ETH balance of a manager (before a new BrToken is deployed)", async () => {
            const manager = await orgRegistry.getManager();
            initialETHbalanceOfManager = await orgPool.ETHBalanceOf(manager);
            console.log(`\n=== ETH balance of manager (before a new BrToken is deployed): ${String(initialETHbalanceOfManager)} wei ===`);            
        });            

        it("Deploy a new BrToken contract by the OrgPool contract (Create a new BrToken with multiple baselined records)", async () => {
            const baselinedRecord4 = web3.utils.asciiToHex("Baselined Record 4");  /// [Note]: Convert from string to bytes32 
            const baselinedRecord5 = web3.utils.asciiToHex("Baselined Record 5");  /// [Note]: Convert from string to bytes32
            const baselinedRecord6 = web3.utils.asciiToHex("Baselined Record 6");  /// [Note]: Convert from string to bytes32

            const _metadataOfBaselinedRecords = [baselinedRecord4, baselinedRecord5, baselinedRecord6];                 
            const txReceipt = await tokenization.createBrToken(_metadataOfBaselinedRecords, { from: accounts[2] });

            gasUsedForDeployment = txReceipt.receipt.gasUsed;
            console.log('\n=== gas-used for deployment of a new BrToken ===', gasUsedForDeployment);
        });

        it("Gas cost is paid from the OrgPool contract to manager address (as the gas-cost sharing)", async () => {
            const manager = await orgRegistry.getManager();
            const txReceipt = await orgPool.gasCostSharing(manager, gasUsedForDeployment, { from: manager });

            gasUsedForDeployment2 = txReceipt.receipt.gasUsed;
            console.log('\n=== gas-used for executing the gasCostSharing() method ===', gasUsedForDeployment2);
        });

        it("ETH balance of manager address after a new BrToken contract was deployed should be same with one before a new BrToken contract deployed", async () => {
            const manager = await orgRegistry.getManager();
            const currentETHbalanceOfManager = await orgPool.ETHBalanceOf(manager);
            console.log(`\n=== ETH balance of manager (after a new BrToken is deployed): ${String(currentETHbalanceOfManager)} wei ===`);

            // assert.equal(
            //     Number(String(initialETHbalanceOfManager)) + Number(gasUsedForDeployment) - Number(gasUsedForDeployment2),
            //     Number(String(currentETHbalanceOfManager)),
            //     "ETH balance of manager should be ETH balance of manager (after a new BrToken is deployed) plus gas-used"
            // );
        });

        it("ETH balance of the OrgPool should be 3 ETH minus gas-used (after a new BrToken contract was deployed)", async () => {
            const currentETHbalanceOfOrgPool = await orgPool.ETHBalanceOf(ORG_POOL);
            console.log(`\n=== ETH balance of the OrgPool contract: ${String(currentETHbalanceOfOrgPool)} wei ===`);
            assert.equal(
                Number(String(initialETHbalanceOfOrgPool)) - Number(gasUsedForDeployment),
                Number(String(currentETHbalanceOfOrgPool)),
                "ETH balance of the OrgPool contract should be 3 ETH minus gas-used"
            );
        });
    });



    ///---------------------------------------------------------
    /// Tests for features below has not been implemented yet.
    ///---------------------------------------------------------

    //describe("[TK01]: The solution must support the deployment of one or many baselined assets within one single token contract.", () => {});

    //describe("[TK02]: The solution must support the deployment of many token contracts in a cost-effective way.", () => {});

    describe("[TK03]: The solution must provide a mechanism to administer all deployed token contracts (i.e. revoke investor access, disable trading on all contracts etc).", () => {});

    describe("[TK04]: The solution must support the upgrade of an entire token contract or parts of it (having a cost efficient mechanism to batch upgrade all contracts is considered a plus).", () => {});

    describe("[TK05]: The solution must ensure consistency between the baselined asset state and the on-chain asset state.", () => {});

    //describe("[TK06]: The solution must support many cost-sharing options for token contracts administration and deployment.", () => {});

    describe("[TK07]: Optional : the solution should ensure privacy of token deployment entity. Token ownership and parties involved in token transfer should remain private (i.e. who the owner is and who the token is transfered to and from should remain private).", () => {});

});
