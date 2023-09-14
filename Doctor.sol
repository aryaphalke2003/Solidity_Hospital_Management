// Name: Arya Phalke
// Roll: 2020CSB1107

// SPDX-License-Identifier: GPL-3.0

pragma solidity >=0.8.2 <0.9.0;

interface Patient{

    function GiveAccess(address doc) external;
    function RevokeAccess(address doc) external;
    function view_Patient_History(address doc) external view returns (string[] memory);
    function update_Patient_History(address doc,string memory newdata) external;
}

contract Doctor {
    string public Doc_Name;
    uint256 public Doc_Age;
    string public Doc_Gender;
    string public Doc_Specialization;

    address public Your_Patient_Address;

    // Initial constructor to create a doctor
    constructor(
        string memory _Doc_Name,
        uint256 _Doc_Age,
        string memory _Doc_Gender,
        string memory _Doc_Specialization
    ) {
        Doc_Name = _Doc_Name;
        Doc_Age = _Doc_Age;
        Doc_Gender = _Doc_Gender;
        Doc_Specialization = _Doc_Specialization;
    }

    // interface PatientInterface {
    //     function giveaccess(address doc) external;
    //     function revokeaccess(address doc) external;
    //     function view_Patient_History(address doc) external view returns (string[] memory);
    //     function view_Patient_History(address doc, string memory newdata) external;
    // }

    //address(this) is hash of current doctor basically
    //msg.sender could have been used but preferrable one was address of contract
    //msg.sender will require different accounts

    // Type the patient you want to checkup on
    function Enter_Patient_Address(address _Your_Patient_Address) public {
        Your_Patient_Address = _Your_Patient_Address;
    }

    // Once typed patient address you can see history
    function View_Patient_History() public view returns (string[] memory) {
        // return PatientInterface(Your_Patient_Address).view_Patient_History(address(this));
        return
            Patient(Your_Patient_Address).view_Patient_History(address(this));
    }

    // Once typed patient address you can update history
    function Update_Patient_History(string memory medicdata) public {
        // return PatientInterface(Your_Patient_Address).update_Patient_History(address(this),medicdata);
        return
            Patient(Your_Patient_Address).update_Patient_History(
                address(this),
                medicdata
            );
    }

    // Doctor data
    function Get_Doc_Data() public view returns (string[] memory) {
        string[] memory doctorData = new string[](4);
        doctorData[0] = Doc_Name;
        doctorData[1] = string(abi.encodePacked("Age: ", toString(Doc_Age)));
        doctorData[2] = string(abi.encodePacked("Gender: ", Doc_Gender));
        doctorData[3] = string(
            abi.encodePacked("Specialization: ", Doc_Specialization)
        );
        return doctorData;
    }

    // Simple tostring to convert initial age to string in constructor
    function toString(uint256 value) internal pure returns (string memory) {
        if (value == 0) {
            return "0";
        }
        uint256 temp = value;
        uint256 digits;
        while (temp != 0) {
            digits++;
            temp /= 10;
        }
        bytes memory buffer = new bytes(digits);
        while (value != 0) {
            digits -= 1;
            buffer[digits] = bytes1(uint8(48 + uint256(value % 10)));
            value /= 10;
        }
        return string(buffer);
    }
}
