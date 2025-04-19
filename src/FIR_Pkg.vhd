library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;	

package FIR_Pkg is
    constant N : integer := 20;
    type unsigned_array is array (0 to N-1) of unsigned(11 downto 0);
    type integer_array is array (0 to N-1) of integer;
end FIR_Pkg;
