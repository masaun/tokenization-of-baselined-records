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
     * @notice - ETH are deposited into the Organization Pool from all organizations (as monthly membership fees, etc...)
     */
    function depositETHFromAllOrgs() public payable returns (bool) {
        /// [Todo]: Add a logic
        address[] payable orgAddresses;
        uint amountOfDeposit;  /// Amount of deposit of each organization
    }

    /**
     * @notice - Share gas cost between registered-organizations
     */
    function gasCostSharing() public returns (bool) {

    }

}
