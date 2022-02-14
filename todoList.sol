// SPDX-License-Identifier: GPL-3.0

pragma solidity >=0.7.0 <0.9.0;

contract Todo_List {

uint count = 0;
struct Todo{
    uint id;
    string title;
    bool complete;
}
mapping(address => Todo[]) allTodos;
address[] addresses;
event TaskCreated(indexed uint id, string content, bool completed, address addedBy);
event TaskCompleted(uint id, bool completed, address addedBy);
// This function creates a new instance of the Todo struct
// It also maps the struct Id to the struct using the Get_List mapping
// It also adds the new struct instance to an array of Todo structs called allTodos
// It emits an event for the task created
 function createNewList( string calldata _title) external {
  Todo memory _todo =  Todo ({
       id: count,
       title: _title,
       complete: false
   });
    emit TaskCreated({
        id:count,
        content: _title,
        complete: false,
        addedBy:msg.sender
    });
   allTodos[msg.sender].push(_todo);
   addresses.push(msg.sender);
    count++;
 }

 // This function find a todo struct from its id using the allTodos mapping function
 // It also updates the completed status of said struct to true
 // It emist an event for the task completed
 function updateTodoStatus (uint id) external {
     allTodos[id].complete = true;
      emit TaskCompleted({
        id:count,
        complete: true,
        addedBy:msg.sender
    });
 }
// delete task 
//blacklist address

}