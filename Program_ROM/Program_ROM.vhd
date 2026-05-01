----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 05/01/2026 02:33:09 PM
-- Design Name: 
-- Module Name: Program_ROM - Behavioral
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
use IEEE.NUMERIC_STD.ALL;
use work.buses.all; 
use work.buses.instruction_address;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity Program_ROM is
--  Port ( );
    port(ROM_address : in instruction_address;
    I : out instruction_bus
    );
end Program_ROM;

architecture Behavioral of Program_ROM is

type rom_type is array (0 to 7) of std_logic_vector (11 downto 0);

    signal count_down : rom_type := (
        "100010001010",--MOVI R1, 10
        "100100000001",--MOVI R2, 1
        "010100000000",--NEG R2
        "000010100000",--ADD R1, R2
        "110010000111",--JZR R1, 7
        "110000000011" --JZR R0, 3 
    );

begin
    I <= count_down(to_integer(unsigned(ROM_address)));
end Behavioral;
