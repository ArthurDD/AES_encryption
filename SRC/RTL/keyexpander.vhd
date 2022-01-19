library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

library LIB_AES;
use LIB_AES.crypt_pack.all;

library LIB_RTL;

entity keyexpander is
	port(
		key_i : in bit128;
		rcon_i : in bit8;
		expansion_key_o : out bit128
	);
	
end keyexpander;


architecture keyexpander_arch of keyexpander is

--Signal pour convertir la clé en type_state
	signal key_col_s : state_col_t; -- clé en entrée mais convertie en state_col
	signal key_expand_s : state_col_t;	-- clé finale mais en state_col
	signal expansion_key_s : bit128;	-- clé finale
	
	signal rcon_s : column_state;

	signal rot_word_s : column_state;	-- contient première colonne rotated
	signal sub_word_s : column_state;	-- contient première colonne rotated et subbyted
	signal xor_word_s : column_state;	-- contient première colonne rotated, subbyted et xor avec rcon et 1
	
	component sbox 
		port(
        data_i : in bit8;
        data_o : out bit8
    );
			
	end component;
	
	
begin

--Etape de transformation du bit128 en state_col_t

--On convertit l'entrée  la clé (bit128) en type_state_col
		col1 : for i in 0 to 3 generate
			ligne1 : for j in 0 to 3 generate
				key_col_s(i)(j) <= key_i(127 - 32*i - 8*j downto 127 - 32*i - 8*j - 7);
			end generate ligne1;
		end generate col1;
	
	
-- Fabrication du rcon
	rcon_s <= (rcon_i, x"00", x"00", x"00");
 

-- Fabrication du rotword
	rot_word_s(3) <= key_col_s(3)(0);
	rot_word_s(0) <= key_col_s(3)(1);
	rot_word_s(1) <= key_col_s(3)(2);
	rot_word_s(2) <= key_col_s(3)(3);

-- Instances de sbox et subbytes sur rotword
	for_SB : for i in 0 to 3 generate
		label0 : sbox 
			port map(
				data_i => rot_word_s(i),
				data_o => sub_word_s(i)
			);
	end generate for_SB;
	

-- Xor
	xor1 : for i in 0 to 3 generate
		xor_word_s(i) <= key_col_s(0)(i) xor sub_word_s(i) xor rcon_s(i);
	end generate;
	
-- Construction de la nouvelle clé	
	key_expand_s(0) <= xor_word_s;
	
	xor2 : for i in 0 to 3 generate
		key_expand_s(1)(i) <= key_col_s(1)(i) xor key_expand_s(0)(i);
		key_expand_s(2)(i) <= key_col_s(2)(i) xor key_expand_s(1)(i);
		key_expand_s(3)(i) <= key_col_s(3)(i) xor key_expand_s(2)(i);
	end generate;
	
-- Conversion de l'expansion key en bit128
	col2 : for i in 0 to 3 generate
		ligne2 : for j in 0 to 3 generate
			expansion_key_s(127 - 32*i - 8*j downto 127 - 32*i - 8*j - 7) <= key_expand_s(i)(j);
		end generate ligne2;
	end generate col2;
	
	expansion_key_o <= expansion_key_s;

end architecture;


configuration keyexpander_conf of keyexpander is
	for keyexpander_arch
		for for_SB
			for all: sbox
				use entity LIB_RTL.sbox(sbox_arch);
			end for;
		end for;
	end for;

end configuration keyexpander_conf;










