----------------------------------------------------------------------------------
-- Company: 
-- Engineer: Christophe Huybrechts
-- 
-- Create Date: 04.05.2016 17:10:22
-- Design Name: 
-- Module Name: QMUX41 - Behavioral
-- Project Name: 
-- Target Devices: Basys3
-- Tool Versions: 
-- Description: 
-- 
-- Dependencies: 
-- 
-- Revision:
-- Revision 0.02 - Comment updated
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

entity mux21 is
    Port ( data : in STD_LOGIC_VECTOR (15 downto 0); -- remane this are not switches
           clk : in STD_LOGIC;
           displaynr : out STD_LOGIC_VECTOR (3 downto 0);
           an : out STD_LOGIC_VECTOR (3 downto 0));
end mux21;

architecture Behavioral of mux21 is

signal disCounter : integer range 0 to 3 := 0;

begin
process (clk) begin
    if rising_edge(clk) then
        if disCounter = 3 then
            disCounter <= 0;
        else
            disCounter <= disCounter + 1;
        end if;
    end if;
end process;

process (data, disCounter) begin
        case (disCounter) is
              when 0 => displaynr <= data (3 downto 0);
              when 1 => displaynr <= data (7 downto 4);
              when 2 => displaynr <= data (11 downto 8);
              when 3 => displaynr <= data (15 downto 12);
              when others => displaynr <= "0000";
  end case;
end process;

process (disCounter) begin
        case (disCounter) is
                when 0 => an <= "1110";
                when 1 => an <= "1101";
                when 2 => an <= "1011";
                when 3 => an <= "0111";
                when others => an <= "1111";
        end case;
end process;

end Behavioral;
