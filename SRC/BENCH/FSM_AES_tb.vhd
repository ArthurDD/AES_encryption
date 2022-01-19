library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

library LIB_AES;
use LIB_AES.crypt_pack.all;

library LIB_RTL;

entity FSM_AES_tb is

end entity FSM_AES_tb;


architecture FSM_AES_tb_arch of FSM_AES_tb is

	component FSM_AES is
		port (
			resetb_i : in std_logic;
			clock_i  : in std_logic;
        	start_i  : in std_logic;

        	reset_key_expander_o : out std_logic;
        	start_key_expander_o : out std_logic;

        	counter_aes_i        : in  bit4;
        	reset_counter_aes_o  : out std_logic;
        	enable_counter_aes_o : out std_logic;
	
        	enableMixcolumns_o     : out std_logic; 
        	enableRoundcomputing_o : out std_logic;
        	enableOutput_o         : out std_logic;
        	done_o                 : out std_logic);
	end component FSM_AES;
	
	signal start_s : std_logic := '0';
	signal clock_s : std_logic := '0';
	signal resetb_s : std_logic := '0';
	
	signal reset_key_expander_o_s : std_logic;
    signal start_key_expander_o_s : std_logic;
	
	signal counter_aes_s : bit4;
	signal reset_counter_aes_o_s : std_logic;
    signal enable_counter_aes_o_s : std_logic;
    
    
	signal enableMixcolumns_o_s : std_logic;
	signal enableRoundcomputing_o_s : std_logic;
	signal enableOutput_o_s : std_logic;
	signal done_o_s : std_logic;

begin

	FSM : FSM_AES
		port map(
			resetb_i => resetb_s,
			clock_i  => clock_s,
        	start_i  => start_s,

        	reset_key_expander_o => reset_key_expander_o_s,
        	start_key_expander_o => start_key_expander_o_s,

        	counter_aes_i => counter_aes_s,
        	reset_counter_aes_o => reset_counter_aes_o_s,
        	enable_counter_aes_o => enable_counter_aes_o_s,
	
        	enableMixcolumns_o => enableMixcolumns_o_s, 
        	enableRoundcomputing_o => enableRoundcomputing_o_s,
        	enableOutput_o => enableOutput_o_s,
        	done_o => done_o_s
		);
		
		clock_s <= not clock_s after 15 ns; 
		resetb_s <= '1' after 10 ns, '0' after 20 ns;
		
		start_s <= '1' after 25 ns;--, '0' after 25 ns;
		counter_aes_s <= X"1" after 50 ns, x"2" after 100 ns, x"8" after 200 ns, x"9" after 250 ns;
		
end architecture FSM_AES_tb_arch;




configuration FSM_AES_tb_conf of FSM_AES_tb is

for FSM_AES_tb_arch
	for FSM : FSM_AES
		use entity LIB_RTL.FSM_AES(FSM_AES_arch);
	end for;
end for;


end configuration FSM_AES_tb_conf;