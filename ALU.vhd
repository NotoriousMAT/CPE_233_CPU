----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 10/12/2016 09:22:03 AM
-- Design Name: 
-- Module Name: ALU - Behavioral
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
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity ALU is
   Port ( A      : in STD_LOGIC_VECTOR(7 downTo 0);
          B      : in STD_LOGIC_VECTOR(7 downTo 0);
          SEL    : in STD_LOGIC_VECTOR(3 downTo 0);
          Cin    : in STD_LOGIC;
          RESULT : out STD_LOGIC_VECTOR(7 downTo 0);
          C      : out STD_LOGIC;
          Z      : out STD_LOGIC);
end ALU;

architecture Behavioral of ALU is
signal output : STD_LOGIC_VECTOR(8 downTo 0);

begin

process(A,B,Cin,SEL)
begin
   case SEL is
      when "0000" => output <= ('0' & A) + ('0' & B);
      when "0001" => output <= ('0' & A) + ('0' & B) + Cin;
      when "0010" => output <= ('0' & A) - ('0' & B);
      when "0011" => output <= ('0' & A) - ('0' & B) - Cin;
      when "0100" => output <= ('0' & A) - ('0' & B);
      when "0101" => output <= ('0' & A) and ('0' & B);
      when "0110" => output <= ('0' & A) or ('0' & B);
      when "0111" => output <= ('0' & A) xor ('0' & B);
      when "1000" => output <= ('0' & A) and ('0' & B);
      when "1001" => output <= A & Cin;
      when "1010" => output <= A(0) & Cin & A(7 downTo 1);
      when "1011" => output <= A(7) & A(6 downTo 0) & A(7);
      when "1100" => output <= A(0) & A(0) & A(7 downTo 1);
      when "1101" => output <= A(0) & A(7) & A(7 downTo 1);
      when "1110" => output <= '0' & B;
      when others => output <= "000000000";  
   end case;
   
end process;

process(output)
begin
   if (output(7 downTo 0) = "00000000") then
      Z <= '1';
   else
      Z <= '0';
   end if;
end process;

C      <= output(8);
RESULT <= output(7 downTo 0);

end Behavioral;
