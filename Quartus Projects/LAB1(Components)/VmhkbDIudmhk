library ieee;
use ieee.std_logic_1164.all;
package basic_components is
	  -- AND2 declaration
     component myAND2
            port (in1, in2: in std_logic; out1: out std_logic);
     end component;
     -- OR2 declaration
	  component myOR2
           port (in1, in2: in std_logic; out1: out std_logic);
     end component;
	  --NOT1 declaration
	  component myNOT1           
           port (in1: in std_logic; out1: out std_logic);
     end component;
end package basic_components;

library ieee;
use ieee.std_logic_1164.all;

     -- 2 input AND gate
     entity myAND2 is
           
           port (in1, in2: in std_logic; out1: out std_logic);
     end myAND2;
     architecture model_conc of myAND2 is
           begin
                
					 out1 <= in1 and in2;
     end model_conc;
	  -- 2 input OR gate
library ieee;
use ieee.std_logic_1164.all;
	  entity myOR2 is
           
           port (in1, in2: in std_logic; out1: out std_logic);
     end myOR2;
     architecture model_conc2 of myOR2 is
           begin
                
					 out1 <= in1 or in2;
     end model_conc2;
	  -- 1 input NOT gate
library ieee;
use ieee.std_logic_1164.all;
	  entity myNOT1 is
           
           port (in1: in std_logic; out1: out std_logic);
     end myNOT1;
     architecture model_conc3 of myNOT1 is
           begin
                
					 out1 <= not in1;
     end model_conc3;