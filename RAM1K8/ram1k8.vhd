-- solution to ex09

library IEEE;
use IEEE.STD_LOGIC_1164.all;
use IEEE.Numeric_Std.all;

entity ram1k8 is
  port (
    clock   : in  std_logic;
    we      : in  std_logic;
    address : in  std_logic_vector(9 downto 0);
    datain  : in  std_logic_vector(7 downto 0);
    dataout : out std_logic_vector(7 downto 0)
  );
end entity ram1k8;

architecture RTL of ram1k8 is

   type ram_type is array (0 to 1023) of std_logic_vector(7 downto 0);
   signal ram : ram_type;

begin

  RamProc: process(clock) is

  begin
    if rising_edge(clock) then
      if we = '1' then
        ram(to_integer(unsigned(address))) <= datain;
      end if;
       dataout <= ram(to_integer(unsigned(address)));   
    end if;
  end process RamProc;


end architecture RTL;

architecture actel of ram1k8 is

  component block_ram is 
    port(WD    : in  std_logic_vector(7 downto 0);
         RD    : out std_logic_vector(7 downto 0);
         WEN   : in  std_logic; 
         REN   : in  std_logic; 
         WADDR : in  std_logic_vector(9 downto 0);
         RADDR : in  std_logic_vector(9 downto 0);
         RWCLK : in  std_logic) ;
  end component block_ram; 
 
  signal we_b : std_logic;

begin

  we_b <= not we; 
  
  UUT: block_ram
  port map (
    WD    => datain,
    RD    => dataout,
    WEN   => we_b,
    REN   => we,
    WADDR => address,
    RADDR => address,
    RWCLK => clock
  );

end architecture actel;

architecture altera of ram1k8 is
  component ram1k8mega
    PORT
    (
      address   : IN STD_LOGIC_VECTOR (9 DOWNTO 0);
      clock   : IN STD_LOGIC ;
      data    : IN STD_LOGIC_VECTOR (7 DOWNTO 0);
      wren    : IN STD_LOGIC ;
      q   : OUT STD_LOGIC_VECTOR (7 DOWNTO 0)
    );
  end component;

begin

  ram1k8mega_inst : ram1k8mega PORT MAP (
      address  => address,
      clock  => clock,
      data   => datain,
      wren   => we,
      q  => dataout
    );


end architecture altera;

architecture lattice of ram1k8 is

  component block_ram is 
    port(Clock    : in std_logic;
         ClockEn  : in std_logic;
         Reset    : in std_logic;
         WE       : in std_logic;
         Address  : in std_logic_vector(9 downto 0);
         Data     : in std_logic_vector(7 downto 0);
         Q        : out std_logic_vector(7 downto 0)
        );
  end component block_ram; 
 
begin

  UUT: block_ram
    port map (
      Clock   => clock,
      ClockEn => '1',
      Reset   => '0',
      WE      => we,
      Address => address,
      Data    => datain,
      Q       => dataout
    );

end architecture lattice;

architecture xilinx of ram1k8 is

  component ram1k8cgen
    port (
    clka: IN std_logic;
    dina: IN std_logic_VECTOR(7 downto 0);
    addra: IN std_logic_VECTOR(9 downto 0);
    wea: IN std_logic_VECTOR(0 downto 0);
    douta: OUT std_logic_VECTOR(7 downto 0));
  end component;

begin

 ram1k8cgen_inst : ram1k8cgen
  port map (
    clka => clock,
    dina => datain,
    addra => address,
    wea(0) => we,
    douta => dataout);


end architecture xilinx;
