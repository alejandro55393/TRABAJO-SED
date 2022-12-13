----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 08.12.2022 11:38:04
-- Design Name: 
-- Module Name: button - Behavioral
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

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity button is
PORT(
    clk, button, rst: IN std_logic;
    debounced : out std_logic
);

end button;

architecture Behavioral of button is
COMPONENT synchrnzr
    port(
        CLK : in std_logic;
        ASYNC_IN : in std_logic;
        SYNC_OUT: out std_logic 
    );
END COMPONENT;

COMPONENT edgedtctr
    port (
        CLK : in std_logic;
        SYNC_IN: in std_logic;
        EDGE: out std_logic
    );
END COMPONENT;

COMPONENT debouncer
    port (
        CLK: in std_logic;
        RST: in std_logic;
        OUT_BUTTON: in std_logic;
        OUT_BUTTON_DEBOUNCED: out std_logic
    );
END COMPONENT;

signal sincronizador: std_logic;
signal flanco: std_logic;
signal button_debounced: std_logic;

begin

Sync: synchrnzr PORT MAP (
    CLK => clk,
    ASYNC_IN => button,
    SYNC_OUT => sincronizador
);

Edge: edgedtctr PORT MAP (
    CLK => clk,
    SYNC_IN => sincronizador,
    EDGE => flanco
);

 Dbncr: debouncer PORT MAP (
    CLK => clk,
    RST => rst,
    OUT_BUTTON => flanco,
    OUT_BUTTON_DEBOUNCED => button_debounced
);
end Behavioral;
