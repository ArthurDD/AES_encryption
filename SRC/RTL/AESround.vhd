library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

library LIB_AES;
use LIB_AES.crypt_pack.all;

library LIB_RTL;

entity AESround is
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

end entity AESround;


architecture AESround_arch of AESround is
	
	component subbytes is
		port(
			data_i : in type_state;
			data_o : out type_state
	 	);
	 end component;
	
	component shiftrow is
		port(
			data_i : in type_state;
       		data_o : out type_state
    	);
    end component;
	
	component mixcol is
		port(
			data_i : in type_state;
			data_o : out type_state;
			enable_i : in std_logic
		);
	end component;
	
	component addroundkey is
		port(
			data_i : in type_state;
			key_i : in type_state;
			data_o : out type_state
		);
	end component;
	
	component register_state is
		port(
			data_i : in type_state;
			data_o : out type_state;
			resetb_i : in std_logic;
			clock_i : in std_logic
		);
	end component;

	
	signal text_i_state_s : type_state;
	signal currentkey_i_state_s : type_state;
	
	signal inter_s : type_state;
	signal subbytes_s : type_state;
	signal shiftrow_s : type_state;
	signal mixcol_s : type_state;
	
	signal input_ark_s : type_state;
	signal addroundkey_s : type_state;
	
	signal converted_output_s : bit128;
	
	begin
			
		Round_SB : subbytes
			port map(
				data_i => inter_s, 	--
				data_o => subbytes_s
			);
		
		
		Round_SR : shiftrow
			port map(
				data_i => subbytes_s,
				data_o => shiftrow_s
			);

		
		Round_MC : mixcol
			port map(
				data_i => shiftrow_s,
				data_o => mixcol_s,
				enable_i => enableMixcolumns_i
			);
		
		
		Round_ARK : addroundkey
			port map(
				data_i => input_ark_s,
				key_i => currentkey_i_state_s,
				data_o => addroundkey_s
			);
		
				
		Round_REG : register_state
			port map(
				data_i => addroundkey_s,
				clock_i => clock_i,
				resetb_i => resetb_i,
				data_o => inter_s
			);

		--On convertit l'entrée texte et la clé (bit128) en type_state
		col1 : for i in 0 to 3 generate
			ligne1 : for j in 0 to 3 generate
				text_i_state_s(j)(i) <= text_i(127 - 32*i - 8*j downto 127 - 32*i - 8*j - 7);
				currentkey_i_state_s(j)(i) <= currentkey_i(127 - 32*i - 8*j downto 127 - 32*i - 8*j - 7);
			end generate ligne1;
		end generate col1;
		
		
		--Multiplexeur 
		input_ark_s <= text_i_state_s when enableRoundcomputing_i = '0' else mixcol_s;
		
		--Conversion de inter_s (type_state) en bit128		
		col2 : for i in 0 to 3 generate
			ligne2 : for j in 0 to 3 generate
				converted_output_s(127 - 32*i - 8*j downto 127 - 32*i - 8*j - 7) <= inter_s(j)(i);
			end generate ligne2;
		end generate col2;
		
		data_o <= converted_output_s;

end AESround_arch;


configuration AESround_conf of AESround is
	for AESround_arch
		for Round_SB: subbytes
			use entity LIB_RTL.subbytes(subbytes_arch);
		end for;

		for Round_SR: shiftrow
			use entity LIB_RTL.shiftrow(shiftrow_arch);
		end for;

		for Round_MC: mixcol
			use entity LIB_RTL.mixcol(mixcol_arch);
		end for;

		for Round_ARK: addroundkey
			use entity LIB_RTL.addroundkey(addroundkey_arch);
		end for;
		
		for Round_REG: register_state
			use entity LIB_RTL.register_state(register_state_arch);
		end for;
	end for;
	
end AESround_conf;











	
	
	
	
	