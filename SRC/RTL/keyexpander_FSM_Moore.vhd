library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

library LIB_AES;
use LIB_AES.crypt_pack.all;

entity keyexpander_FSM_Moore is
	port(
		start_i : in std_logic;
		clock_i : in std_logic;
		resetb_i : in std_logic;
		counter_i : in bit4;
		enable_o : out std_logic;
		resetb_o : out std_logic
		);

end keyexpander_FSM_Moore;

architecture keyexpander_FSM_Moore_arch of keyexpander_FSM_Moore is

	type state_type is (init, count, done);
	
	signal present_state, next_state : state_type;
	
begin
	
	base : process(clock_i, resetb_i)
	begin
		if (resetb_i = '1') then
			present_state <= init;
		else 
			if rising_edge(clock_i) then
				present_state <= next_state;
			end if;
		end if;
	end process;

	suivant : process(present_state, clock_i, start_i, counter_i)
	begin
		case present_state is
			when init =>
				if start_i = '1' then
					next_state <= count;
				else
					next_state <= init;
				end if;

			when count =>
				if counter_i >= x"9" then
						next_state <= done;
				else
						next_state <= count;
				end if;
			
			when done =>
				if start_i = '1' then
					next_state <= done;
				
				else 
					next_state <= init;
				end if;
		end case;
	end process;

	sorties : process(present_state)
	begin
		case present_state is
			when init =>
				enable_o <= '0';
				resetb_o <= '1';
			
			when count =>
				enable_o <= '1';
				resetb_o <= '0';
			
			when done =>
				enable_o <= '0';
				resetb_o <= '0';
		end case;
	end process;

end architecture keyexpander_FSM_Moore_arch;















				
			
		