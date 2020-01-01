------------------------------------------------
-- Proprietary Property of:
--
-- Jordan Woods
-- 312 Calle Bonita
-- Escondido CA, 92029
--
------------------------------------------------
-- Title: Testbench Control Block Entity
--
-- File Name: tcb_e.vhd
--
-- Author: Jordan Woods
--
-- HDL: VHDL-2008
--
-- Description: This is the entity file for
-- each scenario
--
------------------------------------------------
-- Manual Revision History:
-- 12/23/19 - JFW - Initial Check In.
--
------------------------------------------------
-- Libraries:
library std;
use std.standard.all;
use std.textio.all;

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

library work;
use work.tb_pkg.all;
use work.gen_prot.all;

library synth_lib;
use synth_lib.synth_pkg.all;

library gen_bfm_lib;
use gen_bfm_lib.bfm_pkg.all;

library osvvm;
context osvvm.OsvvmContext;

------------------------------------------------
-- entity: Testbench Control Block
entity tcb is
   generic (
      G_SCENARIO : string
   );
   port (
      CLK       : in    std_logic;
      RST       : in    std_logic;
      DONE      : out   std_logic;
      BFM_XCVR  : inout bfm_xcvr_rec
      );
end entity tcb;

