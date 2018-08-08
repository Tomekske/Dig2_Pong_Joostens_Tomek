----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 08/08/2018 11:25:53 PM
-- Design Name: 
-- Module Name: vga_sprite - Behavioral
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

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity vga_sprite is
  Port ( 
  vidon: in std_logic;
  hc : in std_logic_vector(9 downto 0);
  vc : in std_logic_vector(9 downto 0);
  M: in std_logic_vector(0 to 15);
  sw: in std_logic_vector(7 downto 0);
  rom_addr4: out std_logic_vector(3 downto 0);
  red : out std_logic_vector(3 downto 0);
  green : out std_logic_vector(3 downto 0);
  blue : out std_logic_vector(3 downto 0)
  
  );
end vga_sprite;


architecture Behavioral of vga_sprite is



constant hbp: std_logic_vector(9 downto 0) := "0010010000"; --144
constant vbp: std_logic_vector(9 downto 0) := "0000011111"; --31
constant w: integer := 16;
constant h: integer := 16;
signal C1, R1: std_logic_vector(10 downto 0);
signal rom_addr, rom_pix: std_logic_vector(10 downto 0);
signal spriteon, R, G, B: std_logic;



begin

--set C1 and R1 using switches
C1 <= "00" & SW(3 downto 0) & "00001";
R1 <= "00" & SW(7 downto 4) & "00001";
rom_addr <= vc - vbp - R1;
rom_pix <= hc - hbp - C1;
rom_addr4 <= rom_addr(3 downto 0);
--Enable sprite video out when within the sprite region
spriteon <= '1' when (((hc >= C1 + hbp) and (hc < C1 + hbp + w))
and ((vc >= R1 + vbp) and (vc < R1 + vbp + h))) else '0';
process(spriteon, vidon, rom_pix, M)
variable j: integer;
begin
red <= "0000";
green <= "0000";
blue <= "0000";
if spriteon = '1' and vidon = '1' then
j := conv_integer(rom_pix);
R <= M(j);
G <= M(j);
B <= M(j);
red <= R & R & R & R;
green <= G & G & G & G;
blue <= B & B & B & B;
end if;
end process;


end Behavioral;
