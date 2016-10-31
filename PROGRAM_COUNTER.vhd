library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;


-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity PROGRAM_COUNTER is
  Port ( Din                   : in STD_LOGIC_VECTOR(9 downTo 0);
         PC_LD,PC_INC,RST,CLK  : in STD_LOGIC;
         PC_COUNT              : out STD_LOGIC_VECTOR(9 downTo 0));
end PROGRAM_COUNTER;

architecture Counter of PROGRAM_COUNTER is
   signal MY_COUNTER : std_logic_vector(9 downto 0) := (others => '0');

begin
   
   process (CLK, RST)
   begin
      if (RISING_EDGE(CLK)) then
         if (RST = '1') then
            MY_COUNTER <= (others => '0');
         elsif (PC_LD = '1') then
            MY_COUNTER <= Din;
         elsif (PC_INC = '1') then
            MY_COUNTER <= my_counter + '1';
         end if;
      end if;
   end process;
   
   PC_Count <= MY_COUNTER;
   
end Counter;
