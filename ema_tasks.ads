package EMA_Tasks is
	
	task type TControl is -- Cada 5 segundos hace un chequeo de estado y lo escribe.
		 entry Controlar(Estado: out Boolean);
	end TControl;

	task type TLectura is
		entry Informar(Temp:out Integer; Humedad: out Integer);
	end TLectura;

	task type TEscritura is 
		entry Escribir(Temp: in Integer);
	end TEscritura;

end EMA_Tasks;	
