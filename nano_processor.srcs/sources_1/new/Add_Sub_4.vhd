----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 02.05.2026 12:03:51
-- Design Name: 
-- Module Name: Add_Sub_4 - Behavioral
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

entity Add_Sub_4 is
    Port ( A : in STD_LOGIC_VECTOR (3 downto 0);
           B : in STD_LOGIC_VECTOR (3 downto 0);
           Ctrl : in STD_LOGIC;
           S : out STD_LOGIC_VECTOR (3 downto 0);
           cout : out STD_LOGIC;
           Zero : out STD_LOGIC;
           Overflow : out STD_LOGIC);
end Add_Sub_4;

architecture Behavioral of Add_Sub_4 is
    component FA
        port (A,B,cin : in std_logic;
              S, cout : out std_logic);
    end component;
    
    signal c0, c1, c2, c3 : std_logic;
    signal x0, x1, x2, x3 : std_logic;
    signal s_internal : std_logic_vector(3 downto 0); 

begin
    x0 <= B(0) xor Ctrl;
    x1 <= B(1) xor Ctrl;
    x2 <= B(2) xor Ctrl;
    x3 <= B(3) xor Ctrl;
    
    FA0 : FA port map (A => A(0), B => x0, cin => Ctrl, S => s_internal(0), cout => c0);
    FA1 : FA port map (A => A(1), B => x1, cin => c0,   S => s_internal(1), cout => c1);
    FA2 : FA port map (A => A(2), B => x2, cin => c1,   S => s_internal(2), cout => c2);
    FA3 : FA port map (A => A(3), B => x3, cin => c2,   S => s_internal(3), cout => c3);
    
    S <= s_internal;
    cout <= c3;
    
    Zero <= not (s_internal(0) or s_internal(1) or s_internal(2) or s_internal(3));
    
    Overflow <= c2 xor c3;
    
end Behavioral;
