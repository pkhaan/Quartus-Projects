--************************************************************************
--*********************Εργασία 2η*****************************************
--*********************16 bit ALU*****************************************
--*******************Δαμιανός Ιακωβίδης***********************************
--*******************Ιάσων Χριστοφιλάκης**********************************
--*******************Νίκος Κουντουριώτης**********************************
--*******************Πέτρος Χάνας*****************************************
--################ΣΧΕΔΙΑΣΗ ΨΗΦΙΑΚΩΝ ΣΥΣΤΗΜΑΤΩΝ############################
library IEEE;
use IEEE.STD_LOGIC_1164.all;
use ieee.std_logic_unsigned.all; --Χρησιμοποιήθηκαν για να επεκτείνουν την βιβλιοθήκη των λογικών πράξεων.
use ieee.numeric_std.all;        -- >>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>αριθμητικών>>>>.
--use std.standard.severity_level; Βλέπε στο Αρχείο OverflowCheck.vhd  
--use work.OverflowCheck.all;      //////////////////////////////////
use work.ALU.all;
use work.Control_Circuit.all;

entity ALU16BIT is 

      port(opcode: in  std_logic_vector(2 downto 0);
      a : in std_logic_vector (15 downto 0);         --Επέκταση σε 16 λογικά μπιτς
	  b : in std_logic_vector (15 downto 0);         -->>>>>>>>>>>>>>>>>>>>>>>>>>>
	  RESULT : out std_logic_vector(15 downto 0);    -->>>>>>>>>>>>>>>>>>>>>>>>>>>
	  Overflow : out std_logic);-- Δήλωση Υπερχείλισης
	 
end ALU16BIT;

     Architecture behavioral of ALU16BIT is 
	 signal Operation:std_logic_vector(1 downto 0);
	 signal Ainvert,Binvert,Cin,c1,c2,c3,c4,c5,c6,c7,c8,c9,c10,c11,c12,c13,c14,c15:std_logic; --Δήλωση Ενδιάμεσων Κρατουμένων ως Σήματα
	 
	      begin 
		  
		    CUnit (opcode, Operation, Ainvert, Binvert, Cin);  --Εδώ καλείται από το Control Circuit η διαδικασία CUnit
			                                                    --Bλ αρχείο Control_Circuit.vhd 
			    --Port Mapping Every ALU1BIT as Ripple/Carry Adder 
				--Ουσιαστικά για κάθε ξεχωριστο μπιτ των a, b & RESULT απο τα 16 χρησιμοποιείται η 1-μπιτη ALU 
				--για την απορρόφηση των πράξεων που δηλώθηκαν (ως υποκύκλωμα) αφού πρώτα κληθεί το Κύκλωμα Ελέγχου
			  P1: ALU1BIT port map (a(0), b(0), Ainvert, Binvert, Cin, Operation, c1, RESULT(0));  
			  P2: ALU1BIT port map (a(1), b(1), Ainvert, Binvert, c1, Operation, c2, RESULT(1));
			  P3: ALU1BIT port map (a(2), b(2), Ainvert, Binvert, c2, Operation, c3, RESULT(2));
              P4: ALU1BIT port map (a(3), b(3), Ainvert, Binvert, c3, Operation, c4, RESULT(3));
			  P5: ALU1BIT port map (a(4), b(4), Ainvert, Binvert, c4, Operation, c5, RESULT(4));
			  P6: ALU1BIT port map (a(5), b(5), Ainvert, Binvert, c5, Operation, c6, RESULT(5));
			  P7: ALU1BIT port map (a(6), b(6), Ainvert, Binvert, c6, Operation, c7, RESULT(6));
			  P8: ALU1BIT port map (a(7), b(7), Ainvert, Binvert, c7, Operation, c8, RESULT(7));
			  P9: ALU1BIT port map (a(8), b(8), Ainvert, Binvert, c8, Operation, c9, RESULT(8));
			  P10: ALU1BIT port map (a(9), b(9), Ainvert, Binvert, c9, Operation, c10, RESULT(9));
			  P11: ALU1BIT port map (a(10), b(10), Ainvert, Binvert, c10, Operation, c11, RESULT(10));
			  P12: ALU1BIT port map (a(11), b(11), Ainvert, Binvert, c11, Operation, c12, RESULT(11));
			  P13: ALU1BIT port map (a(12), b(12), Ainvert, Binvert, c12, Operation, c13, RESULT(12));
			  P14: ALU1BIT port map (a(13), b(13), Ainvert, Binvert, c13, Operation, c14, RESULT(13));
			  P15: ALU1BIT port map (a(14), b(14), Ainvert, Binvert, c14, Operation, c15, RESULT(14));
			  P16: ALU1BIT port map (a(15), b(15), Ainvert, Binvert, c15, Operation, Overflow, RESULT(15));
			                                                                        --|||||||  Έξοδος last Cout ή Υπερχείλισης
			                --check(Overflow);                                                
					        --βλ. στο αρχείο OverflowCheck.vhd		  
			  
end behavioral;
			  