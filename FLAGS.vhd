-- 
-- A flip-flop to store the the zero, carry, and interrupt flags.
-- To be used in the RAT CPU.
-- 
--

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;


entity FLAGS is
    Port ( C_IN     : in  STD_LOGIC; --flag input
           Z_IN     : in  STD_LOGIC;
           C_LD     : in  STD_LOGIC; --load the out_flag with the in_flag value
           C_SET    : in  STD_LOGIC; --set the flag to '1'
           Z_LD     : in  STD_LOGIC;
           C_CLR    : in  STD_LOGIC; --clear the flag to '0'
           CLK      : in  STD_LOGIC; --system clock
           C_OUT    : out STD_LOGIC; --flag output
           Z_OUT    : out STD_LOGIC);
end FLAGS;

architecture Behavioral of FLAGS is
begin
    process(CLK)
    begin
       if( rising_edge(CLK) ) then
          if( C_LD = '1' ) then
             C_OUT <= C_IN;
          elsif( C_SET = '1' ) then
             C_OUT <= '1';
          elsif( C_CLR = '1' ) then
             C_OUT <= '0';
          end if;
          
          if ( Z_LD = '1' ) then
             Z_OUT <= Z_IN;
          else
          end if;
       end if;
    end process;				
end Behavioral;
