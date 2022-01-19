library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

library LIB_AES;
use LIB_AES.crypt_pack.all;

library LIB_RTL;

entity keyexpander_FSM_Moore_tb is

end entity keyexpander_FSM_Moore_tb;


architecture keyexpander_FSM_Moore_tb_arch of keyexpander_FSM_Moore_tb is

	component keyexpander_FSM_Moore is
		port(
		start_i : in std_logic;
		clock_i : in std_logic;
		resetb_i : in std_logic;
		counter_i : in bit4;
		enable_o : out std_logic;
		resetb_o : out std_logic
		);
	end component keyexpander_FSM_Moore;
	
	signal start_s : std_logic := '0';
	signal clock_s : std_logic := '0';
	signal resetb_s : std_logic := '0';
	signal counter_s : bit4;
	signal enable_o_s : std_logic;
	signal resetb_o_s : std_logic;

begin

	FSM : keyexpander_FSM_Moore
		port map(
			start_i => start_s,
			clock_i => clock_s,
			resetb_i => resetb_s,
			counter_i => counter_s,
			enable_o => enable_o_s,
			resetb_o => resetb_o_s
		);
		
		clock_s <= not clock_s after 15 ns; 
		resetb_s <= '1' after 10 ns, '0' after 30 ns;
		
		start_s <= '1' after 40 ns;--, '0' after 50 ns;
		counter_s <= X"1" after 25 ns, x"2" after 50 ns, x"3" after 75 ns, x"4" after 100 ns, X"5" after 125 ns, x"5" after 150 ns, x"6" after 175 ns, x"7" after 200 ns, X"8" after 225 ns, x"9" after 250 ns;
		
end architecture keyexpander_FSM_Moore_tb_arch;




configuration keyexpander_FSM__Moore_tb_conf of keyexpander_FSM_Moore_tb is

for keyexpander_FSM_Moore_tb_arch
	for FSM : keyexpander_FSM_Moore
		use entity LIB_RTL.keyexpander_FSM_Moore(keyexpander_FSM_Moore_arch);
	end for;
end for;


end configuration keyexpander_FSM__Moore_tb_conf;