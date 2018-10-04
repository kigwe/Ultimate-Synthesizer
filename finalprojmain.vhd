----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 06/06/2018 11:07:58 AM
-- Design Name: 
-- Module Name: finalprojmain - Behavioral
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
use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity finalprojmain is
    Port ( sw : in STD_LOGIC_VECTOR (0 to 14);
           button : in STD_LOGIC_VECTOR (0 to 2);
           clk : in STD_LOGIC;
           segs : out STD_LOGIC_VECTOR (0 to 7);
           anodes : out STD_LOGIC_VECTOR (0 to 3);
           leds : out STD_LOGIC_VECTOR (0 to 14);
           volume, note, lowpower : out STD_LOGIC);
end finalprojmain;

architecture Behavioral of finalprojmain is
    
    component statechanger
        Port ( bt1, bt2, bt3 : in STD_LOGIC; 
               clk : in STD_LOGIC;
               chord_s : out STD_LOGIC;
               oct_s : out STD_LOGIC_VECTOR (1 downto 0);
               segs : out STD_LOGIC_VECTOR (0 to 7);
               anodes : out STD_LOGIC_VECTOR (0 to 3));
    end component;
    
    component notestorage
        Port ( sw : in STD_LOGIC_VECTOR (0 to 14);
               clk, EN : in STD_LOGIC;
               octave : in STD_LOGIC_VECTOR (1 downto 0);           
               leds : out STD_LOGIC_VECTOR(0 to 14);
               note, volume, lowpow : out STD_LOGIC);
    end component;
     
    signal temp_oct: std_logic_vector(1 downto 0);
    signal temp_chord: std_logic;
    signal temp_key: integer;
    
begin

    states: statechanger 
    port map (bt1 => button(0),
              bt2 => button(1),
              bt3 => button(2),
              oct_s => temp_oct,
              chord_s => temp_chord,
              clk => clk,
              segs => segs,
              anodes => anodes);
              
    notesstored: notestorage
    port map (sw => sw,
              clk => clk,
              EN => temp_chord,
              octave => temp_oct,
              leds => leds,
              volume => volume,
              note => note,
              lowpow => lowpower);

end Behavioral;
