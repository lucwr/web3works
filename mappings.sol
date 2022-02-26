// SPDX-License-Identifier: GPL-3.0
pragma solidity ^0.8.10;

contract Counter {
    struct User {
        uint id;
        string name;
        School sch;
    }
    
     struct School {
        bool enrolled;
        string schoolName;
        mapping(address => uint) addressToStudentRegNum;
    }
    struct UserwithoutMapping {
        uint id;
        string name;
        SchoolWithoutMapping schWM;
    }
    struct SchoolWithoutMapping {
        bool enrolled;
        string schoolName;
    }
    uint index =0;
    mapping(uint => User) nameToUser;
    function generateUser (string memory _name, string memory _scName, bool _enrolled) public {
       index++;
       User storage NewUser = nameToUser[index];
       nameToUser[index].id = index;
       nameToUser[index].name =_name;
       nameToUser[index].sch.schoolName = _scName;
       nameToUser[index].sch.enrolled = _enrolled;
       nameToUser[index].sch.addressToStudentRegNum[msg.sender];
    }


// function seeUsers() external view returns(User[] memory users_){
//     users_ = new User[](index);
//     for(uint i=0;i<index;i++){
//         users_[i]=nameToUser[i+1];
//     }
// }


function checkUser(uint _id) external view returns(UserwithoutMapping memory c){
    User storage NewUser = nameToUser[_id];
    c.id = NewUser.id;
    c.name = NewUser.name;
    c.schWM.enrolled = NewUser.sch.enrolled;
    c.schWM.schoolName = NewUser.sch.schoolName;
}


}
