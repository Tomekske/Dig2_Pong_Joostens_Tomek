----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 07/31/2018 10:09:39 AM
-- Design Name: 
-- Module Name: clock_div - Behavioral
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
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity clock_div is
Port(
        clk_in: in STD_LOGIC;
        clk_out: out STD_LOGIC
    );
end clock_div;

architecture Behavioral of clock_div is
signal counter: STD_LOGIC_VECTOR(24 downto 0);
signal div: STD_LOGIC;
begin
    prescaler: process(clk_in) 
begin
    if rising_edge(clk_in) then 
        if counter < X"17D7840" then -- 25 MHz hex
            counter <= counter + 1;
        else
            div <= not div;
            counter <= (others => '0');
        end if;
     end if;
 end process prescaler;
 clk_out <= div;
end Behavioral;
