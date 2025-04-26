-- Copyright 1986-2018 Xilinx, Inc. All Rights Reserved.
-- --------------------------------------------------------------------------------
-- Tool Version: Vivado v.2018.1 (win64) Build 2188600 Wed Apr  4 18:40:38 MDT 2018
-- Date        : Sat Apr 26 16:10:45 2025
-- Host        : DESKTOP-7JRIDGE running 64-bit major release  (build 9200)
-- Command     : write_vhdl -force -mode synth_stub {e:/Especializacion_fiuba/CLP/trabajo
--               final/FIR/sintesis/filter/filter.srcs/sources_1/ip/vio_0/vio_0_stub.vhdl}
-- Design      : vio_0
-- Purpose     : Stub declaration of top-level module interface
-- Device      : xc7z010clg400-1
-- --------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity vio_0 is
  Port ( 
    clk : in STD_LOGIC;
    probe_out0 : out STD_LOGIC_VECTOR ( 5 downto 0 );
    probe_out1 : out STD_LOGIC_VECTOR ( 5 downto 0 )
  );

end vio_0;

architecture stub of vio_0 is
attribute syn_black_box : boolean;
attribute black_box_pad_pin : string;
attribute syn_black_box of stub : architecture is true;
attribute black_box_pad_pin of stub : architecture is "clk,probe_out0[5:0],probe_out1[5:0]";
attribute X_CORE_INFO : string;
attribute X_CORE_INFO of stub : architecture is "vio,Vivado 2018.1";
begin
end;
