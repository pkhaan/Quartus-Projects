library verilog;
use verilog.vl_types.all;
entity ALU16BIT is
    port(
        opcode          : in     vl_logic_vector(2 downto 0);
        a               : in     vl_logic_vector(15 downto 0);
        b               : in     vl_logic_vector(15 downto 0);
        RESULT          : out    vl_logic_vector(15 downto 0);
        Overflow        : out    vl_logic
    );
end ALU16BIT;
