// SPDX-License-Identifier: GPL-3.0
pragma solidity >=0.8.0 <0.9.0;

contract ProofOfExistence {
    // the admin can create record for a students
    // push created record to an array of student records
    //generate an ID for students
    // students can call a function from their accounts to retrieve their records
    // student can give their Id to anyone to get their record
    //nested loops are expensive
    address admin;
    uint256 id = 1000;
    struct StudentRec {
        string fullName;
        uint256 ID;
        uint256 DOB;
        string gender;
        string state_of_origin;
    }
    StudentRec[] studentRecArr;
    mapping(address => uint256) studentToId;
    mapping(uint => StudentRec) IDToRecord;
    mapping(uint => StudentRec) DropOuts;
    
    

    constructor(address _admin) {
        admin = _admin;
    }

    modifier onlyAdmin() {
        require(msg.sender == admin, "Only admin can call this function");
        _;
    }

    function addStudent(
        address _addr,
        string memory _fullName,
        uint256 _DOB,
        string memory SOO,
        string memory _gender
    ) public onlyAdmin returns (bool, uint256) {
        if (addressExist(_addr)) return (false, studentToId[_addr]);
        id = id + 1;
        StudentRec memory newStudent = StudentRec({
            fullName: _fullName,
            ID: id,
            DOB: _DOB,
            gender: _gender,
            state_of_origin: SOO
        });
        studentRecArr.push(newStudent);
        studentToId[_addr] = id;
        IDToRecord[id]= newStudent;
        return (true, id);
    }
    function retrieveId() external view returns (bool, uint256) {
        if (addressExist(msg.sender)) return (true, studentToId[msg.sender]);
        else return (false, 0);
    }

    function adminRecovery (address _addr) external onlyAdmin view returns (bool, uint256) {
         if (addressExist(_addr)) return (true, studentToId[_addr]);
        else return (false, 0);
    }
    function addressExist(address _addr) internal view returns (bool) {
        return !(studentToId[_addr] == 0);
    }
    function getIDToRecord (uint256 _id)  external view returns (StudentRec memory) {
        return IDToRecord[_id];
    }
    function dropOut (uint256 _ID) external onlyAdmin returns (bool) {
        require(IDToRecord[_ID].ID != 0, "Student Doesn't exist");
        DropOuts[_ID] = IDToRecord[_ID];
        delete IDToRecord[_ID];
        uint indexToBeRemoved;
        for(uint i = 0; i < studentRecArr.length; i++) {
            if(studentRecArr[i].ID == _ID){
                indexToBeRemoved = i;
                break;
            }
        }
        studentRecArr[indexToBeRemoved] = studentRecArr[studentRecArr.length-1];
        studentRecArr.pop();
        return true;
    }
}
