-- Test bench for Counter Exercise

entity Counter_tb is
end;

library IEEE;
use IEEE.Std_logic_1164.all;
use STD.TEXTIO.all;
use IEEE.STD_LOGIC_TEXTIO.all;

architecture Part1 of Counter_tb is

  signal Clock, Reset, Enable, Load, UpDn: Std_logic;
  signal Data, Q: Std_logic_vector(7 downto 0);

  signal OK: Boolean := True;

begin

  uut: entity work.Counter
  port map (
    Clock  => Clock,
    Reset  => Reset,
    Enable => Enable,
    Load   => Load,
    UpDn   => UpDn,
    Data   => Data,
    Q      => Q
  );

  Clk: process
  begin
    while now <= 3000 NS loop
      Clock <= '0';
      wait for 5 NS;
      Clock <= '1';
      wait for 5 NS;
    end loop;
    wait;
  end process;

  Stim: process
  begin
    Enable <= '0';
    Load <= '0';
    UpDn <= '1';
    Reset <= '1';
    wait for 10 ns; -- Should be reset
    Reset <= '0';
    wait for 10 ns; -- Should do nothing - not enabled
    Enable <= '1';
    wait for 20 ns; -- Should count up to 2
    UpDn <= '0';
    wait for 40 ns; -- Should count downto 254
    UpDn <= '1';
    wait for 40 ns; -- Should count up to 2
    Reset <= '1';
    wait for 10 ns; -- Should be reset, overriding enable
    Reset <= '0';
    wait for 30 ns; -- Should count up to 3
    Enable <= '0';
    wait for 10 ns; -- Should do nothing - not enabled
    Data <= "01111111";
    Load <= '1';
    wait for 10 ns; -- Should do nothing - not enabled
    Load <= '0';
    Enable <= '1';
    wait for 10 ns; -- Should count from 3 to 4
    Load <= '1';
    wait for 10 ns; -- Should load 127
    Load <= '0';
    wait for 20 ns; -- Should count from 127 to 129
    Enable <= '0';
    wait for 10 ns; -- Should do nothing - not enabled
    UpDn <= '0';
    wait for 10 ns; -- Should do nothing - not enabled
    Enable <= '1';
    wait for 20 ns; -- Should count down from 129 to 127
    Data <= "11110000";
    Load <= '1';
    wait for 10 ns; -- Should load
    Reset <= '1';
    wait for 10 ns; -- Should be reset, overriding load
    Load <= '0';
    UpDn <= '1';
    wait for 10 ns; -- Should stay at 0 - still reset
    Reset <= '0';
    wait for 2560 ns; -- Should count from 0 round to 0
    Enable <= '0';
    wait;   
  end process;

  Check: process
  begin
    wait for 9 ns;
    if Q /= "00000000" then
      OK <= False;
    end if;
    wait for 10 ns;
    if Q /= "00000000"  then
      OK <= False;
    end if;
    wait for 10 ns;
    if Q /= "00000001" then
      OK <= False;
    end if;
    wait for 10 ns;
    if Q /= "00000010" then
      OK <= False;
    end if;
    wait for 10 ns;
    if Q /= "00000001" then
      OK <= False;
    end if;
    wait for 10 ns;
    if Q /= "00000000" then
      OK <= False;
    end if;
    wait for 10 ns;
    if Q /= "11111111" then
      OK <= False;
    end if;
    wait for 10 ns;
    if Q /= "11111110" then
      OK <= False;
    end if;
    wait for 10 ns;
    if Q /= "11111111" then
      OK <= False;
    end if;
    wait for 10 ns;
    if Q /= "00000000" then
      OK <= False;
    end if;
    wait for 10 ns;
    if Q /= "00000001" then
      OK <= False;
    end if;
    wait for 10 ns;
    if Q /= "00000010" then
      OK <= False;
    end if;
    wait for 10 ns;
    if Q /= "00000000" then
      OK <= False;
    end if;
    wait for 10 ns;
    if Q /= "00000001" then
      OK <= False;
    end if;
    wait for 10 ns;
    if Q /= "00000010" then
      OK <= False;
    end if;
    wait for 10 ns;
    if Q /= "00000011" then
      OK <= False;
    end if;
    wait for 10 ns;
    if Q /= "00000011" then
      OK <= False;
    end if;
    wait for 10 ns;
    if Q /= "00000011" then
      OK <= False;
    end if;
    wait for 10 ns;
    if Q /= "00000100" then
      OK <= False;
    end if;
    wait for 10 ns;
    if Q /= "01111111" then
      OK <= False;
    end if;
    wait for 10 ns;
    if Q /= "10000000" then
      OK <= False;
    end if;
    wait for 10 ns;
    if Q /= "10000001" then
      OK <= False;
    end if;
    wait for 10 ns;
    if Q /= "10000001" then
      OK <= False;
    end if;
    wait for 10 ns;
    if Q /= "10000001" then
      OK <= False;
    end if;
    wait for 10 ns;
    if Q /= "10000000" then
      OK <= False;
    end if;
    wait for 10 ns;
    if Q /= "01111111" then
      OK <= False;
    end if;
    wait for 10 ns;
    if Q /= "11110000" then
      OK <= False;
    end if;
    wait for 10 ns;
    if Q /= "00000000" then
      OK <= False;
    end if;
    wait for 10 ns;
    if Q /= "00000000" then
      OK <= False;
    end if;
    wait for 10 ns;
    if Q /= "00000001" then
      OK <= False;
    end if;
    wait for 10 ns;
    if Q /= "00000010" then
      OK <= False;
    end if;
    wait for 10 ns;
    if Q /= "00000011" then
      OK <= False;
    end if;
    wait for 10 ns;
    if Q /= "00000100" then
      OK <= False;
    end if;
    wait for 2500 ns;
    if Q /= "11111110" then
      OK <= False;
    end if;
    wait for 10 ns;
    if Q /= "11111111" then
      OK <= False;
    end if;
    wait for 10 ns;
    if Q /= "00000000" then
      OK <= False;
    end if;
    wait;   
  end process;
  
  process(clock)
	FILE test_file : TEXT open WRITE_MODE is "C:\Users\trainee\Desktop\test_pattern.txt";
	variable linebuf : LINE ;
  begin
	if rising_edge(clock) then
		write(linebuf,data);
		write(linebuf,Q);
		write(linebuf,Reset);
		write(linebuf,Enable);
		write(linebuf,Load);
		write(linebuf,UpDn);
		writeline(test_file,linebuf);
	end if;
  end process;

end architecture;

library IEEE;
use IEEE.Std_logic_1164.all;
use STD.TEXTIO.all;
use IEEE.STD_LOGIC_TEXTIO.all;

architecture Part2 of Counter_tb is

  signal Clock, Reset, Enable, Load, UpDn: Std_logic;
  signal Data, Q: Std_logic_vector(7 downto 0);
  signal OK: Boolean := True;
   
  
begin

  uut: entity work.Counter
  port map (
    Clock  => Clock,
    Reset  => Reset,
    Enable => Enable,
    Load   => Load,
    UpDn   => UpDn,
    Data   => Data,
    Q      => Q
  );

  Clk: process
  begin
    while now <= 3000 NS loop
      Clock <= '0';
      wait for 5 NS;
      Clock <= '1';
      wait for 5 NS;
    end loop;
    wait;
  end process;

  process(clock)
	FILE test_file : TEXT open READ_MODE is "C:\Users\trainee\Desktop\test_pattern.txt";
	variable linebuf : LINE ;
	variable file_q ,file_data : std_logic_vector(7 downto 0);
		variable file_reset ,file_enable, file_load, file_updn : std_logic;
  begin
	if falling_edge(clock) then
		READLINE(TEST_FILE,LINEBUF);
		read(linebuf,file_data);
		read(linebuf,file_q);
		read(linebuf,file_reset);
		read(linebuf,file_enable);
		read(linebuf,file_load);
		read(linebuf,file_updn);
		Data <= file_data;
		Reset <= file_reset;
		Enable <= file_enable;
		Load <= file_load;
		UpDn <= file_updn;
	end if;
	if rising_edge(clock) then
		if Q = file_q then
			OK <= TRUE;
		else 
			OK <= FALSE;
		end if;
	end if;
  end process;

end architecture;

configuration cfg_part1 of counter_tb is    -- 'cfg_part1' configures entity 'counter_tb' ...
  for part1                                 -- ... to use architecture 'part1'
  end for;
end configuration;

configuration cfg_part2 of counter_tb is    -- 'cfg_part2' configures entity 'counter_tb' ...
  for part2                                 -- ... to use architecture 'part2'
  end for;
end configuration;