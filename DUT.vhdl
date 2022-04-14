-- A DUT entity is used to wrap your design.
--  This example shows how you can do this for the
--  ALU (using behavioural modelling)

library ieee;
use ieee.std_logic_1164.all;

entity DUT is
   port(input_vector: in std_logic_vector(33 downto 0);
       output_vector: out std_logic_vector(17 downto 0));
end entity;

architecture DutWrap of DUT is
	component alu_16 is
		generic(
			operand_width : integer:=16;
			control_bits : integer:=2
			);
		port (
			A: in std_logic_vector(operand_width-1 downto 0);
			B: in std_logic_vector(operand_width-1 downto 0);
			control_in: in std_logic_vector(control_bits-1 downto 0);
			C: out std_logic_vector(operand_width-1 downto 0);
		control_out: out std_logic_vector(control_bits-1 downto 0)
		) ;
	end component alu_16;
	

begin

   -- input/output vector element ordering is critical,
   -- and must match the ordering in the trace file!
   add_instance: alu_16
	      generic map (
					operand_width => 16,
					control_bits => 2)
	
			port map (
					-- order of inputs <S1 S0 A3 A2 A1 A0 B3 B2 B1 B0> 
					A(15 downto 0) => input_vector(33 downto 18),
					B(15 downto 0) => input_vector(17 downto 2),
					control_in(1 downto 0) => input_vector(1 downto 0),	

               -- order of outputs  <Y7 Y6 Y5 Y4 Y3 Y2 Y1 Y0>
					C(15 downto 0) => output_vector(17 downto 2),
					control_out(1 downto 0) => output_vector(1 downto 0));
end DutWrap;