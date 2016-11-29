----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 11/18/2016 06:04:03 PM
-- Design Name: 
-- Module Name: Interrupt_Mask - Behavioral
-- Project Name: 
-- Target Devices: 
-- Tool Versions: 
-- Description: 
-- 
-- Dependencies: 
-- 
-- Revision:
-- Revision 0.01 - File Created
-- Additional Comments:
-- 
----------------------------------------------------------------------------------


library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity Interrupt_Mask is
  Port ( I_SET   : in STD_LOGIC;
         I_CLR   : in STD_LOGIC;
         CLK     : in STD_LOGIC;
         INT_OUT : out STD_LOGIC);
end Interrupt_Mask;

architecture Behavioral of Interrupt_Mask is
signal output : STD_LOGIC := '0';

begin
process(I_SET, I_CLR, CLK)
begin
   if (rising_edge(CLK) and I_CLR = '1') then
         output <= '0';
   end if;
   if (rising_edge(CLK) and I_SET = '1') then
         output <= '1';
   end if;
   if (rising_edge(CLK) and I_SET = '0') then
                  output <= '0';
   end if;
end process;

INT_OUT <= output;

end Behavioral;
