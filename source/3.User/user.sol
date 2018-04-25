pragma solidity ^0.4.19;
contract EventExample{

	event SendBalance(
		address indexed _from,
		bytes32 indexed _id,
		uint _value);

	function sendBalance(bytes32 id){
		SendBalance(msg.sender,_id,msg.value);
	}

}