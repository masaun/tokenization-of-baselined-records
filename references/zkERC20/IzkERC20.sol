interface IzkERC20 {
    event CreateConfidentialNote(address indexed _owner, bytes _metadata);
    event DestroyConfidentialNote(address indexed _owner, bytes32 _noteHash);

    function cryptographyEngine() external view returns (address);
    function confidentialIsApproved(address _spender, bytes32 _noteHash) external view returns (bool);
    function confidentialTotalSupply() external view returns (uint256);
    function publicToken() external view returns (address);
    function supportsProof(uint16 _proofId) external view returns (bool);
    function scalingFactor() external view returns (uint256);

    function confidentialApprove(bytes32 _noteHash, address _spender, bool _status, bytes _signature) public;
    function confidentialTransfer(bytes _proofData) public;
    function confidentialTransferFrom(uint16 _proofId, bytes _proofOutput) public;
}
