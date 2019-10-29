-- Solution to ALU Exercise

library IEEE;
use IEEE.Std_logic_1164.all;
use IEEE.Numeric_std.all;

entity ALU is
  port (A, B : in  std_logic_vector(7 downto 0);
        Op   : in  std_logic_vector(3 downto 0);
        F    : out std_logic_vector(7 downto 0);
        Cout : out Std_logic;
        Equal: out Std_logic);
end;

-- TWO ALTERNATIVE SOLUTIONS ARE GIVEN BELOW...

architecture A1 of ALU is

  -- Simple solution...
  -- Easy to read, but relies on resource sharing

  signal Tmp: Signed(8 downto 0);
  signal A9, B9: Signed(8 downto 0);

begin

  A9 <= Resize(signed(A), 9);
  B9 <= Resize(signed(B), 9);

  process (A, A9, B9, Op)
  begin
    case Op is
    when "0000" =>
      -- AplusB
      Tmp <= A9 + B9;
    when "0001" =>
      -- AminusB
      Tmp <= A9 - B9;
    when "0010" =>
      -- BminusA
      Tmp <= B9 - A9;
    when "0100" =>
      -- OnlyA
      Tmp <= A9;
    when "0101" =>
      -- OnlyB
      Tmp <= B9;
    when "0110" =>
      -- minusA
      Tmp <= -A9;
    when "0111" =>
      -- minusB
      Tmp <= -B9;
    when "1000" =>
      -- ShiftleftA
      Tmp <= signed(A) & '0';
    when "1001" =>
      -- ShiftrightA
      Tmp <= "00" & signed(A(7 downto 1));
    when "1010" =>
      -- RotateleftA
      Tmp <= signed(A) & A(7);
    when "1011" =>
      -- RotaterightA
      Tmp <= '0'& A(0) & signed(A(7 downto 1));
    when "1110" =>
      -- AllZeros
      Tmp <= (others => '0');
    when "1111" =>
      -- AllOnes
      Tmp <= (others => '1');
    when others =>
      -- Dummy3
      -- Dummy12
      -- Dummy13
      Tmp <= (others => '-');
    end case;
  end process;

  Equal <= '1' when (A = B) else '0';
  Cout <= Tmp(8);

  F <= std_logic_vector(Tmp(7 downto 0));

end;


architecture A2 of ALU is
  -- Optimal solution, using just one adder...

  signal L, R: Signed(8 downto 0);
  signal Sum: Signed(9 downto 0);
  signal Cin: Std_logic;

  signal A8: Signed(7 downto 0);
  signal A9, B9: Signed(8 downto 0);

begin

  A8 <= signed(A);
  A9 <= Resize(signed(A), 9);
  B9 <= Resize(signed(B), 9);

  process (A8, A9, B9, Op)
  begin
    case Op is
    when "0000" =>
      -- AplusB
      L   <= A9;
      R   <= B9;
      Cin <= '0';
    when "0001" =>
      -- AminusB
      L   <= A9;
      R   <= not B9;
      Cin <= '1';
    when "0010" =>
      -- BminusA
      L   <= not A9;
      R   <= B9;
      Cin <= '1';
    when "0100" =>
      -- OnlyA
      L   <= A9;
      R   <= (others => '0');
      Cin <= '0';
    when "0101" =>
      -- OnlyB
      L   <= (others => '0');
      R   <= B9;
      Cin <= '0';
    when "0110" =>
      -- minusA
      L   <= not A9;
      R   <= (others => '0');
      Cin <= '1';
    when "0111" =>
      -- minusB
      L   <= (others => '0');
      R   <= not B9;
      Cin <= '1';
    when "1000" =>
      -- ShiftleftA
      L   <= A8 & '0';
      R   <= (others => '0');
      Cin <= '0';
    when "1001" =>
      -- ShiftrightA
      L   <= "00" & A8(7 downto 1);
      R   <= (others => '0');
      Cin <= '0';
    when "1010" =>
      -- RotateleftA
      L   <= A8 & A8(7);
      R   <= (others => '0');
      Cin <= '0';
    when "1011" =>
      -- RotaterightA
      L   <= '0' & A8(0) & A8(7 downto 1);
      R   <= (others => '0');
      Cin <= '0';
    when "1110" =>
      -- AllZeros
      L   <= (others => '0');
      R   <= (others => '0');
      Cin <= '0';
    when "1111" =>
      -- AllOnes
      L   <= (others => '1');
      R   <= (others => '0');
      Cin <= '0';
    when others =>
      -- Dummy3
      -- Dummy12
      -- Dummy13
      L   <= (others => '-');
      R   <= (others => '-');
      Cin <= '-';
    end case;
  end process;

  Sum <= (L & '1') + (R & Cin);

  Equal <= '1' when (A = B) else '0';
--  Try introducing Equal errors with this line
--  Equal <= '0' when (A = B) else '1';

  Cout <= Sum(9);
--  Try introducing Cout errors with this line
--  Cout <= not Sum(9);

  F <= std_logic_vector(Sum(8 downto 1));
--  Try introducing Cout errors with this line
--  F <= std_logic_vector(Sum(8 downto 1) srl 1);

end;

