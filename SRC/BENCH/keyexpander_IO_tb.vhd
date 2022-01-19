library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

library LIB_AES;
use LIB_AES.crypt_pack.all;

library LIB_RTL;

entity keyexpander_IO_tb is

end entity;


architecture keyexpander_IO_tb_arch of keyexpander_IO_tb is

	component keyexpander_IO is
		port(
			key_i : in bit128;
			clock_i : in std_logic;
			reset_i : in std_logic;
			start_i : in std_logic;
			expansion_key_o : out bit128
		);
	end component keyexpander_IO;

	signal key_s : bit128;
	signal clock_s : std_logic := '0';
	signal reset_s : std_logic := '0';
	signal start_s : std_logic := '0';
	signal expansion_key_s : bit128;

begin

	key_expander_IO : keyexpander_IO 
		port map(
			key_i => key_s,
			clock_i => clock_s,
			reset_i => reset_s,
			start_i => start_s,
			expansion_key_o => expansion_key_s
		);
			

	key_s <= X"2B7E151628AED2A6ABF7158809CF4F3C";

	clock_s <= not clock_s after 10 ns;
	
	start_s <= '1' after 50 ns, '0' after 75 ns;
	
	reset_s <= '1' after 5 ns, '0' after 20 ns;





end architecture;


configuration keyexpander_IO_tb_conf of keyexpander_IO_tb is
	for keyexpander_IO_tb_arch
		for key_expander_IO : keyexpander_IO
			use entity LIB_RTL.keyexpander_IO(keyexpander_IO_arch);
		end for;
	end for;
end configuration keyexpander_IO_tb_conf;




