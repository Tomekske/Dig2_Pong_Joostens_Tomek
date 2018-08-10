----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 08/02/2018 09:16:56 PM
-- Design Name: 
-- Module Name: debounce - Behavioral
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

entity debounce is
    Port ( clk : in STD_LOGIC;
           sig_in : in STD_LOGIC;
           sig_out : out STD_LOGIC);
end debounce;

architecture Behavioral of debounce is

    signal Q1, Q2, Q3 : std_logic;

begin
    process(clk, sig_in) begin
            if rising_edge (clk) then
                    Q1 <= sig_in;
                    Q2 <= Q1;
                    Q3 <= Q2;
            end if;
    end process;
    sig_out <= Q1 and Q2 and Q3;
    
end Behavioral;
