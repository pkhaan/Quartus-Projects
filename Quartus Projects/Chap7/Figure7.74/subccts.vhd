LIBRARY ieee ;
USE ieee.std_logic_1164.all ;

PACKAGE subccts IS
	
	COMPONENT regn
		GENERIC ( N : INTEGER := 8 ) ;
		PORT (	R			: IN	STD_LOGIC_VECTOR(N-1 DOWNTO 0) ;
				Rin, Clock	: IN	STD_LOGIC ;
				Q		  	: OUT	STD_LOGIC_VECTOR(N-1 DOWNTO 0) ) ;
	END COMPONENT ;
	
	COMPONENT upcount
		PORT (	Clear, Clock	: IN		STD_LOGIC ;
				Q				: BUFFER 	STD_LOGIC_VECTOR(1 DOWNTO 0) ) ;
	END COMPONENT ;
		
	COMPONENT dec2to4
		PORT (	w		: IN	STD_LOGIC_VECTOR(1 DOWNTO 0) ;
				En		: IN	STD_LOGIC ;
				y		: OUT	STD_LOGIC_VECTOR(0 TO 3) );
	END COMPONENT;

END subccts ;

