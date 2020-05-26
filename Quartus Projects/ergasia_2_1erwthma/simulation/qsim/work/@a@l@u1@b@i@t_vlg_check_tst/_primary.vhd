library verilog;
use verilog.vl_types.all;
entity ALU1BIT_vlg_check_tst is
    port(
        Cout            : in     vl_logic;
        Result          : in     vl_logic;
        sampler_rx      : in     vl_logic
    );
end ALU1BIT_vlg_check_tst;
