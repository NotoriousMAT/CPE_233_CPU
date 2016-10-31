library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity Counter_MUX is
  Port ( FROM_IMMED,FROM_STACK : in STD_LOGIC_VECTOR(9 downTo 0);
         MUX_SEL               : in STD_LOGIC_VECTOR(1 downTo 0);
         MUX_OUTPUT            : out STD_LOGIC_VECTOR(9 downTo 0));
end Counter_MUX;

architecture Behavioral of Counter_MUX is

begin
   process(MUX_SEL, FROM_IMMED, FROM_STACK)
   begin
      if (MUX_SEL = "00") then
         MUX_OUTPUT <= FROM_IMMED;
      elsif (MUX_SEL = "01") then
         MUX_OUTPUT <= FROM_STACK;
      elsif (MUX_SEL = "10") then
         MUX_OUTPUT <= (others => '0');
      else
         --Do nothing
      end if;
   end process;

end Behavioral;