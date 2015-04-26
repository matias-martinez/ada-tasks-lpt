with Ada.Text_IO; use Ada.Text_IO;
with Interfaces.C;use Interfaces;
with IO_ParPort_Linux; use IO_ParPort_Linux;
with System.Machine_Code;use System.Machine_Code;


package body EMA_Tasks is
    
	task body TControl is
		ValorEntrada: Unsigned_8:=1;		
		begin
			loop
			
			    accept Controlar(Estado: out Boolean) do
			     					
					Estado:=TRUE;
					ValorEntrada:=Inb(16#0379#)xor(16#87#);
					if ValorEntrada > 0 then
					    Put_Line("Estacion ONLINE");
					else 
						Put_Line("Estacion OFFLINE");
					end if;
					delay (2.0);
				end Controlar;
			
			end loop;
		end TControl;

	task body TLectura is		
		ValorEntrada: Unsigned_8:=0;		
		begin 
			ValorEntrada:=Inb(16#0379#)xor(16#87#);
			
			loop
				select
					accept Informar(Temp: out Integer; Humedad: out Integer) do
						Temp:=Integer(ValorEntrada)/5;
						Humedad:=Integer(ValorEntrada)*2 ;
					end Informar;
				or  
				    delay(1.0);
					ValorEntrada:=Inb(16#0379#)xor(16#87#);		
						
				end select;
			end loop;
		end TLectura;

	task body TEscritura is
		begin 
			loop
			
				accept Escribir(Temp: in Integer) do
					Outb(Unsigned_8(Temp), 16#0378#);
				end Escribir;
			 
		 	end loop;		
		end TEscritura;

end EMA_Tasks;
	
