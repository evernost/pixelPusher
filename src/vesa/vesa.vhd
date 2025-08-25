-- ============================================================================
-- Project        : pixelPusher
-- Module name    : vesa
-- File name      : vesa.vhd
-- File type      : VHDL 2008
-- Purpose        : VESA controller top level
-- Author         : QuBi (nitrogenium@outlook.fr)
-- Creation date  : August 25th, 2025
-- ----------------------------------------------------------------------------
-- Best viewed with space indentation (2 spaces)
-- ============================================================================

-- ============================================================================
-- DESCRIPTION
-- ============================================================================
-- Full description is TODO. Be patient.



-- ============================================================================
-- LIBRARIES
-- ============================================================================
-- Standard libraries
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

-- Project libraries
library vesa_lib; use vesa_lib.vesa_pkg.all;



-- ============================================================================
-- I/O DESCRIPTION
-- ============================================================================
entity vesa is
generic
(
  RESET_SYNC      : BOOLEAN;
  RESET_POL       : STD_LOGIC;
  PIXEL_DATA_BUS  : NATURAL range 1 to 31 := 8;
  H_ACTIVE_POL    : STD_LOGIC := '1';
  V_ACTIVE_POL    : STD_LOGIC := '1'
);
port
( 
  clock           : in STD_LOGIC;
  reset           : in STD_LOGIC; 
  
  pixel_addr_x    : out STD_LOGIC_VECTOR(12 downto 0);  -- x coordinate of the pixel about to be displayed
  pixel_addr_y    : out STD_LOGIC_VECTOR(12 downto 0);  -- y coordinate of the pixel about to be displayed
  pixel_fetch     : out STD_LOGIC;                      -- when '1': pixel data is fetched on the data bus
  pixel_prefetch  : out STD_LOGIC;                      -- same as 'pixel_fetch' but 1 clock cycle ahead
  pixel_data      : in STD_LOGIC_VECTOR(PIXEL_DATA_BUS-1 downto 0);

  display_hsync   : out STD_LOGIC;
  display_vsync   : out STD_LOGIC;
  display_data    : out STD_LOGIC_VECTOR(PIXEL_DATA_BUS-1 downto 0)
);
end vesa;



-- ============================================================================
-- ARCHITECTURE
-- ============================================================================
architecture archDefault of vesa is

  -- Screen settings selection
  constant DF : DISPLAY_FORMAT := DF_1024_768_70HZ;

begin


  -- --------------------------------------------------------------------------
  -- VESA core implementation
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



end archDefault;

