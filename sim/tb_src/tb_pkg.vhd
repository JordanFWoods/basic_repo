------------------------------------------------
-- Proprietary Property of:
--
-- Jordan Woods
-- 312 Calle Bonita
-- Escondido CA, 92029
--
------------------------------------------------
-- Title: Testbench Package
--
-- File Name: tb_pkg.vhd
--
-- Author: Jordan Woods
--
-- HDL: VHDL-2008
--
-- Description: This is the specific Testbench
-- package for this testbench environment.
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
-- package: testbench package
package tb_pkg is
   ---------------------------
   -- Constant Declarations --
   ---------------------------
   constant C_UNUSED  : natural := 0;
end package tb_pkg;
