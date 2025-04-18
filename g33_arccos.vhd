--
-- entity name: g33_arccos
--
-- Version 1.3
-- Authors: Hamza Abu Alkhair, Omar Moussa and Hamza Al Farrash
-- Date: April 3,2025

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
-- numeric std makes it all unsigned

entity g33_arccos is
    port(
        clk   : in  std_logic;
        x     : in  unsigned(7 downto 0);
        angle : out unsigned(9 downto 0)
    );
end g33_arccos;

architecture behave of g33_arccos is

    signal xr          : unsigned(7 downto 0);   -- registered input (optional but recommended)
    signal x2          : unsigned(15 downto 0);  -- 8x8 => 16 bits
    signal p1          : unsigned(23 downto 0);  -- 8+16 => 24 bits
    signal s1          : unsigned(7 downto 0);   -- 8 bits (to hold up to 191 + 8 bits)
    signal p2          : unsigned(23 downto 0);  -- 8+16 => 24 bits
    signal s2          : unsigned(10 downto 0);  -- 11 bits (to hold 1144 + up to 8-bit slice)
    signal p3          : unsigned(18 downto 0);  -- 11+8 => 19 bits
    signal final_angle : unsigned(9 downto 0);   -- 10 bits for final result

begin


    process(clk)
    begin
        if rising_edge(clk) then
            -- Register the final computed result
            angle <= final_angle;
        end if;
    end process;
	 xr    <= x;
  
    -- 1) x2 = xr * xr (16 bits)
    x2 <= xr * xr;

    -- 2) p1 = 86 * x2 (24 bits);
    p1 <= unsigned(to_unsigned(86, 8)) * x2;

    -- 3) s1 = 191 + p1(23 downto 16)
    s1 <= to_unsigned(191, 8) + p1(23 downto 16);

    -- 4) p2 = s1 * x2 (24 bits again)
    p2 <= s1 * x2;

    -- 5) s2 = 1144 + p2(23 downto 16)
    s2 <= to_unsigned(1144, 11) + resize(p2(23 downto 16), 11);

    -- 6) p3 = s2 * xr => 11 bits + 8 bits = up to 19 bits
    p3 <= s2 * xr;

    -- 7) final_angle = 900 - p3(18 downto 9)
    final_angle <= to_unsigned(900, 10) - p3(18 downto 9);

end behave;