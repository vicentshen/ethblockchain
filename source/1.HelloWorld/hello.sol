pragma solidity ^0.4.19;
/**
 * The hello contract does this and that...
 */
contract hello {
	string greeting;

	function hello (string _greeting) public {
		greeting = _greeting;
	}
	

	function sayHello () constant public returns (string) {
		return greeting;
	}	
}
