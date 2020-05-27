LIBRARY ieee ;
USE ieee.std_logic_1164.all ;
USE ieee.std_logic_unsigned.all ;
USE work.components.all ;

ENTITY multiply IS
	GENERIC ( N : INTEGER := 8; NN : INTEGER := 16 ) ;
	PORT (	Clock 		: IN 		STD_LOGIC ;
			Resetn 		: IN 		STD_LOGIC ;
			LA, LB, s 	: IN 		STD_LOGIC ;
			DataA 		: IN 		STD_LOGIC_VECTOR(N-1 DOWNTO 0) ;
			DataB 		: IN 		STD_LOGIC_VECTOR(N-1 DOWNTO 0) ;
			P 			: BUFFER 	STD_LOGIC_VECTOR(NN-1 DOWNTO 0) ;
			Done 		: OUT 		STD_LOGIC ) ;
END multiply ;

ARCHITECTURE Behavior OF multiply IS
	TYPE State_type IS ( S1, S2, S3 ) ;
	SIGNAL y : State_type ;
	SIGNAL Psel, z, EA, EB, EP, Zero : STD_LOGIC ;
	SIGNAL B, N_Zeros : STD_LOGIC_VECTOR(N-1 DOWNTO 0) ;
	SIGNAL A, Ain, DataP, Sum : STD_LOGIC_VECTOR(NN-1 DOWNTO 0) ;
BEGIN
	FSM_transitions: PROCESS ( Resetn, Clock )
	BEGIN
		IF Resetn = '0' THEN
			y <= S1 ;
		ELSIF (Clock'EVENT AND Clock = '1') THEN
			CASE y IS
				WHEN S1 =>
					IF s = '0' THEN	y <= S1 ; ELSE y <= S2 ; END IF ;
				WHEN S2 =>
					IF z = '0' THEN y <= S2 ; ELSE y <= S3 ; END IF ;
				WHEN S3 =>
					IF s = '1' THEN y <= S3 ; ELSE y <= S1 ; END IF ;
			END CASE ;
		END IF ;
	END PROCESS ;

	FSM_outputs: PROCESS ( y, s, LA, LB, B(0) )
	BEGIN
		EP <= '0' ; EA <= '0' ; EB <= '0' ; Done <= '0' ; Psel <= '0';
		CASE y IS
			WHEN S1 =>
				EP <= '1' ;
				IF s = '0' AND LA = '1' THEN EA <= '1' ; 
				ELSE EA <= '0' ; END IF ;
				IF s = '0' AND LB = '1' THEN EB <= '1' ; 
				ELSE EB <= '0' ; END IF ;
			WHEN S2 =>
				EA <= '1' ; EB <= '1' ; Psel <= '1' ;
				IF B(0) = '1' THEN EP <= '1' ; ELSE	EP <= '0' ; END IF ;
			WHEN S3 =>
				Done <= '1' ;
		END CASE ;
	END PROCESS ;

	-- Define the datapath circuit
	Zero <= '0' ;
	N_Zeros <= (OTHERS => '0' ) ;
	Ain <= N_Zeros & DataA ;
	ShiftA: shiftlne GENERIC MAP ( N => NN )
		PORT MAP ( Ain, LA, EA, Zero, Clock, A ) ;
	ShiftB: shiftrne GENERIC MAP ( N => N )
		PORT MAP ( DataB, LB, EB, Zero, Clock, B ) ;
	z <= '1' WHEN B = N_Zeros ELSE '0' ;
	Sum <= A + P ;
	-- Define the 2n 2-to-1 multiplexers for DataP
	GenMUX: FOR i IN 0 TO NN-1 GENERATE
		Muxi: mux2to1 PORT MAP ( Zero, Sum(i), Psel, DataP(i) ) ;
	END GENERATE;
	RegP: regne GENERIC MAP ( N => NN )
		PORT MAP ( DataP, Resetn, EP, Clock, P ) ;
END Behavior ;
