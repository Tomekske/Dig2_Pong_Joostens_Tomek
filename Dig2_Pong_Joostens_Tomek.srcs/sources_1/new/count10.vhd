----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 04.05.2016 17:04:35
-- Design Name: 
-- Module Name: count10 - Behavioral
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

entity count10 is
    Port ( clk : in STD_LOGIC;
           rst : in STD_LOGIC;
           en : in STD_LOGIC;
           en_next :out STD_LOGIC;
           count : out STD_LOGIC_VECTOR (3 downto 0);
           scored: in STD_LOGIC
           
           );
end count10;

architecture Behavioral of count10 is

signal count_int: STD_LOGIC_VECTOR (3 downto 0);
signal enable_next : std_logic;
signal score : std_logic;
begin
process(clk, rst) begin
          enable_next <= '0';
        if (rst = '0') then
            count_int <= "0000";
        elsif  falling_edge(scored) and rising_edge(clk) and en = '1' then
                count_int <= count_int + 1;
                if count_int = "1000" then
                   enable_next <= '1';
                end if;
                
                if count_int = "1001" then
                       -- enable_next <= '1';
                        count_int <= "0000";
                end if;
        end if;
end process;

count <= count_int;

en_next <= enable_next;

end Behavioral;
