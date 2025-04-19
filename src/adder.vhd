library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;
use work.FIR_Pkg.all;

entity adder is
    Generic (
        N : integer := 5
    );
    Port (
        data_in : in integer_array;
        result  : out unsigned(11 downto 0)
    );
end adder;

architecture arch_adder of adder is

    --signal sum: unsigned(29 downto 0);
    signal sum: integer;
begin
    process(data_in)
    begin
        --sum <= to_unsigned(0,12);
        sum <= 0;
        for i in 0 to N-1 loop
            sum <= sum + data_in(i);
        end loop;
        result <= to_unsigned(sum,12);
    end process;
end arch_adder;
