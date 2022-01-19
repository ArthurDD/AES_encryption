library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

library LIB_AES;
use LIB_AES.crypt_pack.all;

library LIB_RTL;


entity addroundkey_tb is

end entity addroundkey_tb;


architecture addroundkey_tb_arch of addroundkey_tb is

component addroundkey
	port(
		data_i : in type_state;
		key_i : in type_state;
		data_o : out type_state
	);
end component;

signal data_i_s : type_state;
signal key_i_s : type_state;
signal data_o_s : type_state;


begin

DUT : addroundkey port map
		(
		data_i => data_i_s,
		key_i => key_i_s,
		data_o => data_o_s
		);
		
data_i_s <=  ((x"45",x"75",x"6E",x"E8"),
            (x"73",x"20",x"66",x"65"),
            (x"2D",x"63",x"69",x"20"),
            (x"74",x"6F",x"6E",x"3F"));

key_i_s <=   (( X"2B", X"28", X"AB", X"09" ),
			( X"7E", X"AE", X"F7", X"CF" ),
			( X"15", X"D2", X"15", X"4F" ),
			( X"16", X"A6", X"88", X"3C" ));

end addroundkey_tb_arch;

configuration addroundkey_tb_conf of addroundkey_tb is
	for addroundkey_tb_arch
		for DUT: addroundkey
			use entity LIB_RTL.addroundkey(addroundkey_arch);
		end for;
	end for;
end configuration addroundkey_tb_conf;