transcript on
if {[file exists rtl_work]} {
	vdel -lib rtl_work -all
}
vlib rtl_work
vmap work rtl_work

vlog -vlog01compat -work work +incdir+C:/Users/Vitão/Desktop/Codes/LAOC2/projetoMemoriaCache {C:/Users/Vitão/Desktop/Codes/LAOC2/projetoMemoriaCache/memoriaCache.v}
vlog -vlog01compat -work work +incdir+C:/Users/Vitão/Desktop/Codes/LAOC2/projetoMemoriaCache {C:/Users/Vitão/Desktop/Codes/LAOC2/projetoMemoriaCache/memoriaPrincipal.v}

vlog -vlog01compat -work work +incdir+C:/Users/Vitão/Desktop/Codes/LAOC2/projetoMemoriaCache {C:/Users/Vitão/Desktop/Codes/LAOC2/projetoMemoriaCache/teste_memoriaCache.v}

vsim -t 1ps -L altera_ver -L lpm_ver -L sgate_ver -L altera_mf_ver -L altera_lnsim_ver -L cycloneii_ver -L rtl_work -L work -voptargs="+acc"  teste_memoriaCache

add wave *
view structure
view signals
run -all
