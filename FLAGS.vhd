-- 
-- A flip-flop to store the the zero, carry, and interrupt flags.
-- To be used in the RAT CPU.
-- 
--

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;


entity FLAGS is
    Port ( C            : in  STD_LOGIC; --flag input
           Z            : in  STD_LOGIC;
           FLAG_C_LD    : in  STD_LOGIC; --load the out_flag with the in_flag value
           FLAG_C_SET   : in  STD_LOGIC; --set the flag to '1'
           FLAG_Z_LD    : in  STD_LOGIC;
           FLAG_C_CLR   : in  STD_LOGIC; --clear the flag to '0'
           FLAG_LD_SEL  : in STD_LOGIC;
           FLAG_SHAD_LD : in STD_LOGIC;
           CLK          : in  STD_LOGIC; --system clock
           C_FLAG       : out STD_LOGIC; --flag output
           Z_FLAG       : out STD_LOGIC);
end FLAGS;

architecture Behavioral of FLAGS is
signal c_in, z_in, c_out, z_out, shad_c, shad_z : std_logic;

begin
    mux: process(C, Z, shad_c, shad_z, FLAG_LD_SEL)
    begin
       if (FLAG_LD_SEL = '0') then 
           c_in <= C;
           z_in <= Z;
       else
           c_in <= shad_c;
           z_in <= shad_z;
       end if;
       
    end process;

    flag: process(CLK,c_in,z_in,FLAG_C_LD,FLAG_C_SET,FLAG_C_CLR,FLAG_Z_LD)
    begin
       if( rising_edge(CLK) ) then
          if( FLAG_C_LD = '1' ) then
             c_out <= c_in;
          elsif( FLAG_C_SET = '1' ) then
             c_out <= '1';
          elsif( FLAG_C_CLR = '1' ) then
             c_out <= '0';
          end if;
          
          if ( FLAG_Z_LD = '1' ) then
             z_out <= z_in;
          end if;
       end if;
    end process;
    
    process(FLAG_SHAD_LD,CLK,c_out,z_out)
    begin       
       if (rising_edge(CLK)) then
          if (FLAG_SHAD_LD = '1') then
             shad_c <= c_out;
             shad_z <= z_out;
          end if;
       end if;
    end process;
    
    C_FLAG <= c_out;
    Z_FLAG <= z_out;
    				
end Behavioral;
