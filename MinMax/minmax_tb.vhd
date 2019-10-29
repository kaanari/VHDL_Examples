----------- Test bench Solution for Minmax Exercise -------------

library IEEE;
use IEEE.STD_LOGIC_1164.all;

entity MinMax_TB is
end;

architecture TB1 of MinMax_TB is
  signal Min0Max1      : STD_LOGIC;
  signal X, Y          : STD_LOGIC_VECTOR (3 downto 0);
  signal Expected_Z, Z : STD_LOGIC_VECTOR (3 downto 0);
  signal OK            : Boolean;
begin

  uut: entity work.MinMax
  port map (
    Min0Max1 => Min0Max1,
    X        => X,
    Y        => Y,
    Z        => Z
  );

  process
  begin
    Min0Max1<='0';X<="0000";Y<="0000";Expected_Z<="0000";wait for 10 ns;
    Min0Max1<='1';X<="0000";Y<="0000";Expected_Z<="0000";wait for 10 ns;
    Min0Max1<='1';X<="0001";Y<="0000";Expected_Z<="0001";wait for 10 ns;
    Min0Max1<='0';X<="0001";Y<="0000";Expected_Z<="0000";wait for 10 ns;
    Min0Max1<='0';X<="0001";Y<="0010";Expected_Z<="0001";wait for 10 ns;
    Min0Max1<='1';X<="0001";Y<="0010";Expected_Z<="0010";wait for 10 ns;
    Min0Max1<='1';X<="0101";Y<="0010";Expected_Z<="0101";wait for 10 ns;
    Min0Max1<='0';X<="0101";Y<="0010";Expected_Z<="0010";wait for 10 ns;
    Min0Max1<='0';X<="0101";Y<="1010";Expected_Z<="0101";wait for 10 ns;
    Min0Max1<='1';X<="0101";Y<="1010";Expected_Z<="1010";wait for 10 ns;
    wait;
  end process;

  OK <= true when Z = Expected_Z else false;

end;
