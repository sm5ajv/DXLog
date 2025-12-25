; DXLogDualKeyboard.ahk
; By: SM5AJV / SE5E
; Date: 2025-12-25
; Description: 
;     This utility is for SO2R and dual keyboards when running DXLOG on a remote desktop. 
;     When running a remote desktop it is very hard or impossible to tunnel two separate
;     USB devices. Instead this script mimics up- and down-arrow from each keyboard. 
;     In order to get this working you need to install both AHI and AHK, see details below.
;     NB! Do not enable two keyboards in DXLOG.
; Notes:  1. Follow the instructions from https://github.com/evilC/AutoHotInterception
;         2. Install AHI in C:\AHI directory
;	        3. Install AHK - AutoHotKey
;         4. Use AHI Monitor.ahk to determine VID/PID for your connected keyboards.
;            Enter VID/PID into the GetKeyboadId function below
;         5. Run script by double click on the filename
;         6. Disable/Enable script by the Scroll Lock key on the keyboard
;         


#SingleInstance forces
#Persistent
#include Lib\AutoHotInterception.ahk
global keyboard := 1   ; Start with keyboard 1
global modifier := -1  

; --- Set up keyboards. Use AHI Monitor.ahk to determine VID/PID
global AHI, keyboardId1, keyboardId2
AHI := new AutoHotInterception()
keyboardId1 := AHI.GetKeyboardId(0x25A7, 0xFA23, 2) ; DELL 1
keyboardId2 := AHI.GetKeyboardId(0x25A7, 0xFA23, 1) ; DELL 2
;keyboardId2 := AHI.GetKeyboardId(0x0040, 0x073D, 1)
AHI.SubscribeKeyboard(keyboardId1, true, Func("KeyEvent1"), true)
AHI.SubscribeKeyboard(keyboardId2, true, Func("KeyEvent2"), true)
SplashTextOn,300,50,DXLogDualKeyboard.ahk, DXLog Dual Keyboard Script activated. nExit with Scroll Lock key!
Sleep, 4000
SplashTextOff
return

KeyEvent1(code, state){
    setModifier(code, state) ; FIX ME this is not fully working 
    ; ToolTip % "setModifier() : " modifier " code: " code
    if (state == 1) {
        if (code == 70) {
            quitMessage()
        }
        if (code==42) {
            modifier := 42
        }
        if (code==29) {
            modifier := 29
        }
        if (code==56) {
            modifier := 56
        }
        if (code==285) {
            modifier := 285
        }
        if (code==312) {
            modifier := 312
        }
        if (code==347) {
            modifier := 347
        }
	
       ;ToolTip % "Keyboard Key - Code: " code ", State: " state " Modifier: " modifier
        if (keyboard != 1) {
            Send {Up}
            keyboard := 1
        }
        sendKey(code)
    }
}

KeyEvent2(code, state){
    setModifier(code, state)
    if (state == 1) {
            if (code == 70) {
                quitMessage()
            }
        if (code==42) {
            modifier := 42
        }
        if (code==29) {
            modifier := 29
        }
        if (code==56) {
            modifier := 56
        }
        if (code==285) {
            modifier := 285
        }
        if (code==312) {
            modifier := 312
        }
            if (code==347) {
            modifier := 347
        }
        
        ;ToolTip % "Keyboard Key - Code: " code ", State: " state " Modifier: " modifier
        if (keyboard != 2) {
            Send {Down}
            keyboard := 2
        }
        sendKey(code)
    }
}

ScrollLock::
    quitMessage()

^Esc::
    ExitApp
    
sendKey(code) 
{
    mykey := Format("sc{:03x}", code)
    sleep, 30
    if (modifier == 42) {
        Send {Shift down}{%mykey%}{Shift up}
    }
    else if (modifier == 29) {
        Send {Ctrl down}{%mykey%}{Ctrl up}
    }
    else if (modifier == 56) {
        Send {Alt down}{%mykey%}{Alt up}
    }
    else if (modifier == 285) {
        Send {Ctrl down}{%mykey%}{Ctrl up}
    }
    else if (modifier == 312) {
        Send {RAlt down}{%mykey%}{RAlt up}
    }
    else if (modifier == 347) {
        Send {Lwin down}{%mykey%}{Lwin up}
    }
    else {
        Send {%mykey%}
    }
}

quitMessage()
{
    MsgBox, 4,, Do you want to EXIT the DXLOG Dual keyboard utility? (press Yes or No)
    IfMsgBox Yes
    {   
        ExitApp
    }
    else
    {   
        MsgBox OK the script will continue.
    }
	
}

setModifier(code, state)
{
    if (code == 42 || code == 29 || code == 56 || code ==285 || code == 312) {
        if (state == 1)
            modifier := code
        else
            modifier := -1
    }
}
