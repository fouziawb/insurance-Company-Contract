// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;
import "@openzeppelin/contracts/access/Ownable.sol";

contract insurancecontract is Ownable {

//struct
    struct Information { string name; string addr; uint age;  bool subscribed; }   
    struct Request {  address user;  uint amount; bool approved; }

//mapping
    mapping(address => Information) public info;
    mapping(address => Request) public requests;

//functions
    function sebscribe(string memory name1, string memory addr1, uint age1 ) public payable {//open
        require(!info[msg.sender].subscribed && msg.value > 0, "invalied");  
        info[msg.sender] = Information(name1, addr1, age1,true); 
        }//close

    function requiestpayout(uint amount1) public {//open
      require(info[msg.sender].subscribed , "not subscribed"); 
        requests[msg.sender] = Request(msg.sender, amount1, false);  //not approvd yet
        }//close

    function withdraw(address user1) public onlyOwner {//opene
        require(requests[user1].user== user1, " no ruquest");
        require(requests[user1].approved==false, "request approved");
        requests[user1].approved = true;
        payable(user1).transfer(requests[user1].amount);
    }//close
    }//bigclose
