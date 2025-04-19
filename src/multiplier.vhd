library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;	

entity multiplier is
    Port (
        sample : in unsigned(11 downto 0);
        coeff  : in integer;
        result : out integer
    );
end multiplier;

architecture arch_multiplier of multiplier is
begin
    process(sample, coeff)
    begin
        --result <= to_integer(unsigned(sample)) * coeff;
        result <= to_integer(sample) * coeff;
    end process;
end arch_multiplier;
