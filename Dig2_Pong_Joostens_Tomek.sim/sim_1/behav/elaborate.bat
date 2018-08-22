@echo off
set xv_path=C:\\Xilinx\\Vivado\\2016.4\\bin
call %xv_path%/xelab  -wto 6fea30771a9f4566a2268dfa931b383e -m64 --debug typical --relax --mt 2 -L xil_defaultlib -L secureip -L xpm --snapshot count10_TB_behav xil_defaultlib.count10_TB -log elaborate.log
if "%errorlevel%"=="0" goto SUCCESS
if "%errorlevel%"=="1" goto END
:END
exit 1
:SUCCESS
exit 0
