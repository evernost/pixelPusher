-- ============================================================================
-- Project        : pixelPusher
-- Module name    : vesa_pkg
-- File name      : vesa_pkg.vhd
-- File type      : VHDL 2008
-- Purpose        : package definition for the VESA controller
-- Author         : QuBi (nitrogenium@outlook.fr)
-- Creation date  : August 24th, 2025 at 14:04
-- ----------------------------------------------------------------------------
-- Best viewed with space indentation (2 spaces)
-- ============================================================================

-- ============================================================================
-- LIBRARIES
-- ============================================================================
-- Standard libraries
library IEEE;
use IEEE.STD_LOGIC_1164.all;
use IEEE.NUMERIC_STD.all;

-- Project libraries
-- None.



-- ============================================================================
-- PACKAGE DESCRIPTION
-- ============================================================================
package vesa_pkg is

  -- --------------------------------------------------------------------------
  -- Constants / Types
  -- --------------------------------------------------------------------------
  type DISPLAY_FORMAT is record
    pixel_clock_MHz : REAL;
    h_sync_time     : NATURAL range 1 to 8191;
    h_back_porch    : NATURAL range 1 to 8191;  -- in pixels
    h_left_border   : NATURAL range 0 to 8191;  -- in pixels
    h_addr_time     : NATURAL range 1 to 8191;  -- in pixels
    h_right_border  : NATURAL range 0 to 8191;
    h_front_porch   : NATURAL range 1 to 8191;
    v_sync_time     : NATURAL range 1 to 8191;
    v_back_porch    : NATURAL range 1 to 8191;
    v_top_border    : NATURAL range 0 to 8191;
    v_addr_time     : NATURAL range 1 to 8191;
    v_bottom_border : NATURAL range 0 to 8191;
    v_front_porch   : NATURAL range 1 to 8191;
  end record DISPLAY_FORMAT;

  -- Extracted from "VESA and Industry Standards and Guidelines for Computer Display Monitor Timing (DMT)"
  -- Version 1.0, Rev. 13 (2013)
  constant DF_640_480_60HZ : DISPLAY_FORMAT := (
    pixel_clock_MHz => 25.175,
    h_sync_time     => 96,      -- in pixel clock ticks
    h_back_porch    => 40,      -- in pixel clock ticks
    h_left_border   => 8,       -- in pixel clock ticks
    h_addr_time     => 640,     -- in pixel clock ticks
    h_right_border  => 8,       -- in pixel clock ticks
    h_front_porch   => 8,       -- in pixel clock ticks
    v_sync_time     => 2,       -- in H lines ticks
    v_back_porch    => 25,      -- in H lines ticks
    v_top_border    => 8,       -- in H lines ticks
    v_addr_time     => 480,     -- in H lines ticks
    v_bottom_border => 8,       -- in H lines ticks
    v_front_porch   => 2        -- in H lines ticks
  );

  constant DF_800_600_60HZ : DISPLAY_FORMAT := (
    pixel_clock_MHz => 40.000,
    h_sync_time     => 128,
    h_back_porch    => 88,
    h_left_border   => 0,
    h_addr_time     => 800,
    h_right_border  => 0,
    h_front_porch   => 40,
    v_sync_time     => 4,
    v_back_porch    => 23,
    v_top_border    => 0,
    v_addr_time     => 600,
    v_bottom_border => 0,
    v_front_porch   => 1
  );

  constant DF_1024_768_70HZ : DISPLAY_FORMAT := ( 
    pixel_clock_MHz => 75.000,
    h_sync_time     => 136,
    h_back_porch    => 144,
    h_left_border   => 0,
    h_addr_time     => 1024,
    h_right_border  => 0,
    h_front_porch   => 24,
    v_sync_time     => 6,
    v_back_porch    => 29,
    v_top_border    => 0,
    v_addr_time     => 768,
    v_bottom_border => 0,
    v_front_porch   => 3
  );


  type H_CTRL_STATE is (h_sync, h_back_porch, h_left_border, h_addr_time, h_right_border, h_front_porch);

  -- --------------------------------------------------------------------------
  -- Components
  -- --------------------------------------------------------------------------
  -- None.

end package vesa_pkg;



-- ============================================================================
-- PACKAGE DESCRIPTION
-- ============================================================================
package body vesa_pkg is 
  
  -- None.
  
end package body;
