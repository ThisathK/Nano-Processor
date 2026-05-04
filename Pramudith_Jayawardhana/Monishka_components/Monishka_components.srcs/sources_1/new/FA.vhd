library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity FA is
    Port ( A : in STD_LOGIC;
           B : in STD_LOGIC;
           C_in : in STD_LOGIC;
           S : out STD_LOGIC;
           C_out : out STD_LOGIC);
end FA;

architecture Dataflow of FA is
begin
    S <= A XOR B XOR C_in;
    C_out <= (A AND B) OR (C_in AND (A XOR B));
end Dataflow;