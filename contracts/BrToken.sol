pragma solidity ^0.6.9;
pragma experimental ABIEncoderV2;

import { ERC20 } from "@openzeppelin/contracts/token/ERC20/ERC20.sol";
//import { ERC721 } from "@openzeppelin/contracts/token/ERC721/ERC721.sol";
import { SafeMath } from "@openzeppelin/contracts/math/SafeMath.sol";
import { AccessControl } from "@openzeppelin/contracts/access/AccessControl.sol";

import { BrToken } from "./BrToken.sol";
import { BaselinedRecords } from "./baselined-records/BaselinedRecords.sol";


/***
 * @title - BrToken contract
 * @notice - This is the smart contract that retain the baselined-records
 **/
contract BrToken is ERC20, AccessControl {
    using SafeMath for uint;

    BaselinedRecords public baselinedRecords;

    /// [Note]: "orgAddress" in the Org struct in the OrgRegistry.sol is assigned
    constructor(address _orgAddress, BaselinedRecords _baselinedRecords) public ERC20("Baselined Records Token", "BLR") {
        baselinedRecords = _baselinedRecords;

        /// Grant the creator of this contract the default admin role: it will be able
        /// to grant and revoke any roles
        _setupRole(DEFAULT_ADMIN_ROLE, _orgAddress); 
    }

    function saveBaselinedRecord(BrToken _brToken, address _orgAddress, bytes32[] memory _metadataOfBaselinedRecords) public returns (bool) {
        /// Save metadata of Baselined Record
        baselinedRecords.createNewBaselinedRecord(_brToken, _orgAddress, _metadataOfBaselinedRecords);
    }

}
