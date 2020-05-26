library ieee;
use ieee.std_logic_1164.all;    
use work.components_3.all;
use work.multi4.all;
use work.fullcomp.all;
use work.MUX2_TO_1.all;

package ALU is
component ALU1BIT is 

	port (a, b, Ainvert, Binvert, Cin: in std_logic; Operation: in std_logic_vector(1 downto 0); Cout, Result: out std_logic);

end component;
end package ALU;


library ieee;
use ieee.std_logic_1164.all;    
use work.components_3.all;
use work.multi4.all;
use work.fullcomp.all;
use work.MUX2_TO_1.all;



  entity ALU1BIT is
port (a, b, Ainvert, Binvert, Cin: in std_logic; Operation: in std_logic_vector(1 downto 0); Cout, Result: out std_logic); 
end ALU1BIT;

architecture DOMH of ALU1BIT is
signal not_a, not_b, resultA, resultB, result1, result2, result3, result4: std_logic;
    
	begin

	I0: myNOT port map (a, not_a);
	I1: myNOT port map (b, not_b);
	I3: myMUX2_TO_1 port map (a, not_a, Ainvert, resultA);
	I4: myMUX2_TO_1 port map (b, not_b, Binvert, resultB);
	I5: myAND2 port map (resultA, resultB, result1);
	I6: myOR2 port map (resultA, resultB, result2);
	I7: FULLADDER port map (Cin, resultA, resultB, result3, Cout);
	I8: myXOR port map (resultA, resultB, result4);
	I9: multiplexer_4_to_1 port map (result1, result2, result3, result4, Operation, RESULT);  

	end DOMH;