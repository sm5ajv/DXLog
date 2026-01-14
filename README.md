# DualKeyboard
This utility is for SO2R (Single Op Two Radios) and dual keyboards when running DXLOG on a remote desktop. 
   
    
When running a remote desktop it is very hard or impossible to tunnel two separate
USB devices. Instead this script mimics up- and down-arrow from each keyboard. 
In order to get this working you need to install both AHI and AHK, see details below.
NB! Do not enable two keyboards in DXLOG.

    
Notes:  
1. Follow the instructions from https://github.com/evilC/AutoHotInterception
2. Install AHI in C:\AHI directory
3. Install AHK - AutoHotKey
4. Use AHI Monitor.ahk to determine VID/PID for your connected keyboards.
   Enter VID/PID into the `GetKeyboadId` function 
5. Run script by double click on the filename
6. Disable/Enable script by the Scroll Lock key on the keyboard
