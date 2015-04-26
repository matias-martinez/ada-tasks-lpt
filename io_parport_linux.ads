with Interfaces.C;use Interfaces;

package IO_ParPort_Linux is

----------------------------------------------------------------
	function Inb (Port : in Unsigned_16) return Unsigned_8;
-----------------------------------------------------------------
	procedure Outb (Val : in Unsigned_8; Port : in Unsigned_16);
----------------------------------------------------------------
end IO_ParPort_Linux;
