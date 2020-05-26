onerror {quit -f}
vlib work
vlog -work work proc.vo
vlog -work work proc.vt
vsim -novopt -c -t 1ps -L cycloneiv_ver -L altera_ver -L altera_mf_ver -L 220model_ver -L sgate work.proc_vlg_vec_tst
vcd file -direction proc.msim.vcd
vcd add -internal proc_vlg_vec_tst/*
vcd add -internal proc_vlg_vec_tst/i1/*
add wave /*
run -all
