library ieee;
use ieee.std_logic_1164.all;
package fullcomp is
component FULLADDER
            port (Cin, x, y: in std_logic; s, Cout: out std_logic);
     end component;
	end package fullcomp;
 
library ieee;
use ieee.std_logic_1164.all; 
    entity FULLADDER is
           port (Cin, x, y: in std_logic; s, Cout: out std_logic);
     end FULLADDER;
     architecture model of FULLADDER is
           begin 
			  
			 s <= x XOR y XOR Cin ;
		    Cout <= (x AND y) OR (Cin AND x) OR (Cin AND y) ;
			 
     end model;