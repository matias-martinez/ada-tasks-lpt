with Interfaces.C;use Interfaces;
with System.Machine_Code;use System.Machine_Code;

package body IO_ParPort_Linux is

----------------------------------------------------------------
function Inb (Port : in Unsigned_16) return Unsigned_8 is
      Tmp : Unsigned_8;
   begin
      Asm ("inb %%dx, %0",
           Unsigned_8'Asm_Output ("=a", Tmp),
           Unsigned_16'Asm_Input  ("d",  Port),
           "",
           True);
      return Tmp;
   end Inb;
   pragma Inline (Inb);
-----------------------------------------------------------------
procedure Outb (Val : in Unsigned_8; Port : in Unsigned_16) is
    begin 
	Asm ("outb %0, %%dx",
	     No_Output_Operands,
	     (Unsigned_8'Asm_Input ("a", Val),
	     Unsigned_16'Asm_Input ("d", Port)),
	     "", True);
    end Outb;
    pragma Inline (Outb);
----------------------------------------------------------------
end IO_ParPort_Linux;
