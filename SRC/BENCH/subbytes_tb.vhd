library IEEE;
use IEEE.std_logic_1164.all;
--conversion de bit8 (std_logic_vector) en entier
use IEEE.numeric_std.all;
--pour l'utilisation du type byt8
library LIB_AES;
use LIB_AES.crypt_pack.all;

library LIB_RTL;

entity subbytes_tb is 

end subbytes_tb;



architecture subbytes_tb_arch of subbytes_tb is

component subbytes
	port(
		data_i : in type_state;
		data_o : out type_state
		);

end component;

signal data_i_s : type_state;
signal data_o_s : type_state;


begin 

	DUT : subbytes port map(
		data_i => data_i_s,
		data_o => data_o_s
		);
	
	data_i_s <= ((x"45",x"75",x"6E",x"E8"),
                 (x"73",x"20",x"66",x"65"),
                 (x"2D",x"63",x"69",x"20"),
                 (x"74",x"6F",x"6E",x"3F"));

end subbytes_tb_arch;

configuration subbytes_tb_conf of subbytes_tb is
	for subbytes_tb_arch
		for all : subbytes
			use entity LIB_RTL.subbytes(subbytes_arch);
		end for;
	end for;
end configuration subbytes_tb_conf;
	
