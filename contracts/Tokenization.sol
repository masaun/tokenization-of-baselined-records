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
     * @param organization - Organization's wallet address
     * @param metadataOfBaselinedRecords - Metadata of the baselined records (bytes32 type data) that assigned from frontend
     */
    function createBrToken(address organization, bytes32 metadataOfBaselinedRecords) public returns (bool) {
        address _orgAddress;
        bytes32 _name;
        bytes memory _messagingEndpoint;
        bytes memory _whisperKey;
        bytes memory _zkpPublicKey;
        bytes memory _metadata;
        (_orgAddress, _name, _messagingEndpoint, _whisperKey, _zkpPublicKey, _metadata) = orgRegistry.getOrg(organization);

        /// [Todo]: Get metadataOfBaselinedRecords
        bytes32 metadataOfBaselinedRecords;

        /// Assign the BaselinedRecords related parameters when a new BrToken is deployed
        BrToken brToken = new BrToken(_orgAddress, metadataOfBaselinedRecords);

        /// Save metadata of Baselined Record
        saveBaselinedRecord(brToken);
    }

}
