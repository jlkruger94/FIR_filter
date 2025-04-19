library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;
use IEEE.math_real.all;
use work.FIR_Pkg.all;

entity FIR_Notch is
    Port (
        clk    : in  std_logic;
        rst    : in  std_logic;
        x_in   : in  unsigned(11 downto 0);
        y_out  : out unsigned(11 downto 0)
    );
end FIR_Notch;

architecture arch_FIR_Noch of FIR_Notch is

    constant N : integer := 20;
    -- Coeficientes del filtro notch
    constant rom : integer_array := (0, 5, 2974, 47, -11630, -391, 22966, 1236, -30714, -2672, 26213, 4604, 0, -6712, -55970, 8438, 145717, -9023, -266603, 7608);
    -- Señales internas
    signal x_samples : unsigned_array;
    signal products  : integer_array;
begin

    SHIFT_REG: entity work.shift_register
        generic map (N => N)
        port map (
            clk         => clk,
            rst         => rst,
            sample      => x_in,
            regs_out    => x_samples
        );

    gen_mult: for i in 0 to N-1 generate
        MULTi: entity work.multiplier
            port map (
                sample => x_samples(i),
                coeff  => rom(i),
                result => products(i)
            );
    end generate;

    SUM: entity work.adder
        generic map (N => N)
        port map (
            data_in => products,
            result  => y_out
        );

end arch_FIR_Noch;
