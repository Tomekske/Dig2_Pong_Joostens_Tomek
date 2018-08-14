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
--use IEEE.STD_LOGIC_ARITH.ALL;
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
        sw : in STD_LOGIC_VECTOR (7 downto 0);
        an_in : in STD_LOGIC_VECTOR (3 downto 0);
        g_to_a : out STD_LOGIC_VECTOR (6 downto 0);
        an : out STD_LOGIC_VECTOR (3 downto 0);
        dp : out STD_LOGIC;
        sel: in STD_LOGIC_VECTOR(1 downto 0);
        Hsync : out STD_LOGIC;
        Vsync : out STD_LOGIC;
        
        vgaRed : out STD_LOGIC_VECTOR (3 downto 0);
        vgaGreen : out STD_LOGIC_VECTOR (3 downto 0);
        vgaBlue : out STD_LOGIC_VECTOR (3 downto 0);
        btn_up: in std_logic;
        btn_down: in std_logic;
        btn_reset: in STD_LOGIC;
        btn_start:  in STD_LOGIC
        );
end top_module;

-- ****************************************************
-- ****************************************************

architecture Behavioral of top_module is

-- ****************************************************
-- ****************************************************

component clock_div is
Port(
        clk_in: in STD_LOGIC;
        clk_out: out STD_LOGIC
    );
end component clock_div;

-- ====================================================

component seg7 is
    Port(
        x : in STD_LOGIC_VECTOR (3 downto 0);
--        an_in : in STD_LOGIC_VECTOR (3 downto 0);
        g_to_a : out STD_LOGIC_VECTOR (6 downto 0);
--        an : out STD_LOGIC_VECTOR (3 downto 0);
        dp : out STD_LOGIC

        );
    end component seg7;

-- ====================================================

component mux21 is
    Port ( 
    sel: in STD_LOGIC_VECTOR (1 downto 0);
    an: out STD_LOGIC_VECTOR (3 downto 0)
    );
end component mux21;


component vga_640x480 is
    Port ( clk : in STD_LOGIC;
           clr : in STD_LOGIC;
           hsync : out STD_LOGIC;
           vsync : out STD_LOGIC;
           hc : out STD_LOGIC_VECTOR (9 downto 0);
           vc : out STD_LOGIC_VECTOR (9 downto 0);
           vidon : out STD_LOGIC);
end component vga_640x480;



component vga_stipes is
 Port ( 
    vidon: in std_logic; 
    hc : in integer range 0 to 800;
    vc : in integer range 0 to 800;
    red : out std_logic_vector(3 downto 0);
    green : out std_logic_vector(3 downto 0);
    blue : out std_logic_vector(3 downto 0)
 );
end component;

component layer_background is
 Port ( 
    vidon: in std_logic; 
    hc : in integer range 0 to 800;
    vc : in integer range 0 to 800;
    red : out std_logic_vector(3 downto 0);
    green : out std_logic_vector(3 downto 0);
    blue : out std_logic_vector(3 downto 0)
 );
end component;



--component vga_sprite is
--  Port ( 
--  clk: in std_logic;
--  clk60: in std_logic;
--  vidon: in std_logic;
--  hc : in std_logic_vector(9 downto 0);
--  vc : in std_logic_vector(9 downto 0);
  
--  M: in std_logic_vector(0 to 15);
--  M_ball: in std_logic_vector(0 to 15);
  
--  sw: in std_logic_vector(7 downto 0);
  
--  rom_sprite_paddle: out std_logic_vector(3 downto 0);
--  rom_sprite_ball: out std_logic_vector(3 downto 0);
  
--  red : out std_logic_vector(3 downto 0);
--  green : out std_logic_vector(3 downto 0);
--  blue : out std_logic_vector(3 downto 0);
  
--  btn_up: in std_logic;
--  btn_down: in std_logic;
--  btn_reset: in std_logic
--  );
--end component;

component vga_sprite is
  Port ( 
 clk: in std_logic;
 clk60: in std_logic;
 vidon: in std_logic;
 hc : in std_logic_vector(9 downto 0);
 vc : in std_logic_vector(9 downto 0);
 M: in std_logic_vector(0 to 15);
 M2: in std_logic_vector(0 to 15);
 M_ball: in std_logic_vector(0 to 15);
 sw: in std_logic_vector(7 downto 0);
 rom_sprite_paddle: out std_logic_vector(3 downto 0);
 rom_sprite_paddle2: out std_logic_vector(3 downto 0);
 rom_sprite_ball: out std_logic_vector(3 downto 0);
 red : out std_logic_vector(3 downto 0);
 green : out std_logic_vector(3 downto 0);
 blue : out std_logic_vector(3 downto 0);
 btn_up: in std_logic;
 btn_down: in std_logic;
 btn_reset: in STD_LOGIC;
 btn_start: in STD_LOGIC

  );
end component;
component clkdiv is
    Port ( clk : in STD_LOGIC;
           clr : in STD_LOGIC;
           clk25 : out STD_LOGIC);
end component;

COMPONENT blk_mem_gen_0 PORT (
clka : IN STD_LOGIC;
addra : IN STD_LOGIC_VECTOR(3 DOWNTO 0); 
douta : OUT STD_LOGIC_VECTOR(15 DOWNTO 0) );
END COMPONENT;

COMPONENT blk_mem_gen_paddle2 PORT (
clka : IN STD_LOGIC;
addra : IN STD_LOGIC_VECTOR(3 DOWNTO 0); 
douta : OUT STD_LOGIC_VECTOR(15 DOWNTO 0) );
END COMPONENT;

COMPONENT blk_mem_gen_ball PORT (
clka : IN STD_LOGIC;
addra : IN STD_LOGIC_VECTOR(3 DOWNTO 0); 
douta : OUT STD_LOGIC_VECTOR(15 DOWNTO 0) );
END COMPONENT;

component clk_wiz_0
port
 (-- Clock in ports
  -- Clock out ports
  clk_out1          : out    std_logic;
  -- Status and control signals
  reset             : in     std_logic;
  locked            : out    std_logic;
  clk_in1           : in     std_logic
 );
end component;
ATTRIBUTE SYN_BLACK_BOX : BOOLEAN;
ATTRIBUTE SYN_BLACK_BOX OF clk_wiz_0 : COMPONENT IS TRUE;
ATTRIBUTE BLACK_BOX_PAD_PIN : STRING;
ATTRIBUTE BLACK_BOX_PAD_PIN OF clk_wiz_0 : COMPONENT IS "clk_in1,clk_out1,reset,locked";





component debounce is
    Port ( clk : in STD_LOGIC;
           sig_in : in STD_LOGIC;
           sig_out : out STD_LOGIC);
end component debounce;


component clock is
    Port ( clk : in STD_LOGIC;
           div : in STD_LOGIC_VECTOR (1 downto 0);
           clk_slow : out STD_LOGIC);
end component;

-- ####################################################
-- ####################################################

signal div: STD_LOGIC;
signal knop: STD_LOGIC;
signal counter: STD_LOGIC_VECTOR (1 downto 0);
signal vierkant: STD_LOGIC_VECTOR (3 downto 0);
signal vvv: STD_LOGIC_VECTOR (3 downto 0);
signal vidon, clr : STD_LOGIC;
signal hc, vc : STD_LOGIC_VECTOR (9 downto 0);
signal nhc, nvc: integer range 0 to 512; 
signal clk25: STD_LOGIC;

signal M : STD_LOGIC_VECTOR (0 to 15);
signal M2 : STD_LOGIC_VECTOR (0 to 15);
signal M_ball : STD_LOGIC_VECTOR (0 to 15);

signal rom_sprite_paddle : STD_LOGIC_VECTOR (3 downto 0);
signal rom_sprite_paddle2 : STD_LOGIC_VECTOR (3 downto 0);
signal rom_sprite_ball: STD_LOGIC_VECTOR (3 downto 0);

signal clk60: std_logic;
-- ####################################################
-- ####################################################

begin
--clock: clock_div Port map(clk_in => clk,clk_out => div);
--cclock: clkdiv Port map(clk => clk,clr => clr,clk25 => div);
c33: clock Port map (clk => clk, div => "01", clk_slow => clk60);
db: debounce Port map(clk => clk, sig_in => btn_up, sig_out => knop);

seg: seg7 Port map(x => vvv,g_to_a => g_to_a, dp => dp);
mux: mux21 Port map (sel => counter, an => an);

nhc <= to_integer(signed(hc));
nvc <= to_integer(signed(vc));
xxx: clk_wiz_0 port map (clk_in1 => clk, clk_out1 => clk25, reset => clr, locked => open);

vga: vga_640x480 Port map(clk => clk25, clr => clr, hsync => Hsync, vsync => Vsync, hc => hc, vc => vc, vidon => vidon);
sp1: blk_mem_gen_0 PORT MAP ( clka => clk, addra => rom_sprite_paddle, douta => M );
sp2: blk_mem_gen_paddle2 PORT MAP ( clka => clk, addra => rom_sprite_paddle2, douta => M2 );
mem_ball: blk_mem_gen_ball PORT MAP ( clka => clk, addra => rom_sprite_ball, douta => M_ball );

--rr: vga_sprite Port Map(clk => clk,clk60 => clk60, vidon => vidon,hc => hc,vc => vc,
--                        M => M, M_ball => M_ball,
--                        sw => sw,
--                        rom_sprite_paddle => rom_sprite_paddle, rom_sprite_ball => rom_sprite_ball, 
--                        btn_up => knop, btn_down => btn_down,btn_reset => btn_reset);
rr: vga_sprite Port Map(clk => clk,clk60 => clk60, 
                        vidon => vidon,hc => hc,vc => vc,
                        M => M,M2 => M2, M_ball => M_ball,
                        sw => sw,
                        rom_sprite_paddle => rom_sprite_paddle,rom_sprite_paddle2 => rom_sprite_paddle2, rom_sprite_ball => rom_sprite_ball,
                        red => vgaRed,green => vgaGreen,blue => vgaBlue, 
                        btn_up => knop, btn_down => btn_down,btn_reset => btn_reset, btn_start => btn_start);


end Behavioral;                                                                            
