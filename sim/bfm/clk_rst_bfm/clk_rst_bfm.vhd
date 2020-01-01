------------------------------------------------
-- Proprietary Property of:
--
-- Jordan Woods
-- 312 Calle Bonita
-- Escondido CA, 92029
--
------------------------------------------------
-- Title: Clocks and Reset BFM.
--
-- File Name: clk_rst_bfm.vhd
--
-- Author: Jordan Woods
--
-- HDL: VHDL-2008
--
-- Description: This is a generic Clock and Reset
-- BFM, and generates a synchronous reset.
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
-- entity: Clock Reset BFM
entity clk_rst_bfm is
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
end entity clk_rst_bfm;

architecture behave of clk_rst_bfm is 
   signal rst_i : std_logic;
   signal clk_i : std_logic;
begin

   CLK <= clk_i;

   proc_clk_i : process is
      variable v_rv   : RandomPType;
      variable vPhase : time := 0 ns;
   begin
      v_rv.InitSeed(clk_rst_bfm'instance_name);
      vPhase := v_rv.RandInt(0, 10) * ns;
      wait for vPhase;
      clock_loop : loop
         clk_i <= '0';
         wait for CLK_PER / 2.0;
         clk_i <= '1';
         wait for CLK_PER / 2.0;
      end loop clock_loop;
   end process proc_clk_i;

   proc_rst_i : process is
   begin
      rst_i <= '0';
      wait for RST_SETUP;
      rst_i <= '1';
      wait for RST_PWIDTH;
      rst_i <= '0';
      wait;
   end process proc_rst_i;

   proc_rst : process (clk_i) is
   begin
      if rising_edge(clk_i) then
         RST <= rst_i;
      end if;
   end process proc_rst;

end architecture behave;
