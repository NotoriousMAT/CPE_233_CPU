library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity SCR_MUX is
  Port ( MUX_0      : in STD_LOGIC_VECTOR(7 downTo 0);
         MUX_1      : in STD_LOGIC_VECTOR(9 downTo 0);
         MUX_SEL    : in STD_LOGIC;
         MUX_OUTPUT : out STD_LOGIC_VECTOR(9 downTo 0));
end SCR_MUX;

architecture Behavioral of SCR_MUX is
signal output : std_logic_vector(9 downTo 0);

begin
   process(MUX_SEL, MUX_0, MUX_1)
   begin
      if (MUX_SEL = '0') then
         output <= '0' & '0'& MUX_0;
      else
         output <= MUX_1;
      end if;
   end process;

   MUX_OUTPUT <= output;
   
end Behavioral;