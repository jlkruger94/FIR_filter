library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;
use work.FIR_Pkg.all;

entity shift_register is
    Generic (
        N : integer := 5
    );
    Port (
        clk         : in  std_logic;
        rst         : in  std_logic;
        sample      : in  unsigned;
        regs_out    : out unsigned_array
    );
end shift_register;

architecture arch_shift_register of shift_register is
    signal regs : unsigned_array := (others => to_unsigned(0,12));
begin
    process(clk, rst)
    begin
        if rising_edge(clk) then
            if rst = '1' then
                regs <= (others => to_unsigned(0,12));
            else
                for i in N-1 downto 1 loop
                    regs(i) <= regs(i-1);
                end loop;
                regs(0) <= sample;
            end if;
        end if;
    end process;
    
    regs_out <= regs;
end arch_shift_register;
