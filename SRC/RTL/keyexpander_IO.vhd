library IEEE;
use IEEE.STD_LOGIC_1164.all;
use IEEE.numeric_std.all;

library LIB_AES;
use LIB_AES.crypt_pack.all;

library LIB_RTL;

entity keyexpander_IO is
	port(
		key_i : in bit128;
		clock_i : in std_logic;
		reset_i : in std_logic;
		start_i : in std_logic;
		expansion_key_o : out bit128
		);
end entity;


architecture keyexpander_IO_arch of keyexpander_IO is

	component keyexpander_FSM_Moore
		port(
			start_i : in std_logic;
			clock_i : in std_logic;
			resetb_i : in std_logic;
			counter_i : in bit4;
			enable_o : out std_logic;
			resetb_o : out std_logic
		);
	end component keyexpander_FSM_Moore;
	
	
	component counter
		 port (
			reset_i  : in  std_logic;
			enable_i : in  std_logic;
			clock_i  : in  std_logic;
	  		counter_o  : out bit4
	  	);
	end component counter;
	
	
	component keyexpander
		port(
			key_i : in bit128;
			rcon_i : in bit8;
			expansion_key_o : out bit128
		);
	end component keyexpander;

	
	component register_bit128
		port(
			data_i : in bit128;
			data_o : out bit128;
			resetb_i : in std_logic;
			clock_i : in std_logic
		);
	end component register_bit128;

	signal counter_s : bit4;		-- Signal de sortie du counter
	signal enable_s : std_logic; 	-- Signal entre la sortie de la FSM et counter
	signal resetb_s : std_logic;	-- Pareil ^^
	signal key_s : bit128;			-- Key en sortie du mux
	signal rcon_s : bit8;			-- En entrée du keyexpander
	signal expansion_key_s : bit128;	-- En sortie du keyexpander
	signal key_reg_s : bit128;		-- Key entre registre et mux

begin
	Key_FSM : keyexpander_FSM_Moore
		port map(
			start_i => start_i,
			clock_i => clock_i,
			resetb_i => reset_i,
			counter_i => counter_s,
			enable_o => enable_s,
			resetb_o => resetb_s
		);
	
	Counter_K : counter
		port map(
			reset_i => resetb_s,
			enable_i => enable_s,
			clock_i => clock_i,
			counter_o => counter_s
		);
	
	Key_exp : keyexpander
		port map(
			key_i => key_s,
			rcon_i => rcon_s,
			expansion_key_o => expansion_key_s
		);
		
	Registre : register_bit128
		port map(
			data_i => expansion_key_s,
			data_o => key_reg_s,
			resetb_i => reset_i,
			clock_i => clock_i
		);
	
	-- Multiplexeur		
	key_s <= key_i when (counter_s = X"0") else key_reg_s;
	
	rcon_s <= Rcon(to_integer(Unsigned(counter_s)));

	expansion_key_o <= key_s;
	
end architecture keyexpander_IO_arch;



configuration keyexpander_IO_conf of keyexpander_IO is
	for keyexpander_IO_arch
		for Key_FSM : keyexpander_FSM_Moore
			use entity LIB_RTL.keyexpander_FSM_Moore(keyexpander_FSM_Moore_arch);
		end for;
		
		for  Counter_K : counter
			use entity LIB_RTL.Counter(Counter_arch);
		end for;
		
		for Key_exp : keyexpander
			use entity LIB_RTL.keyexpander(keyexpander_arch);
		end for;
		
		for Registre : register_bit128
			use entity LIB_RTL.register_bit128(register_bit128_arch);
		end for;
	end for;

end configuration keyexpander_IO_conf;














