----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    20:59:29 02/04/2013 
-- Design Name: 
-- Module Name:    RAT_CPU - Behavioral 
-- Project Name: 
-- Target Devices: 
-- Tool versions: 
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


entity RAT_MCU is
    Port ( IN_PORT  : in  STD_LOGIC_VECTOR (7 downto 0);
           RESET    : in  STD_LOGIC;
           CLK      : in  STD_LOGIC;
           INT_IN   : in  STD_LOGIC;
           OUT_PORT : out  STD_LOGIC_VECTOR (7 downto 0);
           PORT_ID  : out  STD_LOGIC_VECTOR (7 downto 0);
           IO_STRB  : out  STD_LOGIC);
end RAT_MCU;



architecture Behavioral of RAT_MCU is

   component prog_rom  
      port (     ADDRESS : in std_logic_vector(9 downto 0); 
             INSTRUCTION : out std_logic_vector(17 downto 0); 
                     CLK : in std_logic);  
   end component;

   component ALU
       Port ( A : in  STD_LOGIC_VECTOR (7 downto 0);
              B : in  STD_LOGIC_VECTOR (7 downto 0);
              Cin : in  STD_LOGIC;
              SEL : in  STD_LOGIC_VECTOR(3 downto 0);
              C : out  STD_LOGIC;
              Z : out  STD_LOGIC;
              RESULT : out  STD_LOGIC_VECTOR (7 downto 0));
   end component;

   component ControlUnit
       Port ( CLK           : in   STD_LOGIC;
              C_FLAG        : in   STD_LOGIC;
              Z_FLAG        : in   STD_LOGIC;
              INT           : in   STD_LOGIC;
              RESET         : in   STD_LOGIC;
              OPCODE_HI_5   : in   STD_LOGIC_VECTOR (4 downto 0);
              OPCODE_LO_2   : in   STD_LOGIC_VECTOR (1 downto 0);
              
              PC_LD         : out  STD_LOGIC;
              PC_INC        : out  STD_LOGIC;
              RST           : out  STD_LOGIC;		  
              PC_MUX_SEL    : out  STD_LOGIC_VECTOR (1 downto 0);
              SP_LD         : out  STD_LOGIC;
              SP_INCR       : out  STD_LOGIC;
              SP_DECR       : out  STD_LOGIC;
              RF_WR         : out  STD_LOGIC;
              RF_WR_SEL     : out  STD_LOGIC_VECTOR (1 downto 0);
              ALU_OPY_SEL   : out  STD_LOGIC;
              ALU_SEL       : out  STD_LOGIC_VECTOR (3 downto 0);
              SCR_WR        : out  STD_LOGIC;
              SCR_DATA_SEL  : out  STD_LOGIC;
              SCR_ADDR_SEL  : out  STD_LOGIC_VECTOR (1 downto 0);
              FLAG_LD_SEL   : out  STD_LOGIC;
              FLAG_C_LD     : out  STD_LOGIC;
              FLAG_C_CLR    : out  STD_LOGIC;
              FLAG_C_SET    : out  STD_LOGIC;
              FLAG_SHAD_LD  : out  STD_LOGIC;
              FLAG_Z_LD     : out  STD_LOGIC;
              I_SET         : out  STD_LOGIC;
              I_CLR         : out  STD_LOGIC;
              IO_STRB       : out  STD_LOGIC);
   end component;

   component RegisterFile 
       Port ( D_IN   : in     STD_LOGIC_VECTOR (7 downto 0);
              DX_OUT : out  STD_LOGIC_VECTOR (7 downto 0);
              DY_OUT : out    STD_LOGIC_VECTOR (7 downto 0);
              ADRX   : in     STD_LOGIC_VECTOR (4 downto 0);
              ADRY   : in     STD_LOGIC_VECTOR (4 downto 0);
              WE     : in     STD_LOGIC;
              CLK    : in     STD_LOGIC);
   end component;

   component DUAL_MUX_SEL is
      Port ( MUX_0      : in STD_LOGIC_VECTOR(7 downTo 0);
             MUX_1      : in STD_LOGIC_VECTOR(7 downTo 0);
             MUX_SEL    : in STD_LOGIC;
             MUX_OUTPUT : out STD_LOGIC_VECTOR(7 downTo 0));
   end component;

   component QUAD_MUX_SEL is
      Port ( MUX_0      : in STD_LOGIC_VECTOR(7 downTo 0);
             MUX_1      : in STD_LOGIC_VECTOR(7 downTo 0);
             MUX_2      : in STD_LOGIC_VECTOR(7 downTo 0);
             MUX_3      : in STD_LOGIC_VECTOR(7 downTo 0);
             MUX_SEL    : in STD_LOGIC_VECTOR(1 downTo 0);
             MUX_OUTPUT : out STD_LOGIC_VECTOR(7 downTo 0));
   end component;

   component FLAGS is
      Port ( FLG_C_SET   : in STD_LOGIC;
             FLG_C_CLR   : in STD_LOGIC;
             FLG_C_LD    : in STD_LOGIC;
             FLG_Z_LD    : in STD_LOGIC;
             FLG_LD_SEL  : in STD_LOGIC;
             FLG_SHAD_LD : in STD_LOGIC;
             C           : in STD_LOGIC;
             Z           : in STD_LOGIC;
             CLK         : in STD_LOGIC;
             Z_FLAG      : out STD_LOGIC;
             C_FLAG      : out STD_LOGIC);
   end component;

   component PC_MUX_WRAPPER 
      port ( RST,CLK,PC_LD,PC_INC : in std_logic; 
             FROM_IMMED : in std_logic_vector (9 downto 0); 
             FROM_STACK : in std_logic_vector (9 downto 0);  
             MUX_SEL    : in std_logic_vector (1 downto 0); 
             PC_COUNT   : out std_logic_vector (9 downto 0));  
   end component;

   -- intermediate signals ----------------------------------
   signal s_pc_ld        : std_logic := '0'; 
   signal s_pc_inc       : std_logic := '0'; 
   signal s_pc_mux_sel   : std_logic_vector(1 downto 0) := "00"; 
   signal s_pc_count     : std_logic_vector(9 downto 0) := (others => '0'); 

   signal s_instruction  : std_logic_vector(17 downto 0) := (others => '0'); 
   
   signal s_flg_c_ld     : std_logic := '0';
   signal s_flg_c_clr    : std_logic := '0';
   signal s_flg_c_set    : std_logic := '0';
   signal s_flg_shad_ld  : std_logic := '0';
   signal s_flg_z_ld     : std_logic := '0';
   signal s_i_set        : std_logic := '0';
   signal s_i_clr        : std_logic := '0';
   signal s_sp_ld        : std_logic := '0';
   signal s_sp_incr      : std_logic := '0';
   signal s_sp_decr      : std_logic := '0';
   signal s_scr_wr       : std_logic := '0';
   signal s_scr_data_sel : std_logic := '0';
   signal s_scr_addr_sel : std_logic_vector(1 downTo 0) := (others => '0');
   signal s_flg_ld_sel   : std_logic := '0';
   signal s_alu_sel      : std_logic_vector(3 downTo 0) := (others => '0');
   signal s_c_flag       : std_logic := '0';
   signal s_z_flag       : std_logic := '0';
   signal s_alu_opy_sel  : std_logic := '0';
   signal s_rf_wr        : std_logic := '0';
   signal s_rf_wr_sel    : std_logic_vector(1 downTo 0) := (others => '0');
   signal s_rst          : std_logic := '0';
   signal s_io_strb      : std_logic := '0';
   
   signal s_reg_in       : std_logic_vector(7 downTo 0) := (others => '0');
   signal s_dx_out       : std_logic_vector(7 downTo 0) := (others => '0');
   signal s_dy_out       : std_logic_vector(7 downTo 0) := (others => '0');
   
   signal s_alu_b        : std_logic_vector(7 downTo 0) := (others => '0');
   signal s_alu_c        : std_logic := '0';
   signal s_alu_z        : std_logic := '0';
   
   
   signal s_scr_data_out : std_logic_vector(9 downTo 0) := (others => '0');
   signal s_alu_result   : std_logic_vector(7 downTo 0) := (others => '0');
   signal s_sp_data_out  : std_logic_vector(7 downTo 0) := (others => '0');

   -- helpful aliases ------------------------------------------------------------------
   alias s_ir_immed_bits : std_logic_vector(9 downto 0) is s_instruction(12 downto 3); 
 
   

begin

   my_prog_rom: prog_rom  
   port map(     ADDRESS => s_pc_count, 
             INSTRUCTION => s_instruction, 
                     CLK => CLK); 

   my_PC: PC_MUX_WRAPPER 
   port map ( RST        => s_rst,
              CLK        => CLK,
              PC_LD      => s_pc_ld,
              PC_INC     => s_pc_inc,
              FROM_IMMED => s_instruction(12 downTo 3),
              FROM_STACK => s_scr_data_out,
              MUX_SEL    => s_pc_mux_sel,
              PC_COUNT   => s_pc_count); 

   my_quadMux: QUAD_MUX_SEL
   port map ( MUX_0      => s_alu_result,
              MUX_1      => s_scr_data_out(7 downTo 0),
              MUX_2      => s_sp_data_out,
              MUX_3      => IN_PORT,
              MUX_SEL    => s_rf_wr_sel,
              MUX_OUTPUT => s_reg_in);

   my_regfile: RegisterFile 
   port map ( D_IN   => s_reg_in,   
              DX_OUT => s_dx_out,   
              DY_OUT => s_dy_out,   
              ADRX   => s_instruction(12 downTo 8),   
              ADRY   => s_instruction(7 downTo 3),   
              WE     => s_rf_wr,   
              CLK    => CLK); 

   my_alu_mux: DUAL_MUX_SEL
   port map ( MUX_0      => s_dy_out,
              MUX_1      => s_instruction(7 downTo 0),
              MUX_SEL    => s_alu_opy_sel,
              MUX_OUTPUT => s_alu_b);

   my_alu: ALU
   port map ( A => s_dx_out,       
              B => s_alu_b,       
              Cin => s_c_flag,     
              SEL => s_alu_sel,     
              C => s_alu_c,       
              Z => s_alu_z,       
              RESULT => s_alu_result); 

   my_flags: FLAGS 
   port map ( C           => s_alu_c,
              Z           => s_alu_z,
              FLG_C_LD    => s_flg_c_ld,
              FLG_C_SET   => s_flg_c_set,
              FLG_Z_LD    => s_flg_z_ld,
              FLG_C_CLR   => s_flg_c_clr,
              FLG_LD_SEL  => s_flg_ld_sel,
              FLG_SHAD_LD => s_flg_shad_ld,
              CLK         => CLK,
              C_FLAG      => s_c_flag,
              Z_FLAG      => s_z_flag);

   my_cpu: ControlUnit 
   port map ( CLK           => CLK, 
              C_FLAG        => s_c_flag,
              Z_FLAG        => s_z_flag,
              INT           => INT_IN,
              RESET         => RESET,
              OPCODE_HI_5   => s_instruction(17 downTo 13),
              OPCODE_LO_2   => s_instruction(1 downto 0),
                 
              PC_LD         => s_pc_ld,
              PC_INC        => s_pc_inc,
              RST           => s_rst,
              PC_MUX_SEL    => s_pc_mux_sel,
              SP_LD         => s_sp_ld,
              SP_INCR       => s_sp_incr,
              SP_DECR       => s_sp_decr,
              RF_WR         => s_rf_wr,
              RF_WR_SEL     => s_rf_wr_sel,
              ALU_OPY_SEL   => s_alu_opy_sel,
              ALU_SEL       => s_alu_sel,
              SCR_WR        => s_scr_wr,
              SCR_DATA_SEL  => s_scr_data_sel,
              SCR_ADDR_SEL  => s_scr_addr_sel,
              FLAG_LD_SEL    => s_flg_ld_sel,
              FLAG_C_LD      => s_flg_c_ld,
              FLAG_C_CLR     => s_flg_c_clr,
              FLAG_C_SET     => s_flg_c_set,
              FLAG_SHAD_LD   => s_flg_shad_ld,
              FLAG_Z_LD      => s_flg_z_ld,
              I_SET         => s_i_set,
              I_CLR         => s_i_clr,
              IO_STRB       => s_io_strb);
              
   OUT_PORT <= s_dx_out;
   PORT_ID  <= s_instruction(7 downTo 0);
   IO_STRB  <= s_io_strb;



end Behavioral;
