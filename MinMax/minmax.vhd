-- Solution to MinMax Exercise

library IEEE;
use IEEE.STD_LOGIC_1164.all;

entity MinMax is
  port (Min0Max1: in  STD_LOGIC;
        X, Y    : in  STD_LOGIC_VECTOR (3 downto 0);
        Z       : out STD_LOGIC_VECTOR (3 downto 0));
end;


architecture RTL1 of MinMax is
begin
  process (Min0Max1, X, Y)
  begin
    if Min0Max1 = '0' then
      if X < Y then
        Z <= X;
      else
        Z <= Y;
      end if;
    else
      if X > Y then
        Z <= X;
      else
        Z <= Y;
      end if;
    end if;
  end process;
end;


architecture RTL2 of MinMax is
begin
  process (Min0Max1, X, Y)
  begin
    if Min0Max1 = '0' then
      if X > Y then
        Z <= Y;
      else
        Z <= X;
      end if;
    else
      if X > Y then
        Z <= X;
      else
        Z <= Y;
      end if;
    end if;
  end process;
end;


architecture RTL3 of MinMax is
  signal XGTY: BOOLEAN;
begin
  XGTY <= X > Y;
  process (Min0Max1, XGTY, X, Y)
  begin
    if Min0Max1 = '0' then
      if XGTY then
        Z <= Y;
      else
        Z <= X;
      end if;
    else
      if XGTY then
        Z <= X;
      else
        Z <= Y;
      end if;
    end if;
  end process;
end;


architecture RTL4 of MinMax is
begin
  process (Min0Max1, X, Y)
  begin
    if X > Y then
      if Min0Max1 = '0' then
        Z <= Y;
      else
        Z <= X;
      end if;
    else
      if Min0Max1 = '0' then
        Z <= X;
      else
        Z <= Y;
      end if;
    end if;
  end process;
end;


architecture RTL5 of MinMax is
begin
  process (Min0Max1, X, Y)
  begin
    case X > Y is
    when TRUE =>

      case Min0Max1 is
      when '0' =>
        Z <= Y;
      when others =>
        Z <= X;
      end case;

    when FALSE =>

      case Min0Max1 is
      when '0' =>
        Z <= X;
      when others =>
        Z <= Y;
      end case;

    end case;
  end process;
end;


-- If you have time...

architecture RTL6 of MinMax is
  signal XgtY: STD_LOGIC;
begin
  Comp: process (X, Y)
  begin
    if X > Y then
      XgtY <= '1';
    else
      XgtY <= '0';
    end if;
  end process;

  Mux: process (XgtY, Min0Max1, X, Y)
  begin
    if (Min0Max1 = '0' and XgtY = '0') or
       (Min0Max1 = '1' and XgtY = '1') then
      Z <= X;
    else
      Z <= Y;
    end if;
  end process;
end;
