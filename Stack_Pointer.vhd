library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity Stack_Pointer is
   Port ( RST      :  in std_logic;
          LD       :  in std_logic;
          INCR     :  in std_logic;
          DECR     :  in std_logic;
          CLK      :  in std_logic;
          DATA_IN  :  in std_logic_vector(7 downTo 0);
          DATA_OUT : out std_logic_vector(7 downTo 0) );
end Stack_Pointer;

architecture Behavioral of Stack_Pointer is
signal SP : std_logic_vector(7 downTo 0) := (others => '0');

begin

   process(RST, LD, INCR, DECR, CLK, DATA_IN)
   begin
      if (rising_edge(CLK)) then
         if (LD = '1') then
            SP <= DATA_IN;
         elsif (INCR = '1') then
            SP <= SP + '1';
         elsif (DECR = '1') then
            SP <= SP - '1';
         else
         end if;
      end if;
   
      if (RST = '1') then
         SP <= "00000000";
      end if;
   end process;

   DATA_OUT <= SP;
   
end Behavioral;
