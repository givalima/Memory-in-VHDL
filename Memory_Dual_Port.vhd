LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE ieee.numeric_std.ALL; 

USE work.ram_package.ALL;

ENTITY ram_dual IS
	PORT (clock1, clock2 : IN std_logic;
	data : IN word;
	write_address, read_address : IN address_vector;
	we : IN std_logic; q : OUT word );
END ram_dual;

ARCHITECTURE rtl OF ram_dual IS
	SIGNAL ram_block : RAM;
	SIGNAL read_address_reg : address_vector;
	BEGIN PROCESS (clock1)
		BEGIN
			IF (clock1'event AND clock1 = '1') THEN
				IF (we = '1') THEN ram_block(write_address) <= data;
				END IF;
			END IF;
	 	END PROCESS;
	
	PROCESS (clock2)
		BEGIN
		IF (clock2'event AND clock2 = '1') THEN
			q <= ram_block(read_address_reg);
			read_address_reg <= read_address;
		END IF;
	END PROCESS;
END rtl;
