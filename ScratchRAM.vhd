----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 10/10/2016 09:52:31 AM
-- Design Name: 
-- Module Name: ScratchRAM - Behavioral
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
use IEEE.STD_LOGIC_UNSIGNED.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity ScratchRAM is
  Port ( DATA_IN  : in STD_LOGIC_VECTOR(9 downTo 0);
         WE       : in STD_LOGIC;
         ADDR     : in STD_LOGIC_VECTOR(7 downTo 0);
         CLK      : in STD_LOGIC;
         DATA_OUT : out STD_LOGIC_VECTOR(9 downTo 0));
end ScratchRAM;

architecture Behavioral of ScratchRAM is
	TYPE memory is array (0 to 255) of std_logic_vector(9 downto 0);
    SIGNAL REG: memory := (others=>(others=>'0'));
begin

   process(clk)
   begin
      if (rising_edge(clk)) then
         if (WE = '1') then
            REG(conv_integer(ADDR)) <= DATA_IN;
         end if;
      end if;
   end process;
   
   DATA_OUT <= REG(conv_integer(ADDR));

end Behavioral;
