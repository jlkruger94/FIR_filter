library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity gen_enable is
    Generic (
        N : integer := 5
    );
    Port (
        clk    : in std_logic;
        ena_o  : out std_logic;
        rst    : in std_logic
    );
end gen_enable;

architecture arch_gen_enable of gen_enable is

    signal ena    : std_logic := '0';
    signal count  : integer range 0 to (N -1) := 0;
begin
    process(clk)
    begin
        if rising_edge(clk) then
            if rst = '1' then
                count <= 0;
                ena_o   <= '0';
            else
                if count = (N -1) then
                    ena_o <= '1';
                    count <= 0;
                else
                ena_o <= '0';
                    count <= count + 1;
                end if;
            end if;
        end if;
    end process;
end arch_gen_enable;

