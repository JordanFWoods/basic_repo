------------------------------------------------
-- Proprietary Property of:
--
-- Jordan Woods
-- 312 Calle Bonita
-- Escondido CA, 92029
--
------------------------------------------------
-- Title: Top-Level Programmable Logic
--
-- File Name: top_pl.vhd
--
-- Author: Jordan Woods
--
-- HDL: VHDL-2008
--
-- Description: Top Level of the Synthesizable core.
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
use work.synth_pkg.all;

library osvvm;
context osvvm.OsvvmContext;

------------------------------------------------
-- entity: Top PL
-- ADD COMMENT HERE.

entity top_pl is
   port (
      CLK       : in std_logic;
      RST       : in std_logic;
      TEMP_VECT : in std_logic_vector(C_DWORD-1 downto 0)
      );
end entity top_pl;

architecture structure of top_pl is

   ----------------------------
   -- Component Declarations --
   ----------------------------

   -------------------------
   -- Signal Declarations --
   -------------------------
   signal r_temp_vect : std_logic_vector(temp_vect'range);

   ---------------------------
   -- Constant Declarations --
   ---------------------------

begin
   --------------------------
   -- Asynchronous Actions --
   --------------------------
   
   -----------------------
   -- Processed Actions --
   -----------------------
   proc_rst : process (CLK) is
      begin
         if rising_edge(CLK) then
            if RST = '1' then 
               r_temp_vect <= (others => 'X');
            else
               r_temp_vect <= TEMP_VECT;
            end if;
         end if;
      end process proc_rst;
      
end architecture structure;
