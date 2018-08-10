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
use IEEE.std_logic_arith.all;
-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity vga_sprite is
Port ( 
    clk: in std_logic;
    clk60: in std_logic;
    vidon: in std_logic;
    hc : in std_logic_vector(9 downto 0);
    vc : in std_logic_vector(9 downto 0);
    M: in std_logic_vector(0 to 15);
    sw: in std_logic_vector(7 downto 0);
    rom_sprite_paddle: out std_logic_vector(3 downto 0);
    red : out std_logic_vector(3 downto 0);
    green : out std_logic_vector(3 downto 0);
    blue : out std_logic_vector(3 downto 0);
    
    btn_up: in std_logic;
    btn_down: in std_logic;
    btn_reset: in std_logic
);
end vga_sprite;


architecture Behavioral of vga_sprite is

constant hbp: std_logic_vector(9 downto 0) := "0010010000"; --144
constant vbp: std_logic_vector(9 downto 0) := "0000011111"; --31
constant w: integer := 16;
constant h: integer := 16;

signal C1: std_logic_vector(10 downto 0) := "00000001000";
signal R1: std_logic_vector(10 downto 0) := "00011101100";

signal rom_addr, rom_pix: std_logic_vector(10 downto 0);
signal spriteon, R, G, B: std_logic;

signal red_paddle: STD_LOGIC_VECTOR (3 downto 0);                     -- rood
signal green_paddle : STD_LOGIC_VECTOR (3 downto 0);                   -- groen
signal blue_paddle : STD_LOGIC_VECTOR (3 downto 0);                   -- blauw


signal red_bg: STD_LOGIC_VECTOR (3 downto 0);                     -- rood
signal green_bg : STD_LOGIC_VECTOR (3 downto 0);                   -- groen
signal blue_bg : STD_LOGIC_VECTOR (3 downto 0);                   -- blauw



-- constants
constant vc_left_centerline: integer := 150;
constant vc_rigt_centerline: integer := 775;
constant vc_centerline: integer := ((vc_rigt_centerline - vc_left_centerline) / 2) + vc_left_centerline;

constant hc_topline: integer := 100;
constant hc_bottomline: integer := 450;
constant hc_centerline: integer := ((hc_bottomline - hc_topline) / 2) + hc_topline;


-- variables
begin

    -- background
    process(vidon) begin
        red_bg <= "0000";
        green_bg <= "0000";
        blue_bg <= "0000";
        
        if vidon = '1' then
            --centerline
            if hc = vc_centerline and (vc >= hc_topline and vc <= hc_bottomline) then
                red_bg <= "1111";
                green_bg <= "1111";
                blue_bg <= "1111";
            -- verticaal links    
            elsif hc = vc_left_centerline and (vc >= hc_topline and vc <= hc_bottomline) then
                red_bg <= "1111";
                green_bg <= "1111";
                blue_bg <= "1111";
            -- verticaal rechts    
            elsif hc = vc_rigt_centerline and (vc >= hc_topline and vc <= hc_bottomline) then
                red_bg <= "1111";
                green_bg <= "1111";
                blue_bg <= "1111";
            -- horizontaal midden       
            elsif vc = hc_centerline and (hc >= vc_left_centerline and hc <= vc_rigt_centerline) then
                red_bg <= "1111";
                green_bg <= "1111";
                blue_bg <= "1111";
                -- horizontaal beneden    
            -- horizontaal boven       
            elsif vc = hc_topline and (hc >= vc_left_centerline and hc <= vc_rigt_centerline) then
                red_bg <= "1111";
                green_bg <= "1111";
                blue_bg <= "1111";
            -- horizontaal beneden       
            elsif vc = hc_bottomline and (hc >= vc_left_centerline and hc <= vc_rigt_centerline) then
                red_bg <= "1111";
                green_bg <= "1111";
                blue_bg <= "1111";       
            end if;
        end if;
    end process;
    
   

    process(vidon,clk60,btn_up,btn_down,btn_reset) begin
    if rising_edge(clk60) then                                           --paddle boven
            if btn_up = '1' and vidon = '1' then
              R1 <= conv_std_logic_vector(conv_integer(R1)-1,11);
        elsif btn_down = '1' and vidon = '1' then                         --paddle beneden
                R1 <= conv_std_logic_vector(conv_integer(R1)+1,11); 
    elsif btn_reset = '1' and vidon = '1' then                          --paddle reset
                    R1 <=  "00011101100";
                    C1 <= "00000001000";          
            end if;
        end if;
    

    end process;
    


        rom_addr <= vc - vbp - R1;
         rom_pix <= hc - hbp - C1;

    rom_sprite_paddle <= rom_addr(3 downto 0);
    
    --Enable sprite video out when within the sprite region
    spriteon <= '1' when (((hc >= C1 + hbp) and (hc < C1 + hbp + w)) and ((vc >= R1 + vbp) and (vc < R1 + vbp + h))) else '0';
    

    
    
    
    process(spriteon, vidon, rom_pix, M)
        variable j: integer;
        
        begin
        red_paddle <= "0000";
        green_paddle <= "0000";
        blue_paddle <= "0000";
        
        if spriteon = '1' and vidon = '1' then
            j := conv_integer(rom_pix);
            R <= M(j);
            G <= M(j);
            B <= M(j);
            red_paddle <= R & R & R & R;
            green_paddle <= G & G & G & G;
            blue_paddle <= B & B & B & B;
        end if;
    end process;
    
    process(clk) begin
        if rising_edge(clk) then
            red <= red_paddle or red_bg;
            green <= green_paddle or green_bg;
            blue <= blue_paddle or blue_bg;
        end if;
   end process;
end Behavioral;
