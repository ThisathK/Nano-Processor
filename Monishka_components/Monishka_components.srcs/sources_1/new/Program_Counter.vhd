library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity Program_Counter is
    Port ( D : in STD_LOGIC_VECTOR (2 downto 0);
           Res : in STD_LOGIC;
           Clk : in STD_LOGIC;
           Q : out STD_LOGIC_VECTOR (2 downto 0));
end Program_Counter;

architecture Structural of Program_Counter is
    COMPONENT D_FF
        Port ( D : in STD_LOGIC;
               Res : in STD_LOGIC;
               Clk : in STD_LOGIC;
               Q : out STD_LOGIC;
               Qbar : out STD_LOGIC);
    END COMPONENT;
begin
    -- Instantiating 3 D Flip-Flops to hold the 3-bit address
    D_FF_0: D_FF port map (D => D(0), Res => Res, Clk => Clk, Q => Q(0));
    D_FF_1: D_FF port map (D => D(1), Res => Res, Clk => Clk, Q => Q(1));
    D_FF_2: D_FF port map (D => D(2), Res => Res, Clk => Clk, Q => Q(2));
end Structural;