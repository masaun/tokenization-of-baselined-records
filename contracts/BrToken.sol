pragma solidity ^0.6.9;
pragma experimental ABIEncoderV2;

import { ERC721 } from "@openzeppelin/contracts/token/ERC721/ERC721.sol";
import { SafeMath } from "@openzeppelin/contracts/math/SafeMath.sol";
import { AccessControl } from "@openzeppelin/contracts/access/AccessControl.sol";


/***
 * @title - BrToken contract
 * @notice - This is the smart contract that retain the baselined-records
 **/
contract BrToken is ERC721, AccessControl {
    using SafeMath for uint;

    constructor(
        address to,
        string memory ipfsHash 
    ) 
        public
        ERC721("Baselined Record Token", "BRT") 
    {
        /// Grant the creator of this contract the default admin role: it will be able
        /// to grant and revoke any roles
        _setupRole(DEFAULT_ADMIN_ROLE, msg.sender);        
    }


    function something() public returns (bool) {}
    

}
