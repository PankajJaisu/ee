// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.9;

contract HealthRecordContract {
    
    address public owner;
    address public administrator;
    
    constructor() {
        owner = msg.sender;
        administrator = msg.sender;
    }
    
    struct HealthRecord {
        uint256 recordId;
        string patientName;
        string diagnosis;
        string treatment;
        uint256 timestamp;
    }
    
    HealthRecord[] private records;

    function transferAdministrator(address _newAdmin) public {
        require(msg.sender == owner, "Only the owner can transfer administrator role");
        administrator = _newAdmin;
    }

    function addHealthRecord(
        string memory _patientName,
        string memory _diagnosis,
        string memory _treatment
    ) public {
        require(msg.sender == administrator || msg.sender == owner, "Only the administrator or owner can add records");

        uint256 recordId = records.length;
        uint256 timestamp = block.timestamp;

        HealthRecord memory newRecord = HealthRecord({
            recordId: recordId,
            patientName: _patientName,
            diagnosis: _diagnosis,
            treatment: _treatment,
            timestamp: timestamp
        });

        records.push(newRecord);
    }

    function getHealthRecords() public view returns (HealthRecord[] memory) {
        return records;
    }
}
