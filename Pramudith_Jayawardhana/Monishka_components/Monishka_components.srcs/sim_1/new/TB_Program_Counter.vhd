library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity TB_Program_Counter is
end TB_Program_Counter;

architecture Behavioral of TB_Program_Counter is
    component Program_Counter
        Port ( D : in STD_LOGIC_VECTOR (2 downto 0);
               Res : in STD_LOGIC;
               Clk : in STD_LOGIC;
               Q : out STD_LOGIC_VECTOR (2 downto 0));
    end component;

    signal D, Q : STD_LOGIC_VECTOR (2 downto 0);
    signal Res : STD_LOGIC := '1';
    signal Clk : STD_LOGIC := '0';

begin
    UUT: Program_Counter port map (D => D, Res => Res, Clk => Clk, Q => Q);

    -- Clock process
    process
    begin
        Clk <= not Clk;
        wait for 10 ns;
    end process;

    -- Stimulus process
    stim_proc: process
    begin
        -- Assert Reset
        Res <= '1';
        wait for 20 ns;
        
        -- Release Reset and load an address
        Res <= '0';
        D <= "001";
        wait for 20 ns;
        
        -- Load a new address (simulating a jump)
        D <= "110";
        wait for 20 ns;
        
        -- Assert Reset again
        Res <= '1';
        wait for 20 ns;
        
        wait;
    end process;
end Behavioral;