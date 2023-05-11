library IEEE;
use IEEE.Std_Logic_1164.all;
use IEEE.std_logic_unsigned.all;

entity bo is
port ( zi, ci, cpa, cpb, zsoma, csoma, csad_reg, ck, reset: in std_logic;
menor: out std_logic;

A, B: in std_logic_vector(7 downto 0);
Saida: out std_logic_vector (13 downto 0);
endereco: out std_logic_vector (5 downto 0)

);
end bo;
architecture circuito of bo is
signal pA, pB, subi, absi: std_logic_vector (7 downto 0);
signal sum14, mux14, soma: std_logic_vector (13 downto 0);
signal mux7, i, voltinha: std_logic_vector (6 downto 0);

component Sum is
port (A: in std_logic_vector(6 downto 0);
B: in std_logic_vector(6 downto 0);
F: out std_logic_vector(6 downto 0)
);
end component;

component mux2para1 IS
GENERIC (N :POSITIVE:= 7);

PORT (a, b : IN std_logic_vector (N-1 DOWNTO 0);
sel : IN std_logic;
y : OUT std_logic_vector (N - 1 DOWNTO 0));

END component;

component registrador IS GENERIC (N : INTEGER := 8);

PORT( clk, rst, carga: IN STD_LOGIC;
D : IN STD_LOGIC_VECTOR (N-1 DOWNTO 0);
Q: OUT STD_LOGIC_VECTOR(N-1 DOWNTO 0) 
);
END component;

component registrador7 IS GENERIC (N : INTEGER := 7);

PORT( clk, rst, carga: IN STD_LOGIC;
D : IN STD_LOGIC_VECTOR (N-1 DOWNTO 0);
Q: OUT STD_LOGIC_VECTOR(N-1 DOWNTO 0) 
);
END component;

component registrador14 IS GENERIC (N : INTEGER := 14);

PORT( clk, rst, carga: IN STD_LOGIC;
D : IN STD_LOGIC_VECTOR (N-1 DOWNTO 0);
Q: OUT STD_LOGIC_VECTOR(N-1 DOWNTO 0) 
);
END component;

component mux2para114 IS
GENERIC (N :POSITIVE:= 14);

PORT (a, b : IN std_logic_vector (N-1 DOWNTO 0);
sel : IN std_logic;
y : OUT std_logic_vector (N - 1 DOWNTO 0));

END component;

component Sum13 is
port (A: in std_logic_vector(13 downto 0);
B: in std_logic_vector(13 downto 0);
F: out std_logic_vector (13 downto 0)
);
end component;

component Sub is
port (A: in std_logic_vector(7 downto 0);
B: in std_logic_vector(7 downto 0);
F: out std_logic_vector (7 downto 0)
);
end component;

component absu is
port (  
  entrada: in  std_logic_vector(7 downto 0);
  saida: out std_logic_vector(7 downto 0) 
);
end component;

begin 

pA1: registrador port map (ck, reset, cpa, A, pA);
pB1: registrador port map (ck, reset, cpB, B, pB);
sub1: sub port map (pA, pB, subi);
abs1: absu port map (subi, absi);
sum144: sum13 port map (soma,"000000" & absi, sum14);
mux144: mux2para114 port map (sum14, "00000000000000", zsoma, mux14);
soma1: registrador14 port map (ck, reset, csoma, mux14, soma);
SAD_REG: registrador14 port map (ck, reset, csad_reg, soma, saida);


mux77: mux2para1 port map (voltinha, "0000000", zi, mux7);
ii: registrador7 port map (ck, reset, ci, mux7, i);
soma7: sum port map (i, "0000001", voltinha);

menor <= i(6);
endereco <= i(5 downto 0);


end circuito;