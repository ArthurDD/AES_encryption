library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

library LIB_AES;
use LIB_AES.crypt_pack.all;

library LIB_RTL;

entity mixcol_tb is

end mixcol_tb;

architecture mixcol_tb_arch of mixcol_tb is

	component mixcol 
		port(
			data_i : in type_state;
		 	data_o : out type_state;
			enable_i : in std_logic
		);
	end component mixcol;
	
	signal data_i_s : type_state;
	signal data_o_s : type_state;
	signal enable_i_s : std_logic;

begin
	
	DUT : mixcol port map
		(
			data_i => data_i_s,
			data_o => data_o_s,
			enable_i => enable_i_s
		);
	
	
	data_i_s <= ((x"9F",x"4C",x"A6",x"F8"),
        	     (x"19",x"81",x"AC",x"D7"),
        	     (x"10",x"A8",x"07",x"C8"),
        	     (x"7B",x"AA",x"DD",x"8E"));
   
--    data_i_s <= ((x"A6",x"7E",x"83",x"D9"),
--        	     (x"52",x"4F",x"CE",x"9C"),
--         	     (x"83",x"39",x"03",x"84"),
--        	     (x"AB",x"00",x"7B",x"25"));
   
   enable_i_s <= '0', '1' after 50 ns;
   
end architecture mixcol_tb_arch;


configuration mixcol_tb_conf of mixcol_tb is 
	for mixcol_tb_arch
		for DUT : mixcol
			use entity LIB_RTL.mixcol(mixcol_arch);
		end for;
	end for;
end configuration mixcol_tb_conf;