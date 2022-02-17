// SPDX-License-Identifier: GPL-3.0
pragma solidity >=0.8.0 <0.9.0;
contract UserStorage {
    struct User{
        uint ID;
        string fullName;
        string email;
        uint DOB;
        bytes32 password;
    }
    uint count = 1000;
    User[] userArray;
    mapping(string => User) emailToUser;
    mapping(string => mapping(bytes32 => User)) getDetailsLogin;
    event UserCreated (bool status, string indexed email, string fullName) ;
    event passwordUpdated (bool status, string indexed email) ;
    function signUp (string memory _fullName, string memory _email, uint _DOB, string memory _password) external returns (bool, string memory) {
        require (emailToUser[_email].ID == 0, "This email has been taken");
        count++;
        User memory newUser = User({
            ID: count,
            fullName: _fullName,
            email: _email,
            DOB: _DOB,
            password:keccak256(abi.encode(_password))
        });
        emailToUser[_email] = newUser;
        getDetailsLogin[_email][keccak256(abi.encode(_password))] = newUser;
        userArray.push(newUser);
        emit UserCreated(true, _email, _fullName);
        return (true, "User created succesfully");
    }

    modifier validateUser(string memory _email, string memory _password) {
        require (emailToUser[_email].ID != 0, "This user doesn't exist");
        require(emailToUser[_email].password == keccak256(abi.encode(_password)), "Wrong User password");
        _;
    }
    function login (string memory _email, string memory _password) external validateUser(_email, _password) view returns (User memory) {
        return getDetailsLogin[_email][keccak256(abi.encode(_password))];
    }

    function changePassword (string memory _email, string memory _password, string memory _newPassword) external validateUser(_email, _password) returns (bool){
    emailToUser[_email].password = keccak256(abi.encode(_newPassword));
    emit passwordUpdated (true, _email) ;
    return true;
    }

    function deleteUser (string memory _email, string memory _password) external validateUser(_email, _password) {
        uint num = emailToUser[_email].ID;
        User memory userToCompare = userArray[userArray.length-1];
        for(uint i = 0; i < userArray.length; i++){
            if (userArray[i].ID == num){
                userArray[i] = userToCompare; 
            }
        }
        userArray.pop();
    }

}