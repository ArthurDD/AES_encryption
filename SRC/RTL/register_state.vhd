library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

library LIB_AES;
use LIB_AES.crypt_pack.all;

library LIB_RTL;

entity register_state is
	port(
		data_i : in type_state;
		data_o : out type_state;
		resetb_i : in std_logic;
		clock_i : in std_logic
		);

end entity register_state;

architecture register_state_arch of register_state is

	signal reg_s : type_state;
	
	begin
		reg : process(clock_i, resetb_i, reg_s) is
		begin 
			if resetb_i = '1' then
				reg_s <= (others => (others => X"00"));
			
			elsif clock_i'event and clock_i = '1' then
				reg_s <= data_i;
			
			else
				reg_s <= reg_s;
			
			end if;
		end process reg;
		
		data_o <= reg_s;
	
end architecture register_state_arch;

