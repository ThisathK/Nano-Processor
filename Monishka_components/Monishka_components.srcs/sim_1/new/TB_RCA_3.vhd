library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity TB_RCA_3 is
end TB_RCA_3;

architecture Behavioral of TB_RCA_3 is
    component RCA_3
        Port ( A : in STD_LOGIC_VECTOR (2 downto 0);
               B : in STD_LOGIC_VECTOR (2 downto 0);
               C_in : in STD_LOGIC;
               S : out STD_LOGIC_VECTOR (2 downto 0);
               C_out : out STD_LOGIC);
    end component;

    signal A, B, S : STD_LOGIC_VECTOR (2 downto 0);
    signal C_in, C_out : STD_LOGIC;

begin
    UUT: RCA_3 port map (
        A => A, 
        B => B, 
        C_in => C_in, 
        S => S, 
        C_out => C_out
    );

    stim_proc: process
    begin
        -- Set up the adder to act as an incrementer (+1)
        B <= "001";
        C_in <= '0';
        
        -- Test incrementing from 0 (000 + 001)
        A <= "000";
        wait for 20 ns;
        
        -- Test incrementing from 1 (001 + 001)
        A <= "001";
        wait for 20 ns;
        
        -- Test incrementing from 3 (011 + 001)
        A <= "011";
        wait for 20 ns;
        
        -- Test incrementing from 7 (111 + 001) -> Should roll over to 000 with C_out = '1'
        A <= "111";
        wait for 20 ns;

        wait;
    end process;
end Behavioral;