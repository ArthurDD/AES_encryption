library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

library LIB_AES;
use LIB_AES.crypt_pack.all;

library LIB_RTL;


entity AES_tb is

end entity AES_tb;


architecture AES_tb_arch of AES_tb is

	component AES is
		port(
			clock_i	: in  std_logic;
			reset_i	: in  std_logic;
			start_i	: in  std_logic;
			key_i	: in  bit128;
			data_i	: in  bit128;
			data_o	: out bit128;
			aes_on_o : out std_logic);	
	end component AES;
	
	signal clock_s	: std_logic := '0';
	signal reset_s	: std_logic := '1';
	signal start_s	: std_logic := '0';
	signal key_s	: bit128;
	signal data_i_s	: bit128;
	signal data_o_s	: bit128;
	signal aes_on_s : std_logic;	

begin

	AES0 : AES
		port map(
			clock_i => clock_s,
			reset_i => reset_s,
			start_i => start_s,
			key_i => key_s,
			data_i => data_i_s,
			data_o => data_o_s,
			aes_on_o => aes_on_s
			);
	
	clock_s <= not clock_s after 10 ns;
	start_s <= '1' after 20 ns;
	
	key_s <= X"2B7E151628AED2A6ABF7158809CF4F3C";
	
	data_i_s <= X"45732D747520636F6E66696EE865203F";
	
	
	
	




end architecture AES_tb_arch;



configuration AES_tb_conf of AES_tb is
	for AES_tb_arch
		for AES0 : AES
			use entity LIB_RTL.AES(AES_arch);
		end for;
	end for;

end configuration AES_tb_conf;