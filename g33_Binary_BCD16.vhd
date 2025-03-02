--
-- entity name: g33_Binary_BCD16
--
-- Version: 1.0
-- Authors: Hamza Abu Alkhair, Hamza El Farrash
-- Date: February 25th - 5:01pm 

library ieee;
use ieee.std_logic_1164.all;

entity g33_Binary_BCD16 is
	port (bin : in std_logic_vector(15 downto 0);
				BCD5 : out std_logic_vector(3 downto 0);
				BCD4 : out std_logic_vector(3 downto 0);
				BCD3 : out std_logic_vector(3 downto 0);
				BCD2 : out std_logic_vector(3 downto 0);
				BCD1 : out std_logic_vector(3 downto 0) );
end g33_Binary_BCD16;

architecture behave of g33_Binary_BCD16 is
begin
	-- create middle wires / connections
	Isnt1: g33_DM74185 port map(EDCBA(4) => bin(15), 
										 EDCBA(3) => bin(14), 
										 EDCBA(2) => bin(13), 
										 EDCBA(1) => bin(12),
										 EDCBA(0) => bin(11),
										 Y);

end g33_Binary_BCD16;