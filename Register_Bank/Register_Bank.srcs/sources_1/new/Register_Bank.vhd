library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use work.buses.all; 

entity Register_Bank is
    Port ( 
        Reg_En     : in  register_address;
        Res        : in  STD_LOGIC;
        Clk        : in  STD_LOGIC;
        Data       : in  data_bus;
        Data_Buses : out data_buses
    );
end Register_Bank;

architecture Behavioral of Register_Bank is

    -- Internal signal to capture decoder output
    signal Reg_sel : STD_LOGIC_VECTOR(7 downto 0);

begin

    -- Direct Instantiation of the Decoder
    Decoder_3_to_8_0 : entity work.Decoder_3_to_8
        port map(
            I  => Reg_En,
            EN => '1', -- Always enabled
            Y  => Reg_sel
        );

    -- Register 0: Read-Only (Hardwired to "0000")
    reg_inst0: entity work.reg
        generic map(
            N => 4
        )
        port map(
            D   => "0000",
            Res => Res,
            EN  => '1',
            Clk => Clk,
            Q   => Data_Buses(0)
        );

    -- Registers 1 to 7: General Purpose
    registers : for i in 1 to 7 generate
        reg_inst: entity work.reg
            generic map(
                N => 4
            )
            port map(
                D   => Data,
                Res => Res,
                EN  => Reg_sel(i),
                Clk => Clk,
                Q   => Data_Buses(i)
            );
    end generate registers;

end Behavioral;