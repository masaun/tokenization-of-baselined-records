pragma solidity ^0.6.9;
pragma experimental ABIEncoderV2;

import { BrToken } from "./BrToken.sol";
import { BaselinedRecords } from "./baselined-records/BaselinedRecords.sol";

/// Baseline Protocol
import { OrgRegistry } from "./baseline/registry/OrgRegistry.sol";


/***
 * @title - Tokenization contract
 * @notice - This is the factory contract in order to create BrToken
 **/
contract Tokenization {

    BaselinedRecords public baselinedRecords;
    OrgRegistry public orgRegistry;

    /**
     * @param _erc1820 - This is for constructor of OrgRegistry.sol
     */
    constructor(BaselinedRecords _baselinedRecords, address _erc1820) public {
        baselinedRecords = _baselinedRecords;
        orgRegistry = OrgRegistry(_erc1820);
    }

    /**
     * @notice - Create a new BrToken
     * @notice - msg.sender is the organization address (orgAddress)
     * @param metadataOfBaselinedRecords - Assume that metadata of the baselined records (bytes32 type data) that assigned from frontend
     */
    function createBrToken(bytes32 metadataOfBaselinedRecords) public returns (bool) {
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
        brToken.saveBaselinedRecord(brToken, _orgAddress, metadataOfBaselinedRecords);
    }

}
