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
use IEEE.STD_LOGIC_ARITH.ALL;
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
        btn: in STD_LOGIC;
        led: out STD_LOGIC_VECTOR (3 downto 0);
        x : in STD_LOGIC_VECTOR (3 downto 0);
        an_in : in STD_LOGIC_VECTOR (3 downto 0);
        g_to_a : out STD_LOGIC_VECTOR (6 downto 0);
        an : out STD_LOGIC_VECTOR (3 downto 0);
        dp : out STD_LOGIC;
        sel: in STD_LOGIC_VECTOR(1 downto 0)
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

-- ####################################################
-- ####################################################

signal div: STD_LOGIC;
signal knop: STD_LOGIC;
signal counter: STD_LOGIC_VECTOR (1 downto 0);
signal vierkant: STD_LOGIC_VECTOR (3 downto 0);
signal vvv: STD_LOGIC_VECTOR (3 downto 0);

-- ####################################################
-- ####################################################

begin
clock: clock_div Port map(clk_in => clk,clk_out => div);
seg: seg7 Port map(x => vvv,g_to_a => g_to_a, dp => dp);
mux: mux21 Port map (sel => counter, an => an);
end Behavioral;
