------------------------------------------------
-- Proprietary Property of:
--
-- Jordan Woods
-- 312 Calle Bonita
-- Escondido CA, 92029
--
------------------------------------------------
-- Title: BFM Package
--
-- File Name: bfm_pkg.vhd
--
-- Author: Jordan Woods
--
-- HDL: VHDL-2008
--
-- Description: This is the bfm package for the
-- generic bfm.
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

library synth_lib;
use synth_lib.synth_pkg.all;

library osvvm;
context osvvm.OsvvmContext;

------------------------------------------------
-- entity: generic bfm package
-- ADD COMMENT HERE.

package bfm_pkg is

   ---------------------------
   -- Constant Declarations --
   ---------------------------
   constant gen_zeros   : std_logic_vector(C_DWORD-1 downto 0) := (others => '0');

   -----------------------
   -- Type Declarations --
   -----------------------
   type to_tcb is record
      rdy       : std_logic;
   end record to_tcb;
   constant init_to_tcb : to_tcb := (rdy => 'Z');

   type from_tcb is record
      req       : std_logic;
      temp_vect : std_logic_vector(C_DWORD-1 downto 0);
   end record from_tcb;
   constant init_from_tcb : from_tcb :=
         (req      => 'L',
         temp_vect => (others => 'Z')); 
   
   type bfm_xcvr_rec is record
      toTCB   : to_tcb;
      fromTCB : from_tcb;
   end record bfm_xcvr_rec;
   constant init_bfm_xcvr : bfm_xcvr_rec := 
         (toTCB => init_to_tcb,
        fromTCB => init_from_tcb);

   -----------------------------
   -- SubRoutine Declarations --
   -----------------------------

   end package bfm_pkg;

   package body bfm_pkg is 

   end package body bfm_pkg;
 