----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 08/04/2018 07:01:11 PM
-- Design Name: 
-- Module Name: top_module - Behavioral
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

entity top_module is
  Port (
        clk: in STD_LOGIC;

        led: out STD_LOGIC_VECTOR (3 downto 0);
        x: in STD_LOGIC_VECTOR ( 3 downto 0)
       );
end top_module;

architecture Behavioral of top_module is

component clock_div is
Port(
        clk_in: in STD_LOGIC;
        clk_out: out STD_LOGIC
    );
    

end component clock_div;
signal div: STD_LOGIC;

begin
clock: clock_div Port map(clk_in => clk,clk_out => div);

led(0) <= div;
end Behavioral;
