library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;
use IEEE.math_real.all;   -- esta se usa para instanciar la ROM

entity nco_test is
end;

architecture p of nco_test is

	component nco is
		generic(
			DATA_W: natural := 11; -- cantidad de bits del dato + 1
			ADDR_W: natural := 12; -- cantidad de bits de las direcciones de la LUT
			modulo: natural;		-- cantidad de puntos
			PASO_W: natural			-- cantidad de bits del paso
		);
		port(
			clk, rst: in std_logic;
			paso: in unsigned(PASO_W-1 downto 0); -- valor de entrada (paso)
			salida_cos, salida_sen: out unsigned(DATA_W-2 downto 0)
		);
	end component;
	
	constant DATA_W: natural:= 13;
	constant ADDR_W: natural:= 15;
	constant PUNTOS: natural:= (2**ADDR_W)-1;
	constant PASO_W: natural:= 4;
	
	signal clk: std_logic:= '0';
	signal rst: std_logic:= '1';
	signal sin_o: unsigned(DATA_W-2 downto 0);          -- salida del seno (salgo con N-2 bits)
	signal cos_o: unsigned(DATA_W-2 downto 0); 
	signal paso_prueba: unsigned(3 downto 0);
	
begin
	clk <= not clk after 20 ns;
	rst <= '0' after 60 ns;
--	paso_prueba <= "0001";
	paso_prueba <= "0011", "1000" after 1000 us, "1100" after 2000 us, "0001" after 3000 us;
	
	nco_inst: nco
		generic map(
			DATA_W,
			ADDR_W,
			PUNTOS,
			PASO_W
		)
		port map(
			clk,
			'0',
			paso_prueba,
			sin_o,
			cos_o
		);
end;