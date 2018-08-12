# 
# Synthesis run script generated by Vivado
# 

set_msg_config -id {HDL 9-1061} -limit 100000
set_msg_config -id {HDL 9-1654} -limit 100000
set_msg_config -msgmgr_mode ooc_run
create_project -in_memory -part xc7a35tcpg236-1

set_param project.singleFileAddWarning.threshold 0
set_param project.compositeFile.enableAutoGeneration 0
set_param synth.vivado.isSynthRun true
set_msg_config -source 4 -id {IP_Flow 19-2162} -severity warning -new_severity info
set_property webtalk.parent_dir D:/Programs/Developing/Dig2_Pong_Joostens_Tomek/Dig2_Pong_Joostens_Tomek.cache/wt [current_project]
set_property parent.project_path D:/Programs/Developing/Dig2_Pong_Joostens_Tomek/Dig2_Pong_Joostens_Tomek.xpr [current_project]
set_property XPM_LIBRARIES {XPM_CDC XPM_MEMORY} [current_project]
set_property default_lib xil_defaultlib [current_project]
set_property target_language VHDL [current_project]
set_property ip_output_repo d:/Programs/Developing/Dig2_Pong_Joostens_Tomek/Dig2_Pong_Joostens_Tomek.cache/ip [current_project]
set_property ip_cache_permissions {read write} [current_project]
read_ip -quiet D:/Programs/Developing/Dig2_Pong_Joostens_Tomek/Dig2_Pong_Joostens_Tomek.srcs/sources_1/ip/blk_mem_gen_ball/blk_mem_gen_ball.xci
set_property is_locked true [get_files D:/Programs/Developing/Dig2_Pong_Joostens_Tomek/Dig2_Pong_Joostens_Tomek.srcs/sources_1/ip/blk_mem_gen_ball/blk_mem_gen_ball.xci]

foreach dcp [get_files -quiet -all *.dcp] {
  set_property used_in_implementation false $dcp
}
read_xdc dont_touch.xdc
set_property used_in_implementation false [get_files dont_touch.xdc]

set cached_ip [config_ip_cache -export -no_bom -use_project_ipc -dir D:/Programs/Developing/Dig2_Pong_Joostens_Tomek/Dig2_Pong_Joostens_Tomek.runs/blk_mem_gen_ball_synth_1 -new_name blk_mem_gen_ball -ip [get_ips blk_mem_gen_ball]]

if { $cached_ip eq {} } {

synth_design -top blk_mem_gen_ball -part xc7a35tcpg236-1 -mode out_of_context

#---------------------------------------------------------
# Generate Checkpoint/Stub/Simulation Files For IP Cache
#---------------------------------------------------------
catch {
 write_checkpoint -force -noxdef -rename_prefix blk_mem_gen_ball_ blk_mem_gen_ball.dcp

 set ipCachedFiles {}
 write_verilog -force -mode synth_stub -rename_top decalper_eb_ot_sdeen_pot_pi_dehcac_xnilix -prefix decalper_eb_ot_sdeen_pot_pi_dehcac_xnilix_ blk_mem_gen_ball_stub.v
 lappend ipCachedFiles blk_mem_gen_ball_stub.v

 write_vhdl -force -mode synth_stub -rename_top decalper_eb_ot_sdeen_pot_pi_dehcac_xnilix -prefix decalper_eb_ot_sdeen_pot_pi_dehcac_xnilix_ blk_mem_gen_ball_stub.vhdl
 lappend ipCachedFiles blk_mem_gen_ball_stub.vhdl

 write_verilog -force -mode funcsim -rename_top decalper_eb_ot_sdeen_pot_pi_dehcac_xnilix -prefix decalper_eb_ot_sdeen_pot_pi_dehcac_xnilix_ blk_mem_gen_ball_sim_netlist.v
 lappend ipCachedFiles blk_mem_gen_ball_sim_netlist.v

 write_vhdl -force -mode funcsim -rename_top decalper_eb_ot_sdeen_pot_pi_dehcac_xnilix -prefix decalper_eb_ot_sdeen_pot_pi_dehcac_xnilix_ blk_mem_gen_ball_sim_netlist.vhdl
 lappend ipCachedFiles blk_mem_gen_ball_sim_netlist.vhdl

 config_ip_cache -add -dcp blk_mem_gen_ball.dcp -move_files $ipCachedFiles -use_project_ipc -ip [get_ips blk_mem_gen_ball]
}

rename_ref -prefix_all blk_mem_gen_ball_

write_checkpoint -force -noxdef blk_mem_gen_ball.dcp

catch { report_utilization -file blk_mem_gen_ball_utilization_synth.rpt -pb blk_mem_gen_ball_utilization_synth.pb }

if { [catch {
  file copy -force D:/Programs/Developing/Dig2_Pong_Joostens_Tomek/Dig2_Pong_Joostens_Tomek.runs/blk_mem_gen_ball_synth_1/blk_mem_gen_ball.dcp D:/Programs/Developing/Dig2_Pong_Joostens_Tomek/Dig2_Pong_Joostens_Tomek.srcs/sources_1/ip/blk_mem_gen_ball/blk_mem_gen_ball.dcp
} _RESULT ] } { 
  send_msg_id runtcl-3 error "ERROR: Unable to successfully create or copy the sub-design checkpoint file."
  error "ERROR: Unable to successfully create or copy the sub-design checkpoint file."
}

if { [catch {
  write_verilog -force -mode synth_stub D:/Programs/Developing/Dig2_Pong_Joostens_Tomek/Dig2_Pong_Joostens_Tomek.srcs/sources_1/ip/blk_mem_gen_ball/blk_mem_gen_ball_stub.v
} _RESULT ] } { 
  puts "CRITICAL WARNING: Unable to successfully create a Verilog synthesis stub for the sub-design. This may lead to errors in top level synthesis of the design. Error reported: $_RESULT"
}

if { [catch {
  write_vhdl -force -mode synth_stub D:/Programs/Developing/Dig2_Pong_Joostens_Tomek/Dig2_Pong_Joostens_Tomek.srcs/sources_1/ip/blk_mem_gen_ball/blk_mem_gen_ball_stub.vhdl
} _RESULT ] } { 
  puts "CRITICAL WARNING: Unable to successfully create a VHDL synthesis stub for the sub-design. This may lead to errors in top level synthesis of the design. Error reported: $_RESULT"
}

if { [catch {
  write_verilog -force -mode funcsim D:/Programs/Developing/Dig2_Pong_Joostens_Tomek/Dig2_Pong_Joostens_Tomek.srcs/sources_1/ip/blk_mem_gen_ball/blk_mem_gen_ball_sim_netlist.v
} _RESULT ] } { 
  puts "CRITICAL WARNING: Unable to successfully create the Verilog functional simulation sub-design file. Post-Synthesis Functional Simulation with this file may not be possible or may give incorrect results. Error reported: $_RESULT"
}

if { [catch {
  write_vhdl -force -mode funcsim D:/Programs/Developing/Dig2_Pong_Joostens_Tomek/Dig2_Pong_Joostens_Tomek.srcs/sources_1/ip/blk_mem_gen_ball/blk_mem_gen_ball_sim_netlist.vhdl
} _RESULT ] } { 
  puts "CRITICAL WARNING: Unable to successfully create the VHDL functional simulation sub-design file. Post-Synthesis Functional Simulation with this file may not be possible or may give incorrect results. Error reported: $_RESULT"
}


} else {


if { [catch {
  file copy -force D:/Programs/Developing/Dig2_Pong_Joostens_Tomek/Dig2_Pong_Joostens_Tomek.runs/blk_mem_gen_ball_synth_1/blk_mem_gen_ball.dcp D:/Programs/Developing/Dig2_Pong_Joostens_Tomek/Dig2_Pong_Joostens_Tomek.srcs/sources_1/ip/blk_mem_gen_ball/blk_mem_gen_ball.dcp
} _RESULT ] } { 
  send_msg_id runtcl-3 error "ERROR: Unable to successfully create or copy the sub-design checkpoint file."
  error "ERROR: Unable to successfully create or copy the sub-design checkpoint file."
}

if { [catch {
  file rename -force D:/Programs/Developing/Dig2_Pong_Joostens_Tomek/Dig2_Pong_Joostens_Tomek.runs/blk_mem_gen_ball_synth_1/blk_mem_gen_ball_stub.v D:/Programs/Developing/Dig2_Pong_Joostens_Tomek/Dig2_Pong_Joostens_Tomek.srcs/sources_1/ip/blk_mem_gen_ball/blk_mem_gen_ball_stub.v
} _RESULT ] } { 
  puts "CRITICAL WARNING: Unable to successfully create a Verilog synthesis stub for the sub-design. This may lead to errors in top level synthesis of the design. Error reported: $_RESULT"
}

if { [catch {
  file rename -force D:/Programs/Developing/Dig2_Pong_Joostens_Tomek/Dig2_Pong_Joostens_Tomek.runs/blk_mem_gen_ball_synth_1/blk_mem_gen_ball_stub.vhdl D:/Programs/Developing/Dig2_Pong_Joostens_Tomek/Dig2_Pong_Joostens_Tomek.srcs/sources_1/ip/blk_mem_gen_ball/blk_mem_gen_ball_stub.vhdl
} _RESULT ] } { 
  puts "CRITICAL WARNING: Unable to successfully create a VHDL synthesis stub for the sub-design. This may lead to errors in top level synthesis of the design. Error reported: $_RESULT"
}

if { [catch {
  file rename -force D:/Programs/Developing/Dig2_Pong_Joostens_Tomek/Dig2_Pong_Joostens_Tomek.runs/blk_mem_gen_ball_synth_1/blk_mem_gen_ball_sim_netlist.v D:/Programs/Developing/Dig2_Pong_Joostens_Tomek/Dig2_Pong_Joostens_Tomek.srcs/sources_1/ip/blk_mem_gen_ball/blk_mem_gen_ball_sim_netlist.v
} _RESULT ] } { 
  puts "CRITICAL WARNING: Unable to successfully create the Verilog functional simulation sub-design file. Post-Synthesis Functional Simulation with this file may not be possible or may give incorrect results. Error reported: $_RESULT"
}

if { [catch {
  file rename -force D:/Programs/Developing/Dig2_Pong_Joostens_Tomek/Dig2_Pong_Joostens_Tomek.runs/blk_mem_gen_ball_synth_1/blk_mem_gen_ball_sim_netlist.vhdl D:/Programs/Developing/Dig2_Pong_Joostens_Tomek/Dig2_Pong_Joostens_Tomek.srcs/sources_1/ip/blk_mem_gen_ball/blk_mem_gen_ball_sim_netlist.vhdl
} _RESULT ] } { 
  puts "CRITICAL WARNING: Unable to successfully create the VHDL functional simulation sub-design file. Post-Synthesis Functional Simulation with this file may not be possible or may give incorrect results. Error reported: $_RESULT"
}

}; # end if cached_ip 

if {[file isdir D:/Programs/Developing/Dig2_Pong_Joostens_Tomek/Dig2_Pong_Joostens_Tomek.ip_user_files/ip/blk_mem_gen_ball]} {
  catch { 
    file copy -force D:/Programs/Developing/Dig2_Pong_Joostens_Tomek/Dig2_Pong_Joostens_Tomek.srcs/sources_1/ip/blk_mem_gen_ball/blk_mem_gen_ball_stub.v D:/Programs/Developing/Dig2_Pong_Joostens_Tomek/Dig2_Pong_Joostens_Tomek.ip_user_files/ip/blk_mem_gen_ball
  }
}

if {[file isdir D:/Programs/Developing/Dig2_Pong_Joostens_Tomek/Dig2_Pong_Joostens_Tomek.ip_user_files/ip/blk_mem_gen_ball]} {
  catch { 
    file copy -force D:/Programs/Developing/Dig2_Pong_Joostens_Tomek/Dig2_Pong_Joostens_Tomek.srcs/sources_1/ip/blk_mem_gen_ball/blk_mem_gen_ball_stub.vhdl D:/Programs/Developing/Dig2_Pong_Joostens_Tomek/Dig2_Pong_Joostens_Tomek.ip_user_files/ip/blk_mem_gen_ball
  }
}
