----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 10/17/2016 09:48:03 AM
-- Design Name: 
-- Module Name: ALU_TESTBENCH - Behavioral
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

entity ALU_TESTBENCH is
end ALU_TESTBENCH;

architecture Behavioral of ALU_TESTBENCH is

component ALU is
   Port ( A      : in STD_LOGIC_VECTOR(7 downTo 0);
          B      : in STD_LOGIC_VECTOR(7 downTo 0);
          SEL    : in STD_LOGIC_VECTOR(3 downTo 0);
          Cin    : in STD_LOGIC;
          RESULT : out STD_LOGIC_VECTOR(7 downTo 0);
          C      : out STD_LOGIC;
          Z      : out STD_LOGIC);
end component;

   --Inputs
   signal A_TB, B_TB : STD_LOGIC_VECTOR(7 downTo 0);
   signal SEL_TB     : STD_LOGIC_VECTOR(3 downTo 0);
   signal Cin_TB     : STD_LOGIC;
   
   --Output
   signal RESULT_TB  : STD_LOGIC_VECTOR(7 downTo 0);
   signal C_TB, Z_TB : STD_LOGIC;

   -- Clock period definitions
   constant CLK_period : time := 10 ns;

begin

   TB1 : ALU port map ( A      => A_TB,
                        B      => B_TB,
                        SEL    => SEL_TB,
                        Cin    => Cin_TB,
                        RESULT => RESULT_TB,
                        C      => C_TB,
                        Z      => Z_TB);

   process
   begin
      wait for CLK_period;

      A_TB   <= "10101010";
      B_TB   <= "10101010";
      Cin_TB <= '0';
      SEL_TB <= "0000";
      
      wait for CLK_period;
      
      A_TB   <= "11001000";
      B_TB   <= "00110111";
      Cin_TB <= '1';
      SEL_TB <= "0001";
      
      wait for CLK_period;
      
      A_TB   <= "11001000";
      B_TB   <= "01100100";
      Cin_TB <= '0';
      SEL_TB <= "0010";
      
      wait for CLK_period;
      
      A_TB   <= "11001000";
      B_TB   <= "11001000";
      Cin_TB <= '1';
      SEL_TB <= "0011";
      
      wait for CLK_period;
      
      A_TB   <= "10101010";
      B_TB   <= "11111111";
      Cin_TB <= '0';
      SEL_TB <= "0100";
      
      wait for CLK_period;
      
      A_TB   <= "10101010";
      B_TB   <= "10101010";
      Cin_TB <= '0';
      SEL_TB <= "0100";
      
      wait for CLK_period;
      
      A_TB   <= "10101010";
      B_TB   <= "11001100";
      Cin_TB <= '0';
      SEL_TB <= "0101";
      
      wait for CLK_period;
      
      A_TB   <= "10101010";
      B_TB   <= "10101010";
      Cin_TB <= '0';
      SEL_TB <= "0110";
      
      wait for CLK_period;
      
      A_TB   <= "10101010";
      B_TB   <= "10101010";
      Cin_TB <= '0';
      SEL_TB <= "0111";
      
      wait for CLK_period;
      
      A_TB   <= "10101010";
      B_TB   <= "01010101";
      Cin_TB <= '0';
      SEL_TB <= "1000";
      
      wait for CLK_period;
      
      A_TB   <= "00000001";
      B_TB   <= "00010010";
      Cin_TB <= '1';
      SEL_TB <= "1001";
      
      wait for CLK_period;
      
      A_TB   <= "10000001";
      B_TB   <= "00110011";
      Cin_TB <= '0';
      SEL_TB <= "1010";
      
      wait for CLK_period;
      
      A_TB   <= "00000001";
      B_TB   <= "10101011";
      Cin_TB <= '1';
      SEL_TB <= "1011";
      
      wait for CLK_period;
      
      A_TB   <= "10000001";
      B_TB   <= "00111100";
      Cin_TB <= '0';
      SEL_TB <= "1100";
      
      wait for CLK_period;
      
      A_TB   <= "10000001";
      B_TB   <= "10000001";
      Cin_TB <= '0';
      SEL_TB <= "1101";
      
      wait for CLK_period;
      
      A_TB   <= "01010000";
      B_TB   <= "00110000";
      Cin_TB <= '0';
      SEL_TB <= "1110";
      
      wait for CLK_period;
   end process;
   
   
   

end Behavioral;
