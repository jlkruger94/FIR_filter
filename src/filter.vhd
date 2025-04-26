library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;
use work.FIR_Pkg.all;

entity FIR_Notch is
    Port (
        clk     : in  std_logic;
        rst     : in  std_logic;
        ena     : in  std_logic;
        x_in    : in  unsigned(11 downto 0);
        y_out   : out unsigned(11 downto 0)
    );
end FIR_Notch;

architecture arch_FIR_Noch of FIR_Notch is
    constant N : integer := 59;

    -- Array de coeficientes normalizados por 2 a la 11
    constant rom : integer_array := (0,
    0,
    0,
    0,
    0,
    1,
    1,
    1,
    1,
    0,
    -1,
    -4,
    -7,
    -10,
    -14,
    -16,
    -17,
    -15,
    -10,
    0,
    15,
    35,
    59,
    87,
    116,
    143,
    168,
    188,
    201,
    205,
    201,
    188,
    168,
    143,
    116,
    87,
    59,
    35,
    15,
    0,
    -10,
    -15,
    -17,
    -16,
    -14,
    -10,
    -7,
    -4,
    -1,
    0,
    1,
    1,
    1,
    1,
    0,
    0,
    0,
    0,
    0
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
            ena      => ena,
            sample   => x_signed,
            regs_out => x_samples
        );

    gen_mult: for i in 0 to N-1 generate
        MULTi: entity work.multiplier
            port map (
                clk    => clk,
                ena    => ena,
                sample => x_samples(i),
                coeff  => rom(i),
                result => products(i)
            );
    end generate;

    SUM: entity work.adder
        generic map (N => N)
        port map (
            clk     => clk,
            ena     => ena,
            data_in => products,
            result  => y_out
        );
end arch_FIR_Noch;
