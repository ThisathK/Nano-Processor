library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity Mux_2_way_3_bit is
    Port ( D0 : in STD_LOGIC_VECTOR (2 downto 0);
           D1 : in STD_LOGIC_VECTOR (2 downto 0);
           S  : in STD_LOGIC;
           Y  : out STD_LOGIC_VECTOR (2 downto 0));
end Mux_2_way_3_bit;

architecture Behavioral of Mux_2_way_3_bit is
begin
    Y <= D0 when S = '0' else D1;
end Behavioral;