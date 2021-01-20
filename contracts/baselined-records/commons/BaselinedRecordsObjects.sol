pragma solidity ^0.6.9;
pragma experimental ABIEncoderV2;

import { BrToken } from "../../BrToken.sol";


contract BaselinedRecordsObjects {

    struct BaselinedRecord {  /// [Key]: baselinedRecordId
        BrToken brToken;
        address userAddress;
        uint amount;
    }

}
