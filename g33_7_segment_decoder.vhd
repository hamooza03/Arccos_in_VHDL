--
-- entity name: g33_7_segment_decoder
--
-- Version 1.3
-- Authors: Hamza Abu Alkhair, Omar Moussa and Hamza Al Farrash
-- Date: April 3, 2025

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity g33_7_segment_decoder is
    port(
        nums    : in  std_logic_vector(3 downto 0);
        RB_In    : in  std_logic;
        RB_Out   : out std_logic;
        segments : out std_logic_vector(6 downto 0)
    );
end g33_7_segment_decoder;

architecture behave of g33_7_segment_decoder is
begin

    process(RB_In, nums)
    begin  
       
        if (RB_In = '1' and nums = "0000") then
            RB_Out   <= '1';          -- propagate ripple blank
            segments <= "1111111";    -- blank (all off)
				
        else
            RB_Out <= '0';  -- normal case, no further blanking
            case nums is
                when "0000" => segments <= "1000000";
                when "0001" => segments <= "1111001";  
                when "0010" => segments <= "0100100";  
                when "0011" => segments <= "0110000";
                when "0100" => segments <= "0011001";
                when "0101" => segments <= "0010010";
                when "0110" => segments <= "0000010";
                when "0111" => segments <= "1111000";
                when "1000" => segments <= "0000000";
                when "1001" => segments <= "0010000";
                when others => segments <= "1111111";
            end case;
        end if;
    end process;

end behave;
