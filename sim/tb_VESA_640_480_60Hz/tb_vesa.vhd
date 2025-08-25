-- ============================================================================
-- Project        : synthChip
-- Module name    : tb_vesa
-- File name      : tb_vesa.vhd
-- File type      : VHDL 2008
-- Purpose        : testbench for the VESA IP
-- Author         : QuBi (nitrogenium@outlook.fr)
-- Creation date  : August 25th, 2025
-- ----------------------------------------------------------------------------
-- Best viewed with space indentation (2 spaces)
-- ============================================================================

-- ============================================================================
-- DESCRIPTION
-- ============================================================================
-- Test of the VESA core in the 640x480 / 60 Hz configuration.



-- ============================================================================
-- LIBRARIES
-- ============================================================================
-- Standard libraries
library IEEE;
use IEEE.STD_LOGIC_1164.all;
use IEEE.NUMERIC_STD.all;

-- Project libraries
library vesa_lib; use vesa_lib.vesa_pkg.all;



-- ============================================================================
-- I/O DESCRIPTION
-- ============================================================================
entity tb_blinky is
generic
(
  RESET_POL       : STD_LOGIC := '0';
  RESET_SYNC      : BOOLEAN := TRUE;
  CLOCK_FREQ_MHZ  : REAL := 100.0;
  BLINK_FREQ_HZ   : REAL := 10.0
);
end tb_blinky;



-- ============================================================================
-- ARCHITECTURE
-- ============================================================================
architecture archDefault of tb_blinky is

  signal clock  : STD_LOGIC := '0';
  signal reset  : STD_LOGIC := '0';

  signal blink  : STD_LOGIC;

  constant clock_period : TIME := 1 sec / (CLOCK_FREQ_MHZ * 1.0E6);

begin
  
  -- --------------------------------------------------------------------------
  -- DUT (VESA core)
  -- --------------------------------------------------------------------------
  vesa_core_0 : entity vesa_lib.vesa_core(archDefault)
  generic map
  (
    RESET_POL       => RESET_POL,
    RESET_SYNC      => RESET_SYNC,
    PIXEL_DATA_BUS  => PIXEL_DATA_BUS,
    H_ACTIVE_POL    => H_ACTIVE_POL,
    V_ACTIVE_POL    => V_ACTIVE_POL,
    H_SYNC_TIME     => DF.h_sync_time,
    H_BACK_PORCH    => DF.h_back_porch,
    H_LEFT_BORDER   => DF.h_left_border,
    H_ADDR_TIME     => DF.h_addr_time,
    H_RIGHT_BORDER  => DF.h_right_border,
    H_FRONT_PORCH   => DF.h_front_porch,
    V_SYNC_TIME     => DF.v_sync_time,
    V_BACK_PORCH    => DF.v_back_porch,
    V_TOP_BORDER    => DF.v_top_border,
    V_ADDR_TIME     => DF.v_addr_time,
    V_BOTTOM_BORDER => DF.v_bottom_border,
    V_FRONT_PORCH   => DF.v_front_porch,
    HV_DELAY        => 0
  )
  port map
  ( 
    clock           => clock,
    reset           => reset,
    
    pixel_addr_x    => pixel_addr_x,
    pixel_addr_y    => pixel_addr_y,
    pixel_fetch     => pixel_fetch,
    pixel_prefetch  => pixel_prefetch,
    pixel_data      => pixel_data,

    display_hsync   => display_hsync,
    display_vsync   => display_vsync,
    display_data    => display_data
  );



  -- Resets 
  reset <= RESET_POL, not(RESET_POL) after 111.0 ns;
  
  -- Clocks
  clock <= not(clock) after (clock_period/2);
  
end archDefault;
