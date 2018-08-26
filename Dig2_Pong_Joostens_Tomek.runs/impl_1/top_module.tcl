proc start_step { step } {
  set stopFile ".stop.rst"
  if {[file isfile .stop.rst]} {
    puts ""
    puts "*** Halting run - EA reset detected ***"
    puts ""
    puts ""
    return -code error
  }
  set beginFile ".$step.begin.rst"
  set platform "$::tcl_platform(platform)"
  set user "$::tcl_platform(user)"
  set pid [pid]
  set host ""
  if { [string equal $platform unix] } {
    if { [info exist ::env(HOSTNAME)] } {
      set host $::env(HOSTNAME)
    }
  } else {
    if { [info exist ::env(COMPUTERNAME)] } {
      set host $::env(COMPUTERNAME)
    }
  }
  set ch [open $beginFile w]
  puts $ch "<?xml version=\"1.0\"?>"
  puts $ch "<ProcessHandle Version=\"1\" Minor=\"0\">"
  puts $ch "    <Process Command=\".planAhead.\" Owner=\"$user\" Host=\"$host\" Pid=\"$pid\">"
  puts $ch "    </Process>"
  puts $ch "</ProcessHandle>"
  close $ch
}

proc end_step { step } {
  set endFile ".$step.end.rst"
  set ch [open $endFile w]
  close $ch
}

proc step_failed { step } {
  set endFile ".$step.error.rst"
  set ch [open $endFile w]
  close $ch
}

set_msg_config -id {HDL 9-1061} -limit 100000
set_msg_config -id {HDL 9-1654} -limit 100000

start_step init_design
set ACTIVE_STEP init_design
set rc [catch {
  create_msg_db init_design.pb
  set_param xicom.use_bs_reader 1
  set_property design_mode GateLvl [current_fileset]
  set_param project.singleFileAddWarning.threshold 0
  set_property webtalk.parent_dir D:/Programs/Developing/Dig2_Pong_Joostens_Tomek/Dig2_Pong_Joostens_Tomek.cache/wt [current_project]
  set_property parent.project_path D:/Programs/Developing/Dig2_Pong_Joostens_Tomek/Dig2_Pong_Joostens_Tomek.xpr [current_project]
  set_property ip_output_repo D:/Programs/Developing/Dig2_Pong_Joostens_Tomek/Dig2_Pong_Joostens_Tomek.cache/ip [current_project]
  set_property ip_cache_permissions {read write} [current_project]
  set_property XPM_LIBRARIES {XPM_CDC XPM_MEMORY} [current_project]
  add_files -quiet D:/Programs/Developing/Dig2_Pong_Joostens_Tomek/Dig2_Pong_Joostens_Tomek.runs/synth_1/top_module.dcp
  add_files -quiet d:/Programs/Developing/Dig2_Pong_Joostens_Tomek/Dig2_Pong_Joostens_Tomek.srcs/sources_1/ip/blk_mem_gen_paddle2/blk_mem_gen_paddle2.dcp
  set_property netlist_only true [get_files d:/Programs/Developing/Dig2_Pong_Joostens_Tomek/Dig2_Pong_Joostens_Tomek.srcs/sources_1/ip/blk_mem_gen_paddle2/blk_mem_gen_paddle2.dcp]
  add_files -quiet d:/Programs/Developing/Dig2_Pong_Joostens_Tomek/Dig2_Pong_Joostens_Tomek.srcs/sources_1/ip/clk_wiz_0/clk_wiz_0.dcp
  set_property netlist_only true [get_files d:/Programs/Developing/Dig2_Pong_Joostens_Tomek/Dig2_Pong_Joostens_Tomek.srcs/sources_1/ip/clk_wiz_0/clk_wiz_0.dcp]
  add_files -quiet d:/Programs/Developing/Dig2_Pong_Joostens_Tomek/Dig2_Pong_Joostens_Tomek.srcs/sources_1/ip/blk_mem_gen_0/blk_mem_gen_0.dcp
  set_property netlist_only true [get_files d:/Programs/Developing/Dig2_Pong_Joostens_Tomek/Dig2_Pong_Joostens_Tomek.srcs/sources_1/ip/blk_mem_gen_0/blk_mem_gen_0.dcp]
  add_files -quiet d:/Programs/Developing/Dig2_Pong_Joostens_Tomek/Dig2_Pong_Joostens_Tomek.srcs/sources_1/ip/blk_mem_gen_ball/blk_mem_gen_ball.dcp
  set_property netlist_only true [get_files d:/Programs/Developing/Dig2_Pong_Joostens_Tomek/Dig2_Pong_Joostens_Tomek.srcs/sources_1/ip/blk_mem_gen_ball/blk_mem_gen_ball.dcp]
  read_xdc -mode out_of_context -ref clk_wiz_0 -cells inst d:/Programs/Developing/Dig2_Pong_Joostens_Tomek/Dig2_Pong_Joostens_Tomek.srcs/sources_1/ip/clk_wiz_0/clk_wiz_0_ooc.xdc
  set_property processing_order EARLY [get_files d:/Programs/Developing/Dig2_Pong_Joostens_Tomek/Dig2_Pong_Joostens_Tomek.srcs/sources_1/ip/clk_wiz_0/clk_wiz_0_ooc.xdc]
  read_xdc -prop_thru_buffers -ref clk_wiz_0 -cells inst d:/Programs/Developing/Dig2_Pong_Joostens_Tomek/Dig2_Pong_Joostens_Tomek.srcs/sources_1/ip/clk_wiz_0/clk_wiz_0_board.xdc
  set_property processing_order EARLY [get_files d:/Programs/Developing/Dig2_Pong_Joostens_Tomek/Dig2_Pong_Joostens_Tomek.srcs/sources_1/ip/clk_wiz_0/clk_wiz_0_board.xdc]
  read_xdc -ref clk_wiz_0 -cells inst d:/Programs/Developing/Dig2_Pong_Joostens_Tomek/Dig2_Pong_Joostens_Tomek.srcs/sources_1/ip/clk_wiz_0/clk_wiz_0.xdc
  set_property processing_order EARLY [get_files d:/Programs/Developing/Dig2_Pong_Joostens_Tomek/Dig2_Pong_Joostens_Tomek.srcs/sources_1/ip/clk_wiz_0/clk_wiz_0.xdc]
  read_xdc -mode out_of_context -ref blk_mem_gen_0 -cells U0 d:/Programs/Developing/Dig2_Pong_Joostens_Tomek/Dig2_Pong_Joostens_Tomek.srcs/sources_1/ip/blk_mem_gen_0/blk_mem_gen_0_ooc.xdc
  set_property processing_order EARLY [get_files d:/Programs/Developing/Dig2_Pong_Joostens_Tomek/Dig2_Pong_Joostens_Tomek.srcs/sources_1/ip/blk_mem_gen_0/blk_mem_gen_0_ooc.xdc]
  read_xdc -mode out_of_context -ref blk_mem_gen_ball -cells U0 d:/Programs/Developing/Dig2_Pong_Joostens_Tomek/Dig2_Pong_Joostens_Tomek.srcs/sources_1/ip/blk_mem_gen_ball/blk_mem_gen_ball_ooc.xdc
  set_property processing_order EARLY [get_files d:/Programs/Developing/Dig2_Pong_Joostens_Tomek/Dig2_Pong_Joostens_Tomek.srcs/sources_1/ip/blk_mem_gen_ball/blk_mem_gen_ball_ooc.xdc]
  read_xdc D:/Programs/Basys3_Master.xdc
  link_design -top top_module -part xc7a35tcpg236-1
  write_hwdef -file top_module.hwdef
  close_msg_db -file init_design.pb
} RESULT]
if {$rc} {
  step_failed init_design
  return -code error $RESULT
} else {
  end_step init_design
  unset ACTIVE_STEP 
}

start_step opt_design
set ACTIVE_STEP opt_design
set rc [catch {
  create_msg_db opt_design.pb
  opt_design 
  write_checkpoint -force top_module_opt.dcp
  catch { report_drc -file top_module_drc_opted.rpt }
  close_msg_db -file opt_design.pb
} RESULT]
if {$rc} {
  step_failed opt_design
  return -code error $RESULT
} else {
  end_step opt_design
  unset ACTIVE_STEP 
}

start_step place_design
set ACTIVE_STEP place_design
set rc [catch {
  create_msg_db place_design.pb
  implement_debug_core 
  place_design 
  write_checkpoint -force top_module_placed.dcp
  catch { report_io -file top_module_io_placed.rpt }
  catch { report_utilization -file top_module_utilization_placed.rpt -pb top_module_utilization_placed.pb }
  catch { report_control_sets -verbose -file top_module_control_sets_placed.rpt }
  close_msg_db -file place_design.pb
} RESULT]
if {$rc} {
  step_failed place_design
  return -code error $RESULT
} else {
  end_step place_design
  unset ACTIVE_STEP 
}

start_step route_design
set ACTIVE_STEP route_design
set rc [catch {
  create_msg_db route_design.pb
  route_design 
  write_checkpoint -force top_module_routed.dcp
  catch { report_drc -file top_module_drc_routed.rpt -pb top_module_drc_routed.pb -rpx top_module_drc_routed.rpx }
  catch { report_methodology -file top_module_methodology_drc_routed.rpt -rpx top_module_methodology_drc_routed.rpx }
  catch { report_timing_summary -warn_on_violation -max_paths 10 -file top_module_timing_summary_routed.rpt -rpx top_module_timing_summary_routed.rpx }
  catch { report_power -file top_module_power_routed.rpt -pb top_module_power_summary_routed.pb -rpx top_module_power_routed.rpx }
  catch { report_route_status -file top_module_route_status.rpt -pb top_module_route_status.pb }
  catch { report_clock_utilization -file top_module_clock_utilization_routed.rpt }
  close_msg_db -file route_design.pb
} RESULT]
if {$rc} {
  write_checkpoint -force top_module_routed_error.dcp
  step_failed route_design
  return -code error $RESULT
} else {
  end_step route_design
  unset ACTIVE_STEP 
}

start_step write_bitstream
set ACTIVE_STEP write_bitstream
set rc [catch {
  create_msg_db write_bitstream.pb
  set src_rc [catch { 
    puts "source D:/Programs/Developing/Dig2_Pong_Joostens_Tomek/a.tcl"
    source D:/Programs/Developing/Dig2_Pong_Joostens_Tomek/a.tcl
  } _RESULT] 
  if {$src_rc} { 
    send_msg_id runtcl-1 error "$_RESULT"
    send_msg_id runtcl-2 error "sourcing script D:/Programs/Developing/Dig2_Pong_Joostens_Tomek/a.tcl failed"
    return -code error
  }
  set_property XPM_LIBRARIES {XPM_CDC XPM_MEMORY} [current_project]
  catch { write_mem_info -force top_module.mmi }
  write_bitstream -force -no_partial_bitfile top_module.bit 
  catch { write_sysdef -hwdef top_module.hwdef -bitfile top_module.bit -meminfo top_module.mmi -file top_module.sysdef }
  catch {write_debug_probes -quiet -force debug_nets}
  close_msg_db -file write_bitstream.pb
} RESULT]
if {$rc} {
  step_failed write_bitstream
  return -code error $RESULT
} else {
  end_step write_bitstream
  unset ACTIVE_STEP 
}

