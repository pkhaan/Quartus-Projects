onerror {quit -f}
vlib work
vlog -work work ERG1PR3.vo
vlog -work work ERG1PR3.vt
vsim -novopt -c -t 1ps -L cycloneii_ver -L altera_ver -L altera_mf_ver -L 220model_ver -L sgate work.ERG1PR3_vlg_vec_tst
vcd file -direction ERG1PR3.msim.vcd
vcd add -internal ERG1PR3_vlg_vec_tst/*
vcd add -internal ERG1PR3_vlg_vec_tst/i1/*
add wave /*
run -all
