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
  M_ball: in std_logic_vector(0 to 15);
  sw: in std_logic_vector(7 downto 0);
  rom_sprite_paddle: out std_logic_vector(3 downto 0);
  rom_sprite_ball: out std_logic_vector(3 downto 0);
  red : out std_logic_vector(3 downto 0);
  green : out std_logic_vector(3 downto 0);
  blue : out std_logic_vector(3 downto 0);
  btn_up: in std_logic;
  btn_down: in std_logic;
  btn_reset: in STD_LOGIC;
  btn_start: in STD_LOGIC
);
end vga_sprite;


architecture Behavioral of vga_sprite is

constant hbp: std_logic_vector(9 downto 0) := "0010010000"; --144
constant vbp: std_logic_vector(9 downto 0) := "0000011111"; --31
constant w: integer := 16;
constant h: integer := 16;

constant Y_ball_start: integer := 236;
constant X_ball_start: integer := 310;

constant Y_paddle_start: integer := 236;
constant X_paddle_start: integer := 8;


constant ball_max_left: integer := 2;
constant ball_max_right: integer := 620;

constant ball_max_top: integer := 66;
constant ball_max_bottom: integer := 408;

constant paddle_max_top: integer := 70;
constant paddle_max_bottom: integer := 403;
signal X_paddle: std_logic_vector(10 downto 0) := conv_std_logic_vector(conv_integer(X_paddle_start),11);
signal Y_paddle: std_logic_vector(10 downto 0) := conv_std_logic_vector(conv_integer(Y_paddle_start),11);

--signal X_ball: std_logic_vector(10 downto 0) := conv_std_logic_vector(conv_integer(310),11);
signal X_ball: std_logic_vector(10 downto 0) := conv_std_logic_vector(conv_integer(X_ball_start),11);
signal Y_ball: std_logic_vector(10 downto 0) := conv_std_logic_vector(conv_integer(Y_ball_start),11);
--signal Y_ball: std_logic_vector(10 downto 0) := conv_std_logic_vector(conv_integer(8),11);

signal rom_addr, rom_pix: std_logic_vector(10 downto 0);
signal spriteon, R, G, B: std_logic;

signal red_paddle: STD_LOGIC_VECTOR (3 downto 0);                     -- rood
signal green_paddle : STD_LOGIC_VECTOR (3 downto 0);                   -- groen
signal blue_paddle : STD_LOGIC_VECTOR (3 downto 0);                   -- blauw

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

-- constants
constant vc_left_centerline: integer := 150;
constant vc_rigt_centerline: integer := 775;
constant vc_centerline: integer := ((vc_rigt_centerline - vc_left_centerline) / 2) + vc_left_centerline;

constant hc_topline: integer := 100;
constant hc_bottomline: integer := 450;
constant hc_centerline: integer := ((hc_bottomline - hc_topline) / 2) + hc_topline;

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

signal q1,q2,q3,q4,qml,qmr: std_logic := '1';
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
    
   
    -- paddle logic
    process(vidon,clk60,btn_up,btn_down,btn_reset) begin
        if btn_reset = '1' then                          --paddle reset
            Y_paddle<=  conv_std_logic_vector(conv_integer(Y_paddle_start),11);
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

    -- reset logic
    process(btn_reset) begin
        if btn_reset = '1' and reset_paddle ='1' and reset_ball = '1' then                          --paddle reset
                reset <= '0';
        end if;
    end process;
    --ball logic
    process(vidon,clk60,btn_start,direction) begin     
        if rising_edge(clk60) then
            -- press btn to start game 
            if btn_start = '1' then
                ball_fall <= '0';
                ball_down <= '0';
                direction <= "0101";
                qml <= '0';             

            end if;
            -- press reset btn to reset game
            if btn_reset = '1' then                          
                ball_fall <= '1';  
                Y_ball <=  conv_std_logic_vector(conv_integer(Y_ball_start),11);
                X_ball <= conv_std_logic_vector(conv_integer(X_ball_start),11);
                q1 <= '1';             
                q2 <= '1';                  
                q3 <= '1';             
                q1 <= '1';                  
                qml <= '1';             
                qmr <= '1';             
            end if;
        -- logic       
            if  vidon = '1' and ball_fall = '0' then
--                    case (direction) is
--                        when "0000" => q3 <= '0';
--                        when "0001" => q1 <= '0';
--                        when "0010" => q2 <= '0';
--                        when "0011" => q4 <= '0';
--                        when "0101" => qm <= '0';
--                        when others => q4 <= '0';
--                    end case;
                    if qml = '0' then
                        X_ball <= conv_std_logic_vector(conv_integer(X_ball) - 1,11);
                    elsif qmr = '0' then
                            X_ball <= conv_std_logic_vector(conv_integer(X_ball) + 1,11);
                    elsif q1 = '0' then
                                if Y_ball >= conv_std_logic_vector(conv_integer(ball_max_top),11) and X_ball <= conv_std_logic_vector(conv_integer(ball_max_right),11)then
                                    X_ball <= conv_std_logic_vector(conv_integer(X_ball) + 1,11);
                                    Y_ball <= conv_std_logic_vector(conv_integer(Y_ball) - 1,11);
                                else
                                    q1 <= '1';
                                    q2 <= '0';
                                end if;
                    elsif q2 = '0' then
                                if Y_ball <= conv_std_logic_vector(conv_integer(ball_max_bottom),11) and X_ball <= conv_std_logic_vector(conv_integer(ball_max_right),11) then
                                    X_ball <= conv_std_logic_vector(conv_integer(X_ball) + 1,11);
                                    Y_ball <= conv_std_logic_vector(conv_integer(Y_ball) + 1,11);
                                else
                                    q1 <= '0';
                                    q2 <= '1';
                                    
                                end if;

                   end if;              
                    if qml ='0' and X_ball <= X_paddle and Y_ball >= conv_std_logic_vector(conv_integer(Y_paddle)-paddle_offset,11) and Y_ball <= conv_std_logic_vector(conv_integer(Y_paddle)+ paddle_offset,11) then
                            if  X_ball <= X_paddle and Y_ball = Y_paddle then
                                qml <= '1';
                                qmr <= '0';
                                q1 <= '1';

                            elsif X_ball <= X_paddle and Y_ball >= conv_std_logic_vector(conv_integer(Y_paddle)-paddle_offset,11) and Y_ball <= conv_std_logic_vector(conv_integer(Y_paddle),11) then
                                qml <= '1';
                                qmr <= '1';
                                q1 <= '0';
                            elsif X_ball <= X_paddle and Y_ball <= conv_std_logic_vector(conv_integer(Y_paddle)+paddle_offset,11) and Y_ball >= conv_std_logic_vector(conv_integer(Y_paddle),11) then
                                    qml <= '1';
                                    qmr <= '1';
                                    q1 <= '1';
                                    q2 <= '0';
                            end if;
                    end if;
            end if; 
        end if;
    end process;   
--    --ball logic
--    process(vidon,clk60,btn_start) begin     
--    if rising_edge(clk60) then
--        -- press btn to start game 
--        if btn_start = '1' then
--            ball_fall <= '0';
--            ball_down <= '0';
--        end if;
--        -- press reset btn to reset game
--        if btn_reset = '1' then                          
--            ball_down <= '1';
--            ball_up <= '1';  
--            ball_fall <= '1';  
--            Y_ball <=  conv_std_logic_vector(conv_integer(Y_ball_start),11);
--            X_ball <= conv_std_logic_vector(conv_integer(X_ball_start),11);             
--        end if;
--        -- logic       
--        if  vidon = '1' and ball_fall = '0' then
--            if ball_fall = '0' and ball_down = '0' and q1 = '1'then
--                -- make sure ball hits the peddle within a certain range            
--                if   X_ball <= X_paddle and Y_ball >= conv_std_logic_vector(conv_integer(Y_paddle)-paddle_offset,11) and Y_ball <= conv_std_logic_vector(conv_integer(Y_paddle)+ paddle_offset,11) then
----                    ball_down <= '1';  
----                    ball_up <= '0';
--                    if X_ball <= X_paddle and Y_ball = Y_paddle then
--                        ball_down <= '1';  
--                        ball_up <= '0';
--                    elsif X_ball <= X_paddle and Y_ball >= conv_std_logic_vector(conv_integer(Y_paddle)-paddle_offset,11) and Y_ball <= conv_std_logic_vector(conv_integer(Y_paddle) -1, 11) then
--                    q1 <= '0';
 
--                    else
--                        ball_up <= '1';
--                        ball_down <= '1';     
--                        ball_fall <= '1'; 
--                        Y_ball <=  conv_std_logic_vector(conv_integer(Y_ball_start),11);
--                        X_ball <= conv_std_logic_vector(conv_integer(X_ball_start),11);                                    
--                    end if;
--                -- if peddle misses ball reset the game
--                elsif X_ball <= (conv_std_logic_vector(conv_integer(X_paddle_start),11))and (ball_down = '0') then
--                    ball_up <= '1';
--                    ball_down <= '1';     
--                    ball_fall <= '1'; 
--                    Y_ball <=  conv_std_logic_vector(conv_integer(Y_ball_start),11);
--                    X_ball <= conv_std_logic_vector(conv_integer(X_ball_start),11);
                
----                elsif q1 = '0' and Y_ball <= conv_std_logic_vector(conv_integer(ball_max_top),11) then
----                    Y_ball <= conv_std_logic_vector(conv_integer(Y_ball) - 1,11);
----                    X_ball <= conv_std_logic_vector(conv_integer(X_ball) + 1,11);   
--                -- else move ball to the left side of the field                     
--                else
--                    X_ball <= conv_std_logic_vector(conv_integer(X_ball)-1,11);                         
--                end if;
--            -- if ball has bounced of the paddle then reverse ball direction
--            elsif X_ball < (conv_std_logic_vector(conv_integer(ball_max_right),11)) and (ball_up = '0') then
--                 X_ball <= conv_std_logic_vector(conv_integer(X_ball)+1,11);
--            -- if ball bouces on the right wall reverse ball direction
--            elsif X_ball <= (conv_std_logic_vector(conv_integer(ball_max_right),11)) and (ball_up = '0') then
--                 ball_up <= '1';
--                 ball_down <= '0'; 
--            elsif q1 = '0' and Y_ball <= conv_std_logic_vector(conv_integer(ball_max_top),11) then
            
--                Y_ball <= conv_std_logic_vector(conv_integer(Y_ball) - 1,11);
--                X_ball <= conv_std_logic_vector(conv_integer(X_ball) + 1,11);   
--            elsif q1 = '0' then -- and Y_ball >= conv_std_logic_vector(conv_integer(ball_max_top),11) then
                
--                    q1 <='1';
--            end if;   
--        end if;                                          
--    end if;    
--end process;

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
    
    --show colors on VGA
    process(clk) begin
        if rising_edge(clk) then
            red <= red_paddle or red_bg or red_ball;
            green <= green_paddle or green_bg or green_ball;
            blue <= blue_paddle or blue_bg or blue_ball;
        end if;
   end process;
end Behavioral;
