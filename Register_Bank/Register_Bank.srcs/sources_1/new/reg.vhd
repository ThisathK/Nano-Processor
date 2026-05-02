library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity reg is
    generic (
        N : integer := 4 -- Added this to match your Register_Bank
    );
    Port ( 
        D   : in  STD_LOGIC_VECTOR (N-1 downto 0);
        Res : in  STD_LOGIC; -- Added this to match your Register_Bank
        En  : in  STD_LOGIC;
        Clk : in  STD_LOGIC;
        Q   : out STD_LOGIC_VECTOR (N-1 downto 0)
    );
end reg;

architecture Behavioral of reg is
begin
    process (Clk) 
    begin
        if (rising_edge(Clk)) then 
            if Res = '1' then       -- Synchronous Reset
                Q <= (others => '0');
            elsif En = '1' then     -- Enable logic
                Q <= D;
            end if;
        end if;
    end process;
end Behavioral;