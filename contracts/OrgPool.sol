pragma solidity ^0.6.9;
pragma experimental ABIEncoderV2;


/***
 * @title - The Organization Pool contract
 **/
contract OrgPool {

    address ORG_POOL;
    address payable ORG_POOL_PAYABLE;

    constructor() public {
        ORG_POOL = address(this);
        ORG_POOL_PAYABLE = address(uint160(ORG_POOL));  /// [Note]: The payable version of this contract address
    }

    /**
     * @notice - An organization deposit ETH into the Organization Pool
     */
    function depositETH() public payable returns (bool) {
        uint amountDeposited = 1 ether;  /// [Note]: This is an example amount of deposit of ETH 

        /// Receive specified-amount of Ether
        ORG_POOL_PAYABLE.call.value(amountDeposited).gas(53000)("");   
        //ORG_POOL_PAYABLE.call{value: amountDeposited}.gas(35000)();

        //require(address(this).call.value(msg.value).gas(35000)(), "Transferring ETH was fail");
    }

    /**
     * @notice - ETH are deposited into the Organization Pool from all organizations (as monthly membership fees, etc...)
     */
    function depositETHFromAllOrgs() public payable returns (bool) {
        /// [Todo]: Add a logic
        address[] memory orgAddresses;
        uint amountOfDeposit;  /// Amount of deposit of each organization
    }

    /**
     * @notice - Share gas cost between registered-organizations
     */
    function gasCostSharing() public returns (bool) {


    }

}
