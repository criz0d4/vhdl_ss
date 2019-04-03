LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
use ieee.numeric_std.all;

ENTITY entrena IS
port( a,b,s,inst: in std_logic_vector(1 downto 0); --Patrones de entrenamiento / número de instrucción
		I_res:			out std_logic_vector(2 downto 0); --Monitor del resultado de I
		weight1, weight2: out std_logic_vector(1 downto 0) -- monitor de los pesos
	 );
END ENTITY entrena;

ARCHITECTURE neurona OF entrena is
signal I_signal: std_logic_vector(2 downto 0); 
signal w1: 	integer:=0; --pesos iniciales
signal w2:	integer:=0;
BEGIN

	PROCESS(a,b,s,inst)
		VARIABLE x1,x2,y: integer range -1 to 1;
--		VARIABLE w1,w2: 	integer:=0; --pesos iniciales
		VARIABLE I: 		integer;
		VARIABLE respuesta: integer range -1 to 1;
		VARIABLE beta: 	integer range -1 to 1;
		CONSTANT theta: 	integer:= 1;
		variable tope: 	integer;
	BEGIN
	tope := to_integer(unsigned(inst));
		
		x1 := to_integer(signed(a)); -- Convierte a(1 downto 0) en Entero
		x2 := to_integer(signed(b)); -- Convierte b(1 downto 0) en Entero
		y 	:= to_integer(signed(s)); -- Convierte s(1 downto 0) en Entero
		
		 I := w1*x1+w2*x2; --Ecuación general 
		 
		 I_signal <= std_logic_vector(to_signed(I,I_signal'length)); --Señal con el resultado de I, convertido de entero a vector
		 
		 IF I>= theta THEN --Calcula la respuesta del perceptron
				respuesta:=1;
		 ELSE
				respuesta:=-1;
		 END IF;

		 IF y = respuesta then
			beta:=1;
		 else
			beta:=-1;
		 end if;
		 
--		 IF y= respuesta THEN  --Si la respuesta es correcta
--				IF respuesta = 1 THEN
--					w1	:= w1+x1;
--					w2	:= w2+x2;
--				ELSE
--					w1	:= w1-x1;
--					w2	:= w2-x2;
--				END IF;
--				
--		 ELSE							--Si la respuesta es incorrecta
--				IF respuesta = 1 THEN
--					w1	:=	w1-x1;
--					w2	:=	w2-x2;
--				ELSE
--					W1	:=	w1+x1;
--					w2	:=	w2-x2;
--				END IF;	
--		 END IF;

		W1	<=	w1+(respuesta*beta*x1); -- Se ajusta el vector de ponderaciones 
		w2	<=	w2+(respuesta*beta*x2);

	--if (tope<=3) then
		I_res 	<= I_signal;	--monitorea el resultado de I
		weight1	<= std_logic_vector(to_unsigned(w1,2)); --Monitorea los pesos, convertidos de Entero a std_logic_vector 
		weight2	<= std_logic_vector(to_unsigned(w2,2));
		
	--end if;
	END PROCESS;
	END neurona;