ENTITY adder16 IS
	PORT (	X, Y 	: IN 	INTEGER RANGE -32768 TO 32767 ;
			S 		: OUT 	INTEGER RANGE -32768 TO 32767 ) ;
END adder16 ;

ARCHITECTURE Behavior OF adder16 IS    
BEGIN
	S <= X + Y ;
END Behavior ;