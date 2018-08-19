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
--    clk: in std_logic;
--    clk60: in std_logic;
--    vidon: in std_logic;
--    hc : in std_logic_vector(9 downto 0);
--    vc : in std_logic_vector(9 downto 0);
    
--    M: in std_logic_vector(0 to 15);
--    M_ball: in std_logic_vector(0 to 15);
    
--    sw: in std_logic_vector(7 downto 0);
    
--    rom_sprite_paddle: out std_logic_vector(3 downto 0);
--    rom_sprite_ball: out std_logic_vector(3 downto 0);
    
--    red : out std_logic_vector(3 downto 0);
--    green : out std_logic_vector(3 downto 0);
--    blue : out std_logic_vector(3 downto 0);
    
--    btn_up: in std_logic;
--    btn_down: in std_logic;
--    btn_reset: in std_logic


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
  btn_start: in STD_LOGIC;
  scored: out STD_LOGIC;
  rst: out STD_LOGIC := '1'
);
end vga_sprite;


architecture Behavioral of vga_sprite is

-- constants
constant vc_left_centerline: integer := 150;
constant vc_rigt_centerline: integer := 775;
constant vc_centerline: integer := ((vc_rigt_centerline - vc_left_centerline) / 2) + vc_left_centerline;

constant hc_topline: integer := 150;
constant hc_bottomline: integer := 400;
constant hc_centerline: integer := ((hc_bottomline - hc_topline) / 2) + hc_topline;






constant hbp: std_logic_vector(9 downto 0) := "0010010000"; --144
constant vbp: std_logic_vector(9 downto 0) := "0000011111"; --31
constant w: integer := 16;
constant h: integer := 16;

constant ball_max_left: integer := 2;
constant ball_max_right: integer := 620;
constant paddle_offset_start: integer := 6;

constant Y_ball_start: integer := 236;
constant X_ball_start: integer := 310;

constant Y_paddle_start: integer := 236 - 40;
constant X_paddle_start: integer := ball_max_left + paddle_offset_start;

constant Y_paddle_start2: integer := 236 + 40;
constant X_paddle_start2: integer := ball_max_right - paddle_offset_start;



constant ball_max_top: integer := (hc_topline - 35);
constant ball_max_bottom: integer := (hc_bottomline - 42);

constant paddle_max_top: integer := (hc_topline - 30);
constant paddle_max_bottom: integer := (hc_bottomline - 47);
signal X_paddle: std_logic_vector(10 downto 0) := conv_std_logic_vector(conv_integer(X_paddle_start),11);
signal Y_paddle: std_logic_vector(10 downto 0) := conv_std_logic_vector(conv_integer(Y_paddle_start),11);

signal X_paddle2: std_logic_vector(10 downto 0) := conv_std_logic_vector(conv_integer(X_paddle_start2),11);
signal Y_paddle2: std_logic_vector(10 downto 0) := conv_std_logic_vector(conv_integer(Y_paddle_start2),11);

--signal X_ball: std_logic_vector(10 downto 0) := conv_std_logic_vector(conv_integer(310),11);
signal X_ball: std_logic_vector(10 downto 0) := conv_std_logic_vector(conv_integer(X_ball_start),11);
signal Y_ball: std_logic_vector(10 downto 0) := conv_std_logic_vector(conv_integer(Y_ball_start),11);
--signal Y_ball: std_logic_vector(10 downto 0) := conv_std_logic_vector(conv_integer(8),11);

signal rom_addr, rom_pix: std_logic_vector(10 downto 0);
signal spriteon, R, G, B: std_logic;

signal red_paddle: STD_LOGIC_VECTOR (3 downto 0);                     -- rood
signal green_paddle : STD_LOGIC_VECTOR (3 downto 0);                   -- groen
signal blue_paddle : STD_LOGIC_VECTOR (3 downto 0);                   -- blauw
--
signal rom_addr2, rom_pix2: std_logic_vector(10 downto 0);
signal spriteon2, R2, G2, B2: std_logic;

signal red_paddle2: STD_LOGIC_VECTOR (3 downto 0);                     -- rood
signal green_paddle2 : STD_LOGIC_VECTOR (3 downto 0);                   -- groen
signal blue_paddle2 : STD_LOGIC_VECTOR (3 downto 0);                   -- blauw

--
signal red_ball: STD_LOGIC_VECTOR (3 downto 0);                     -- rood
signal green_ball : STD_LOGIC_VECTOR (3 downto 0);                   -- groen
signal blue_ball : STD_LOGIC_VECTOR (3 downto 0);                   -- blauw

signal rom_addY_ball, rom_pix_ball: std_logic_vector(10 downto 0);
signal spriteon_ball, RB, GB, BB: std_logic;

signal red_bg: STD_LOGIC_VECTOR (3 downto 0);                     -- rood
signal green_bg : STD_LOGIC_VECTOR (3 downto 0);                   -- groen
signal blue_bg : STD_LOGIC_VECTOR (3 downto 0);                   -- blauw

constant wb: integer := 16;
constant hb: integer := 16;

constant w2: integer := 16;
constant h2: integer := 16;

constant paddle_offset: integer := 8; 
constant paddle_max: integer := conv_integer(Y_paddle) - 20; 
constant paddle_min: integer := conv_integer(Y_paddle) + 20; 



signal ball_fall: std_logic := '1';
signal ball_down: std_logic := '1';
signal ball_up: std_logic := '1';
signal reset_paddle: std_logic := '1';
signal reset_ball: std_logic := '1';
signal reset: std_logic := '1';
signal collision: std_logic := '1';
signal sr1,sr2: std_logic := '1';
signal q1,q2,q3,q4,qml,qmr,dir_right,dir_left,start,game_over,ball: std_logic := '1';
signal direction: std_logic_vector (3 downto 0);
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
--            -- horizontaal midden       
--            elsif vc = hc_centerline and (hc >= vc_left_centerline and hc <= vc_rigt_centerline) then
--                red_bg <= "1111";
--                green_bg <= "1111";
--                blue_bg <= "1111";
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
    
   
    -- paddle logic
    process(vidon,clk60,btn_up,btn_down,btn_reset) begin
        if btn_reset = '1' then                          --paddle reset
            Y_paddle<=  conv_std_logic_vector(conv_integer(Y_paddle_start),11);
            X_paddle <= conv_std_logic_vector(conv_integer(X_paddle_start),11); 
  
        end if;
        if game_over = '0' then
            Y_paddle <=  conv_std_logic_vector(conv_integer(Y_paddle_start),11);
            X_paddle <= conv_std_logic_vector(conv_integer(X_paddle_start),11);
        end if;
        if rising_edge(clk60) then
            --paddle boven
            if btn_up = '1' and vidon = '1' then
                if Y_paddle > conv_std_logic_vector(conv_integer(paddle_max_top),11) then
                    Y_paddle <= conv_std_logic_vector(conv_integer(Y_paddle)-1,11);
                end if;
            --paddle beneden
            elsif btn_down = '1' and vidon = '1' then                         
                if Y_paddle < conv_std_logic_vector(conv_integer(paddle_max_bottom),11) then
                    Y_paddle <= conv_std_logic_vector(conv_integer(Y_paddle)+1,11);
                end if;
            end if;
        end if;
    end process;   


    -- paddle2 logic
    process(vidon,clk60,btn_reset) begin
        if btn_reset = '1' then                          --paddle reset
            Y_paddle2 <=  conv_std_logic_vector(conv_integer(Y_paddle_start2),11);
            X_paddle2 <= conv_std_logic_vector(conv_integer(X_paddle_start2),11);
               
        end if;
        
        if rising_edge(clk60) then
            if vidon = '1' then
                 game_over <= '1';
                --paddle boven
                if y_ball >= conv_std_logic_vector(conv_integer(paddle_max_top),11) and start = '0' then           
                        Y_paddle2 <= conv_std_logic_vector(conv_integer(y_ball),11);
                
                --paddle beneden
                elsif y_ball <= conv_std_logic_vector(conv_integer(paddle_max_bottom),11) and start = '0' then
                    Y_paddle2 <= conv_std_logic_vector(conv_integer(y_ball),11);
                end if;
                if game_over = '0' then
                    Y_paddle2 <=  conv_std_logic_vector(conv_integer(Y_paddle_start2),11);
                    X_paddle2 <= conv_std_logic_vector(conv_integer(X_paddle_start2),11);
                    
                end if;
            end if;
        end if;
    end process;  

    -- reset logic
    process(btn_reset) begin
        if btn_reset = '1' and reset_paddle ='1' and reset_ball = '1' then                          --paddle reset
                reset <= '0';
                
        end if;
    end process;
    --ball logic
    process(vidon,clk60,btn_start,direction,sr1) begin     
        if rising_edge(clk60) then
            -- press btn to start game 
            if btn_start = '1' then
                ball_fall <= '0';
                ball_down <= '0';
                qml <= '0'; 
                rst <= '0';
                start <= '0';
                game_over <= '1';            
            else
                scored <= '1';
                rst <= '1';            

            end if;
            -- press reset btn to reset game
            if btn_reset = '1' then                          
                ball_fall <= '1';  
                Y_ball <=  conv_std_logic_vector(conv_integer(Y_ball_start),11);
                X_ball <= conv_std_logic_vector(conv_integer(X_ball_start),11);
                direction <= (others => '1');                 
                qml <= '1';             
                qmr <= '1';
                rst <= '0';
                game_over <= '1';
                start <= '1';
             
            end if;
        -- logic       
            if  vidon = '1' and ball_fall = '0' then
                    if qml = '0' then                        

                        X_ball <= conv_std_logic_vector(conv_integer(X_ball) - 1,11);
                    elsif qmr = '0' then
                        X_ball <= conv_std_logic_vector(conv_integer(X_ball) + 1,11);
                    elsif direction(0) = '0' then
                                if Y_ball >= conv_std_logic_vector(conv_integer(ball_max_top),11) and X_ball <= conv_std_logic_vector(conv_integer(X_paddle2),11)then
                                    
                                    X_ball <= conv_std_logic_vector(conv_integer(X_ball) + 1,11);
                                    Y_ball <= conv_std_logic_vector(conv_integer(Y_ball) - 1,11);
                                elsif X_ball >= X_paddle2 and Y_ball >= conv_std_logic_vector(conv_integer(Y_paddle2)-paddle_offset,11) and Y_ball <= conv_std_logic_vector(conv_integer(Y_paddle2)+ paddle_offset,11) then
                                        qml <= '1';
                                        qmr <= '1';
                                        direction <= (others => '1');                 
                                else
                                    direction <= "1101";                 
                                end if;
                                
                    elsif direction(1) = '0' then
                                if Y_ball <= conv_std_logic_vector(conv_integer(ball_max_bottom),11) and X_ball <= conv_std_logic_vector(conv_integer(X_paddle2),11) then
                                    X_ball <= conv_std_logic_vector(conv_integer(X_ball) + 1,11);
                                    Y_ball <= conv_std_logic_vector(conv_integer(Y_ball) + 1,11);
                                elsif X_ball >= X_paddle2 and Y_ball >= conv_std_logic_vector(conv_integer(Y_paddle2)-paddle_offset,11) and Y_ball <= conv_std_logic_vector(conv_integer(Y_paddle2)+ paddle_offset,11) then
                                    direction <= (others => '1');                 
                                    qml <= '1';
                                    qmr <= '1';
                                else
                                    direction <= "1110";                            
                                end if;
                    elsif direction(2) = '0' then
                                if Y_ball >= conv_std_logic_vector(conv_integer(ball_max_top),11) and X_ball >= conv_std_logic_vector(conv_integer(X_paddle),11)then
                                    
                                    X_ball <= conv_std_logic_vector(conv_integer(X_ball) - 1,11);
                                    Y_ball <= conv_std_logic_vector(conv_integer(Y_ball) - 1,11);
                                elsif X_ball <= X_paddle and Y_ball >= conv_std_logic_vector(conv_integer(Y_paddle)-paddle_offset,11) and Y_ball <= conv_std_logic_vector(conv_integer(Y_paddle)+ paddle_offset,11) then
                                        direction <= (others => '1');
                                        qml <= '1';
                                        qmr <= '1';
                 
                                else
                                    direction <= "0111";                 
                                end if;
                    elsif direction(3) = '0' then
                                if Y_ball <= conv_std_logic_vector(conv_integer(ball_max_bottom),11) and X_ball >= conv_std_logic_vector(conv_integer(X_paddle),11) then
                                    X_ball <= conv_std_logic_vector(conv_integer(X_ball) - 1,11);
                                    Y_ball <= conv_std_logic_vector(conv_integer(Y_ball) + 1,11);
                                elsif X_ball <= X_paddle and Y_ball >= conv_std_logic_vector(conv_integer(Y_paddle)-paddle_offset,11) and Y_ball <= conv_std_logic_vector(conv_integer(Y_paddle)+ paddle_offset,11) then
                                    direction <= (others => '1');                 
                                    qml <= '1';                               
                                    qmr <= '1';                               
                                else
                                    direction <= "1011";                            
                                end if;
                   end if;              
                    if  X_ball <= X_paddle and Y_ball >= conv_std_logic_vector(conv_integer(Y_paddle)-paddle_offset,11) and Y_ball <= conv_std_logic_vector(conv_integer(Y_paddle)+ paddle_offset,11) then
                            -- ball goes from left side to the right side
 
                                 scored <= '0';
 
 
                            if  qml ='0' and X_ball <= X_paddle and Y_ball = Y_paddle then
                                qml <= '1';
                                qmr <= '0';
                                direction <= (others => '1');
                
                            -- ball rechtsboven
                            elsif X_ball = X_paddle and Y_ball >= conv_std_logic_vector(conv_integer(Y_paddle)-paddle_offset,11) and Y_ball <= conv_std_logic_vector(conv_integer(Y_paddle),11) then
                                direction <= "1110";
                                qml <= '1';
                                qmr <= '1';

                            -- rechts beneden
                            elsif X_ball = X_paddle and Y_ball <= conv_std_logic_vector(conv_integer(Y_paddle)+paddle_offset,11) and Y_ball >= conv_std_logic_vector(conv_integer(Y_paddle),11) then
                                direction <= "1101";
                                qml <= '1';
                                qmr <= '1';
--                                                scored <= '0';
                 
                            end if;
                            
                    elsif X_ball >= X_paddle2 and Y_ball >= conv_std_logic_vector(conv_integer(Y_paddle2)-paddle_offset,11) and Y_ball <= conv_std_logic_vector(conv_integer(Y_paddle2)+ paddle_offset,11) then
                                 scored <= '1';

                             -- ball goes from right side to the left side
                             if  qmr = '0' and X_ball = X_paddle2 and Y_ball = conv_std_logic_vector(conv_integer(Y_paddle2),11) then
                                qml <= '0';
                                qmr <= '1';
                                direction <= (others => '1');
                            -- ball links boven
                            elsif X_ball = X_paddle2 and Y_ball < conv_std_logic_vector(conv_integer(Y_paddle_start2), 11) then
                                direction <= "1011";                 
                                qml <= '1';
                                qmr <= '1';
                            -- ball links beneden                                   
                            elsif X_ball = X_paddle2 and Y_ball > conv_std_logic_vector(conv_integer(Y_paddle_start2), 11) then                 
                                direction <= "0111";                 
                                qml <= '1';
                                qmr <= '1';   
                            end if;
                    elsif  X_ball < (conv_std_logic_vector(conv_integer(X_paddle_start),11)) then
                        ball_fall <= '1';  
                        Y_ball <=  conv_std_logic_vector(conv_integer(Y_ball_start),11);
                        X_ball <= conv_std_logic_vector(conv_integer(X_ball_start),11);
                        direction <= (others => '1');                 
                        rst <= '1';
                  
                        qml <= '1';             
                        qmr <= '1';
                        
                        game_over <= '0';
                    end if;
            end if; 
        end if;
    end process; 
    rom_addr <= vc - vbp - Y_paddle;
    rom_pix <= hc - hbp - X_paddle;  
    rom_sprite_paddle <= rom_addr(3 downto 0);   
    --Enable sprite video out when within the sprite region
    spriteon <= '1' when (((hc >= X_paddle + hbp) and (hc < X_paddle + hbp + w)) and ((vc >= Y_paddle + vbp) and (vc < Y_paddle + vbp + h))) else '0';
    
    rom_addY_ball <= vc - vbp - Y_ball;
    rom_pix_ball <= hc - hbp - X_ball;  
    rom_sprite_ball <= rom_addY_ball(3 downto 0);   
    --Enable sprite video out when within the sprite region
    spriteon_ball <= '1' when (((hc >= X_ball + hbp) and (hc < X_ball + hbp + wb)) and ((vc >= Y_ball + vbp) and (vc < Y_ball + vbp + hb))) else '0';

    rom_addr2 <= vc - vbp - Y_paddle2;
    rom_pix2 <= hc - hbp - X_paddle2;  
    rom_sprite_paddle2 <= rom_addr2(3 downto 0);   
    --Enable sprite video out when within the sprite region
    spriteon2 <= '1' when (((hc >= X_paddle2 + hbp) and (hc < X_paddle2 + hbp + w2)) and ((vc >= Y_paddle2 + vbp) and (vc < Y_paddle2 + vbp + h2))) else '0';

    
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
    
    process(spriteon_ball, vidon, rom_pix_ball, M_ball)
        variable k: integer;
        
        begin
        red_ball <= "0000";
        green_ball <= "0000";
        blue_ball <= "0000";
        
        if spriteon_ball = '1' and vidon = '1' then
            k := conv_integer(rom_pix_ball);
            RB <= M_ball(k);
            GB <= M_ball(k);
            BB <= M_ball(k);
            red_ball <= RB & RB & RB & RB;
            green_ball <= GB & GB & GB & GB;
            blue_ball <= BB & BB & BB & BB;
        end if;
    end process;
        
    process(spriteon2, vidon, rom_pix2, M2)
        variable j: integer;
        
        begin
        red_paddle2 <= "0000";
        green_paddle2 <= "0000";
        blue_paddle2 <= "0000";
        
        if spriteon2 = '1' and vidon = '1' then
            j := conv_integer(rom_pix2);
            R2 <= M2(j);
            G2 <= M2(j);
            B2 <= M2(j);
            red_paddle2 <= R2 & R2 & R2 & R2;
            green_paddle2 <= G2 & G2 & G2 & G2;
            blue_paddle2 <= B2 & B2 & B2 & B2;
        end if;
    end process;    
    --show colors on VGA
    process(clk) begin
        if rising_edge(clk) then
            red <= red_paddle or red_bg or red_ball or red_paddle2;
            green <= green_paddle or green_bg or green_ball or green_paddle2;
            blue <= blue_paddle or blue_bg or blue_ball or blue_paddle2;
        end if;
   end process;
end Behavioral;