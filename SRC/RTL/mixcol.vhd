library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

library LIB_AES;
use LIB_AES.crypt_pack.all;

library LIB_RTL;

entity mixcol is
	port(
		data_i : in type_state;
		data_o : out type_state;
		enable_i : in std_logic
		);
end entity mixcol;

architecture mixcol_arch of mixcol is

	signal temp_s : type_state;

begin 

	
	colonnes : for i in 0 to 3 generate
		temp_s(0)(i) <= (mult2(data_i(0)(i))) XOR (mult3(data_i(1)(i))) XOR data_i(2)(i) XOR data_i(3)(i);
		temp_s(1)(i) <= data_i(0)(i) XOR (mult2(data_i(1)(i))) XOR (mult3(data_i(2)(i))) XOR data_i(3)(i);
		temp_s(2)(i) <= data_i(0)(i) XOR data_i(1)(i) XOR (mult2(data_i(2)(i))) XOR (mult3(data_i(3)(i)));
		temp_s(3)(i) <= (mult3(data_i(0)(i))) XOR data_i(1)(i) XOR data_i(2)(i) XOR (mult2(data_i(3)(i)));
		
	end generate colonnes;
		
	data_o <= temp_s when enable_i = '1' else data_i;
		

end architecture mixcol_arch;
	
