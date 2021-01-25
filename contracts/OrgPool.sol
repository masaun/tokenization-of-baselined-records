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
    function depositETH() public returns (bool) {
        address orgAddress = msg.sender;
        orgAddress.transfer(msg.value);
    }

    /**
     * @notice - Share gas cost between registered-organizations
     */
    function gasCostSharing() public returns (bool) {}

}
