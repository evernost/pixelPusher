:: ============================================================================
:: Project       : pixelPusher
:: Module name   : -
:: File name     : run.bat
:: File type     : Batch script for Windows
:: Purpose       : script for syntax check, compilation and simulation
:: Author        : QuBi (nitrogenium@outlook.fr)
:: Creation date : Monday, 25 August 2025
:: ----------------------------------------------------------------------------
:: Best viewed with space indentation (2 spaces)
:: ============================================================================

@echo off
setlocal



:: ============================================================================
:: SETTINGS
:: ============================================================================
for /f "usebackq tokens=1,2 delims==" %%A in ("..\..\xilinx_tools_path.ini") do (
  set %%A=%%B
)
echo [INFO] Reading Vivado 'bin' path from 'xilinx_tools_path.ini': '%VIVADO_BIN%'

set WCFG_FILE="probeSetup.wcfg"
set SRC_DIR=..\..\src


:: ============================================================================
:: SYNTAX CHECK AND COMPILE
:: ============================================================================
echo [INFO] Syntax check...
call %VIVADO_BIN%\xvhdl --work vesa_lib "%SRC_DIR%/vesa/vesa_pkg.vhd"
call %VIVADO_BIN%\xvhdl --work vesa_lib "%SRC_DIR%/vesa/vesa_core.vhd"
echo [DEBUG] 'xvhdl' command return code: %ERRORLEVEL%

call %VIVADO_BIN%\xvhdl --work work tb_blinky.vhd
echo [DEBUG] 'xvhdl' command return code: %ERRORLEVEL%


:: ============================================================================
:: TESTBENCH ELABORATION
:: ============================================================================
echo [INFO] Elaborating...
call %VIVADO_BIN%\xelab tb_blinky -L blinky_lib -generic_top "BLINK_FREQ_HZ=10.0" -s tb_sim -debug all



:: ============================================================================
:: RUN SIMULATION
:: ============================================================================
if "%~1"=="nogui" (
  echo [INFO] GUI is disabled. Running simulation silently...
  %VIVADO_BIN%\xsim tb_sim -runall
) else (
  echo [INFO] GUI mode
  
  if exist "%WCFG_FILE%" (
    %VIVADO_BIN%\xsim tb_sim --gui -view "%WCFG_FILE%"
  ) else (
    echo [WARNING] Wave file directive not found. Using defaults...
    %VIVADO_BIN%\xsim tb_sim --gui
  )
)

endlocal