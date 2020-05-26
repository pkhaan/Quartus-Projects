library verilog;
use verilog.vl_types.all;
entity ALU16BIT_vlg_sample_tst is
    port(
        a               : in     vl_logic_vector(15 downto 0);
        b               : in     vl_logic_vector(15 downto 0);
        opcode          : in     vl_logic_vector(2 downto 0);
        sampler_tx      : out    vl_logic
    );
end ALU16BIT_vlg_sample_tst;
