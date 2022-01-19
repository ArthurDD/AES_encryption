library IEEE;
use IEEE.STD_LOGIC_1164.all;
use IEEE.numeric_std.all;

library LIB_AES;
use LIB_AES.crypt_pack.all;

entity Counter is
  port(reset_i  : in  std_logic;
       enable_i : in  std_logic;
       clock_i  : in  std_logic;
       counter_o  : out bit4);
end entity Counter;



architecture Counter_arch of Counter is

  signal counter_s : natural range 0 to 15;
  
begin

  P0 : process(clock_i, reset_i, enable_i)
  begin
    if (reset_i = '1') then
      counter_s <= 0;
    elsif (clock_i'event and clock_i = '1') then
      if (enable_i = '1') then
        counter_s <= counter_s + 1;
      else
        counter_s <= counter_s;
      end if;
    end if;
  end process P0;

  counter_o <= std_logic_vector(to_unsigned(counter_s, 4));

end architecture Counter_arch;

