----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 08.12.2022 11:27:37
-- Design Name: 
-- Module Name: top - Behavioral
-- Project Name: 
-- Target Devices: 
-- Tool Versions: 
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


entity top is
    port(
        RESET: in STD_LOGIC;
        CLK: in STD_LOGIC;
        BUTTON1 : in STD_LOGIC;
        BUTTON2 : in STD_LOGIC;
        START : in STD_LOGIC;
        BOMBA: out STD_LOGIC_VECTOR(0 TO 3)
    );
end top;

architecture Behavioral of top is

    COMPONENT button
        port (
            clk, button, rst: IN std_logic;
            debounced : out std_logic
        );
    end COMPONENT;

    COMPONENT TEMP
        generic(FRQ : integer;
                TIEMPO : integer);
        port (
            CLK     : in std_logic;
            SET    : in std_logic;
            OTP : out std_logic
        );
    end COMPONENT;

    COMPONENT fsm
        port(
            RESET: in STD_LOGIC;
            CLK: in STD_LOGIC;
            BUTTON1 : in STD_LOGIC;
            BUTTON2 : in STD_LOGIC;
            DONE1 : in STD_LOGIC;
            DONE2 : in STD_LOGIC;
            START : in STD_LOGIC;
            TIMER1 : out STD_LOGIC;
            TIMER2 : out STD_LOGIC;
            SALIDA: out STD_LOGIC_VECTOR(0 TO 3)
        );
    end COMPONENT;

    SIGNAL timer1_done, timer2_done, start_db, button1_db, button2_db : STD_LOGIC;
    SIGNAL set_timer1, set_timer2 : STD_LOGIC := '0';
BEGIN


    INST_button1: button PORT MAP(
            clk => CLK,
            button => BUTTON1,
            rst => RESET,
            debounced => button1_db
        );

    INST_button2: button PORT MAP(
            clk => CLK,
            button => BUTTON2,
            rst => RESET,
            debounced => button2_db
        );

    INST_start : button PORT MAP(
            clk => CLK,
            button => START,
            rst => RESET,
            debounced => start_db
        );

    INST_temp10: TEMP
        generic map(FRQ => 0, TIEMPO => 10)
        port map (
            CLK     => CLK,
            SET    => set_timer1,
            OTP => timer1_done
        );

    INST_temp20: TEMP
        generic map(FRQ => 0, TIEMPO => 20)
        port map (
            CLK     => CLK,
            SET    => set_timer2,
            OTP => timer2_done
        );

    INST_fsm: fsm PORT MAP(
            RESET => RESET,
            CLK => CLK,
            BUTTON1 => button1_db,
            BUTTON2 => button2_db,
            DONE1 => timer1_done,
            DONE2 => timer2_done,
            START => start_db,
            TIMER1 => set_timer1,
            TIMER2 => set_timer2,
            SALIDA => BOMBA
        );
end Behavioral;
