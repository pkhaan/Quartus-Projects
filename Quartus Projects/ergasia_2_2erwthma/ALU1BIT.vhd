library ieee;
use ieee.std_logic_1164.all;    
use work.components_3.all; --Χρήση του Πακέτου από την προηγούμενη εργασία αφού τροποποιήθηκε (primitive logic gates)
use work.multi4.all;       -- Πολυπλέκτης 4 to 1
use work.fullcomp.all;     -- Πλήρης Αθροιστής
use work.MUX2_TO_1.all;    -- Πολυπλέκτης 2 to 1

package ALU is
component ALU1BIT is 

	port (a, b, Ainvert, Binvert, Cin: in std_logic; Operation: in std_logic_vector(1 downto 0);
	Cout : out std_logic;
	ResultFINAL: out std_logic);

end component;
end package ALU;


library ieee;
use ieee.std_logic_1164.all;    
use work.components_3.all;
use work.multi4.all;
use work.fullcomp.all;
use work.MUX2_TO_1.all;



  entity ALU1BIT is
port (a, b, Ainvert, Binvert, Cin: in std_logic;
      Operation: in std_logic_vector(1 downto 0);
      Cout : out std_logic;
      ResultFINAL: out std_logic); 
    end ALU1BIT;

architecture DOMH of ALU1BIT is
signal not_a, not_b, resultA, resultB, result1, result2, result3, result4: std_logic; --Ενδιάμεσα Σήματα Πυλών ως διπλής κατευθύνσεως
																												  --π.χ. τα result1,2,3,4 εισάγονται στον τελικό πολυπλέκτη
	begin
   --Απλό Port Mapping του Σχεδόυ Κυκλώματος 7
	I0: myNOT port map (a, not_a);
	I1: myNOT port map (b, not_b);
	I3: myMUX2_TO_1 port map (a, not_a, Ainvert, resultA);
	I4: myMUX2_TO_1 port map (b, not_b, Binvert, resultB);
	I5: myAND2 port map (resultA, resultB, result1);
	I6: myOR2 port map (resultA, resultB, result2);
	I7: FULLADDER port map (Cin, resultA, resultB, result3, Cout);
	I8: myXOR port map (resultA, resultB, result4);
	I9: multiplexer_4_to_1 port map (result1, result2, result3, result4, Operation, ResultFINAL);  

	end DOMH;