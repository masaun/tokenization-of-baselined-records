pragma solidity ^0.6.9;
pragma experimental ABIEncoderV2;

import { BaselinedRecordsStorages } from "./commons/BaselinedRecordsStorages.sol";

import { BrToken } from "../BrToken.sol";


/***
 * @title - Tokenization contract
 * @notice - This is the factory contract in order to create BrToken
 **/
contract BaselinedRecords is BaselinedRecordsStorages {

    uint8 public currentBaselinedRecordId;

    constructor() public {}

    /**
     * @notice - Save a new baselined-records
     */
    function _saveBaselinedRecord(BrToken _brToken, address _orgAddress, bytes32 _metadataOfBaselinedRecords) internal returns (bool) {
        uint8 newBaselinedRecordId = getNextBaselinedRecordId();
        currentBaselinedRecordId++;

        /// [Todo]: Add properties for saving a new BaselinedRecord
        BaselinedRecord storage baselinedRecord = baselinedRecords[newBaselinedRecordId];
        baselinedRecord.brToken = _brToken;
        baselinedRecord.orgAddress = _orgAddress;
        baselinedRecord.metadataOfBaselinedRecords = _metadataOfBaselinedRecords;
    }


    ///------------------------------------------------------------
    /// Private functions
    ///------------------------------------------------------------
    function getNextBaselinedRecordId() private view returns (uint8 nextBaselinedRecordId) {
        return currentBaselinedRecordId + 1;
    }

}
