------------------------------------------------
-- Proprietary Property of:
--
-- Jordan Woods
-- 312 Calle Bonita
-- Escondido CA, 92029
--
------------------------------------------------
-- Title: Bus Functional Model Harness
--
-- File Name: bfm_harness.vhd
--
-- Author: Jordan Woods
--
-- HDL: VHDL-2008
--
-- Description: This VHD wraps around the DUT,
-- holds the individual BFMs, and takes orders
-- from the Testbench Control Block (TCB).
--
------------------------------------------------
-- Manual Revision History:
-- 12/23/19 - JFW - Initial Check In.
--
------------------------------------------------
-- Libraries:
library std;
use std.standard.all;

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

library work;
use work.tb_pkg.all;

library synth_lib;
use synth_lib.synth_pkg.all;

library clk_bfm_lib;
use clk_bfm_lib.all;

library gen_bfm_lib;
use gen_bfm_lib.bfm_pkg.all;

library osvvm;
context osvvm.OsvvmContext;

------------------------------------------------
-- entity: bfm_harness
entity bfm_harness is
   port (
      CLK       : out   std_logic;
      RST       : out   std_logic;
      DONE      : in    std_logic;
      TEMP_VECT : out   std_logic_vector(C_DWORD-1 downto 0);
      BFM_XCVR  : inout bfm_xcvr_rec
      );
end entity;

architecture structure of bfm_harness is
   ----------------------------
   -- Component Declarations --
   ----------------------------
   component clk_rst_bfm
   generic (
      CLK_PER    : time := 100 ns;
      RST_SETUP  : time := 0   ns;
      RST_PWIDTH : time := 1   us
   );
   port (
      CLK      : out   std_logic;
      RST      : out   std_logic;
      DONE     : in    std_logic
   );
      end component clk_rst_bfm;

   component gen_bfm
   generic (
      G_GENERIC : boolean := false
   );
   port (
      CLK       : in    std_logic;
      RST       : in    std_logic;
      TEMP_VECT : out   std_logic_vector(C_DWORD-1 downto 0);
      BFM_XCVR  : inout bfm_xcvr_rec
   );
   end component gen_bfm;
   -------------------------
   -- Signal Declarations --
   -------------------------
   signal clk_int : std_logic := '0';
   signal rst_int : std_logic := '0';

   ---------------------------
   -- Constant Declarations --
   ---------------------------

begin

   --------------------------
   -- Asynchronous Actions --
   --------------------------
   CLK <= clk_int;
   RST <= rst_int;

   --------------------------
   -- Clock and Reset BFMs --
   --------------------------
   u0_clk_rst_bfm : clk_rst_bfm
   generic map (
      CLK_PER    => 100 ns,
      RST_SETUP  => 0 ns,
      RST_PWIDTH => 1 us
   )
   port map (
      CLK      => clk_int,
      RST      => rst_int,
      DONE     => DONE
   );

   -----------------
   -- Generic BFM --
   -----------------
   u_gen_bfm : gen_bfm
   generic map (
      G_GENERIC => true
   )
   port map (
      CLK       => clk_int,
      RST       => rst_int,
      TEMP_VECT => TEMP_VECT,
      BFM_XCVR  => BFM_XCVR
   );

end architecture structure;
