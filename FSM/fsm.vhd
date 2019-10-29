-- Template for Finite State Machine Exercise

library IEEE;
use IEEE.STD_LOGIC_1164.all;

entity FSM is
  port (Crystal, nSysReset: in STD_LOGIC;
        Buttons: in STD_LOGIC_VECTOR(1 to 2);
        WatchRunning, WatchReset: out STD_LOGIC);
end;

architecture RTL of FSM is

	type TypeState is (zero, start, running, stop, stopped, reset);
	signal State : TypeState;

begin
	process(Crystal, nSysReset, Buttons)
	begin
		if nSysReset = '0' then
			state <= zero;	
			WatchRunning <= '0';
			WatchReset <= '0';				
		else
			if rising_edge(crystal) then 
				case State is
					when zero =>
						if Buttons(1) = '1' then
							state <= start;
							WatchRunning <= '1';
							WatchReset <= '0';	
						else 
							state <= zero;
							WatchRunning <= '0';
							WatchReset <= '0';	
						end if;
					when start =>
						if Buttons = "00" then
							state <= running;
							WatchRunning <= '1';
							WatchReset <= '0';	
						else 
							state <= start;
							WatchRunning <= '1';
							WatchReset <= '0';	
						end if;
					when running =>
						if Buttons(1) = '1' then
							state <= stop;
							WatchRunning <= '0';
							WatchReset <= '0';	
						else 
							state <= running;
							WatchRunning <= '1';
							WatchReset <= '0';							
						end if;
					when stop =>
						if Buttons = "00" then
							state <= stopped;
							WatchRunning <= '0';
							WatchReset <= '0';	
						else 
							state <= stop;
							WatchRunning <= '0';
							WatchReset <= '0';	
						end if;
					when stopped =>
						if Buttons(1) = '1' then
							state <= start;
							WatchRunning <= '1';
							WatchReset <= '0';	
						elsif Buttons = "01" then
							state <= reset;
							WatchRunning <= '0';
							WatchReset <= '1';	
						else
							state <= stopped;
							WatchRunning <= '0';
							WatchReset <= '0';	
						end if;
					when reset =>
						if Buttons = "00" then
							state <= zero;
							WatchRunning <= '0';
							WatchReset <= '0';	
						else 
							state <= reset;
							WatchRunning <= '0';
							WatchReset <= '1';	
						end if;
					when others =>
						state <= zero;
						WatchRunning <= '0';
						WatchReset <= '0';	
				end case; 
			end if;
		end if;
	end process;
end;

