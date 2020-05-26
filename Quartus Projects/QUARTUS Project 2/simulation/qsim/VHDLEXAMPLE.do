onerror {quit -f}
vlib work
vlog -work work VHDLEXAMPLE.vo
vlog -work work VHDLEXAMPLE.vt
vsim -novopt -c -t 1ps -L cycloneii_ver -L altera_ver -L altera_mf_ver -L 220model_ver -L sgate work.VHDLEXAMPLE_vlg_vec_tst
vcd file -direction VHDLEXAMPLE.msim.vcd
vcd add -internal VHDLEXAMPLE_vlg_vec_tst/*
vcd add -internal VHDLEXAMPLE_vlg_vec_tst/i1/*
add wave /*
run -all
