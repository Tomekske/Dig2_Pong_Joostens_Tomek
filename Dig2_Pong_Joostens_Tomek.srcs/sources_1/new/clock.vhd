----------------------------------------------------------------------------------
-- Company: 
-- Engineer: Christophe Huybrechts
-- 
-- Create Date: 29.09.2016 12:08:02
-- Design Name: 
-- Module Name: Top - PacMan
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

entity clock is
    Port ( clk : in STD_LOGIC;
           div : in STD_LOGIC_VECTOR (1 downto 0);
           clk_slow : out STD_LOGIC);
end clock;

architecture Behavioral of clock is

signal i: integer range 0 to 25000000 := 1;
signal int_clk: std_logic := '0';
signal base: integer range 0 to 25000000 := 25000000;
signal prev_div: std_logic := '0';

begin
process(clk, div) begin
        if rising_edge (clk) then
            i <= i + 1;
            if (i = base) then
                i <= 1;
                int_clk <= not int_clk;
            end if;
            case (div) is
                    when "00" => base <= 100000;
                    when "01" => base <= 2400000;
                    when "10" => base <= 200000;
                    when "11" => base <= 3;
                    when others => base <=250000;
             end case;
         end if;
end process;
clk_slow <= int_clk;

end Behavioral;
