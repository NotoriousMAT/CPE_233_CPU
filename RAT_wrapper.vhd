----------------------------------------------------------------------------------
-- Company:  RAT Technologies
-- Engineer:  Various RAT rats
-- 
-- Create Date:    1/31/2012
-- Design Name: 
-- Module Name:    RAT_wrapper - Behavioral 
-- Project Name: 
-- Target Devices: 
-- Tool versions: 
-- Description: Wrapper for RAT CPU. This model provides a template to interfaces 
--    the RAT CPU to the Nexys2 development board. 
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

entity RAT_wrapper is
    Port ( LEDS     : out   STD_LOGIC_VECTOR (7 downto 0);
           SEGMENTS : out   STD_LOGIC_VECTOR (7 downto 0);
           DISP_EN  : out   STD_LOGIC_VECTOR (3 downto 0);
           SWITCHES : in    STD_LOGIC_VECTOR (7 downto 0);
           INT      : in    STD_LOGIC;
           RST      : in    STD_LOGIC;
           CLK      : in    STD_LOGIC);
end RAT_wrapper;

architecture Behavioral of RAT_wrapper is
   component sseg_dec_uni is
    Port (       COUNT1 : in std_logic_vector(13 downto 0); 
                 COUNT2 : in std_logic_vector(7 downto 0);
                    SEL : in std_logic_vector(1 downto 0);
			      dp_oe : in std_logic;
                     dp : in std_logic_vector(1 downto 0); 					  
                    CLK : in std_logic;
				   SIGN : in std_logic;
				  VALID : in std_logic;
                DISP_EN : out std_logic_vector(3 downto 0);
               SEGMENTS : out std_logic_vector(7 downto 0));
   end component;

   -- INPUT PORT IDS -------------------------------------------------------------
   -- Right now, the only possible inputs are the switches
   -- In future labs you can add more port IDs, and you'll have
   -- to add constants here for the mux below
   CONSTANT SWITCHES_ID : STD_LOGIC_VECTOR (7 downto 0) := X"20";
   -------------------------------------------------------------------------------
   
   -------------------------------------------------------------------------------
   -- OUTPUT PORT IDS ------------------------------------------------------------
   -- In future labs you can add more port IDs
   CONSTANT LEDS_ID       : STD_LOGIC_VECTOR (7 downto 0) := X"40";
   CONSTANT SEGS_ID       : STD_LOGIC_VECTOR (7 downto 0) := X"82";
   CONSTANT DISP_ID       : STD_LOGIC_VECTOR (7 downto 0) := X"83";
   -------------------------------------------------------------------------------
   
   -- Declare CLK_Divider --------------------------------------------------------
   component clk_wiz_0 
      Port (
     -- Clock in ports
         clk_in1  : in STD_LOGIC;
     -- Clock out ports
         clk_out1 : out STD_LOGIC);
   end component;
   
   signal new_CLK : STD_LOGIC;
   
   -- Declare RAT_CPU ------------------------------------------------------------
   component RAT_MCU 
       Port ( IN_PORT  : in  STD_LOGIC_VECTOR (7 downto 0);
              OUT_PORT : out STD_LOGIC_VECTOR (7 downto 0);
              PORT_ID  : out STD_LOGIC_VECTOR (7 downto 0);
              IO_STRB  : out STD_LOGIC;
              RESET    : in  STD_LOGIC;
              INT_IN   : in  STD_LOGIC;
              CLK      : in  STD_LOGIC);
   end component RAT_MCU;
   -------------------------------------------------------------------------------
   
   --Signals for connecting SSEG to RAT_wrapper ----------------------------------
  
   signal s_disp_en     : std_logic_vector (3 downto 0);
   signal s_segments    : std_logic_vector (7 downto 0);

   -- Signals for connecting RAT_CPU to RAT_wrapper -------------------------------
   signal s_input_port  : std_logic_vector (7 downto 0);
   signal s_output_port : std_logic_vector (7 downto 0);
   signal s_port_id     : std_logic_vector (7 downto 0);
   signal s_load        : std_logic;
   signal s_interrupt   : std_logic;
   
   -- Register definitions for output devices ------------------------------------
   signal r_LEDS        : std_logic_vector (7 downto 0); 
   signal r_SEGMENT     : std_logic_vector (7 downto 0) := "00000000";
   signal r_DISP_EN     : std_logic_vector (3 downto 0);
   signal r_CONTROL_REG : std_logic_vector (13 downto 0) := "00000000000000";
   -------------------------------------------------------------------------------

begin
   CLK_DIV: clk_wiz_0
   port map( clk_in1  => CLK,
             clk_out1 => new_CLK);
             
   -- Instantiate RAT_CPU --------------------------------------------------------
   CPU: RAT_MCU
   port map(  IN_PORT  => s_input_port,
              OUT_PORT => s_output_port,
              PORT_ID  => s_port_id,
              RESET    => RST,  
              IO_STRB  => s_load,
              INT_IN   => INT,
              CLK      => new_CLK);         
   -------------------------------------------------------------------------------

   ------------------------------------------------------------------------------- 
   -- MUX for selecting what input to read ---------------------------------------
   -------------------------------------------------------------------------------
   inputs: process(s_port_id, SWITCHES)
   begin
      if (s_port_id = SWITCHES_ID) then
         s_input_port <= SWITCHES;
      else
         s_input_port <= x"00";
      end if;
   end process inputs;
   -------------------------------------------------------------------------------


   -------------------------------------------------------------------------------
   -- MUX for updating output registers ------------------------------------------
   -- Register updates depend on rising clock edge and asserted load signal
   -------------------------------------------------------------------------------
   outputs: process(new_CLK) 
   begin   
      if (rising_edge(new_CLK)) then
         if (s_load = '1') then 
           
            -- the register definition for the LEDS
            if ( s_port_id = LEDS_ID ) then
               r_LEDS <= s_output_port;
            elsif ( s_port_id = SEGS_ID ) then
               r_SEGMENT <= s_output_port;
            elsif ( s_port_id = DISP_ID ) then
               r_DISP_EN <= "11" & s_output_port(7) & s_output_port(3);
            end if;
           
         end if; 
      end if;
   end process outputs;      
   -------------------------------------------------------------------------------
   r_CONTROL_REG <= "00000000001001";

   --sseg: sseg_dec_uni
   --port map (    COUNT1 => r_CONTROL_REG,
   --              COUNT2 => r_SEGMENT,
   --                 SEL => "10",
   --			      dp_oe => '0',
   --                  dp => "00", 					  
   --                 CLK => new_CLK,
   --   			   SIGN => '0',
	--			  VALID => '1',
    --            DISP_EN => DISP_EN,
    --           SEGMENTS => SEGMENTS);

   -- Register Interface Assignments ---------------------------------------------
   LEDS <= r_LEDS;
   SEGMENTS <= r_SEGMENT;
   DISP_EN <= r_DISP_EN;

end Behavioral;