------------------------------------------------
-- Proprietary Property of:
--
-- Jordan Woods
-- 312 Calle Bonita
-- Escondido CA, 92029
--
------------------------------------------------
-- Title: general protected sim package
--
-- File Name: gen_prot.vhd
--
-- Author: Jordan Woods
--
-- HDL: VHDL-2008
--
-- Description: This is a sim package to learn
-- the basics of protected types. This package
-- creates a protected type to allow for
-- returning a string in a function. 
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

library osvvm;
context osvvm.OsvvmContext;

------------------------------------------------
-- package: testbench package
package gen_prot is
   ---------------------------
   -- Constant Declarations --
   ---------------------------
   constant C_UNUSED  : natural := 0;

   type LinePType is protected
      procedure copy (S : in string);
      impure function get (EraseLine : boolean := TRUE) return string;
   end protected LinePType;
   
end package gen_prot;

package body gen_prot is

   type LinePType is protected body
      variable Message : line;
      
      procedure copy ( S : in string) is 
      begin
         deallocate(Message);
         Message := new string'(S);
      end procedure copy;

      impure function get (EraseLine : boolean := TRUE) return string is
         variable value : string (1 to Message'length);
      begin
         value := Message.all;
         if EraseLine then
            deallocate(Message);
         end if;
         return value;
      end function get;
   end protected body LinePType;

end gen_prot;