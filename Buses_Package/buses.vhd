library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

package buses is

    subtype register_address is STD_LOGIC_VECTOR(2 downto 0);

    subtype data_bus is STD_LOGIC_VECTOR(3 downto 0);
    
    subtype instruction_address is STD_LOGIC_VECTOR(2 downto 0);
    
    subtype instruction_bus is STD_LOGIC_VECTOR(11 downto 0);

    type data_buses is array (0 to 7) of data_bus;

end package buses;
