----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 08/06/2018 03:38:33 PM
-- Design Name: 
-- Module Name: mux21 - Behavioral
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

entity mux21 is
    Port ( 
    sel: in STD_LOGIC_VECTOR (1 downto 0);
    an: out STD_LOGIC_VECTOR (3 downto 0)
    );
end mux21;

architecture Behavioral of mux21 is

begin

process (sel) begin
        case (sel) is
                when "00" => an <= "1110";
                when "01" => an <= "1101";
                when "10" => an <= "1011";
                when "11" => an <= "0111";
                when others => an <= "1111";
        end case;
end process;

end Behavioral;
