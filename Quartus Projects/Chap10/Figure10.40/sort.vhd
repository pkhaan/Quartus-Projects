LIBRARY ieee;
USE ieee.std_logic_1164.all;
USE work.components.all ;

ENTITY sort IS
	GENERIC ( N : INTEGER := 4 ) ;
	PORT (	Clock, Resetn	: IN 		STD_LOGIC ;
			s, WrInit, Rd	: IN 		STD_LOGIC ;
			DataIn 			: IN 		STD_LOGIC_VECTOR(N-1 DOWNTO 0) ;
			RAdd 			: IN 		INTEGER RANGE 0 TO 3 ;
			DataOut 		: BUFFER 	STD_LOGIC_VECTOR(N-1 DOWNTO 0) ;
			Done 			: BUFFER 	STD_LOGIC ) ;
END sort ;

ARCHITECTURE Behavior OF sort IS
	TYPE State_type IS ( S1, S2, S3, S4, S5, S6, S7, S8, S9 ) ;
	SIGNAL y : State_type ;
	SIGNAL Ci, Cj : INTEGER RANGE 0 TO 3 ;
	SIGNAL Rin : STD_LOGIC_VECTOR(3 DOWNTO 0) ;
	TYPE RegArray IS 
		ARRAY(3 DOWNTO 0) OF STD_LOGIC_VECTOR(N-1 DOWNTO 0) ;
	SIGNAL R : RegArray ;
	SIGNAL RData, ABMux : STD_LOGIC_VECTOR(N-1 DOWNTO 0) ;
	SIGNAL Int, Csel, Wr, BltA : STD_LOGIC ;
	SIGNAL CMux, IMux : INTEGER RANGE 0 TO 3 ;
	SIGNAL Ain, Bin, Aout, Bout : STD_LOGIC ;
	SIGNAL LI, LJ, EI, EJ, zi, zj : STD_LOGIC ;
	SIGNAL Zero : INTEGER RANGE 3 DOWNTO 0 ; -- parallel data for Ci = 0
	SIGNAL A, B, ABData : STD_LOGIC_VECTOR(N-1 DOWNTO 0) ; 
BEGIN
	FSM_transitions: PROCESS ( Resetn, Clock )
	BEGIN
		IF Resetn = '0' THEN
			y <= S1 ;
		ELSIF (Clock'EVENT AND Clock = '1') THEN
			CASE y IS
				WHEN S1 => IF S = '0' THEN y <= S1 ; 
					ELSE y <= S2 ; END IF ;
				WHEN S2 => y <= S3 ;
				WHEN S3 => y <= S4 ;
				WHEN S4 => y <= S5 ;
				WHEN S5 => IF BltA = '1' THEN y <= S6 ; 
					ELSE y <= S8 ; END IF ;
				WHEN S6 => y <= S7 ;
				WHEN S7 => y <= S8 ;
				WHEN S8 =>
					IF zj = '0' THEN y <= S4 ;
					ELSIF zi = '0' THEN y <= S2 ;
					ELSE y <= S9 ;
					END IF ;
				WHEN S9 => IF s = '1' THEN y <= S9 ; ELSE y <= S1 ; END IF ;
			END CASE ;
		END IF ;
	END PROCESS ;
	-- define the outputs generated by the FSM
	Int <= '0' WHEN y = S1 ELSE '1' ;
	Done <= '1' WHEN y = S9 ELSE '0' ;
	FSM_outputs: PROCESS ( y, zi, zj )
	BEGIN
		LI <= '0' ; LJ <= '0' ; EI <= '0' ; EJ <= '0' ; Csel <= '0' ;
		Wr <= '0'; Ain <= '0' ; Bin <= '0' ; Aout <= '0' ; Bout <= '0' ;
		CASE y IS
			WHEN S1 => LI <= '1' ; EI <= '1' ;
			WHEN S2 => Ain <= '1' ; LJ <= '1' ; EJ <= '1' ;
			WHEN S3 => EJ <= '1' ;
			WHEN S4 => Bin <= '1' ; Csel <= '1' ;
			WHEN S5 => -- no outputs asserted in this state
			WHEN S6 => Csel <= '1' ; Wr <= '1' ; Aout <= '1' ;
			WHEN S7 => Wr <= '1' ; Bout <= '1' ;
			WHEN S8 => Ain <= '1' ;
				IF zj = '0' THEN
					EJ <= '1' ;
				ELSE
					EJ <= '0' ;
					IF zi = '0' THEN
						EI <= '1' ;
					ELSE
						EI <= '0' ;
					END IF;
				END IF ;
			WHEN S9 => -- Done is assigned 1 by conditional signal assignment
		END CASE ;
	END PROCESS ;

	-- define the datapath circuit
	Zero <= 0 ;
	GenReg: FOR i IN 0 TO 3 GENERATE
		Reg: regne GENERIC MAP ( N => N )
			PORT MAP ( RData, Resetn, Rin(i), Clock, R(i) ) ;
	END GENERATE ;	
	RegA: regne GENERIC MAP ( N => N )
		PORT MAP ( ABData, Resetn, Ain, Clock, A ) ;
	RegB: regne GENERIC MAP ( N => N )
		PORT MAP ( ABData, Resetn, Bin, Clock, B ) ;
	BltA <= '1' WHEN B < A ELSE '0' ;
	ABMux <= A WHEN Bout = '0' ELSE B ;
	RData <= ABMux WHEN WrInit = '0' ELSE DataIn ;
	OuterLoop: upcount GENERIC MAP ( modulus => 4 )
		PORT MAP ( Resetn, Clock, EI, LI, Zero, Ci ) ;
	InnerLoop: upcount GENERIC MAP ( modulus => 4 )
		PORT MAP ( Resetn, Clock, EJ, LJ, Ci, Cj ) ;
	CMux <= Ci WHEN Csel = '0' ELSE Cj ;
	IMux <= Cmux WHEN Int = '1' ELSE Radd ;
	WITH IMux Select
		ABData <= 	R(0) WHEN 0,
					R(1) WHEN 1,
					R(2) WHEN 2,
					R(3) WHEN OTHERS ;
	RinDec: PROCESS ( WrInit, Wr, IMux )
	BEGIN
		IF (WrInit OR Wr) = '1' THEN
			CASE IMux IS
				WHEN 0 =>		Rin <= "0001" ;
				WHEN 1 =>		Rin <= "0010" ;
				WHEN 2 =>		Rin <= "0100" ;
				WHEN OTHERS	=>	Rin <= "1000" ;
			END CASE ;
		ELSE Rin <= "0000" ;
		END IF ;
	END PROCESS ;
	Zi <= '1' WHEN Ci = 2 ELSE '0' ;
	Zj <= '1' WHEN Cj = 3 ELSE '0' ;
	DataOut <= (OTHERS => 'Z') WHEN Rd = '0' ELSE ABData ;
END Behavior ;
