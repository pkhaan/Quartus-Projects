library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use work.ALU.all;--χρησιμοποείται το πακέτο απλά για την κληρονόμηση των μεταβλητών
package Control_Circuit is 

procedure CUnit
    (signal opcode : in std_logic_vector(2 downto 0); --3μπιτο
     signal Operation : out std_logic_vector(1 downto 0);--2μπιτο
	  signal Ainvert : out std_logic; 
	  signal Binvert : out std_logic;
	  signal Cin : out std_logic);
	  end Control_Circuit;

     package body Control_Circuit is 
	       procedure CUnit
		  (signal opcode : in std_logic_vector(2 downto 0);
         signal Operation : out std_logic_vector(1 downto 0);
	      signal Ainvert : out std_logic; 
	      signal Binvert : out std_logic;
	      signal Cin : out std_logic) is
	 
	     begin 
		 
		if opcode = "000" then     --AND
		 
		     Operation <= "00";
			  Ainvert <= '0';
			  Binvert <= '0';
			  Cin <= '0';
			 
		 elsif opcode = "001" then   --OR
		                                                
			 Operation <= "01";
			 Ainvert <= '0';
			 Binvert <= '0';
			 Cin <= '0';
			 
		 elsif opcode = "011" then   --ADD
		 
			 Operation <= "11";
			 Ainvert <= '0';
			 Binvert <= '0';
			 Cin <= '0';
			 
		 elsif opcode = "010" then   --SUB
		 
			 Operation <= "11";
			 Ainvert <= '0';
			 Binvert <= '1';
			 Cin <= '1';
			 
		 elsif opcode = "101" then  --NOR
	 
	       Operation <= "00";
			 Ainvert <= '1';
			 Binvert <= '1';
			 Cin <= '0';
			  
		 elsif opcode = "100" then  --XOR
     
          Operation <= "10";
			 Ainvert <= '0';
			 Binvert <= '0';
			 Cin <= '0';
			 
		 else  -- elsif  opcode = "110" and opcode = "111" then (Εναλλακτικός τρόπος επικάλυψης 
		                                                     --  2 τελευταίων περιπτώσεων opcode____________πιο σύντομο απο πλευράς κώδικα
	                                                                                                       --μιας και έχουν εξαντληθει
																																			 --οι εναλλακτικές τιμές opcode	
			 Operation <= "--";       --Don't Care Cases
			 Ainvert <= '-';          -->>>>>>>>>>>>>>>>
			 Binvert <= '-';          -->>>>>>>>>>>>>>>>
			 Cin <= '-';              -->>>>>>>>>>>>>>>>
			 
			 end if;
	
			 end CUnit;
			 end Control_Circuit;