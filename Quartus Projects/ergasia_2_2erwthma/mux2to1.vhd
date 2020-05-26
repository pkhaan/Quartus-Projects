library ieee;
use ieee.std_logic_1164.all;
package MUX2_TO_1 is
--Πολυπλέκτης 2 to 1 Δήλωση::::--
 component myMUX2_TO_1
            port (w0, w1, s: in std_logic; f: out std_logic);
     end component;
end package MUX2_TO_1;

	 library ieee;
use ieee.std_logic_1164.all;



--MULTIPLEXER--
 entity myMUX2_TO_1 is
           
           port (w0, w1, s: in std_logic; f: out std_logic);
     end myMUX2_TO_1;
     architecture model_concM of myMUX2_TO_1 is
           begin
                
			 f <= w0 WHEN s = '0' ELSE w1 ; --συνθήκη When για έλεγχο σημάτων
					 
     end model_concM;