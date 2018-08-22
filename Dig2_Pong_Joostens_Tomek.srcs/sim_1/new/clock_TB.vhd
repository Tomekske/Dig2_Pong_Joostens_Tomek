----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 08/22/2018 10:21:25 PM
-- Design Name: 
-- Module Name: clock_TB - Behavioral
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

entity clock_TB is
--  Port ( );
end clock_TB;

architecture Behavioral of clock_TB is

component clock is
    Port ( clk : in STD_LOGIC;
           div : in STD_LOGIC_VECTOR (1 downto 0);
           clk_slow : out STD_LOGIC);
end component clock;

signal clk, clk_slow : STD_LOGIC;
signal div : STD_LOGIC_VECTOR (1 downto 0);
constant clk_period: time := 10ns;

begin
    UUT: clock port map (clk => clk, div => div, clk_slow => clk_slow);
    clk_proc: process begin
    clk <= '0';
    wait for clk_period/2;
    clk <= '1';
    wait for clk_period/2;
    end process;
    
    test: process begin
        for i in 0 to 10 loop
            div <= "00";
            wait for 50ns;
            div <= "01";
            wait for 50ns;
        end loop;
        wait;
    end process;

end Behavioral;
