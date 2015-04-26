with Interfaces.C;use Interfaces;
with IO_ParPort_Linux; use IO_ParPort_Linux;
with System.Machine_Code;use System.Machine_Code;
with Ada.Text_Io; use Ada.Text_Io;
with EMA_Tasks; use EMA_Tasks;
with Ada.Integer_Text_IO;  use Ada.Integer_Text_IO;



procedure Ema is   

-- Importacion de funcion ioperm() de C.   
	function Ioperm(From : in C.Unsigned_Long;
                   Num : in C.Unsigned_Long;
                   Tuen_On : in C.Int) return C.Int;
    	pragma Import(C, Ioperm, "ioperm");

--Declaracion de variables
    DATOS     : constant Unsigned_16 := 16#0378#;
    ESTADO    : constant Unsigned_16 := 16#0379#;
    temp,humedad: Integer;
    op        : Integer;
    errno     : C.Int:=Ioperm(C.Unsigned_Long(DATOS), 3, 1);
    aux       : Boolean:=FALSE;

-- Declaracion de tareas
    T1: TControl;
    T2: TLectura;
    T3: TEscritura;

begin
    loop
	put_line("");
	put_line("Ingresar Opcion");
	put_line("1 - Comprobar Estado de la Estacion");
	put_line("2 - Solicitar Temperatura y Humedad y Escribir Temp en Puerto de DATOS");
	put_line("3 - Salir");
	put("Opcion : ");
	get(op);
	put_line("");
	if op = 1 then 
		T1.Controlar(aux);
	elsif op = 2 then
		T2.Informar(temp,humedad);
		put_line("TEMPERATURA : "& integer'image(temp) &" °C");
		put_line("HUMEDAD     : "& integer'image(humedad) &" %");
        	T3.Escribir(temp);
        end if;

     exit when op=3;
     end loop;
     abort T1;
     abort T2;
     abort T3;
     errno := Ioperm(C.Unsigned_Long(DATOS), 3, 0);

end Ema;

