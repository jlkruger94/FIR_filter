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
    constant N : integer := 99;

    -- Array de coeficientes normalizados por 2 a la 11
    constant rom : integer_array := (0,
    0,
    1,
    1,
    1,
    0,
    -1,
    -3,
    -4,
    -1,
    2,
    6,
    7,
    4,
    -3,
    -9,
    -10,
    -6,
    2,
    8,
    9,
    5,
    0,
    -2,
    0,
    3,
    1,
    -9,
    -19,
    -21,
    -6,
    22,
    48,
    51,
    21,
    -33,
    -80,
    -89,
    -44,
    35,
    107,
    126,
    74,
    -27,
    -122,
    -154,
    -101,
    10,
    119,
    2212,
    119,
    10,
    -101,
    -153,
    -120,
    -27,
    73,
    124,
    105,
    34,
    -44,
    -86,
    -78,
    -32,
    20,
    49,
    46,
    21,
    -6,
    -20,
    -18,
    -8,
    0,
    3,
    0,
    -2,
    0,
    5,
    8,
    7,
    2,
    -5,
    -9,
    -8,
    -3,
    3,
    6,
    6,
    2,
    -1,
    -3,
    -3,
    -1,
    0,
    1,
    1,
    1,
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
