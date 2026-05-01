library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use work.buses.all;

entity TB_IDecoder is

end TB_IDecoder;

architecture Behavioral of TB_IDecoder is

    -- Component Declaration for the Unit Under Test (UUT)
    component Inst_Decoder
        port(
            I: in instruction_bus;
            RC_Jump: in data_bus;
            R_Enable: out register_address;
            Reg_A: out register_address;
            Reg_B: out register_address;
            OpS: out std_logic;
            Immediate: out data_bus;
            J: out std_logic;
            J_Address: out instruction_address;
            L: out std_logic
        );
    end component;

    -- Signals to connect to UUT
    signal I          : instruction_bus := (others => '0');
    signal RC_Jump    : data_bus := (others => '0');
    signal R_Enable   : register_address;
    signal Reg_A      : register_address;
    signal Reg_B      : register_address;
    signal OpS        : std_logic;
    signal Immediate  : data_bus;
    signal J          : std_logic;
    signal J_Address  : instruction_address;
    signal L          : std_logic;

begin

    -- Instantiate the Unit Under Test (UUT)
    uut: Inst_Decoder port map (
          I => I,
          RC_Jump => RC_Jump,
          R_Enable => R_Enable,
          Reg_A => Reg_A,
          Reg_B => Reg_B,
          OpS => OpS,
          Immediate => Immediate,
          J => J,
          J_Address => J_Address,
          L => L
        );

        stim_proc: process
        begin        
            --Reset
            wait for 100 ns;
    
            -- "101110000011" -> MOVI R7, 3
            I <= "101110000011";
            wait for 20 ns;
            -- Result: L='1', R_Enable="111", Immediate="0011"
    
            -- "100010000001" -> MOVI R1, 1
            I <= "100010000001";
            wait for 20 ns;
            -- Result: L='1', R_Enable="001", Immediate="0001"
    
            -- "010010000000" -> NEG R1
            I <= "010010000000";
            wait for 20 ns;
            -- Result: OpS='1', Reg_A="000", Reg_B="001", R_Enable="001", L='0'
    
            -- "100100000011" -> MOVI R2, 3
            I <= "100100000011";
            wait for 20 ns;
            -- Result: L='1', R_Enable="010", Immediate="0011"
    
            -- Address 4: "000100010000" -> ADD R2, R1
            I <= "000100010000";
            wait for 20 ns;
            -- Result: OpS='0', Reg_A="010", Reg_B="001", R_Enable="010", L='0'
    
            -- Address 5: "001110100000" -> ADD R7, R2
            I <= "001110100000";
            wait for 20 ns;
            -- Result: OpS='0', Reg_A="111", Reg_B="010", R_Enable="111", L='0'
    
            -- "110100000110" -> JZR R2, 6
            I <= "110100000110";
            RC_Jump <= "0000"; -- Simulate R2 is zero to test the jump
            wait for 20 ns;
            -- Result: J='1', J_Address="110", Reg_A="010"
    
            -- "110000000100" -> JZR R0, 4
            I <= "110000000100";
            RC_Jump <= "0000"; -- R0 is always zero
            wait for 20 ns;
            -- Result: J='1', J_Address="100", Reg_A="000"
    
            wait;
        end process;

end Behavioral;