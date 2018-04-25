pragma solidity ^0.4.19;
/**
@title Shape Calculator
*/
contract shapeCalculator{
	/**
	@dev calculator a rectangle's surface and perimeter

	@param w width of rectangles

	@param h height of rectangles

	@return s surface of the rectangles

	@return p preimeter of rectangles
	*/

	function rectangles(uint w,uint h) returns (uint s,uint p){
		
		s = w*h;

		p = 2*(w+h);
	
	}
}