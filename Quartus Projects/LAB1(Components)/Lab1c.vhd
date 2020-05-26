library IEEE, basic_components;
use ieee.std_logic_1164.all;
use work.basic_components.all;
entity Lab1c is
	port (x1, x2, x3: in std_logic;
	f: out std_logic);
end Lab1c;

architecture structural of Lab1c is
	signal not_x1, not_x3, pos1, pos2, sum1, sum2: std_logic;

begin
	
	I0: myNOT1 port map (x1, not_x1);
	I1: myNOT1 port map (x3, not_x3);
	I2: myOR2 port map (x1, x3, pos1);
	I3: myOR2 port map (not_x1, x2, sum1);
	I4: myOR2 port map (sum1, not_x3, pos2);
	I5: myAND2 port map (pos1, pos2, f);
end structural; 