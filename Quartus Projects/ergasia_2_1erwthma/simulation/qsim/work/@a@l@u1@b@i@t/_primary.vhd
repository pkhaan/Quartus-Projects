library verilog;
use verilog.vl_types.all;
entity ALU1BIT is
    port(
        a               : in     vl_logic;
        b               : in     vl_logic;
        Ainvert         : in     vl_logic;
        Binvert         : in     vl_logic;
        Cin             : in     vl_logic;
        Operation       : in     vl_logic_vector(1 downto 0);
        Cout            : out    vl_logic;
        Result          : out    vl_logic
    );
end ALU1BIT;
