--#############################################################################
--#############################################################################
--#############################################################################
--#############################################################################
--#############################################################################


--


LIBRARY IEEE; 
USE IEEE.STD_LOGIC_1164.all; 
USE IEEE.STD_LOGIC_SIGNED.all; 

ENTITY proc IS   --Αρχική Δήλωση Input/Output Επεξεργαστή
    PORT ( DIN : IN STD_LOGIC_VECTOR(15 DOWNTO 0); 
           Reset, Clock, Run : IN STD_LOGIC; 
           Done : BUFFER STD_LOGIC; 
           BusWires : BUFFER STD_LOGIC_VECTOR(15 DOWNTO 0)); 
END proc; 

ARCHITECTURE Behavior OF proc IS  --Δήλωση Αποκωδικοποιητή 3-to-8    
      COMPONENT dec3to8 
       PORT ( W : IN STD_LOGIC_VECTOR(2 DOWNTO 0);
             EN : IN STD_LOGIC;
			    Y  : OUT STD_LOGIC_VECTOR(0 TO 7));
  END COMPONENT;
  
   COMPONENT REGN    --Δήλωση Καταχωρητή 16-bit (Σκελετός)
       GENERIC (n : INTEGER :=16);      
	       PORT (R : IN STD_LOGIC_VECTOR(n-1 DOWNTO 0);
	             Rin, Clock : IN STD_LOGIC;
			       Q : BUFFER STD_LOGIC_VECTOR(n-1 DOWNTO 0));--Σήμα Διπλής Κατευθύνσεως (READ BACK)_(BIDIR)
   END COMPONENT;
  
    COMPONENT upcount --Δήλωση Μετρητή (ΑΠΑΡΙΘΜΗΣΗΣ)  
	   PORT (Clear, Clock : IN STD_LOGIC; --Εισόδου
			   Q : BUFFER STD_LOGIC_VECTOR(1 DOWNTO 0));      -->>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
	 END COMPONENT;

	  SIGNAL Rin, Rout : STD_LOGIC_VECTOR(0 TO 7); --bit upscaling
	  SIGNAL Sum : STD_LOGIC_VECTOR(15 DOWNTO 0);  --bit downscaling
	  SIGNAL Tstep_Q : STD_LOGIC_VECTOR(1 DOWNTO 0); --down
	  SIGNAL ep : STD_LOGIC_VECTOR(1 to 10);  --Αυτό το σήμα θα επιλέξει την Λεωφόρο μεταξύ των R καταχωρητών
	  SIGNAL Ain, IRin, High, Clear, DINout, Gin, Gout, AddSub : STD_LOGIC;--Δήλωση Σημάτων Πολυπλέκτων 
	  SIGNAL Xreg, Yreg : STD_LOGIC_VECTOR(0 TO 7);
	  SIGNAL R0, R1, R2, R3, R4, R5, R6, R7, A, G : STD_LOGIC_VECTOR(15 DOWNTO 0); --Σήματα των 8 Καταχωρητών R και των Α, G 
	  SIGNAL I : STD_LOGIC_VECTOR(2 DOWNTO 0); --Αντιστοίχηση Σήματος                                                      --όλοι 16-bit                   
	  SIGNAL IR : STD_LOGIC_VECTOR(1 TO 9);    --9 μπιτος καταχωρητής IR
	  
	
BEGIN 
  High <= '1'; 
  Clear <= NOT(Reset) OR Done OR (NOT(Run) AND NOT(Tstep_Q(1)) AND NOT(Tstep_Q(0))); --Συνθήκη Εκκαθάρισης TEMP Βήματος ως reset Clear CUNIT
  Tstep : upcount  PORT MAP (Clear, Clock, Tstep_Q);      --Port Mapping Step to Clearance   
  I <= IR(1 TO 3);
  decX: dec3to8 PORT MAP (IR(4 TO 6), High, Xreg);
  decY: dec3to8 PORT MAP (IR(7 TO 9), High, Yreg);



	-- Instruction Table
	--  000: mv			Rx,Ry
	--  001: mvi		Rx,#D
	--  010: and      Rx,Ry	
	--  011: or       Rx,Ry	
	--  100: add		Rx,Ry		: Rx <- [Rx] + [Ry]
	--  101: sub		Rx,Ry		: Rx <- [Rx] - [Ry]
	--  110: xor      Rx,Ry	
	--  111: not      Rx,Ry
	--  OPCODE format: III XXX YYY, where 
	--  III = instruction, XXX = Rx, and YYY = Ry. For mvi,
	--  a second word of data is loaded from DIN

  controlsignals: PROCESS (Tstep_Q, I, Xreg, Yreg) 

  BEGIN 
      IRin <= '0';        --Αρχικοποίηση Σημάτων
	   Done <= '0';        -->>>>>>>>>>>>>>>>>>>>
	   Rin  <= "00000000"; -->>>>>>>>>>>>>>>>>>>>
	   Rout <= "00000000"; -->>>>>>>>>>>>>>>>>>>>
	   Ain  <= '0';        -->>>>>>>>>>>>>>>>>>>>
	   AddSub <= '0';      -->>>>>>>>>>>>>>>>>>>>
	   Gin <= '0';         -->>>>>>>>>>>>>>>>>>>>
	   Gout <= '0';        -->>>>>>>>>>>>>>>>>>>>
	   DINout <= '0';      -->>>>>>>>>>>>>>>>>>>>
	
    CASE Tstep_Q IS 
      WHEN "00" =>  --store DIN in IR as long as Tstep_Q = 0 
        IRin <= '1'; 
      WHEN "01" =>  --define signals in time step T1 
        CASE I IS 
          WHEN "000" =>   --Signal Execution of Discerned Processor Command mv Rx, Ry
		   Rin <= Xreg;
			Rout <= Yreg;
			Done <= '1';
          WHEN "001" =>   -- mv1 Rx ,Ry 
		    Rin <= Xreg;
			Done <= '1';
			DINout <= '1';
		  WHEN "010" =>   --LOG Assu. (_ADD)
		     Rout <= Xreg;
			  Ain <= '1';
		  WHEN OTHERS =>
		     Rout <= Xreg;
			  Ain <= '1';
        END CASE; 
      WHEN "10" =>  --define signals in time step T2 
        CASE I IS 
         WHEN "010" => --LOG ASSU. (-ADD)
		   Rout <= Yreg;
		   Gin <= '1';
		 WHEN OTHERS =>
		   Rout <= Yreg;
		   AddSub <= '1';
		   Gin <= '1';
        END CASE; 
      WHEN "11" =>  --define signals in time step T3 
        CASE I IS 
       WHEN "010" => 
	      Gout <= '1';
		   Rin <= Xreg;
		   Done <= '1';
	   WHEN OTHERS => 
          Gout <= '1';
		    Rin <= Xreg;
		    Done <= '1';
        END CASE; 
    END CASE; 
  END PROCESS; 
  --Αρχιτεκτονική Κατασκευή των Καταχωρητών R, A, G
  reg_0: regn PORT MAP (BusWires, Rin(0), Clock, R0); --Για κάθε μπιτ του R
  reg_1: regn PORT MAP (BusWires, Rin(1), Clock, R1); -->>>>>>>>>>>>>>>>>>>
  reg_2: regn PORT MAP (BusWires, Rin(2), Clock, R2); -->>>>>>>>>>>>>>>>>>>
  reg_3: regn PORT MAP (BusWires, Rin(3), Clock, R3); -->>>>>>>>>>>>>>>>>>>
  reg_4: regn PORT MAP (BusWires, Rin(4), Clock, R4); -->>>>>>>>>>>>>>>>>>>
  reg_5: regn PORT MAP (BusWires, Rin(5), Clock, R5); -->>>>>>>>>>>>>>>>>>>
  reg_6: regn PORT MAP (BusWires, Rin(6), Clock, R6); -->>>>>>>>>>>>>>>>>>>
  reg_7: regn PORT MAP (BusWires, Rin(7), Clock, R7); -->>>>>>>>>>>>>>>>>>>
  reg_A: regn PORT MAP (BusWires, Ain, Clock, A);     --Κατασκευή του Α
  reg_IR: regn GENERIC MAP (n => 9) PORT MAP (DIN(15 DOWNTO 7), IRin, Clock, IR);--Κατασκευή τoυ G
            --Generic Command usage for INFO Disemmination                                  
  
--Αρχιτεκτόνική Κατασκευή Αριθμητικής Λογικής Μονάδας
--Ως Διαδικασία που επιδέχεται το σήμα του καταχωρητή Α  
--και το σήμα της εκάστοτε λεωφόρου και εξάγει ALUExit.

  ALU: PROCESS (AddSub, A, BusWires)--ALUOp
  BEGIN
       IF AddSub = '0' THEN    --Συνθήκη Ελέγχου για το αν στο άθροισμα θα προστεθεί ο καταχωρητής Α με την Λεωφόρο ή το Αντίστροφο
	        Sum <= A + BusWires;
	    ELSE 
		     Sum <= A - BusWires;                     --(**********************)--
		 END IF;
   END PROCESS;
           -- ep : Επιλογή BUS  
           -- R..N:Σήματα Λεωφόρου
           -- G Σήμα Καταχωρητή G (Gin/Gout)	
           -- DIN_out σύνδεση πολυπλέκτη με καταχωρητή G	
		
   reg_G: regn PORT MAP (Sum, Gin, Clock, G); --Καταχωρητής G κατασκευή χρησιμοποιώντας το υποκύκλωμα regn 
	
	ep <= Rout & DINout & Gout;                --Δήλωση του Bus του επεξεργαστή μέσω σημάτων των καταχωρητών
	
   busconc: PROCESS (ep, R0, R1, R2, R3, R4, R5, R6, R7, G, DIN)  --Bus Construction
       BEGIN 
	    IF    ep = "1000000000" THEN 
		    BusWires <= R0;
	    ELSIF ep = "0100000000" THEN 
		    BusWires <= R1;
	    ELSIF ep = "0010000000" THEN
		    BusWires <= R2;
		ELSIF  ep = "0001000000" THEN 
		    BusWires <= R3;
		ELSIF  ep = "0000100000" THEN 
		    BusWires <= R4;
	    ELSIF ep = "0000010000" THEN 
		    BusWires <= R5;
		ELSIF  ep = "0000001000" THEN 
		    BusWires <= R6;
		ELSIF  ep = "0000000100" THEN 
		    BusWires <= R7;
		ELSIF  ep = "0000000010" THEN
		    BusWires <= G;
	    ELSE
		    BusWires <= DIN;
			
		END IF;
	END PROCESS;
END Behavior; 

LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.all;
USE IEEE.STD_LOGIC_SIGNED.all;


ENTITY upcount IS                           --Μετρητής

  PORT ( Clear, Clock : IN STD_LOGIC; 
  Q : OUT STD_LOGIC_VECTOR(1 DOWNTO 0)); 
END upcount; 

ARCHITECTURE Behavior OF upcount IS 
 SIGNAL Count : STD_LOGIC_VECTOR(1 DOWNTO 0); 

BEGIN 
  PROCESS (Clock) 
  BEGIN 

    IF (Clock'EVENT AND Clock = '1') THEN 

     IF Clear = '1' THEN 
       Count <= "00"; 
     ELSE 
       Count <= Count + 1; 
     END IF; 

   END IF; 
  END PROCESS; 
  Q <= Count; 

END Behavior; 


LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.all;


ENTITY dec3to8 IS    --Κατασκευή ενός Αποκωδικοποιητή 3-to-8


  PORT ( W : IN STD_LOGIC_VECTOR(2 DOWNTO 0); 
  En : IN STD_LOGIC; 
  Y : OUT STD_LOGIC_VECTOR(0 TO 7)); 
END dec3to8; 

ARCHITECTURE Behavior OF dec3to8 IS 
                                           
BEGIN 
  PROCESS (W, En) 
  BEGIN 

    IF En = '1' THEN 
         --Σύμφωνα με τον πίνακα της εκφώνησης
      CASE W IS 
         WHEN "000" => Y <= "10000000";  --mv Rx, Ry  <- [Ry]
		 WHEN "001" => Y <= "01000000";  --mvi Rx, #D <- D
		 WHEN "010" => Y <= "00100000";  --and Rx, Ry <- [Rx] AND [Ry]
		 WHEN "011" => Y <= "00010000";  --or Rx, Ry  <- [Rx] OR  [Ry]
		 WHEN "100" => y <= "00001000";  --add Rx, Ry <- [Rx]  +  [Ry]
  		 WHEN "101" => Y <= "00000100";  --sub Rx, Ry <- [Rx]  -  [Ry]
		 WHEN "110" => Y <= "00000010";  --xor Rx, Ry <- [Rx] XOR [Ry]
		 WHEN "111" => Y <= "00000001";  --not Rx, Ry <- NOT [Ry]
		 WHEN OTHERS => Y <= "--------"; --Αδιάφορες Τιμές
      END CASE; 
         ELSE 
      Y <= "00000000"; --Reinitilization Signal Y
    END IF; 
   END PROCESS; 
END Behavior; 

LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.all;

ENTITY regn IS        
  GENERIC (n : INTEGER := 16);                      
  PORT ( R : IN STD_LOGIC_VECTOR(n-1 DOWNTO 0);     
																	 	
  Rin, Clock : IN STD_LOGIC; 

  Q : BUFFER STD_LOGIC_VECTOR(n-1 DOWNTO 0)); 
END regn; 

ARCHITECTURE Behavior OF regn IS --Αρχιτεκτονική Κατασκευή ενός Καταχωρητή

BEGIN 
  PROCESS (Clock) 
  BEGIN 

    IF Clock'EVENT AND Clock = '1' THEN 
      IF Rin = '1' THEN 
        Q <=R; 
      END IF; 
    END IF; 
  END PROCESS; 
END Behavior;






