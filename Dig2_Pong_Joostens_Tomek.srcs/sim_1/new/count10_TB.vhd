----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 08/22/2018 11:00:27 PM
-- Design Name: 
-- Module Name: count10_TB - Behavioral
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

entity count10_TB is
--  Port ( );
end count10_TB;

architecture Behavioral of count10_TB is

component count10 is
    Port ( clk : in STD_LOGIC;
           rst : in STD_LOGIC;
           en : in STD_LOGIC;
           en_next :out STD_LOGIC;
           count : out STD_LOGIC_VECTOR (3 downto 0);
           scored: in STD_LOGIC

           );          
end component;
signal clk, rst, en, en_next, scored : std_logic;
signal count : std_logic_vector(3 downto 0);
constant clk_period: time := 1ns;

begin
UUT: count10 Port map(clk => clk,rst => rst, en => en,en_next => en_next,count => count, scored => scored);

clk_proc: process begin
clk <= '0';
wait for clk_period/2;
clk <= '1';
wait for clk_period/2;
end process;

test: process begin
    rst <= '0';
    en <= '1';
    wait for 5ns;
    rst <= '0';
    wait for 5ns;
    en <= '1';
    for i in 0 to 20 loop
        
    end loop;
    wait;
end process;

end Behavioral;
