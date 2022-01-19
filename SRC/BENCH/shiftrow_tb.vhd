library IEEE;
use IEEE.std_logic_1164.all;

use IEEE.numeric_std.all;

library LIB_AES;
use LIB_AES.crypt_pack.all;

library LIB_RTL;

entity shiftrow_tb is

end entity shiftrow_tb;

architecture shiftrow_tb_arch of shiftrow_tb is
component shiftrow
    port(
        data_i  : in type_state;
        data_o  : out type_state
    );
end component;

signal data_i_s : type_state;
signal data_o_s : type_state;

begin

DUT : shiftrow port map
    (
        data_i => data_i_s,
        data_o => data_o_s
    );


data_i_s <= ((x"01",x"02",x"03",x"04"),
             (x"01",x"02",x"03",x"04"),
             (x"01",x"02",x"03",x"04"),
             (x"01",x"02",x"03",x"04"));


end shiftrow_tb_arch ; -- shiftrow_arch

configuration shiftrow_tb_conf of shiftrow_tb is
    for shiftrow_tb_arch
        for DUT : shiftrow
            use entity LIB_RTL.shiftrow(shiftrow_arch);
        end for;
    end for;
end configuration shiftrow_tb_conf;