pragma solidity ^0.6.9;
pragma experimental ABIEncoderV2;

import { BaselinedRecords } from "./baselined-records/BaselinedRecords.sol";
import { BrToken } from "./BrToken.sol";

/// Baseline Protocol
import { OrgRegistry } from "./baseline/registry/OrgRegistry.sol";


/***
 * @title - Tokenization contract
 * @notice - This is the factory contract in order to create BrToken
 **/
contract Tokenization is BaselinedRecords {

    OrgRegistry public orgRegistry;

    /**
     * @param _erc1820 - This is for constructor of OrgRegistry.sol
     */
    constructor(address _erc1820) public {
        orgRegistry = OrgRegistry(_erc1820);
    }

    /**
     * @notice - Create a new BrToken
     * @notice - Parameters are the BaselinedRecords related parameters. 
     */
    function createBrToken(address organization, bytes32 metadataOfBaselinedRecords) public returns (bool) {
        /// [Todo]: Assign the BaselinedRecords related parameters when a new BrToken is deployed
        BrToken brToken = new BrToken(organization, metadataOfBaselinedRecords);

        /// [Todo]:
        saveBaselinedRecord(brToken);
    }

}
