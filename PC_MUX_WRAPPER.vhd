library IEEE;
use IEEE.STD_LOGIC_1164.ALL;


entity PC_MUX_WRAPPER is
   Port ( FROM_STACK, FROM_IMMED  : in STD_LOGIC_VECTOR(9 downTo 0);
          MUX_SEL                 : in STD_LOGIC_VECTOR(1 downTo 0);
          PC_LD, PC_INC, RST, CLK : in STD_LOGIC;
          PC_COUNT                : out STD_LOGIC_VECTOR(9 downTo 0));
end PC_MUX_WRAPPER;

   

architecture Behavioral of PC_MUX_WRAPPER is
   signal MUX_OUTPUT, PC_OUTPUT : std_logic_vector(9 downto 0) := (others => '0');

   component Counter_MUX
      Port ( FROM_IMMED,FROM_STACK : in STD_LOGIC_VECTOR(9 downTo 0);
             MUX_SEL               : in STD_LOGIC_VECTOR(1 downTo 0);
             MUX_OUTPUT            : out STD_LOGIC_VECTOR(9 downTo 0));
   end component;
   
   component PROGRAM_COUNTER is
     Port ( Din                   : in STD_LOGIC_VECTOR(9 downTo 0);
            PC_LD,PC_INC,RST,CLK  : in STD_LOGIC;
            PC_COUNT              : out STD_LOGIC_VECTOR(9 downTo 0));
   end component;

begin
   MUX : Counter_MUX port map( FROM_IMMED => FROM_IMMED,
                               FROM_STACK => FROM_STACK,
                               MUX_SEL    => MUX_SEL,
                               MUX_OUTPUT => MUX_OUTPUT);
                               
   COUNTER : PROGRAM_COUNTER port map ( Din      => MUX_OUTPUT,
                                        PC_LD    => PC_LD,
                                        PC_INC   => PC_INC,
                                        RST      => RST,
                                        CLK      => CLK,
                                        PC_COUNT => PC_OUTPUT);
                                        
   PC_COUNT <= PC_OUTPUT;

end Behavioral;