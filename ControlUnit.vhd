
----------------------------------------------------------------------------------
-- Company:  CPE 233
-- -------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity ControlUnit is
    Port ( CLK           : in   STD_LOGIC;
           C_FLAG        : in   STD_LOGIC;
           Z_FLAG        : in   STD_LOGIC;
           INT           : in   STD_LOGIC;
           RESET         : in   STD_LOGIC;
           OPCODE_HI_5   : in   STD_LOGIC_VECTOR (4 downto 0);
           OPCODE_LO_2   : in   STD_LOGIC_VECTOR (1 downto 0);
 
           RST           : out  STD_LOGIC;
           PC_LD         : out  STD_LOGIC;
           PC_INC        : out  STD_LOGIC;
           PC_MUX_SEL    : out  STD_LOGIC_VECTOR (1 downto 0);
  
           SP_LD         : out  STD_LOGIC;
           SP_INCR       : out  STD_LOGIC;
           SP_DECR       : out  STD_LOGIC;

           RF_WR         : out  STD_LOGIC;
           RF_WR_SEL     : out  STD_LOGIC_VECTOR (1 downto 0);

           ALU_OPY_SEL   : out  STD_LOGIC;
           ALU_SEL       : out  STD_LOGIC_VECTOR (3 downto 0);
  
           SCR_WR        : out  STD_LOGIC;
           SCR_DATA_SEL  : out STD_LOGIC;
           SCR_ADDR_SEL  : out  STD_LOGIC_VECTOR (1 downto 0);
  
           FLAG_LD_SEL   : out  STD_LOGIC;
           FLAG_SHAD_LD  : out  STD_LOGIC;
  
           FLAG_C_LD     : out  STD_LOGIC;
           FLAG_C_SET    : out  STD_LOGIC;
           FLAG_C_CLR    : out  STD_LOGIC;
           
           FLAG_Z_LD     : out  STD_LOGIC;
           FLAG_Z_SET    : out  STD_LOGIC;
           FLAG_Z_CLR    : out  STD_LOGIC;
  
           I_SET         : out STD_LOGIC;
           I_CLR         : out STD_LOGIC;
           IO_STRB       : out  STD_LOGIC);
end ControlUnit;

architecture Behavioral of ControlUnit is

type state_type is (ST_init, ST_fet, ST_exec);
signal PS,NS : state_type;
signal sig_OPCODE_7: std_logic_vector (6 downto 0);
begin
    -- concatenate the all opcodes into a 7-bit complete opcode for
-- easy instruction decoding.
   sig_OPCODE_7 <= OPCODE_HI_5 & OPCODE_LO_2;

   sync_p: process (CLK, NS, RESET)
begin
   if (RESET = '1') then
      PS <= ST_init;
   elsif (rising_edge(CLK)) then 
      PS <= NS;
   end if;
end process sync_p;


   comb_p: process (sig_OPCODE_7, PS, NS)
   begin
    
    -- This is the default block for all signals set in the STATE cases.  Note that any output values desired 
    -- to be different from these values shown below will be assigned in the individual case statements for 
-- each STATE.  Please note that that this "default" set of values must be stated for each individual case
    -- statement.  We have a case statement for CPU states and then an embedded case statement for OPCODE 
    -- resolution. 

   PC_LD          <= '0';     RF_WR          <= '0';       FLAG_C_LD      <= '0';     I_SET          <= '0';
   PC_INC         <= '0';     RF_WR_SEL      <= "00";      FLAG_C_SET     <= '0';     I_CLR          <= '0';
   PC_MUX_SEL     <= "00";    ALU_OPY_SEL    <= '0';       FLAG_C_CLR     <= '0';
                              ALU_SEL        <= "0000";                               FLAG_LD_SEL    <= '0';
   SP_LD          <= '0';     SCR_DATA_SEL   <= '0';       FLAG_Z_LD      <= '0';     FLAG_SHAD_LD   <= '0';
   SP_INCR        <= '0';     SCR_WR         <= '0';       FLAG_Z_SET     <= '0';
   SP_DECR        <= '0';     SCR_ADDR_SEL   <= "00";      FLAG_Z_CLR     <= '0'; 
                                                          
   IO_STRB        <= '0';     RST            <= '0'; 
                                             
case PS is
   -- STATE: the init cycle ------------------------------------
   -- Initialize all control outputs to non-active states and reset the PC and SP to all zeros.
   when ST_init => 
      NS <= ST_fet;
      RST <= '1';
      RST <= '1';
         -- STATE: the fetch cycle -----------------------------------
   when ST_fet => 
      NS <= ST_exec;
      PC_INC <= '1';
        -- STATE: the execute cycle ---------------------------------
   when ST_exec => 
      NS <= ST_fet;
      -- This is the default block for all signals set in the OPCODE cases.  Note that any output values desired 
      -- to be different from these values shown below will be assigned in the individual case statements for 
      -- each opcode.
      PC_LD          <= '0';     RF_WR          <= '0';       FLAG_C_LD      <= '0';     I_SET          <= '0';
      PC_INC         <= '0';     RF_WR_SEL      <= "00";      FLAG_C_SET     <= '0';     I_CLR          <= '0';
      PC_MUX_SEL     <= "00";    ALU_OPY_SEL    <= '0';       FLAG_C_CLR     <= '0';
                                 ALU_SEL        <= "0000";                               FLAG_LD_SEL    <= '0';
      SP_LD          <= '0';     SCR_DATA_SEL   <= '0';       FLAG_Z_LD      <= '0';     FLAG_SHAD_LD   <= '0';
      SP_INCR        <= '0';     SCR_WR         <= '0';       FLAG_Z_SET     <= '0';
      SP_DECR        <= '0';     SCR_ADDR_SEL   <= "00";      FLAG_Z_CLR     <= '0';                 
                                                                                      
      IO_STRB        <= '0';     RST            <= '0'; 
case sig_OPCODE_7 is
   
   -- ADD reg-reg ----------
               when "0000100" =>
                  
                  
   -- ADD reg-immed --------
               when "1010000" | "1010001" | "1010010" | "1010011" =>
               
               
   -- ADDC reg-reg ---------
               when "0000101" =>
               
               
   -- ADDC reg-immed -------
               when "1010100" | "1010101" | "1010110" | "1010111" =>
               
               
   -- 
   
   
   -- BRN ------------------
               when "0010000" =>   
                  PC_LD       <= '1';
                  PC_MUX_SEL  <= "00";

   -- EXOR reg-reg ---------
               when "0000010" =>
                  RF_WR       <= '1';
                  ALU_SEL     <= "0111";
                  FLAG_Z_LD   <= '1';
  
   -- EXOR reg-immed -------
               when "1001000" | "1001001" | "1001010" | "1001011" =>
                  RF_WR       <= '1';
                  FLAG_Z_LD   <= '1';
                  ALU_SEL     <= "0111";
                  ALU_OPY_SEL <= '1';
              
   -- IN reg-in_port(imm_val) ------
               when "1100100" | "1100101" | "1100110" | "1100111"=>
                  RF_WR       <= '1';
                  RF_WR_SEL   <= "11";
     
   -- MOV reg-reg ------
               when "0001001" =>
                  RF_WR       <= '1';
                  ALU_SEL     <= "1110";
                  RF_WR_SEL   <= "00";
  
   -- MOV reg-immed ------ 
               when "1101100" | "1101101" | "1101110" | "1101111" =>
                  RF_WR       <= '1';
                  ALU_SEL     <= "1110";
                  ALU_OPY_SEL <= '1';
                  RF_WR_SEL   <= "00";
       
   -- OUT out_port(imm_val)-Rd ------
               when "1101000" | "1101001" | "1101010" | "1101011" =>
                  IO_STRB     <= '1';
   
  

               -- ADD WHEN CASES FOR IN, MOV, AND OUT INSTRUCTIONS HERE
               
               when others =>
                  -- repeat the default block here to avoid incompletely specified outputs and hence avoid
                  -- the problem of inadvertently created latches within the synthesized system.

 PC_LD          <= '0';     RF_WR          <= '0';       FLAG_C_LD      <= '0';     I_SET          <= '0';
 PC_INC         <= '0';     RF_WR_SEL      <= "00";      FLAG_C_SET     <= '0';     I_CLR          <= '0';
 PC_MUX_SEL     <= "00";    ALU_OPY_SEL    <= '0';       FLAG_C_CLR     <= '0';
                            ALU_SEL        <= "0000";                               FLAG_LD_SEL    <= '0';
 SP_LD          <= '0';     SCR_DATA_SEL   <= '0';       FLAG_Z_LD      <= '0';     FLAG_SHAD_LD   <= '0';
 SP_INCR        <= '0';     SCR_WR         <= '0';       FLAG_Z_SET     <= '0';
 SP_DECR        <= '0';     SCR_ADDR_SEL   <= "00";      FLAG_Z_CLR     <= '0';                 
                                                                       
 IO_STRB        <= '0';     RST            <= '0'; 
 
           end case;

          when others => 
  NS <= ST_fet;
   
            -- repeat the default block here to avoid incompletely specified outputs and hence avoid
            -- the problem of inadvertently created latches within the synthesized system.
            PC_LD          <= '0';     RF_WR          <= '0';       FLAG_C_LD      <= '0';     I_SET          <= '0';
            PC_INC         <= '0';     RF_WR_SEL      <= "00";       FLAG_C_SET     <= '0';     I_CLR          <= '0';
            PC_MUX_SEL     <= "00";    ALU_OPY_SEL    <= '0';       FLAG_C_CLR     <= '0';
                                       ALU_SEL        <= "0000";                               FLAG_LD_SEL    <= '0';
            SP_LD          <= '0';     SCR_DATA_SEL   <= '0';       FLAG_Z_LD      <= '0';     FLAG_SHAD_LD   <= '0';
            SP_INCR        <= '0';     SCR_WR         <= '0';       FLAG_Z_SET     <= '0';
            SP_DECR        <= '0';     SCR_ADDR_SEL   <= "00";      FLAG_Z_CLR     <= '0';                 
                                                                                  
            IO_STRB        <= '0';     RST            <= '0'; 
   end case;
   end process comb_p;
end Behavioral;