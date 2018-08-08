----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 08/08/2018 02:32:53 PM
-- Design Name: 
-- Module Name: vga_stipes - Behavioral
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
use IEEE.STD_LOGIC_UNSIGNED.ALL; 
use IEEE.STD_LOGIC_arith.all;
-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity vga_stipes is
 Port ( 
    vidon: in std_logic; 
    hc : in integer range 0 to 800;
    vc : in integer range 0 to 800;
    red : out std_logic_vector(3 downto 0);
    green : out std_logic_vector(3 downto 0);
    blue : out std_logic_vector(3 downto 0)
 );
end vga_stipes;

architecture Behavioral of vga_stipes is
signal vc_vec: std_logic_vector (9 downto 0);

begin

process(vidon, vc_vec)
begin
    vc_vec <= conv_std_logic_vector(vc,10);
    red <= "0000";
    green <= "0000";
    blue <= "0000";
    if vidon = '1' then
        red <= vc_vec(4) & vc_vec(4) & vc_vec(4)& vc_vec(4);
        green <= not (vc_vec(5) & vc_vec(5) & vc_vec(5)& vc_vec(5));
    end if;
    end process;
end Behavioral;
