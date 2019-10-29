----------------------------------------------------------------------------------
-- Company:        Educational Purpose
-- Engineer:       Kaan ARI
-- 
-- Create Date:    19:12:43 10/28/2019 
-- Design Name: 
-- Module Name:    MUX4_1 - Behavioral 
-- Project Name:   Educational Designs
-- Target Devices: 
-- Tool versions: 
-- Description: 
--
-- Dependencies: 
--
-- Revision: 
-- Revision 0.01 - File Created
-- Additional Comments: 
--
----------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity MUX4_1 is
    Port ( A : in  STD_LOGIC;
           B : in  STD_LOGIC;
           C : in  STD_LOGIC;
           D : in  STD_LOGIC;
           SEL : in  STD_LOGIC_VECTOR (1 downto 0);
           O : out  STD_LOGIC);
end MUX4_1;

architecture Behavioral_V1 of MUX4_1 is

	signal F1,F2,F3,F4 : Std_logic;
	
begin
	
	F1 <= A AND (NOT SEL(1) AND NOT SEL(0));
	F2 <= B AND (NOT SEL(1) AND SEL(0));
	F3 <= C AND (SEL(1) AND NOT SEL(0));
	F4 <= D AND (SEL(1) AND SEL(0));
	
	O <= F1 OR F2 OR F3 OR F4;


end architecture Behavioral_V1;

architecture Behavioral_V2 of MUX4_1 is

	signal F1,F2,F3,F4 : Std_logic;
	
begin
	
	process (SEL,A,B,C,D) is
	begin
	
	if SEL = "00" then
		O <= A;
	elsif SEL = "01" then
		O <= B;
	elsif SEL = "10" then
		O <= C;
	else
		O <= D;
	end if;
	
	
	end process;


end architecture Behavioral_V2;
