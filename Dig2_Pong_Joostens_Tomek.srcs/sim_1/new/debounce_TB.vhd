----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 08/22/2018 10:44:41 PM
-- Design Name: 
-- Module Name: debounce_TB - Behavioral
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

entity debounce_TB is
--  Port ( );
end debounce_TB;

architecture Behavioral of debounce_TB is

component debounce is
    Port ( clk : in STD_LOGIC;
           sig_in : in STD_LOGIC;
           sig_out : out STD_LOGIC);
end component;

signal sig_in, clk, sig_out : STD_LOGIC;
constant clk_period: time := 10ns;

begin
    UUT: debounce Port map (sig_in => sig_in, clk => clk, sig_out => sig_out);
    
    clk_proc: process begin
    clk <= '0';
    wait for clk_period/2;
    clk <= '1';
    wait for clk_period/2;
    end process;
    
    test: process begin
    sig_in <= '0';
    wait for 10 ns;
    sig_in <= '1';
    wait for 10 ns;
    for i in 0 to 10 loop
       sig_in <= '0';
       wait for 30ns;
       sig_in <= '1';
       wait for 30ns;
    end loop;
    wait;
    end process;

end Behavioral;
