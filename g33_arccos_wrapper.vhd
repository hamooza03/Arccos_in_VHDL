--
-- entity name: g33_arccos_wrapper
--
-- Version 1.3
-- Authors: Hamza Abu Alkhair, Omar Moussa and Hamza Al Farrash
-- Date: April 3, 2025

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity g33_arccos_wrapper is 
    port (
        clk      : in  std_logic;
        switches : in  std_logic_vector(7 downto 0);
        HEX_0    : out std_logic_vector(6 downto 0);
        HEX_1    : out std_logic_vector(6 downto 0);
        HEX_2    : out std_logic_vector(6 downto 0); 
        HEX_3    : out std_logic_vector(6 downto 0)
    );
end g33_arccos_wrapper;

architecture behave of g33_arccos_wrapper is

    component g33_arccos
        port (
            clk   : in  std_logic;
            x     : in  unsigned(7 downto 0);
            angle : out unsigned(9 downto 0)
        );
    end component;
    
    component g33_Binary_BCD16
        port (
            bin  : in  std_logic_vector(15 downto 0);
            BCD5 : out std_logic_vector(3 downto 0);
            BCD4 : out std_logic_vector(3 downto 0);
            BCD3 : out std_logic_vector(3 downto 0);
            BCD2 : out std_logic_vector(3 downto 0);
            BCD1 : out std_logic_vector(3 downto 0)
        );
    end component;
    
    component g33_7_segment_decoder
        port (
            nums    : in  std_logic_vector(3 downto 0);
            RB_In    : in  std_logic;
            RB_Out   : out std_logic;
            segments : out std_logic_vector(6 downto 0)
        );
    end component;
    
    -- Internal signals for intermediate connections
    signal angled_output  : unsigned(9 downto 0);
    signal angle_extended : std_logic_vector(15 downto 0);
    signal DEC0, DEC1, DEC2, DEC3 : std_logic_vector(3 downto 0);
    signal dummy        : std_logic_vector(3 downto 0);  -- Dummy node, not used
    signal RB3, RB2, RB1, RBdummy : std_logic;
    
begin

    -- Instantiate the arccos component
    Inst1 : g33_arccos port map(
        clk   => clk,
        x     => unsigned(switches),
        angle => angled_output
    );
    
    -- Extend the 10-bit angle to 16 bits and convert to std_logic_vector
    angle_extended <= std_logic_vector(resize(angled_output, 16));
    
    -- Convert the binary angle to five BCD digits (BCD5 is discarded)
    Inst2 : g33_Binary_BCD16 port map (
        bin  => angle_extended,
        BCD5 => dummy,
        BCD4 => DEC3,
        BCD3 => DEC2,
        BCD2 => DEC1,
        BCD1 => DEC0
    );
    
    -- Instantiate the 7-segment decoders with ripple blanking logic.
    Inst3 : g33_7_segment_decoder port map(
        nums    => DEC3,
        RB_In    => '1',      -- Most significant digit: always enable ripple blanking check
        RB_Out   => RB3,
        segments => HEX_3
    );
    
    Inst4 : g33_7_segment_decoder port map(
        nums    => DEC2,
        RB_In    => RB3,      -- Ripple blanking propagates from HEX_3
        RB_Out   => RB2,
        segments => HEX_2
    );
    
    Inst5 : g33_7_segment_decoder port map(
        nums    => DEC1,
        RB_In    => RB2,      -- Ripple blanking propagates from HEX_2
        RB_Out   => RB1,
        segments => HEX_1
    );
    
    Inst6 : g33_7_segment_decoder port map(
        nums    => DEC0,
        RB_In    => '0',      -- Least significant digit: always displayed
        RB_Out   => RBdummy,  -- Unused output
        segments => HEX_0
    );

end behave;
