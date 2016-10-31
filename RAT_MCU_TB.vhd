

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity RAT_MCU_TB is
end RAT_MCU_TB;

architecture Behavioral of RAT_MCU_TB is
component RAT_MCU is
    Port ( IN_PORT  : in  STD_LOGIC_VECTOR (7 downto 0);
           RESET    : in  STD_LOGIC;
           CLK      : in  STD_LOGIC;
           INT_IN   : in  STD_LOGIC;
           OUT_PORT : out  STD_LOGIC_VECTOR (7 downto 0);
           PORT_ID  : out  STD_LOGIC_VECTOR (7 downto 0);
           IO_STRB  : out  STD_LOGIC);
end component;

signal IN_PORT_TB  :  STD_LOGIC_VECTOR (7 downto 0);
signal RESET_TB    :  STD_LOGIC;
signal CLK_TB      :  STD_LOGIC;
signal INT_IN_TB   :  STD_LOGIC;
signal OUT_PORT_TB :  STD_LOGIC_VECTOR (7 downto 0);
signal PORT_ID_TB  :  STD_LOGIC_VECTOR (7 downto 0);
signal IO_STRB_TB  :  STD_LOGIC;

   constant CLK_period : time := 10 ns;

begin
my_RAT_MCU : RAT_MCU
port map ( IN_PORT  => IN_PORT_TB,
           RESET    => RESET_TB,
           CLK      => CLK_TB,
           INT_IN   => INT_IN_TB,
           OUT_PORT => OUT_PORT_TB,
           PORT_ID  => PORT_ID_TB,
           IO_STRB  => IO_STRB_TB);

   CLK_process :process
   begin
		CLK_tb <= '0';
		wait for CLK_period/2;
		CLK_tb <= '1';
		wait for CLK_period/2;
   end process;

   RESET_TB   <= '0';
   INT_IN_TB  <= '0';
   IN_PORT_TB <= "00100000";
   
   process
   begin
   wait for CLK_period;
   wait for CLK_period;
   wait for CLK_period;
   wait for CLK_period;
   wait for CLK_period;
   wait for CLK_period;
   wait for CLK_period;
   wait for CLK_period;
   wait for CLK_period;
   wait for CLK_period;
   wait for CLK_period;
   wait for CLK_period;
   wait for CLK_period;
   wait for CLK_period;
   wait for CLK_period;
   wait for CLK_period;
   
   
   end process;
end Behavioral;
