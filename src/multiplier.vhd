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
    signal internal_result : integer;
begin
    process(clk)
    begin
        if rising_edge(clk) then
            if ena = '1' then
                internal_result <= to_integer(sample) * coeff;
            end if;
        end if;
    end process;

    result <= internal_result;
end arch_multiplier;
