LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE ieee.numeric_std.ALL;
ENTITY Ula IS
PORT (a, b : IN std_logic_vector (31 DOWNTO 0);
sel : IN std_logic_vector (2 downto 0);
y : OUT std_logic_vector (31 DOWNTO 0));
END Ula;

ARCHITECTURE arch OF Ula IS
signal Soma, opera, mux: std_logic_vector(31 downto 0);

component mux2para1 IS
GENERIC (N :POSITIVE:= 31);
PORT (a, b : IN std_logic_vector (N-1 DOWNTO 0);
sel : IN std_logic;
y : OUT std_logic_vector (N - 1 DOWNTO 0));
END component;

BEGIN
DUV: entity work.Sum
 port map(a,b,sel(2),Soma);
 mux1: mux2para1 port map ();


END arch;