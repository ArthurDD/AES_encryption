library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

library LIB_AES;
use LIB_AES.crypt_pack.all;

library LIB_RTL;


entity AESround_tb is

end entity AESround_tb;


architecture AESround_tb_arch of AESround_tb is

	component AESround
		port(
			text_i : in  bit128;
			currentkey_i : in  bit128;
			clock_i	: in  std_logic;
			resetb_i : in  std_logic;
			enableMixcolumns_i	: in  std_logic;
			enableRoundcomputing_i : in  std_logic;
			data_o : out bit128
			--inter_s_i : in type_state		--
		);
	end component;
	
	signal text_s : bit128;
	signal currentkey_s : bit128;
	signal clock_s : std_logic := '0';
	signal resetb_s : std_logic;
	signal enableMixcolumns_s : std_logic;
	signal enableRoundcomputing_s : std_logic;
	signal data_s : bit128;
	--signal inter_s : type_state; 		--
	

begin

	AESrd : AESround
		port map(
			text_i => text_s,
			currentkey_i => currentkey_s,
			clock_i => clock_s,
			resetb_i => resetb_s,
			enableMixcolumns_i => enableMixcolumns_s,
			enableRoundcomputing_i => enableRoundcomputing_s,
			data_o => data_s
			--inter_s_i => inter_s		--
		);
	
	text_s <= X"45732D747520636F6E66696EE865203F";
	
	--currentkey_s <= X"A0FAFE1788542CB123A339392A6C7605";
	
	currentkey_s <= X"2B7E151628AED2A6ABF7158809CF4F3C";
	
	clock_s <= not clock_s after 15 ns;
	
	resetb_s <= '0';
	
	enableMixcolumns_s <= '1';
	
	enableRoundcomputing_s <= '0';
	
	--inter_s <=  (( X"6E", X"5D", X"C5", X"E1" ),
	--			 ( X"0D", X"8E", X"91", X"AA" ),
	--			 ( X"38", X"B1", X"7C", X"6F" ),
	--			 ( X"62", X"C9", X"E6", X"03" ) );


end architecture AESround_tb_arch;




configuration AESround_tb_conf of AESround_tb is
	for AESround_tb_arch
		for AESrd : AESround
			use entity LIB_RTL.AESround(AESround_arch);
		end for;
	end for;

end configuration AESround_tb_conf;