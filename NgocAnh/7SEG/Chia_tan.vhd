library IEEE;
use IEEE.STD_LOGIC_1164.ALL;


entity Chia_tan is
  Port (CLK_50MHz : in std_logic; --Tan so thach anh 50Mhz
        CLK_1Hz : out std_logic;  --Tan so LED dem 1s
        CLK_25Hz : out std_logic);--Tan so quet LED
end Chia_tan;

architecture Behavioral of Chia_tan is

    signal cnt_1hz : integer := 0; --Bi?n ??m chia t?n s? 1hz
    signal cnt_25hz : integer := 0;
    signal CLK_1Hz_local : std_logic := '0';
    signal CLK_25Hz_local : std_logic := '0';
    
begin

    CNT_1Hz_control: process(CLK_50Mhz)
    begin
        if rising_edge(CLK_50MHz) then
            if  cnt_1hz = 49 then -- thuc te 5_999_999
                cnt_1hz <= 0;
                CLK_1Hz_local <= not CLK_1Hz_local; 
            else
                cnt_1hz <= cnt_1hz +1;
            end if;
        end if;
    end process;     
    CLK_1Hz <= CLK_1Hz_local;
    
    ---process Chia tan 25Hz
    CNT_25Hz_control: process(CLK_50Mhz)
    begin
        if rising_edge(CLK_50MHz) then
            if  cnt_25hz = 19 then  ----- thuc te : 1_999_999
                cnt_25hz <= 0;
                CLK_25Hz_local <= not CLK_25Hz_local; 
            else
                cnt_25hz <= cnt_25hz +1;
            end if;
        end if;
    end process;     
    CLK_25Hz <= CLK_25Hz_local;

end Behavioral;
