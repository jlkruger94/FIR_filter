library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity multiplier is
    Port (
        clk    : in std_logic;
        ena    : in std_logic;
        sample : in signed(11 downto 0);
        coeff  : in integer;
        result : out integer
    );
end multiplier;

architecture arch_multiplier of multiplier is
begin
    process(ena, clk)
    begin
        result <= to_integer(sample) * coeff;
    end process;
end arch_multiplier;
