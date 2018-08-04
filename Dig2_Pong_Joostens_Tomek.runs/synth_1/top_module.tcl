# 
# Synthesis run script generated by Vivado
# 

set_msg_config -id {HDL 9-1061} -limit 100000
set_msg_config -id {HDL 9-1654} -limit 100000
create_project -in_memory -part xc7a35tcpg236-1

set_param project.singleFileAddWarning.threshold 0
set_param project.compositeFile.enableAutoGeneration 0
set_param synth.vivado.isSynthRun true
set_property webtalk.parent_dir D:/Programs/Developing/Dig2_Pong_Joostens_Tomek/Dig2_Pong_Joostens_Tomek.cache/wt [current_project]
set_property parent.project_path D:/Programs/Developing/Dig2_Pong_Joostens_Tomek/Dig2_Pong_Joostens_Tomek.xpr [current_project]
set_property default_lib xil_defaultlib [current_project]
set_property target_language VHDL [current_project]
set_property ip_output_repo d:/Programs/Developing/Dig2_Pong_Joostens_Tomek/Dig2_Pong_Joostens_Tomek.cache/ip [current_project]
set_property ip_cache_permissions {read write} [current_project]
read_vhdl -library xil_defaultlib D:/Programs/Developing/Dig2_Pong_Joostens_Tomek/Dig2_Pong_Joostens_Tomek.srcs/sources_1/new/top_module.vhd
foreach dcp [get_files -quiet -all *.dcp] {
  set_property used_in_implementation false $dcp
}
read_xdc D:/Programs/Basys3_Master.xdc
set_property used_in_implementation false [get_files D:/Programs/Basys3_Master.xdc]


synth_design -top top_module -part xc7a35tcpg236-1


write_checkpoint -force -noxdef top_module.dcp

catch { report_utilization -file top_module_utilization_synth.rpt -pb top_module_utilization_synth.pb }
