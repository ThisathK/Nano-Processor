library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;
use work.buses.all; 

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity Inst_Decoder is
    port(
    I: in instruction_bus; -- Instruction
    RC_Jump: in data_bus; -- Register Check for Jump
    R_Enable: out register_address; -- Register Enable
    Reg_A: out register_address; -- Register Select A
    Reg_B: out register_address; -- Register Select B
    OpS: out std_logic; -- Operation Select
    Immediate: out data_bus; -- Immediate value
    J: out std_logic; -- Jump flag
    J_Address: out instruction_address; -- Jump Address,
    L: out std_logic -- Load Select
);
end Inst_Decoder;

architecture Behavioral of Inst_Decoder is

constant Immediate_Load : std_logic := '1';
constant Register_Load  : std_logic := '0';

signal IEn: std_logic_vector(1 downto 0); -- Instruction Enable
signal RCJ: std_logic_vector(3 downto 0); -- Register Check for Jump
constant Jump : std_logic := '1';
constant NotJump : std_logic := '0';

begin
    IEn <= I(11 downto 10); -- Instruction Bits 11 and 10
    RCJ <= RC_Jump;
    
    decode: process(IEn, RCJ, I)
    begin
    
        J          <= '0';
        OpS        <= '0';
        L          <= '0';
        R_Enable   <= "000";
        Reg_A      <= "000";
        Reg_B      <= "000";
        Immediate  <= "0000";
        J_Address  <= "000";
        
        case IEn is
            when "10" => --Movi
                J <= NotJump;
                Immediate <= I(3 downto 0); 
                L <= '1'; --Immediate load 
                R_Enable <= I(9 downto 7);
                
            when "00" => --Add
                J <= '0';
                OpS <= '0' ;
                Reg_A <= I(9 downto 7);
                Reg_B <= I(6 downto 4);
                R_Enable <= I(9 downto 7); --Destination
                L <= Register_Load;
                
            when "01" => --Neg
                J <= '0';
                OpS <= '1';
                Reg_A <= "000"; -- Subtract from Zero
                Reg_B <= I(9 downto 7);
                R_Enable <= I(9 downto 7);
                L <= Register_Load;
                
            when "11" => --JZR
                Reg_A <= I(9 downto 7);
                R_Enable <= "000";
                if RCJ = "0000" then
                    J <= Jump;
                    J_Address <= I(2 downto 0);
                else
                    J <= NotJump;
                end if;
            when others => 
                null;
        end case;

    end process decode;

end Behavioral;
