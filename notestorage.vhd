----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 06/07/2018 01:36:40 PM
-- Design Name: 
-- Module Name: notestorage - Behavioral
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

entity notestorage is
    Port ( sw : in STD_LOGIC_VECTOR (0 to 14);
           clk, EN : in STD_LOGIC;
           octave : in STD_LOGIC_VECTOR (1 downto 0);           
           leds : out STD_LOGIC_VECTOR(0 to 14);
           note, volume, lowpow : out STD_LOGIC);
end notestorage;

architecture Behavioral of notestorage is

    signal cnt15, cnt14, cnt13, cnt12, cnt11, cnt10, cnt9, cnt8, cnt7, cnt6, cnt5, cnt4, cnt3, cnt2: integer := 0;
    signal cnt30, cnt29, cnt28, cnt27, cnt26, cnt25, cnt24, cnt23, cnt22, cnt21, cnt20, cnt19, cnt18, cnt17: integer := 0;
    signal cnt45, cnt44, cnt43, cnt42, cnt41, cnt40, cnt39, cnt38, cnt37, cnt36, cnt35, cnt34, cnt33, cnt32: integer := 0;
    signal volt: std_logic := '1';
    signal sw15, sw14, sw13, sw12, sw11, sw10, sw9, sw8, sw7, sw6, sw5, sw4, sw3, sw2, sw0: std_logic;
    signal C2, Cs2, D2, Ds2, E2, F2, Fs2, G2, Gs2, A2, Bf2, B2: integer;
    signal C3, Cs3, D3, Ds3, E3, F3, Fs3, G3, Gs3, A3, Bf3, B3: integer;
    signal C4, Cs4, D4, Ds4, E4, F4, Fs4, G4, Gs4, A4, Bf4, B4: integer;
    signal C5, Cs5, D5, Ds5, E5, F5, Fs5, G5, Gs5, A5, Bf5, B5: integer;

begin
    C2 <= 764410; Cs2 <= 721501; D2 <= 681013; Ds2 <= 642839; E2 <= 606722; F2 <= 572672; 
    Fs2 <= 540541; G2 <= 510204; Gs2 <= 481556; A2 <= 454545; Bf2 <= 429037; B2 <= 404957;
    C3 <= 382234; Cs3 <= 360776; D3 <= 340530; Ds3 <= 321419; E3 <= 303324; F3 <= 286352;
    Fs3 <= 270270; G3 <= 255102; Gs3 <= 240790; A3 <= 227273; Bf3 <= 214519; B3 <= 202478;
    C4 <= 191110; Cs4 <= 180388; D4 <= 170265; Ds4 <= 160705; E4 <= 151685; F4 <= 143172; 
    Fs4 <= 135139; G4 <= 127551; Gs4 <= 120395; A4 <= 113636; Bf4 <= 107259; B4 <= 101239;
    C5 <= 95560; Cs5 <= 90192; D5 <= 85131; E5 <= 75844; F5 <= 71586; G5 <= 63776; 
    A5 <= 56818; B5 <= 50619;

    sw15 <= sw(14); sw14 <= sw(13); sw13 <= sw(12); sw12 <= sw(11); sw11 <= sw(10); 
    sw10 <= sw(9); sw9 <= sw(8); sw8 <= sw(7); sw7 <= sw(6); sw6 <= sw(5); sw5 <= sw(4); 
    sw4 <= sw(3); sw3 <= sw(2); sw2 <= sw(1); sw0 <= sw(0);

    volume <= '1'; --'1' sets the volume of the audio to 6db; '0' sets it to 12db
    lowpow <= '1'; --'1' allows current to go from board to speaker; '0' disallows it

    get_note: process(sw15, sw14, sw13, sw12, sw11, sw10, sw9, sw8, sw7, sw6, sw5, sw4, sw3, sw2, sw0, octave, clk, volt, EN)
    begin
        if (rising_edge(clk)) and (EN = '0') then
            case octave is
                when "00" =>
                    if (sw15 = '1') then
                        cnt15 <= cnt15 + 1;
                        if cnt15 = C2 then
                            volt <= not volt;
                            cnt15 <= 0;
                        end if;
                    elsif (sw14 = '1') then 
                        if (sw0 = '1') then
                            cnt14 <= cnt14 + 1;
                            if cnt14 = Cs2 then
                                volt <= not volt;
                                cnt14 <= 0;
                            end if;
                        else
                            cnt14 <= cnt14 + 1;
                            if cnt14 = D2 then
                                volt <= not volt;
                                cnt14 <= 0;
                            end if;
                        end if;
                    elsif (sw13 = '1') then  
                        if (sw0 = '1') then
                            cnt13 <= cnt13 + 1;
                            if cnt13 = D2 then
                                volt <= not volt;
                                cnt13 <= 0;
                            end if;
                        else
                            cnt13 <= cnt13 + 1;
                            if cnt13 = E2 then
                                volt <= not volt;
                                cnt13 <= 0;
                            end if;
                        end if;
                    elsif (sw12 = '1') then 
                        if (sw0 = '1') then
                            cnt12 <= cnt12 + 1;
                            if cnt12 = Ds2 then
                                volt <= not volt;
                                cnt12 <= 0;
                            end if;
                        else
                            cnt12 <= cnt12 + 1;
                            if cnt12 = F2 then
                                volt <= not volt;
                                cnt12 <= 0;
                            end if;
                        end if;
                    elsif (sw11 = '1') then 
                        if (sw0 = '1') then
                            cnt11 <= cnt11 + 1;
                            if cnt11 = E2 then
                                volt <= not volt;
                                cnt11 <= 0;
                            end if;
                        else
                            cnt11 <= cnt11 + 1;
                            if cnt11 = G2 then
                                volt <= not volt;
                                cnt11 <= 0;
                            end if;
                        end if;
                    elsif (sw10 = '1') then
                        if (sw0 = '1') then
                            cnt10 <= cnt10 + 1;
                            if cnt10 = F2 then
                                volt <= not volt;
                                cnt10 <= 0;
                            end if;
                        else
                            cnt10 <= cnt10 + 1;
                            if cnt10 = A2 then
                                volt <= not volt;
                                cnt10 <= 0;
                            end if;
                        end if;
                    elsif (sw9 = '1') then 
                        if (sw0 = '1') then
                            cnt9 <= cnt9 + 1;
                            if cnt9 = Fs2 then
                                volt <= not volt;
                                cnt9 <= 0;
                            end if;
                        else
                            cnt9 <= cnt9 + 1;
                            if cnt9 = B2 then
                                volt <= not volt;
                                cnt9 <= 0;
                            end if;
                        end if;
                    elsif (sw8 = '1') then
                        if (sw0 = '1') then
                            cnt8 <= cnt8 + 1;
                            if cnt8 = G2 then
                                volt <= not volt;
                                cnt8 <= 0;
                            end if;
                        else
                            cnt8 <= cnt8 + 1;
                            if cnt8 = C3 then
                                volt <= not volt;
                                cnt8 <= 0;
                            end if;
                        end if;
                    elsif (sw7 = '1') then 
                        if (sw0 = '1') then
                            cnt7 <= cnt7 + 1;
                            if cnt7 = Gs2 then
                                volt <= not volt;
                                cnt7 <= 0;
                            end if;
                        else
                            cnt7 <= cnt7 + 1;
                            if cnt7 = D3 then
                                volt <= not volt;
                                cnt7 <= 0;
                            end if;
                        end if;
                    elsif (sw6 = '1') then 
                        if (sw0 = '1') then
                            cnt6 <= cnt6 + 1;
                            if cnt6 = A2 then
                                volt <= not volt;
                                cnt6 <= 0;
                            end if;
                        else
                            cnt6 <= cnt6 + 1;
                            if cnt6 = E3 then
                                volt <= not volt;
                                cnt6 <= 0;
                            end if;
                        end if;
                    elsif (sw5 = '1') then
                        if (sw0 = '1') then
                            cnt5 <= cnt5 + 1;
                            if cnt5 = Bf2 then
                                volt <= not volt;
                                cnt5 <= 0;
                            end if;
                        else
                            cnt5 <= cnt5 + 1;
                            if cnt5 = F3 then
                                volt <= not volt;
                                cnt5 <= 0;
                            end if;
                        end if;
                    elsif (sw4 = '1') then
                        if (sw0 = '1') then
                            cnt4 <= cnt4 + 1;
                            if cnt4 = B2 then
                                volt <= not volt;
                                cnt4 <= 0;
                            end if;
                        else
                            cnt4 <= cnt4 + 1;
                            if cnt4 = G3 then
                                volt <= not volt;
                                cnt4 <= 0;
                            end if;
                        end if;
                    elsif (sw3 = '1') then 
                        if (sw0 = '1') then
                            cnt3 <= cnt3 + 1;
                            if cnt3 = C3 then
                                volt <= not volt;
                                cnt3 <= 0;
                            end if;
                        else
                            cnt3 <= cnt3 + 1;
                            if cnt3 = A3 then
                                volt <= not volt;
                                cnt3 <= 0;
                            end if;
                        end if;
                    elsif (sw2 = '1') then
                        if (sw0 = '1') then
                            cnt2 <= cnt2 + 1;
                            if cnt2 = Cs3 then
                                volt <= not volt;
                                cnt2 <= 0;
                            end if;
                        else
                            cnt2 <= cnt2 + 1;
                            if cnt2 = B3 then
                                volt <= not volt;
                                cnt2 <= 0;
                            end if;
                        end if;
                    else
                    end if;
                when "01" =>
                    if (sw15 = '1') then
                        cnt30 <= cnt30 + 1;
                        if cnt30 = C3 then
                            volt <= not volt;
                            cnt30 <= 0;
                        end if;
                    elsif (sw14 = '1') then 
                        if (sw0 = '1') then
                            cnt29 <= cnt29 + 1;
                            if cnt29 = Cs3 then
                                volt <= not volt;
                                cnt29 <= 0;
                            end if;
                        else
                            cnt29 <= cnt29 + 1;
                            if cnt29 = D3 then
                                volt <= not volt;
                                cnt29 <= 0;
                            end if;
                        end if;
                    elsif (sw13 = '1') then  
                        if (sw0 = '1') then
                            cnt28 <= cnt28 + 1;
                            if cnt28 = D3 then
                                volt <= not volt;
                                cnt28 <= 0;
                            end if;
                        else
                            cnt28 <= cnt28 + 1;
                            if cnt28 = E3 then
                                volt <= not volt;
                                cnt28 <= 0;
                            end if;
                        end if;
                    elsif (sw12 = '1') then 
                        if (sw0 = '1') then
                            cnt27 <= cnt27 + 1;
                            if cnt27 = Ds3 then
                                volt <= not volt;
                                cnt27 <= 0;
                            end if;
                        else
                            cnt27 <= cnt27 + 1;
                            if cnt27 = F3 then
                                volt <= not volt;
                                cnt27 <= 0;
                            end if;
                        end if;
                    elsif (sw11 = '1') then 
                        if (sw0 = '1') then
                            cnt26 <= cnt26 + 1;
                            if cnt26 = E3 then
                                volt <= not volt;
                                cnt26 <= 0;
                            end if;
                        else
                            cnt26 <= cnt26 + 1;
                            if cnt26 = G3 then
                                volt <= not volt;
                                cnt26 <= 0;
                            end if;
                        end if;
                    elsif (sw10 = '1') then
                        if (sw0 = '1') then
                            cnt25 <= cnt25 + 1;
                            if cnt25 = F3 then
                                volt <= not volt;
                                cnt25 <= 0;
                            end if;
                        else
                            cnt25 <= cnt25 + 1;
                            if cnt25 = A3 then
                                volt <= not volt;
                                cnt25 <= 0;
                            end if;
                        end if;
                    elsif (sw9 = '1') then 
                        if (sw0 = '1') then
                            cnt24 <= cnt24 + 1;
                            if cnt24 = Fs3 then
                                volt <= not volt;
                                cnt24 <= 0;
                            end if;
                        else
                            cnt24 <= cnt24 + 1;
                            if cnt24 = B3 then
                                volt <= not volt;
                                cnt24 <= 0;
                            end if;
                        end if;
                    elsif (sw8 = '1') then
                        if (sw0 = '1') then
                            cnt23 <= cnt23 + 1;
                            if cnt23 = G3 then
                                volt <= not volt;
                                cnt23 <= 0;
                            end if;
                        else
                            cnt23 <= cnt23 + 1;
                            if cnt23 = C4 then
                                volt <= not volt;
                                cnt23 <= 0;
                            end if;
                        end if;
                    elsif (sw7 = '1') then 
                        if (sw0 = '1') then
                            cnt22 <= cnt22 + 1;
                            if cnt22 = Gs3 then
                                volt <= not volt;
                                cnt22 <= 0;
                            end if;
                        else
                            cnt22 <= cnt22 + 1;
                            if cnt22 = D4 then
                                volt <= not volt;
                                cnt22 <= 0;
                            end if;
                        end if;
                    elsif (sw6 = '1') then 
                        if (sw0 = '1') then
                            cnt21 <= cnt21 + 1;
                            if cnt21 = A3 then
                                volt <= not volt;
                                cnt21 <= 0;
                            end if;
                        else
                            cnt21 <= cnt21 + 1;
                            if cnt21 = E4 then
                                volt <= not volt;
                                cnt21 <= 0;
                            end if;
                        end if;
                    elsif (sw5 = '1') then
                        if (sw0 = '1') then
                            cnt20 <= cnt20 + 1;
                            if cnt20 = Bf3 then
                                volt <= not volt;
                                cnt20 <= 0;
                            end if;
                        else
                            cnt20 <= cnt20 + 1;
                            if cnt20 = F4 then
                                volt <= not volt;
                                cnt20 <= 0;
                            end if;
                        end if;
                    elsif (sw4 = '1') then
                        if (sw0 = '1') then
                            cnt19 <= cnt19 + 1;
                            if cnt19 = B3 then
                                volt <= not volt;
                                cnt19 <= 0;
                            end if;
                        else
                            cnt19 <= cnt19 + 1;
                            if cnt19 = G4 then
                                volt <= not volt;
                                cnt19 <= 0;
                            end if;
                        end if;
                    elsif (sw3 = '1') then 
                        if (sw0 = '1') then
                            cnt18 <= cnt18 + 1;
                            if cnt18 = C4 then
                                volt <= not volt;
                                cnt18 <= 0;
                            end if;
                        else
                            cnt18 <= cnt18 + 1;
                            if cnt18 = A4 then
                                volt <= not volt;
                                cnt18 <= 0;
                            end if;
                        end if;
                    elsif (sw2 = '1') then
                        if (sw0 = '1') then
                            cnt17 <= cnt17 + 1;
                            if cnt17 = Cs4 then
                                volt <= not volt;
                                cnt17 <= 0;
                            end if;
                        else
                            cnt17 <= cnt17 + 1;
                            if cnt17 = B4 then
                                volt <= not volt;
                                cnt17 <= 0;
                            end if;
                        end if;
                    else
                    end if;
                when "10" =>
                    if (sw15 = '1') then
                        cnt45 <= cnt45 + 1;
                        if cnt45 = C4 then
                            volt <= not volt;
                            cnt45 <= 0;
                        end if;
                    elsif (sw14 = '1') then 
                        if (sw0 = '1') then
                            cnt44 <= cnt44 + 1;
                            if cnt44 = Cs4 then
                                volt <= not volt;
                                cnt44 <= 0;
                            end if;
                        else
                            cnt44 <= cnt44 + 1;
                            if cnt44 = D4 then
                                volt <= not volt;
                                cnt44 <= 0;
                            end if;
                        end if;
                    elsif (sw13 = '1') then  
                        if (sw0 = '1') then
                            cnt43 <= cnt43 + 1;
                            if cnt43 = D4 then
                                volt <= not volt;
                                cnt43 <= 0;
                            end if;
                        else
                            cnt43 <= cnt43 + 1;
                            if cnt43 = E4 then
                                volt <= not volt;
                                cnt43 <= 0;
                            end if;
                        end if;
                    elsif (sw12 = '1') then 
                        if (sw0 = '1') then
                            cnt42 <= cnt42 + 1;
                            if cnt42 = Ds4 then
                                volt <= not volt;
                                cnt42 <= 0;
                            end if;
                        else
                            cnt42 <= cnt42 + 1;
                            if cnt42 = F4 then
                                volt <= not volt;
                                cnt42 <= 0;
                            end if;
                        end if;
                    elsif (sw11 = '1') then 
                        if (sw0 = '1') then
                            cnt41 <= cnt41 + 1;
                            if cnt41 = E4 then
                                volt <= not volt;
                                cnt41 <= 0;
                            end if;
                        else
                            cnt41 <= cnt41 + 1;
                            if cnt41 = G4 then
                                volt <= not volt;
                                cnt41 <= 0;
                            end if;
                        end if;
                    elsif (sw10 = '1') then
                        if (sw0 = '1') then
                            cnt40 <= cnt40 + 1;
                            if cnt40 = F4 then
                                volt <= not volt;
                                cnt40 <= 0;
                            end if;
                        else
                            cnt40 <= cnt40 + 1;
                            if cnt40 = A4 then
                                volt <= not volt;
                                cnt40 <= 0;
                            end if;
                        end if;
                    elsif (sw9 = '1') then 
                        if (sw0 = '1') then
                            cnt39 <= cnt39 + 1;
                            if cnt39 = Fs4 then
                                volt <= not volt;
                                cnt39 <= 0;
                            end if;
                        else
                            cnt39 <= cnt39 + 1;
                            if cnt39 = B4 then
                                volt <= not volt;
                                cnt39 <= 0;
                            end if;
                        end if;
                    elsif (sw8 = '1') then
                        if (sw0 = '1') then
                            cnt38 <= cnt38 + 1;
                            if cnt38 = G4 then
                                volt <= not volt;
                                cnt38 <= 0;
                            end if;
                        else
                            cnt38 <= cnt38 + 1;
                            if cnt38 = C5 then
                                volt <= not volt;
                                cnt38 <= 0;
                            end if;
                        end if;
                    elsif (sw7 = '1') then 
                        if (sw0 = '1') then
                            cnt37 <= cnt37 + 1;
                            if cnt37 = Gs4 then
                                volt <= not volt;
                                cnt37 <= 0;
                            end if;
                        else
                            cnt37 <= cnt37 + 1;
                            if cnt37 = D5 then
                                volt <= not volt;
                                cnt37 <= 0;
                            end if;
                        end if;
                    elsif (sw6 = '1') then 
                        if (sw0 = '1') then
                            cnt36 <= cnt36 + 1;
                            if cnt36 = A4 then
                                volt <= not volt;
                                cnt36 <= 0;
                            end if;
                        else
                            cnt36 <= cnt36 + 1;
                            if cnt36 = E5 then
                                volt <= not volt;
                                cnt36 <= 0;
                            end if;
                        end if;
                    elsif (sw5 = '1') then
                        if (sw0 = '1') then
                            cnt35 <= cnt35 + 1;
                            if cnt35 = Bf4 then
                                volt <= not volt;
                                cnt35 <= 0;
                            end if;
                        else
                            cnt35 <= cnt35 + 1;
                            if cnt35 = F5 then
                                volt <= not volt;
                                cnt35 <= 0;
                            end if;
                        end if;
                    elsif (sw4 = '1') then
                        if (sw0 = '1') then
                            cnt34 <= cnt34 + 1;
                            if cnt34 = B4 then
                                volt <= not volt;
                                cnt34 <= 0;
                            end if;
                        else
                            cnt34 <= cnt34 + 1;
                            if cnt34 = G5 then
                                volt <= not volt;
                                cnt34<= 0;
                            end if;
                        end if;
                    elsif (sw3 = '1') then 
                        if (sw0 = '1') then
                            cnt33 <= cnt33 + 1;
                            if cnt33 = C5 then
                                volt <= not volt;
                                cnt33 <= 0;
                            end if;
                        else
                            cnt33 <= cnt33 + 1;
                            if cnt33 = A5 then
                                volt <= not volt;
                                cnt33 <= 0;
                            end if;
                        end if;
                    elsif (sw2 = '1') then
                        if (sw0 = '1') then
                            cnt32 <= cnt32 + 1;
                            if cnt32 = Cs5 then
                                volt <= not volt;
                                cnt32 <= 0;
                            end if;
                        else
                            cnt32 <= cnt32 + 1;
                            if cnt32 = B5 then
                                volt <= not volt;
                                cnt32 <= 0;
                            end if;
                        end if;
                    else
                    end if;
                when others =>
            end case;
        end if;
        note <= volt;
        if (sw0 = '1') then
            leds <= "110010101001010";
        else
            leds <= "000000000000000";
        end if;
    end process get_note;

end Behavioral;