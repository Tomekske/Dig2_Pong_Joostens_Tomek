# 
# Synthesis run script generated by Vivado
# 

set_param xicom.use_bs_reader 1
set_msg_config -id {HDL 9-1061} -limit 100000
set_msg_config -id {HDL 9-1654} -limit 100000
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
add_files D:/Programs/Developing/Dig2_Pong_Joostens_Tomek/Dig2_Pong_Joostens_Tomek.srcs/sources_1/ip/paddle.coe
add_files D:/Programs/Developing/Dig2_Pong_Joostens_Tomek/Dig2_Pong_Joostens_Tomek.srcs/sources_1/ip/ball.coe
add_files D:/Programs/Developing/Dig2_Pong_Joostens_Tomek/Dig2_Pong_Joostens_Tomek.srcs/sources_1/ip/paddle2.coe
add_files -quiet d:/Programs/Developing/Dig2_Pong_Joostens_Tomek/Dig2_Pong_Joostens_Tomek.srcs/sources_1/ip/clk_wiz_0/clk_wiz_0.dcp
set_property used_in_implementation false [get_files d:/Programs/Developing/Dig2_Pong_Joostens_Tomek/Dig2_Pong_Joostens_Tomek.srcs/sources_1/ip/clk_wiz_0/clk_wiz_0.dcp]
add_files -quiet d:/Programs/Developing/Dig2_Pong_Joostens_Tomek/Dig2_Pong_Joostens_Tomek.srcs/sources_1/ip/blk_mem_gen_0/blk_mem_gen_0.dcp
set_property used_in_implementation false [get_files d:/Programs/Developing/Dig2_Pong_Joostens_Tomek/Dig2_Pong_Joostens_Tomek.srcs/sources_1/ip/blk_mem_gen_0/blk_mem_gen_0.dcp]
add_files -quiet d:/Programs/Developing/Dig2_Pong_Joostens_Tomek/Dig2_Pong_Joostens_Tomek.srcs/sources_1/ip/blk_mem_gen_ball/blk_mem_gen_ball.dcp
set_property used_in_implementation false [get_files d:/Programs/Developing/Dig2_Pong_Joostens_Tomek/Dig2_Pong_Joostens_Tomek.srcs/sources_1/ip/blk_mem_gen_ball/blk_mem_gen_ball.dcp]
read_vhdl -library xil_defaultlib {
  D:/Programs/Developing/Dig2_Pong_Joostens_Tomek/Dig2_Pong_Joostens_Tomek.srcs/sources_1/new/count10.vhd
  D:/Programs/Developing/Dig2_Pong_Joostens_Tomek/Dig2_Pong_Joostens_Tomek.srcs/sources_1/new/vga_sprite.vhd
  D:/Programs/Developing/Dig2_Pong_Joostens_Tomek/Dig2_Pong_Joostens_Tomek.srcs/sources_1/new/vga_640x480.vhd
  D:/Programs/Developing/Dig2_Pong_Joostens_Tomek/Dig2_Pong_Joostens_Tomek.srcs/sources_1/new/seg7.vhd
  D:/Programs/Developing/Dig2_Pong_Joostens_Tomek/Dig2_Pong_Joostens_Tomek.srcs/sources_1/new/mux21.vhd
  D:/Programs/Developing/Dig2_Pong_Joostens_Tomek/Dig2_Pong_Joostens_Tomek.srcs/sources_1/new/debounce.vhd
  D:/Programs/Developing/Dig2_Pong_Joostens_Tomek/Dig2_Pong_Joostens_Tomek.srcs/sources_1/new/clock.vhd
  D:/Programs/Developing/Dig2_Pong_Joostens_Tomek/Dig2_Pong_Joostens_Tomek.srcs/sources_1/new/top_module.vhd
}
read_ip -quiet D:/Programs/Developing/Dig2_Pong_Joostens_Tomek/Dig2_Pong_Joostens_Tomek.srcs/sources_1/ip/blk_mem_gen_paddle2/blk_mem_gen_paddle2.xci
set_property used_in_implementation false [get_files -all d:/Programs/Developing/Dig2_Pong_Joostens_Tomek/Dig2_Pong_Joostens_Tomek.srcs/sources_1/ip/blk_mem_gen_paddle2/blk_mem_gen_paddle2_ooc.xdc]
set_property is_locked true [get_files D:/Programs/Developing/Dig2_Pong_Joostens_Tomek/Dig2_Pong_Joostens_Tomek.srcs/sources_1/ip/blk_mem_gen_paddle2/blk_mem_gen_paddle2.xci]

foreach dcp [get_files -quiet -all *.dcp] {
  set_property used_in_implementation false $dcp
}
read_xdc D:/Programs/Basys3_Master.xdc
set_property used_in_implementation false [get_files D:/Programs/Basys3_Master.xdc]

read_xdc dont_touch.xdc
set_property used_in_implementation false [get_files dont_touch.xdc]

synth_design -top top_module -part xc7a35tcpg236-1


write_checkpoint -force -noxdef top_module.dcp

catch { report_utilization -file top_module_utilization_synth.rpt -pb top_module_utilization_synth.pb }
