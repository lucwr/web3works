// SPDX-License-Identifier: GPL-3.0
pragma solidity >=0.8.0 <0.9.0;
// Multisig wallet
// AN ARRAY OF ADDRESSES  has control over the contract; the person who deployes the contract aads this array.
// Only one of the  controller can add an electoral candidate.
// Only one of the  controller can add a potential voter.
// A candidate can only be added once.
// A voter can only be added or registered.
// A voter can only vote once; obviously, lol.
// We can get the winner of the election by calling a getWinner function
import './sortingLibrary.sol';
contract Election {
    struct ElectoralCandidate {
        uint id;
        uint age;
        address addr;
        string name;
        string party;
        bool approve;
    }
     struct Voter {
        uint id;
        uint age;
        address addr;
        string name;
        bool vote;
    }
    uint candidateID = 0;
    uint voterID = 0;
    uint quorum;
    address Controller;
    mapping(address => bool) allowedToSignLeaders;
    mapping (uint => ElectoralCandidate) public idToCandidate;
    mapping(uint => uint) public numberSignedForCandidate;
    mapping (address => mapping(address => bool)) signForCandidate;
    mapping(address => Voter) public addrToVoter;
    mapping(uint => uint) public candidateVotes;
    mapping(address => bool) registeredVoter;
    mapping(address => bool) registeredCandidate;
    constructor (address[] memory _co_signers, uint _quorum) {
        for(uint i = 0; i<_co_signers.length; i++){
            allowedToSignLeaders[_co_signers[i]] = true;
        }
        quorum = _quorum;
    }

    modifier onlySigners () {
        require (allowedToSignLeaders[msg.sender] == true, "only Signers allowed");
        _;
    }
    function addElectoralCandidates (string memory _name, string memory _party, uint _age, address _addr) onlySigners external{
        require (signForCandidate[msg.sender][_addr] == false, "signer can only sign once for candidate");
        signForCandidate[msg.sender][_addr] = true;
        candidateID++;
        require (idToCandidate[candidateID].id == 0, "You can't add candidate twice");
        require(registeredCandidate[_addr] == false, "You can't add candidate twice");
        registeredCandidate[_addr] = true;
        numberSignedForCandidate[candidateID]++;
        ElectoralCandidate storage candidate = idToCandidate[candidateID];
        candidate.name = _name;
        candidate.id = candidateID;
        candidate.party = _party;
        candidate.age =_age;
        candidate.addr = _addr;

    }
    function approveCandidate(uint _index, address _addr) onlySigners external {
        require (signForCandidate[msg.sender][_addr] == false, "signer can only sign once for candidate");
        signForCandidate[msg.sender][_addr] = true;
        numberSignedForCandidate[_index]++;
         if (numberSignedForCandidate[_index] >= quorum ){
             idToCandidate[_index].approve = true;
         }
    }

    function registerVoter (string memory _name, uint _age, address _addr) onlySigners external{
        voterID++;
        require(addrToVoter[_addr].id == 0, "Voter should be added Once");
        require(registeredVoter[_addr] == false, "Voter should be added once");
        Voter storage voter = addrToVoter[_addr];
        registeredVoter[_addr] = true;
        voter.name = _name;
        voter.id = voterID;
        voter.age =_age;
        voter.addr =_addr;
    }

    function vote (uint _candidateId) external{
        require(addrToVoter[msg.sender].id != 0, "Voter has to be registered");
        require (idToCandidate[candidateID].id != 0, "Candidate Not Registered");
        require (idToCandidate[candidateID].approve == true, "Candiddate is not approved");
        require (addrToVoter[msg.sender].vote  == false, "You've voted for a candidate already");
        candidateVotes[_candidateId]++;
        addrToVoter[msg.sender].vote = true;

    }

    function getAllVotes() view internal returns (uint[] memory) {
        uint[] memory votes = new uint[](candidateID);
        for (uint i =1; i<candidateID+1; i++){
            votes[i-1] = candidateVotes[i];
        }
        return votes;
    }

    function sortVotes () internal returns (uint[] memory){
       uint[] memory votes = getAllVotes();
        QuickSort sort = new QuickSort();
        return sort.sort(votes);
    }

    function getWinner () external returns (ElectoralCandidate memory winner){
        uint[] memory votes = sortVotes();
        uint _vote = votes[votes.length-1];
        for (uint i =1; i<candidateID+1; i++){
            if(candidateVotes[i] == _vote) {
                winner = idToCandidate[i];
            }
        }
    }
}
// ["0x5B38Da6a701c568545dCfcB03FcB875f56beddC4","0xAb8483F64d9C6d1EcF9b849Ae677dD3315835cb2","0x4B20993Bc481177ec7E8f571ceCaE8A9e22C02db","0x78731D3Ca6b7E34aC0F824c42a7cC18A495cabaB","0x617F2E2fD72FD9D5503197092aC168c91465E7f2"]