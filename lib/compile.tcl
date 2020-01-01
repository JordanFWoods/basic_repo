puts {
  ModelSimSE general compile script version 1.1
  Copyright (c) Doulos June 2004, SD
}

quietly cd ../
quietly set PROJ [pwd]
quietly set SRC   $PROJ/src
quietly set SIM   $PROJ/sim
quietly set LIB   $PROJ/lib
quietly set OSV   c:/Users/jorda/sandbox/OSVVM
quietly cd $LIB

quietly set library_file_list {
   osvvm     { 
       "../../../OSVVM/NamePkg.vhd"
       "../../../OSVVM/OsvvmGlobalPkg.vhd"
       "../../../OSVVM/VendorCovApiPkg.vhd"
       "../../../OSVVM/TranscriptPkg.vhd"
       "../../../OSVVM/TextUtilPkg.vhd"
       "../../../OSVVM/AlertLogPkg.vhd"
       "../../../OSVVM/MessagePkg.vhd"
       "../../../OSVVM/SortListPkg_int.vhd"
       "../../../OSVVM/RandomBasePkg.vhd"
       "../../../OSVVM/RandomPkg.vhd"
       "../../../OSVVM/CoveragePkg.vhd"
       "../../../OSVVM/MemoryPkg.vhd"
       "../../../OSVVM/ScoreboardGenericPkg.vhd"
       "../../../OSVVM/ScoreboardPkg_slv.vhd"
       "../../../OSVVM/ScoreboardPkg_int.vhd"
       "../../../OSVVM/ResolutionPkg.vhd"
       "../../../OSVVM/TbUtilPkg.vhd"
       "../../../OSVVM/OsvvmContext.vhd"}
   synth_lib { 
       "../src/synth_pkg.vhd"
       "../src/top_pl.vhd"}
   clk_bfm_lib   {
       "../sim/bfm/clk_rst_bfm/clk_rst_bfm.vhd"}
   gen_bfm_lib   {
       "../sim/bfm/gen_bfm/bfm_pkg.vhd"
       "../sim/bfm/gen_bfm/gen_bfm.vhd"}
   sim_lib       {
       "../sim/tb_src/tb_pkg.vhd"
       "../sim/sim_pkgs/gen_prot.vhd"
       "../sim/sim_pkgs/gen_res.vhd"
       "../sim/tb_src/bfm_harness.vhd"       
       "../sim/tb_src/tcb_e.vhd"
       "../sim/tb_src/testbench.vhd"}
}
quietly set top_level              sim_lib.testbench
quietly set wave_patterns {
                           /*
}
quietly set wave_radices {
                           hexadecimal {data q}
}

# After sourcing the script from ModelSim for the
# first time use these commands to recompile.

proc r  {} {uplevel #0 source compile.tcl}
proc rr {} {global last_compile_time
            set last_compile_time 0
            r                            }
proc q  {} {quit -sim -force                  }

# Prefer a fixed point font for the transcript
quietly set PrefMain(font) {Courier 10 roman normal}

# Compile out of date files
quietly set time_now [clock seconds]
if [catch {set last_compile_time}] {
  set last_compile_time 0
}
foreach {library file_list} $library_file_list {
  vlib $library
  vmap work $library
  foreach file $file_list {
    if { $last_compile_time < [file mtime $file] } {
      if [regexp {.vhdl?$} $file] {
        vcom -2008 $file
      } else {
        vlog $file
      }
      set last_compile_time 0
    }
  }
}
set last_compile_time $time_now

puts {
  Script commands are:

  r = Recompile changed and dependent files
 rr = Recompile everything
  q = Quit without confirmation
}

quit