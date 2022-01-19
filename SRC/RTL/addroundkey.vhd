library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

library LIB_AES;
use LIB_AES.crypt_pack.all;

entity addroundkey is
	port(
		data_i : in type_state;
		key_i : in type_state;
		data_o : out type_state
		);
end entity addroundkey;

architecture addroundkey_arch of addroundkey is

begin
	data_o(0) <= xor_ligne(data_i(0), key_i(0));
	data_o(1) <= xor_ligne(data_i(1), key_i(1));
	data_o(2) <= xor_ligne(data_i(2), key_i(2));
	data_o(3) <= xor_ligne(data_i(3), key_i(3));

end architecture addroundkey_arch;