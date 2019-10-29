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
LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
 
ENTITY MUX4_1_TB IS
END MUX4_1_TB;
 
ARCHITECTURE behavior OF MUX4_1_TB IS 

   --Inputs
   signal A : std_logic := '0';
   signal B : std_logic := '0';
   signal C : std_logic := '0';
   signal D : std_logic := '0';
   signal SEL : std_logic_vector(1 downto 0) := (others => '0');

 	--Outputs
   signal O : std_logic;
   -- No clocks detected in port list. Replace <clock> below with 
   -- appropriate port name 
  
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
	UUT: entity work.MUX4_1(Behavioral_V1) port map (  -- OR entity work.MUX4_1(Behavioral_V2)
    A   => A,
    B   => B,
    C   => C,
    D   => D,
    SEL => SEL,
    O   => O
  );

   -- Stimulus process
   stim_proc: process
   begin		
      -- hold reset state for 100 ns.
      wait for 100 ns;	
		
		SEL <= "00";
		A <= '0';
		B <= '0';
		C <= '0';
		D <= '0';	
		wait for 100 ns;
		
		SEL <= "00";
		A <= '1';
		B <= '0';
		C <= '0';
		D <= '0';	
		wait for 100 ns;
		
		SEL <= "00";
		A <= '0';
		B <= '1';
		C <= '1';
		D <= '1';	
		wait for 100 ns;
		
		--TESTING A FINISH--
		
		SEL <= "01";
		A <= '0';
		B <= '0';
		C <= '0';
		D <= '0';	
		wait for 100 ns;
		
		SEL <= "01";
		A <= '0';
		B <= '1';
		C <= '0';
		D <= '0';	
		wait for 100 ns;
		
		SEL <= "01";
		A <= '1';
		B <= '0';
		C <= '1';
		D <= '1';	
		wait for 100 ns;
		
		--TESTING B FINISH--
		
		SEL <= "10";
		A <= '0';
		B <= '0';
		C <= '0';
		D <= '0';	
		wait for 100 ns;
		
		SEL <= "10";
		A <= '0';
		B <= '0';
		C <= '1';
		D <= '0';	
		wait for 100 ns;
		
		SEL <= "10";
		A <= '1';
		B <= '1';
		C <= '0';
		D <= '1';	
		wait for 100 ns;
		
		--TESTING C FINISH--
		
		SEL <= "11";
		A <= '0';
		B <= '0';
		C <= '0';
		D <= '0';	
		wait for 100 ns;
		
		SEL <= "11";
		A <= '0';
		B <= '0';
		C <= '0';
		D <= '1';	
		wait for 100 ns;
		
		SEL <= "11";
		A <= '1';
		B <= '1';
		C <= '1';
		D <= '0';	
		wait for 100 ns;
		
		--TESTING D FINISH--

      wait;
   end process;

END;

