library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity TB_Mux_2_way_3_bit is
end TB_Mux_2_way_3_bit;

architecture Behavioral of TB_Mux_2_way_3_bit is
    component Mux_2_way_3_bit
        Port ( D0 : in STD_LOGIC_VECTOR (2 downto 0);
               D1 : in STD_LOGIC_VECTOR (2 downto 0);
               S  : in STD_LOGIC;
               Y  : out STD_LOGIC_VECTOR (2 downto 0));
    end component;

    signal D0, D1, Y : STD_LOGIC_VECTOR (2 downto 0);
    signal S : STD_LOGIC;

begin
    UUT: Mux_2_way_3_bit port map (D0 => D0, D1 => D1, S => S, Y => Y);

    stim_proc: process
    begin
        D0 <= "010";
        D1 <= "101";
        
        S <= '0';
        wait for 20 ns;
        
        S <= '1';
        wait for 20 ns;
        
        wait;
    end process;
end Behavioral;