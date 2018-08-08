----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 05.10.2016 14:22:46
-- Design Name: 
-- Module Name: clkdiv - Behavioral
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
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;
use IEEE.std_logic_unsigned.all;


-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity clkdiv is
    Port ( clk : in STD_LOGIC;
           clr : in STD_LOGIC;
           clk25 : out STD_LOGIC);
end clkdiv;

architecture Behavioral of clkdiv is

signal q: STD_LOGIC_VECTOR(3 downto 0);

begin
    process (clk, clr)
    begin
        if clr = '1' then
            q <= "0000";
        elsif rising_edge(clk) then
            q <= q + 1;
        end if;
    end process;

    clk25 <= q(1);    --25 MHz


end Behavioral;
