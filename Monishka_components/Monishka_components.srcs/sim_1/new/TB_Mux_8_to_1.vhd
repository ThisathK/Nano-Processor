library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity TB_Mux_8_to_1 is
end TB_Mux_8_to_1;

architecture Behavioral of TB_Mux_8_to_1 is
    component Mux_8_to_1
        Port (
            D  : in STD_LOGIC_VECTOR (7 downto 0);
            S  : in STD_LOGIC_VECTOR (2 downto 0);
            EN : in STD_LOGIC;
            Y  : out STD_LOGIC
        );
    end component;

    signal D  : STD_LOGIC_VECTOR (7 downto 0);
    signal S  : STD_LOGIC_VECTOR (2 downto 0);
    signal EN : STD_LOGIC;
    signal Y  : STD_LOGIC;

begin
    UUT: Mux_8_to_1 port map (D => D, S => S, EN => EN, Y => Y);

    stim_proc: process
    begin
        EN <= '1';
        D <= "10101010";
        
        S <= "010"; wait for 20 ns;
        S <= "111"; wait for 20 ns;
        
        EN <= '0';
        S <= "010"; wait for 20 ns;
        
        wait;
    end process;
end Behavioral;