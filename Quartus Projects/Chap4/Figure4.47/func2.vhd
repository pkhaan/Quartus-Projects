LIBRARY ieee ;
USE ieee.std_logic_1164.all ;

ENTITY func2 IS 
	PORT ( x1, x2, x3, x4  : IN STD_LOGIC ; 
	f : OUT STD_LOGIC ) ; 
END func2 ; 

ARCHITECTURE LogicFunc OF func2 IS 
BEGIN  
	f <= (NOT x1 AND NOT x2 AND x3 AND NOT x4) OR 
	     (NOT x1 AND NOT x2 AND x3 AND x4) OR 
	     (x1 AND NOT x2 AND NOT x3 AND x4) OR 
	     (x1 AND NOT x2 AND x3 AND NOT x4) OR
	     (x1 AND NOT x2 AND x3 AND x4) OR
	     (x1 AND x2 AND NOT x3 AND x4) ;
END LogicFunc ; 

