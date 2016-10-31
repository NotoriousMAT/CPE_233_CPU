library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity DUAL_MUX_SEL is
  Port ( MUX_0      : in STD_LOGIC_VECTOR(7 downTo 0);
         MUX_1      : in STD_LOGIC_VECTOR(7 downTo 0);
         MUX_SEL    : in STD_LOGIC;
         MUX_OUTPUT : out STD_LOGIC_VECTOR(7 downTo 0));
end DUAL_MUX_SEL;

architecture Behavioral of DUAL_MUX_SEL is

begin
   process(MUX_SEL, MUX_0, MUX_1)
   begin
      if (MUX_SEL = '0') then
         MUX_OUTPUT <= MUX_0;
      else
         MUX_OUTPUT <= MUX_1;
      end if;
   end process;

end Behavioral;