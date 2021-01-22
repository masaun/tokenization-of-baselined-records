pragma solidity ^0.6.9;
pragma experimental ABIEncoderV2;

import { ERC20 } from "@openzeppelin/contracts/token/ERC20/ERC20.sol";
//import { ERC721 } from "@openzeppelin/contracts/token/ERC721/ERC721.sol";
import { SafeMath } from "@openzeppelin/contracts/math/SafeMath.sol";
import { AccessControl } from "@openzeppelin/contracts/access/AccessControl.sol";


/***
 * @title - BrToken contract
 * @notice - This is the smart contract that retain the baselined-records
 **/
contract BrToken is ERC20, AccessControl {
    using SafeMath for uint;

    constructor(
        address organization,  /// [Note]: "orgAddress" in the Org struct in the OrgRegistry.sol is assigned
        bytes32 memory metadataOfBaselinedRecords
    ) 
        public
        ERC20("Baselined Records Token", "BLR")
    {
        /// Grant the creator of this contract the default admin role: it will be able
        /// to grant and revoke any roles
        _setupRole(DEFAULT_ADMIN_ROLE, organization);        
    }


    function something() public returns (bool) {}
    

}
