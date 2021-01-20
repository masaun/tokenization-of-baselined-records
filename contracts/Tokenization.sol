pragma solidity ^0.6.9;
pragma experimental ABIEncoderV2;

import { BaselinedRecords } from "./baselined-records/BaselinedRecords.sol";

import { BrToken } from "./BrToken.sol";


/***
 * @title - Tokenization contract
 * @notice - This is the factory contract in order to create BrToken
 **/
contract Tokenization is BaselinedRecords {

    constructor() public {}

    /**
     * @notice - Create a new BrToken
     * @notice - Parameters are the BaselinedRecords related parameters. 
     */
    function createBrToken() public returns (bool) {
        /// [Todo]: Assign the BaselinedRecords related parameters when a new BrToken is deployed
        BrToken brToken = new BrToken();

        /// [Todo]:
        saveBaselinedRecord(brToken);
    }

}
