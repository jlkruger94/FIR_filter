library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;
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
    constant N : integer := 59;

    -- Array de coeficientes normalizados por 2 a la 11
    constant rom : integer_array := (
        0, 0, 0, 0, 0, 1, -1, -1, 2, 0, -5, 4, 5, -10, 0, 16, -13, -15, 31, 0, -46, 35, 43, -87, 0, 143, -122, -188, 617, 1229, 617, -188, -122, 143, 0, -87, 43, 35, -46, 0, 31, -15, -13, 16, 0, -10, 5, 4, -5, 0, 2, -1, -1, 1, 0, 0, 0, 0, 0
    );

    signal x_signed   : signed(11 downto 0);
    signal x_samples  : signed_array;
    signal products   : integer_array;
    signal y_signed   : signed(11 downto 0);
begin

    --x_signed <= signed(x_in);
    -- unsigned to signed
    x_signed <= signed(x_in) - to_signed(2048, 12);

    SHIFT_REG: entity work.shift_register
        generic map (N => N)
        port map (
            clk      => clk,
            rst      => rst,
            sample   => x_signed,
            regs_out => x_samples
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
