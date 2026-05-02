library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;
use work.buses.all;

entity Register_Bank_tb is
-- Testbench has no ports
end Register_Bank_tb;

architecture sim of Register_Bank_tb is

    -- Signals to connect to UUT (Unit Under Test)
    signal Reg_En     : register_address := (others => '0');
    signal Res        : STD_LOGIC := '0';
    signal Clk        : STD_LOGIC := '0';
    signal Data       : data_bus := (others => '0');
    signal Data_Buses : data_buses;

    -- Clock period
    constant clk_period : time := 20 ns;

begin

    uut: entity work.Register_Bank
        port map (
            Reg_En     => Reg_En,
            Res        => Res,
            Clk        => Clk,
            Data       => Data,
            Data_Buses => Data_Buses
        );

    -- Clock process
    clk_process : process
    begin
        while now < 500 ns loop
            Clk <= '0';
            wait for clk_period/2;
            Clk <= '1';
            wait for clk_period/2;
        end loop;
        wait;
    end process;

    stim_proc: process
    begin		
        -- Reset
        Res <= '1';
        wait for 40 ns;
        Res <= '0';
        wait for 20 ns;

        -- 1010 to Reg 1
        Data   <= "1010";
        Reg_En <= "001";
        wait for clk_period;

        -- 1111 to Reg 7
        Data   <= "1111";
        Reg_En <= "111";
        wait for clk_period;

        -- Checking hardwired case
        Data   <= "0101";
        Reg_En <= "000";
        wait for clk_period;

        --0011 to Reg 2
        Data   <= "0011";
        Reg_En <= "010";
        wait for clk_period;

        Data   <= "0000";
        Reg_En <= "000";
        wait;
    end process;

end sim;