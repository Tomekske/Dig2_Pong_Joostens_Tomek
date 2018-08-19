----------------------------------------------------------------------------------
-- Company: 
-- Engineer:
-- 
-- Create Date: 28.09.2016 18:38:49
-- Design Name: 
-- Module Name: vga_640x480 - Behavioral
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

entity vga_640x480 is
    Port ( clk : in STD_LOGIC;
           clr : in STD_LOGIC;
           hsync : out STD_LOGIC;
           vsync : out STD_LOGIC;
           hc : out STD_LOGIC_VECTOR (9 downto 0);
           vc : out STD_LOGIC_VECTOR (9 downto 0);
           vidon : out STD_LOGIC);
end vga_640x480;

architecture Behavioral of vga_640x480 is
constant hpixels: std_logic_vector(9 downto 0) := "1100100000"; --800
constant vlines: std_logic_vector(9 downto 0) := "1000001001"; --521
constant hbp: std_logic_vector(9 downto 0) := "0010010000"; --144 = 96+48
constant hfp: std_logic_vector(9 downto 0) := "1100010000"; -- 784 = 96+48+640
constant vbp: std_logic_vector(9 downto 0) := "0000011111"; --31 = 29 + 2
constant vfp: std_logic_vector(9 downto 0) := "0111111111"; --511 = 2+29+480
signal hcs, vcs: std_logic_vector(9 downto 0);
signal vsenable: std_logic;

begin
        process (clk,clr)
        begin
            if clr = '1' then
                hcs <= "0000000000";
            elsif(clk'event and clk = '1') then
                if hcs = hpixels - 1 then
                    hcs <= "0000000000";
                    vsenable <= '1';    --Enable the vertical counter
                else
                    hcs <= hcs +1;
                    vsenable <= '0';
                end if;
            end if;
        end process;
        
        hsync <= '0' when hcs < 96 else '1';
        
        process (clk, clr, vsenable)
        begin
            if clr = '1' then
                    vcs <= "0000000000";
            elsif (clk'event and clk = '1' and vsenable = '1') then
                    if vcs = vlines - 1 then 
                                vcs <= "0000000000";
                    else
                                vcs <= vcs + 1;
                    end if;
            end if;
        end process;
        
        vsync <= '0' when vcs < 2 else '1';
        
        --Enable video out when within the porches
        vidon <= '1' when (((hcs < hfp) and (hcs >= hbp))
        and ((vcs < vfp) and (vcs >= vbp))) else '0';
        
        --Output horizontal and vertical counters
        hc <= hcs;
        vc <= vcs;


end Behavioral;
