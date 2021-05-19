pragma solidity 0.5.16;
 
//creating the contract
contract Contest {
 
	//creating strcture to model the contestant
	struct Contestant {
		uint id;
		string name;
		uint voteCount;
	}
    
	struct Voter {
		uint id;
		address account;

		string aadhar;
	}
	mapping(uint => Voter) public voterData;
	//use mapping to get or fetch the contestant details
	mapping(uint => Contestant) public contestants;
 
	//to save the list of users/accounts who already casted vote
	mapping(address => bool) public voters;
 
	//add a public state variable to keep track of contestant Count
	uint public contestantsCount;

	uint public voterCount;

	//
    string[] myVoters;
 
	event votedEvent (
        uint indexed _contestantId
    );
 
    constructor() public {
		addContestant("Tom");
		addContestant("Jerry");
	}
 
	//add a function to add contestant
	function addContestant (string memory _name) private {
		contestantsCount ++;
		contestants[contestantsCount] = Contestant(contestantsCount, _name, 0);
	}
   function stringsEqual(string storage _a, string memory _b) internal returns (bool) 
   { 
	bytes storage a = bytes(_a); bytes memory b = bytes(_b); 
   if (a.length != b.length)
    return false; 
   
   for (uint i = 0; i < a.length; i ++) 
   if (a[i] != b[i]) 
   return false; 
   return true;
   }
	function vote (uint _contestantId,string memory aadhar) public {
		//restricting the person who already casted the vote
		bool a=false;
		uint i;
		 for(i = 0; i < myVoters.length; i++)
  		{
    	 if(stringsEqual(myVoters[i],aadhar))
		a=true;
		}
		    require(!a);
			require(!voters[msg.sender]);
		//require that the vote is casted to a valid contestant
		require(_contestantId > 0 && _contestantId <= contestantsCount);
		//increase the contestant vote count
		contestants[_contestantId].voteCount ++;
		//set the voter's voted status to true
		voters[msg.sender] = true;
		myVoters.push(aadhar);
        voterCount ++;
		voterData[voterCount] = Voter(voterCount, msg.sender,aadhar);
		//trigger the vote event
		emit votedEvent(_contestantId);
		
		
	}
}