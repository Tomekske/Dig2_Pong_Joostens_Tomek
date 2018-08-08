----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 08/01/2018 09:58:57 PM
-- Design Name: 
-- Module Name: seg7 - Behavioral
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
use IEEE.numeric_std.all;
use IEEE.std_logic_unsigned.all;
-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity seg7 is
Port(
    x : in STD_LOGIC_VECTOR (3 downto 0);
--    an_in : in STD_LOGIC_VECTOR (3 downto 0);
    g_to_a : out STD_LOGIC_VECTOR (6 downto 0);
--    an : out STD_LOGIC_VECTOR (3 downto 0);
    dp : out STD_LOGIC
    );
end seg7;

architecture Behavioral of seg7 is

begin

process(x)
    begin
        case x is
            when "0000" => g_to_a <= "1000000"; --0
            when "0001" => g_to_a <= "1111001"; --1
            when "0010" => g_to_a <= "0100100"; --2
            when "0011" => g_to_a <= "0110000"; --3
            when "0100" => g_to_a <= "0011001"; --4
            when "0101" => g_to_a <= "0010010"; --5
            when "0110" => g_to_a <= "0000010"; --6
            when "0111" => g_to_a <= "1011000"; --7
            when "1000" => g_to_a <= "0000000"; --8
            when "1001" => g_to_a <= "0010000"; --9
            when "1010" => g_to_a <= "0001000"; --A
            when "1011" => g_to_a <= "0000011"; --b
            when "1100" => g_to_a <= "1000110"; --C
            when "1101" => g_to_a <= "0100001"; --d
            when "1110" => g_to_a <= "0000110"; --E
            when others => g_to_a <= "0001110"; --F
        end case;
    end process;
--    an(0) <= an_in(0);
--    dp <= '0';
end Behavioral;
