pragma solidity ^0.6.9;
pragma experimental ABIEncoderV2;


/***
 * @title - The Organization Pool contract
 **/
contract OrgPool {

    constructor() public {}

    /**
     * @notice - An organization deposit ETH into the Organization Pool
     */
    function depositETH() public payable returns (bool) {
        address payable orgAddress = msg.sender;
        orgAddress.transfer(msg.value);
    }

    /**
     * @notice - ETH are deposited into the Organization Pool from all organizations
     */
    function depositETHFromAllOrgs() public payable returns (bool) {
        /// [Todo]: Add a logic        
    }

    /**
     * @notice - Share gas cost between registered-organizations
     */
    function gasCostSharing() public returns (bool) {

    }

}
