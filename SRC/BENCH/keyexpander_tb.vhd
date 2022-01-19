library IEEE;
use IEEE.std_logic_1164.all;
library LIB_AES;
library LIB_RTL;
use LIB_AES.crypt_pack.all;


entity keyexpander_tb is

end entity keyexpander_tb;



architecture keyexpander_tb_arch of keyexpander_tb is

	component keyexpander 
		port(
			key_i : in bit128;
			rcon_i : in bit8;
			expansion_key_o : out bit128
			
		);
	end component;
			
	signal key_s : bit128;
	signal rcon_s : bit8;
	signal expansion_key_s : bit128;

begin

	KE : keyexpander
		port map(
			key_i => key_s,
			rcon_i => rcon_s,
			expansion_key_o => expansion_key_s
		);

	key_s <= X"2B7E151628AED2A6ABF7158809CF4F3C";
	rcon_s <= X"01";
	
	
	
end architecture keyexpander_tb_arch;




configuration keyexpander_tb_conf of keyexpander_tb is
	for keyexpander_tb_arch
		for KE : keyexpander
			use entity LIB_RTL.keyexpander(keyexpander_arch);
		end for;
	end for;

end configuration keyexpander_tb_conf;