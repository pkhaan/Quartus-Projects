library IEEE, components_3;
use ieee.std_logic_1164.all;
use work.components_3.all;
entity Problem1 is
	port(x1, x2, x3, x4, x5: in std_logic;
	f, g: out std_logic);
end Problem1;

architecture STRUC of Problem1 is
signal not_x1, not_x2, not_x3, not_x4, not_x5, p1, p2, p3, p4, p5, p6, p7, p8, p9: std_logic;

begin

	I0: myNOT port map (x1, not_x1);
	I1: myNOT port map (x2, not_x2);
	I2: myNOT port map (x3, not_x3);
	I3: myNOT port map (x4, not_x4);
	I4: myNOT port map (x5, not_x5);
	I5: myOR2 port map (not_x1, x2, p1);
	I6: myOR2 port map (not_x4, x5, p2);
	I7: myOR2 port map (x2, not_x4, p3);
	I8: myOR2 port map (x3, x5, p4);
	I9: myOR3 port map (not_x2, x4, not_x5, p5);--<-COMMON FACTOR IMPLICANT--
	I10: myOR3 port map (x2, x4, not_x5, p6);
	I11: myOR3 port map (x2, not_x3, not_x4, p7);
	I12: myOR3 port map (not_x1, x2, not_x3, p8);
	I13: myOR4 port map (not_x1, not_x3, not_x4, x5, p9);
	I14: myAND5 port map (p1, p2, p3, p4, p5, f);
	I15: myAND5 port map (p5, p6, p7, p8, p9, g);
end STRUC;
	