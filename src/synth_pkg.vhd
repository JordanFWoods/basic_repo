------------------------------------------------
-- Proprietary Property of:
--
-- Jordan Woods
-- 312 Calle Bonita
-- Escondido CA, 92029
--
------------------------------------------------
-- Title: Synthesis Package
--
-- File Name: synth_pkg.vhd
--
-- Author: Jordan Woods
--
-- HDL: VHDL-2008
--
-- Description: This is a generic design package that
-- will be seen by both the design and verification side. 
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

library osvvm;
context osvvm.OsvvmContext;

------------------------------------------------
-- package: synth_pkg
package synth_pkg is
   ---------------------------
   -- Constant Declarations --
   ---------------------------
   constant C_BYTE  : natural := 8;
   constant C_WORD  : natural := 16;
   constant C_DWORD : natural := 32;

   -------------------------
   -- Record Declarations --
   -------------------------
   type synth_rec is record
      a : std_logic;
      b : std_logic;
      c : std_logic;
      d : std_logic;
   end record synth_rec;

   ----------------------------
   -- Component Declarations --
   ----------------------------

end synth_pkg;
