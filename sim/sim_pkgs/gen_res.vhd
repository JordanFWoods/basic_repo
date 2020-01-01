------------------------------------------------
-- Proprietary Property of:
--
-- Jordan Woods
-- 312 Calle Bonita
-- Escondido CA, 92029
--
------------------------------------------------
-- Title: general resolution sim package
--
-- File Name: gen_res.vhd
--
-- Author: Jordan Woods
--
-- HDL: VHDL-2008
--
-- Description: This is a sim package to learn
-- the basics of resolving types. This package
-- resolves the type 'time', and is largely
-- copied from OSVVM. 
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
-- package: gen resolutions
-- ADD COMMENT HERE.
package gen_res is 

function resolved_max ( s : time_vector ) return time ;            
subtype  time_max is resolved_max time ; 
subtype  time_vector_max is (resolved_max) time_vector ; 
type     time_vector_max_c is array (natural range <>) of time_max ; -- for non VHDL-2008  

function resolved_sum ( s : time_vector ) return time ;            
subtype  time_sum is resolved_sum time ; 
subtype  time_vector_sum is (resolved_sum) time_vector ; 
type     time_vector_sum_c is array (natural range <>) of time_sum ; -- for non VHDL-2008  

function resolved ( s : time_vector ) return time ; 
subtype  resolved_time is resolved time ;

end package gen_res ;

package body gen_res is 
   ------------------------------------------------------------
   function resolved_max ( s : time_vector ) return time is 
   ------------------------------------------------------------
   begin
      return maximum(s) ; 
   end function resolved_max ; 
   ------------------------------------------------------------
   function resolved_sum ( s : time_vector ) return time is 
   ------------------------------------------------------------
      variable result : time := 0 sec ; 
   begin
      for i in s'RANGE loop
      if s(i) /= time'left then 
         result := s(i) + result;
      end if ;
      end loop ;
      return result ; 
   end function resolved_sum ; 


   ------------------------------------------------------------
   function resolved ( s : time_vector ) return time is 
   -- requires interface to be initialized to 0 ns
   ------------------------------------------------------------
      variable result : time := 0 ns ; 
      variable failed : boolean := FALSE ; 
   begin
      for i in s'RANGE loop
         if s(i) > 0 ns then 
            failed := failed or (result /= 0 ns) ;
            result := maximum(s(i),result);
         end if ;
      end loop ;
      assert not failed report "ResolutionPkg.resolved: multiple drivers on time" severity MULTIPLE_DRIVER_SEVERITY ; 
      -- AlertIf(OSVVM_ALERTLOG_ID, failed, "ResolutionPkg.resolved: multiple drivers on time") ; 
      return result ; 
   end function resolved ; 
  
end package body gen_res ;
