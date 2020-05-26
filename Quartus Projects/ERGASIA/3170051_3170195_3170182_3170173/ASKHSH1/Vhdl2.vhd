library ieee;
use ieee.std_logic_1164.all;
package components_3 is
--OR2 Declaration--
  component myOR2
            port (in1, in2: in std_logic; out1: out std_logic);
     end component;
--OR3 Declaration--
  component myOR3
            port (in1, in2, in3: in std_logic; out1: out std_logic);
     end component;
--OR4 Declaration--
  component myOR4
            port (in1, in2, in3, in4: in std_logic; out1: out std_logic);
     end component;
--AND5 Declaration--
  component myAND5
            port (in1, in2, in3, in4, in5: in std_logic; out1: out std_logic);
     end component;
--NOT Declaration--
  component myNOT           
           port (in1: in std_logic; out1: out std_logic);
     end component;
	 end package components_3;
	 
	 library ieee;
use ieee.std_logic_1164.all;

--2 Input OR GATE--
 entity myOR2 is
           
           port (in1, in2, in3: in std_logic; out1: out std_logic);
     end myOR2;
     architecture model_conc of myOR2 is
           begin
                
					 out1 <= in1 or in2;
     end model_conc;
	 library ieee;
use ieee.std_logic_1164.all;
--3 Input OR GATE--
 entity myOR3 is
           
           port (in1, in2, in3: in std_logic; out1: out std_logic);
     end myOR3;
     architecture model_conc of myOR3 is
           begin
                
					 out1 <= in1 or in2 or in3;
     end model_conc;
	 library ieee;
use ieee.std_logic_1164.all;
--4 Input OR GATE--
entity myOR4 is
           
           port (in1, in2, in3, in4: in std_logic; out1: out std_logic);
     end myOR4;
     architecture model_conc of myOR4 is
           begin
                
					 out1 <= in1 or in2 or in3 or in4;
     end model_conc;
	 library ieee;
use ieee.std_logic_1164.all;
--5 Input AND GATE--
entity myAND5 is
           
           port (in1, in2, in3, in4, in5: in std_logic; out1: out std_logic);
     end myAND5;
     architecture model_conc of myAND5 is
           begin
                
					 out1 <= in1 and in2 and in3 and in4 and in5;
     end model_conc;
	 library ieee;
use ieee.std_logic_1164.all;
--Single Input NOT--
  entity myNOT is
           
           port (in1: in std_logic; out1: out std_logic);
     end myNOT;
     architecture model_conc3 of myNOT is
           begin
                
					 out1 <= not in1;
     end model_conc3;

