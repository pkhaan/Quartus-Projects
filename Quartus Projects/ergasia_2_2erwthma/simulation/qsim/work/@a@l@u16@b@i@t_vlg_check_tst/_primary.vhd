library verilog;
use verilog.vl_types.all;
entity ALU16BIT_vlg_check_tst is
    port(
        Overflow        : in     vl_logic;
        RESULT          : in     vl_logic_vector(15 downto 0);
        sampler_rx      : in     vl_logic
    );
end ALU16BIT_vlg_check_tst;
