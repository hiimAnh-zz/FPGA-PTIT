library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;


entity seg_7 is
	Port (
            segments  : out std_logic_vector(6 downto 0)
         );
end seg_7;

architecture Behavioral of seg_7 is
    --componet chia tan so
    component Chia_tan is
      Port (CLK_50MHz : in std_logic;
            CLK_1Hz : out std_logic;
            CLK_25Hz : out std_logic);
    end component;
    
    signal CLK_50M : std_logic :='0';
    signal CLK_1 : std_logic := '0';
    signal CLK_25 : std_logic := '0';
    
    ---------------------------------------
    subtype digit_type is integer range 0 to 9;
    type digits_type is array (1 downto 0) of digit_type;
    signal digit : digit_type;
    signal digits : digits_type;
    ------------------------------------------
    signal value : integer range 0 to 99;

begin
    
    chia_tan_0: Chia_tan
    Port map(CLK_50MHz => CLK_50M,
             CLK_1Hz => CLK_1,
             CLK_25Hz => CLK_25);
             
    ------------Chon led hien thi--------------------
     process(CLK_25)
     begin
        if rising_edge(CLK_25) then
            digit <= digits(0);
        else 
            digit <= digits(1);
        end if; 
    end process;
    ------------counter------------------------------

    COUNTER: process(CLK_1)--su dung clock tan so 200MHz de dem 1s
        begin
            if rising_edge(CLK_1) then
                if value = 99 then -- dem het 1s thi reset lai bo dem
                    value <= 0;
                elsif value < 99 then
                    value <= value + 1;                             
                end if;
            end if;
        end process;
    ----------------------------------------    
    digits(1) <= value / 10;
    digits(0) <= value - ((value / 10) * 10); 
    --------------encoder process------------------------
    ENCODER : process(digit)
    begin
        case digit is
           when 0 => segments <= "0111111"; --0
           when 1 => segments <= "0000110"; --1
           when 2 => segments <= "1011011"; --2
           when 3 => segments <= "1001111"; --3
           when 4 => segments <= "1100110"; --4
           when 5 => segments <= "1101101"; --5
           when 6 => segments <= "1111101"; --6
           when 7 => segments <= "0000111"; --7
           when 8 => segments <= "1111111"; --8
           when 9 => segments <= "1101111"; --9
        end case;
    end process;
end Behavioral;
