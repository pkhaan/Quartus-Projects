onerror {quit -f}
vlib work
vlog -work work ALU1BIT.vo
vlog -work work ALU1BIT.vt
vsim -novopt -c -t 1ps -L cycloneii_ver -L altera_ver -L altera_mf_ver -L 220model_ver -L sgate work.ALU1BIT_vlg_vec_tst
vcd file -direction ALU1BIT.msim.vcd
vcd add -internal ALU1BIT_vlg_vec_tst/*
vcd add -internal ALU1BIT_vlg_vec_tst/i1/*
add wave /*
run -all
