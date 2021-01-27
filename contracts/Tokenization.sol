pragma solidity ^0.6.9;
pragma experimental ABIEncoderV2;

import { BrToken } from "./BrToken.sol";
import { BaselinedRecords } from "./baselined-records/BaselinedRecords.sol";

/// Baseline Protocol
import { OrgRegistry } from "./baseline/registry/OrgRegistry.sol";


/***
 * @title - The tokenization contract
 * @notice - This is the factory contract in order to create a new BrToken
 **/
contract Tokenization {

    BaselinedRecords public baselinedRecords;
    OrgRegistry public orgRegistry;

    constructor(BaselinedRecords _baselinedRecords, OrgRegistry _orgRegistry) public {
        baselinedRecords = _baselinedRecords;
        orgRegistry = _orgRegistry;
    }

    /**
     * @notice - Create a new BrToken
     * @notice - msg.sender is the organization address (orgAddress)
     * @param _metadataOfBaselinedRecords - Metadata of the baselined records. (single record or multiple records)
     */
    function createBrToken(bytes32[] memory _metadataOfBaselinedRecords) public returns (bool) {
        address _orgAddress;
        bytes32 _name;
        bytes memory _messagingEndpoint;
        bytes memory _whisperKey;
        bytes memory _zkpPublicKey;
        bytes memory _metadata;
        (_orgAddress, _name, _messagingEndpoint, _whisperKey, _zkpPublicKey, _metadata) = orgRegistry.getOrg(msg.sender);

        /// Assign the BaselinedRecords related parameters when a new BrToken is deployed
        BrToken brToken = new BrToken(_orgAddress, baselinedRecords);

        /// Save metadata of Baselined Record
        brToken.saveBaselinedRecord(brToken, _orgAddress, _metadataOfBaselinedRecords);
    }

}
