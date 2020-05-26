onerror {quit -f}
vlib work
vlog -work work Problem1.vo
vlog -work work Problem1.vt
vsim -novopt -c -t 1ps -L cycloneii_ver -L altera_ver -L altera_mf_ver -L 220model_ver -L sgate work.Problem1_vlg_vec_tst
vcd file -direction Problem1.msim.vcd
vcd add -internal Problem1_vlg_vec_tst/*
vcd add -internal Problem1_vlg_vec_tst/i1/*
add wave /*
run -all
