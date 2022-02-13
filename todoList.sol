// SPDX-License-Identifier: GPL-3.0

pragma solidity >=0.7.0 <0.9.0;

contract Todo_List {

uint count = 0;
struct Todo{
    uint id;
    string title;
    bool complete;
}
mapping(uint => Todo) Get_List;
Todo[] list_arr;
event TaskCreated(uint id, string content, bool completed);
event TaskCompleted(uint id, bool completed);
// This function creates a new instance of the Todo struct
// It also maps the struct Id to the struct using the Get_List mapping
// It also adds the new struct instance to an array of Todo structs called list_arr

 function createNewList( string calldata _title) external {
    Get_List[count] =  Todo(count, _title, false);
    list_arr.push(Todo(count, _title, false));
    count++;
    emit TaskCreated(count, _title, false;
 }

 // This function find a todo struct from its id using te Get_List mapping function
 // It also updates the completed status of said struct to true
 function updateTodoStatus (uint id) external {
     Get_List[id].complete = true;
     emit TaskCompleted(id, true)
 }


}