----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 06/02/2018 03:01:38 PM
-- Design Name: 
-- Module Name: genrestate - Behavioral
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
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity statechanger is
    Port ( bt1, bt2, bt3: in STD_LOGIC; 
           clk : in STD_LOGIC;
           chord_s : out STD_LOGIC;
           oct_s : out STD_LOGIC_VECTOR (1 downto 0);
           segs : out STD_LOGIC_VECTOR (0 to 7);
           anodes : out STD_LOGIC_VECTOR (0 to 3));
           
end statechanger;

architecture Behavioral of statechanger is

    component clk_div
        Port (clk : in std_logic;
              sclk : out std_logic);
    end component;

    signal cnt_dig : std_logic_vector(1 downto 0);
    signal octstat : std_logic_vector(1 downto 0) := "00"; 
    signal digit : std_logic_vector (3 downto 0);
    signal temp_fclk : std_logic;
    signal chordstat: std_logic := '0';
    
begin

    fast_clk: clk_div 
    port map (clk => clk,
              sclk => temp_fclk);
              
    --slow_clk: clk_div2 
    --port map (clk => clk,
    --          sclk => temp_sclk);
    
    cnt_proc: process(temp_fclk)
    begin
        if (rising_edge(temp_fclk)) then 
            cnt_dig <= cnt_dig + 1; 
        end if; 
    end process cnt_proc; 
 
    -- select the display sseg data abcdefg (active low) -----
    segs <= "11111101" when digit = "0011"  else -- '-'
                "00000011" when digit = "0100"  else -- O
                "00100101" when digit = "1010"  else -- 2
                "00001101" when digit = "1011"  else -- 3
                "10011001" when digit = "1100"  else -- 4
                "01001001" when digit = "1101"  else -- 5
                "10011111" when digit = "1110"  else -- 1
                "11111111"; 
 
    anodes <= "1110" when cnt_dig = "00" else 
               "1101" when cnt_dig = "01" else
               "1011" when cnt_dig = "10" else
               "0111" when cnt_dig = "11" else
               "1111";
    
    ocl_proc: process(bt1, bt2, bt3, chordstat, octstat)
    begin
        if (bt2 = '1') and (bt3 = '1') and (bt1 = '0') then
            case chordstat is
                when '1' =>
                    chordstat <= '0';
                when '0' =>
                    chordstat <= '1';
                when others =>
                    chordstat <= chordstat;
            end case;
        elsif (bt2 = '0') and (bt3 = '0') and (bt1 = '1') then
            case octstat is
                when "00" =>
                    octstat <= "01";
                when "01" =>
                    octstat <= "10";
                when "10" =>
                    octstat <= "00";
                when others =>
                    octstat <= "00";
            end case;
        end if;
        oct_s <= octstat;
        chord_s <= chordstat;
    end process ocl_proc;
    
    disp_process: process(cnt_dig, octstat, chordstat, bt1, bt2, bt3)
    begin 
      if bt3 = '1' and bt1 = '0' then 
            case cnt_dig is
                when "01" => digit <= "1001"; -- c
                when "10" => digit <= "0011"; -- '-'
                when "11" =>
                    if chordstat = '1' then
                        digit <= "1110"; -- 1
                    else
                        digit <= "0100"; -- 0
                    end if;
                when others => digit <= "1111"; 
            end case;
       else
            case cnt_dig is
                when "01" =>
                    if octstat = "00" then
                        digit <= "1010"; -- 2
                    elsif octstat = "01" then
                        digit <= "1011"; -- 3
                    elsif octstat = "10" then
                        digit <= "1100"; -- 4
                    end if;
                when "10" => digit <= "0011"; -- '-'
                when "11" => 
                    if octstat = "00" then
                        digit <= "1011"; -- 3
                    elsif octstat = "01" then
                        digit <= "1100"; -- 4
                    elsif octstat = "10" then
                        digit <= "1101"; -- 5
                    end if;
                when others => digit <= "1111"; 
            end case;
        end if;
    end process disp_process;
 
end Behavioral;

-----------------------------------------------------------------------
-----------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;
-----------------------------------------------------------------------
-- Module to divide the clock 
-----------------------------------------------------------------------
entity clk_div is
    Port (  clk : in std_logic;
           sclk : out std_logic);
end clk_div;

architecture my_clk_div of clk_div is
   constant max_count : integer := (1100);  
   signal tmp_clk : std_logic := '0'; 
begin
   my_div: process (clk, tmp_clk)              
      variable div_cnt : integer := 0;   
   begin
      if (rising_edge(clk)) then   
         if (div_cnt = MAX_COUNT) then 
            tmp_clk <= not tmp_clk; 
            div_cnt := 0; 
         else
            div_cnt := div_cnt + 1; 
         end if; 
      end if; 
      sclk <= tmp_clk; 
   end process my_div; 
end my_clk_div;