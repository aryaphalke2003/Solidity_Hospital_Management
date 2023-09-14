// Name: Arya Phalke
// Roll: 2020CSB1107

// SPDX-License-Identifier: GPL-3.0

pragma solidity >=0.8.2 <0.9.0;

interface Doctor {
    function Get_Doc_Data() external view returns (string[] memory);
}

contract Patient {
    
    string public Patient_Name;
    uint256 public Patient_Age;
    string public Patient_Gender;
    string[] public Patient_History;
    

    // Store all address of doctors who have access
    mapping(address => uint256) public doctorswithaccess;

    
    // Initial constructor to make a patient you need to provide these values
    constructor(string memory _Patient_Name, uint256 _Patient_Age, string memory _Patient_Gender) {
        Patient_Name = _Patient_Name;
        Patient_Age = _Patient_Age;
        Patient_Gender = _Patient_Gender;

        Patient_History.push(string(abi.encodePacked("Patient_Name: ", _Patient_Name)));
        Patient_History.push(string(abi.encodePacked("Patient_Age: ", toString(_Patient_Age))));
        Patient_History.push(string(abi.encodePacked("Patient_Gender: ", _Patient_Gender)));
    }


    // Function to give access to a specific doctor address
    function GiveAccess(address doc) public {

        require(doctorswithaccess[doc]==0,"Doctor already has access!");
        doctorswithaccess[doc]=1;

    }


    // Function to revoke doctor access
    function RevokeAccess(address doc) public {

        require(doctorswithaccess[doc]==1,"Doctor has access revoked!");
        doctorswithaccess[doc]=0;

    }


    // Actual use in doctor contract to see patient
    function view_Patient_History(address doc) public view returns (string[] memory) {

        require(doctorswithaccess[doc]==1,"Doctor doesn't have access!");
        return Patient_History;

    }


    // Actual use in doctor contract to update data
    function update_Patient_History(address doc,string memory newdata) public {

        require(doctorswithaccess[doc]==1,"Doctor doesn't have access!");    
        Patient_History.push(newdata);

    }


    // Function to view doctor info to whom you want to give access
    function view_Doc_Data(address doc) public view returns (string[] memory) {
        
        return Doctor(doc).Get_Doc_Data();
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