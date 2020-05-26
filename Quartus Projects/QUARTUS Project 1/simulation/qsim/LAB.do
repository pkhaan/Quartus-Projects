onerror {quit -f}
vlib work
vlog -work work LAB.vo
vlog -work work LAB.vt
vsim -novopt -c -t 1ps -L cycloneii_ver -L altera_ver -L altera_mf_ver -L 220model_ver -L sgate work.LAB_vlg_vec_tst
vcd file -direction LAB.msim.vcd
vcd add -internal LAB_vlg_vec_tst/*
vcd add -internal LAB_vlg_vec_tst/i1/*
add wave /*
run -all
