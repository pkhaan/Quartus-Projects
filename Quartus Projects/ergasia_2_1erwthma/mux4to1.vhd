library ieee ;
use ieee.std_logic_1164.all ;
package multi4 is
	component multiplexer_4_to_1
		port (p0, p1, p2, p3	: in 	std_logic;
				s 				: in	std_logic_vector;
				f 				: out 	std_logic );
	end component;
end package multi4;



library ieee ;
use ieee.std_logic_1164.all ;

entity multiplexer_4_to_1 is
	port (	p0, p1, p2, p3	: in 	std_logic;
			s				: in 	std_logic_vector;
			f				: out 	std_logic );
end multiplexer_4_to_1;

architecture structure of multiplexer_4_to_1 is	
begin
	with s select
		f <= 	p0 when "00",
				p1 when "01",
				p2 when "10",
				p3 when others;
end structure;