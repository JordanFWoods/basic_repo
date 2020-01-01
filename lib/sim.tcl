quietly set LIB [pwd]
quietly cd ../sim
quietly set SIM [pwd]
quietly cd $LIB

puts "Determine Scenario Name."
quietly set rm_brace [split $argv \}]
quietly set args [regexp -all -inline {\S+} [lindex $rm_brace 0]]
quietly set ind [llength $args]
quietly set tcb_name [lindex $args [expr {$ind-1}]]

echo $tcb_name

quietly set top_level sim_lib.testbench
quietly set wave_patterns {
                           /*
}
quietly set wave_radices {
                           hexadecimal {data q}
}

#Does this installation support Tk?
quietly set tk_ok 1
quietly if [catch {package require Tk}] {set tk_ok 0}

# Load the simulation
quietly set tcb_path ../sim/scen/tcb_$tcb_name.vhd
vcom -reportprogress 300 -2008 -work sim_lib $tcb_path

file mkdir  ./results/
vsim $top_level -voptargs=+acc +nowarn8683 \
    -wlf ./results/$tcb_name.wlf \
    -l   ./results/$tcb_name.log 

# Run the simulation
onbreak {resume}
log -r /*
coverage save -onexit ./results/loopback.ucdb
quietly set IgnoreWarning 1
run 1
quietly set IgnoreWarning 0
run -all
simstats

# If waves are required
if [llength $wave_patterns] {
  if $tk_ok {wave zoomfull}
}
quit