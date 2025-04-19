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
    signal sum_s : signed(23 downto 0); -- más bits para evitar truncamiento
begin
    process(data_in)
        variable acc : integer := 0;
    begin
        acc := 0;
        for i in 0 to N-1 loop
            acc := acc + data_in(i);
        end loop;

        -- Normalización
        sum_s <= shift_right(to_signed(acc, 24), 11);

        -- Ajuste de escala y conversión a unsigned para salida
        result <= unsigned(resize(sum_s, 12));
    end process;
end arch_adder;
