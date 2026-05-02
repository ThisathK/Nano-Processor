----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 02.05.2026 12:28:32
-- Design Name: 
-- Module Name: TB_Add_Sub_4 - Behavioral
-- Project Name: 
-- Target Devices: 
-- Tool Versions: 
-- Description: 
-- 
-- Dependencies: 
-- 
-- Revision:
-- Revision 0.01 - File Created
-- Additional Comments:
-- 
----------------------------------------------------------------------------------


library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity TB_Add_Sub_4 is
--  Port ( );
end TB_Add_Sub_4;

architecture Behavioral of TB_Add_Sub_4 is
    component Add_Sub_4
        Port ( A, B : in STD_LOGIC_VECTOR (3 downto 0);
               Ctrl : in STD_LOGIC;
               S : out STD_LOGIC_VECTOR (3 downto 0);
               cout, Zero, Overflow : out STD_LOGIC);
    end component;

    signal A, B, S : std_logic_vector(3 downto 0);
    signal Ctrl, cout, Zero, Overflow : std_logic;

begin
    UUT: Add_Sub_4 port map (A => A, B => B, Ctrl => Ctrl, S => S, cout => cout, Zero => Zero, Overflow => Overflow);

    process
    begin
        -- CASE 1: Normal Addition (2 + 3 = 5)
        A <= "0010"; B <= "0011"; Ctrl <= '0';
        wait for 100 ns;

        -- CASE 2: Normal Subtraction (7 - 3 = 4)
        A <= "0111"; B <= "0011"; Ctrl <= '1';
        wait for 100 ns;

        -- CASE 3: Check Zero Flag (5 - 5 = 0)
        A <= "0101"; B <= "0101"; Ctrl <= '1';
        wait for 100 ns;

        -- CASE 4: Check Overflow (7 + 1 = 8) 
        -- In 4-bit signed, 7 is max positive. 7+1 results in -8 (1000).
        A <= "0111"; B <= "0001"; Ctrl <= '0';
        wait for 100 ns;

        -- CASE 5: Check Negative Overflow (-8 - 1)
        A <= "1000"; B <= "0001"; Ctrl <= '1';
        wait for 100 ns;

        wait;
    end process;
end Behavioral;
