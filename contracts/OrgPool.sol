pragma solidity ^0.6.9;
pragma experimental ABIEncoderV2;

import { SafeMath } from "@openzeppelin/contracts/math/SafeMath.sol";

import { Tokenization } from "./Tokenization.sol";


/***
 * @title - The Organization Pool contract
 **/
contract OrgPool {
    using SafeMath for uint;

    Tokenization public tokenization;

    address ORG_POOL;
    address payable ORG_POOL_PAYABLE;

    constructor(Tokenization _tokenization) public {
        tokenization = _tokenization;

        ORG_POOL = address(this);
        ORG_POOL_PAYABLE = address(uint160(ORG_POOL));  /// [Note]: The payable version of this contract address
    }

    /**
     * @notice - An organization deposit ETH into the Organization Pool
     */
    function depositETH() public payable returns (bool) {
        uint amountDeposited = 1 ether;  /// [Note]: This is an example amount of deposit of ETH 

        /// Receive specified-amount of Ether
        ORG_POOL_PAYABLE.call{value: amountDeposited}{gas: 53000}("");  /// [Note]: This is the recommended-syntax version
        //ORG_POOL_PAYABLE.call.value(amountDeposited).gas(53000)("");  /// [Note]: It works. But, this is the deprecated-syntax version

        //require(ORG_POOL_PAYABLE.call.value(amountDeposited).gas(53000)(""), "Transferring ETH from an user's wallet to the OrgPool contract was fail");
    }

    /**
     * @notice - ETH are deposited into the Organization Pool from all organizations (as monthly membership fees, etc...)
     */
    function depositETHFromAllOrgs() public payable returns (bool) {
        /// [Todo]: Add a logic
        address[] memory orgAddresses;  /// All organizations addresses
        uint amountOfDeposit;  /// Amount of deposit of each organization
    }

    /**
     * @notice - Create a new BrToken by the OrgPool contract
     */
    function createBrTokenByOrgPool(bytes32[] memory _metadataOfBaselinedRecords) public returns (bool) {
        tokenization.createBrToken(_metadataOfBaselinedRecords);  /// [Note]: Gas cost is paid by the OrgPool
    }


    /**
     * @notice - Share gas cost between registered-organizations. 
     * @param gasCostSpent - Gas cost (amount) when the token contract was deployed. Amount of gasCostSpent is transferred into the manager address from this OrgPool contract
     */
    function gasCostSharing(address payable manager, uint gasCostSpent) public payable returns (bool) {
        manager.transfer(gasCostSpent);
    }


    /////////////////////
    /// Getter methods
    /////////////////////

    /**
     * @notice - Retrieve ETH balance
     */
    function ETHBalanceOf(address walletAddress) public view returns (uint _ETHBalance) {
        return walletAddress.balance;
    }

}
