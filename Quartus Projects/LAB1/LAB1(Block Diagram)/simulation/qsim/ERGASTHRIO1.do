onerror {quit -f}
vlib work
vlog -work work ERGASTHRIO1.vo
vlog -work work ERGASTHRIO1.vt
vsim -novopt -c -t 1ps -L cycloneii_ver -L altera_ver -L altera_mf_ver -L 220model_ver -L sgate work.ERGASTHRIO1_vlg_vec_tst
vcd file -direction ERGASTHRIO1.msim.vcd
vcd add -internal ERGASTHRIO1_vlg_vec_tst/*
vcd add -internal ERGASTHRIO1_vlg_vec_tst/i1/*
add wave /*
run -all