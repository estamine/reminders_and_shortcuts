;Startup
#Persistent
#SingleInstance
#Include, GDIplusWrapper.ahk
#NoTrayIcon
SetWinDelay, 10
Coordmode, ToolTip, Screen
Coordmode, Mouse, Screen
Coordmode, Pixel, Screen
SetWorkingDir %A_ScriptDir%


; Higher numbers mean less sensitivity
; esmb_Threshold = 1

; This key/Button activates scrolling
; esmb_TriggerKey = XButton1

; This key/Button sends Middle click
; esmb_TriggerKey2 = XButton2

; End of configuration

; #Persistent
; CoordMode, Mouse, Screen
; Hotkey, %esmb_TriggerKey%, esmb_TriggerKeyDown
; HotKey, %esmb_TriggerKey% Up, esmb_TriggerKeyUp
; HotKey, %esmb_TriggerKey2%, esmb_TriggerKey2Down
; HotKey, %esmb_TriggerKey2% Up, esmb_TriggerKey2Up
; esmb_KeyDown = n
; SetTimer, esmb_CheckForScrollEventAndExecute, 10

; SetTitleMatchMode, 2
; IfWinNotExist,Firefox
    ; Run,C:\Users\rcaldeir\Programs\FirefoxPortable\FirefoxPortable.exe,C:\Users\rcaldeir\Programs\FirefoxPortable\,Max

Random, rand, 1, 7
SplashImage, %A_ScriptDir%\todo\todo0%rand%.png, b
sleep, 10000
KeyWait, Escape, D
SplashImage, Off	
	
	
Pausa := A_Now

Pausa += 30, minutes	


tempotempo := 0
tempotempo2 := 1
GoTo, Clock

; esmb_TriggerKey2Down:
; MouseClick, Middle,,,,, D
; return

; esmb_TriggerKey2Up:
; MouseClick, Middle,,,,, U
; return

;RButton & LButton::Send, {MButton}
;RButton::RButton ; Restore the original RButton functionality

#LButton::
Send, {MButton}
return

#i::
Send, ^c
ClipWait, 1
StringReplace, clippoint, Clipboard, `,, ., All
inch := clippoint / 254 * 10
mm := clippoint * 254 / 10
MsgBox clip: %clippoint% `n`n inch: %inch% `n mm: %mm%
return

#a::
Winset, AlwaysOnTop, TOGGLE, A
return

+#r::
Reload
return

^#r::
Run, autohotkey.exe %Clipboard%
return

^#p::
Run, C:\Users\rcaldeir\Programs\WinPython-64bit-3.4.4.2\python-3.4.4.amd64\python.exe %Clipboard%
return

#4::
Send, ^c
Send, $%Clipboard%$
return


; #w::
; Pausa =
; Pausa += 75, minutes
; FormatTime, Pausa2, %Pausa%, HH:mm
; MsgBox, 64, Pausa!, Pausa às %Pausa2%
; return

; #+w::
; Pausa =
; Pausa += 15, minutes
; FormatTime, Pausa2, %Pausa%, HH:mm
; MsgBox, 64, Snooze!, Snooze às %Pausa2%
; return

#Enter::
InputBox, waittime , Delayed Enter, Enter time to wait in miliseconds:
SetTimer, TakeAction, %waittime%
return

TakeAction:
SetTimer, TakeAction, Off
Send,{Enter}
return

; Volume control

#^Up::
Send {Volume_Up 3}
return

#t::
Run,cmd.exe /K "cd /d C:\Users\rcaldeir\Programs\tools", Max
return

#+t::
explorerpath:= "explorer C:\Users\rcaldeir\Programs\tools" 
Run, %explorerpath%
return

#^Down::
Send {Volume_Down 3}
return

#c::
Run,cmd.exe %clipboard%
return

#^c::
Send,^c
Clipboard := "Hi " . clipboard . "!`n`nI cannot host you this time.`nHope you find something!`n`nHugs,`nRui`n"
return

; acentos

!^a::
Send,ã
return

!^n::
Send,ñ
return

!^c::
Send,ç
return

!^o::
Send,õ
return

; END acentos


#p::
Send, ^c
ClipWait, 1
Gui, 3:+AlwaysOnTop +caption +Border +ToolWindow +LastFound
Gui, 3:Add, Edit, +Wrap,%Clipboard%
Gui, 3:Show, , PopUp
return

#e::
if WinExist("ahk_class CabinetWClass")
{
WinActivate
}
else
{
Run, explorer.exe,"M:\"
}
return

#+e::
Run, explorer.exe,"M:\"
return


#z::
Send,%A_now%{Enter}
Send,%CurrentDateTime%
return

#x::
Clock:
if tempotempo <> 1
{
tempotempo := 1
While tempotempo
{
FormatTime, CurrentDateTime,, ss

SetTimer, RemoveToolTip, 10000
While tempotempo2
{
FormatTime, CurrentDateTime,, HH:mmtt
ToolTip, %CurrentDateTime%
if A_Now > %Pausa%
{
SplashImage, drinkmorewater.png, b,,,Agua
SysGet, screenx, 0
SysGet, screeny, 1
screenx := screenx - 389
screeny := screeny - 562
Random, aguax, 0, %screenx%
Random, aguay, 0, %screeny%
WinMove, Agua, , %aguax%, %aguay%
sleep, 5000
KeyWait, Escape, D
SplashImage, Off
Pausa := A_Now
Pausa += 30, minutes
}
Sleep 25
}
tempotempo2 := 1
Sleep,150000
}
}
ToolTip
return

#+x::
tempotempo :=0
return

RemoveToolTip:
SetTimer, RemoveToolTip, Off
ToolTip
tempotempo2 = 0
return

#s::
Gui, 4:Destroy
clipboard =  ; Start off empty to allow ClipWait to detect when the text has arrived.
ClipWait,0.5
MyEdit = ;
Send ^c
ClipWait,0.5  ; Wait for the clipboard to contain text.
StringReplace,MyEdit,clipboard,`n,`r`n,all
;MyEdit = %clipboard%
Gui, 4:Add, Edit, gMyEdit w500 r1 vMyEdit, %clipboard%
Gui, 4:Add, ListBox, vMyListBox gMyListBox w500 r20
GuiControl,4:, MyListBox,|https://duckduckgo.com/?q=%MyEdit% | https://duckduckgo.com/?q=%MyEdit% !g| https://duckduckgo.com/?q=%MyEdit% !gt | http://www.wolframalpha.com/input/?i=%MyEdit%|https://www.priberam.pt/dlpo/default.aspx?pal=%MyEdit%|http://de.pons.eu/dict/search/results/?q=%MyEdit%&l=deen&in=&lf=de&kbd=en-gb|http://www.linguee.de/deutsch-englisch/search?source=auto&query=%MyEdit%|http://www.verbix.com/webverbix/German/%MyEdit%.html|%ComSpec% /C %MyEdit%|http://%MyEdit%|h:\Progs\doublecmd\doublecmd.exe %MyEdit%|%MyEdit%|https://duckduckgo.com/?q=%MyEdit% autohotkey | https://duckduckgo.com/?q=%MyEdit% autohotkey !g
Gui,4:+ToolWindow
Gui,4:Show, ,GoBox
return

MyEdit:
GuiControlGet, MyEdit, 4:
GuiControl,4:,MyListBox,|https://duckduckgo.com/?q=%MyEdit% | https://duckduckgo.com/?q=%MyEdit% !g| https://duckduckgo.com/?q=%MyEdit% !gt | http://www.wolframalpha.com/input/?i=%MyEdit%|https://www.priberam.pt/dlpo/default.aspx?pal=%MyEdit%|http://de.pons.eu/dict/search/results/?q=%MyEdit%&l=deen&in=&lf=de&kbd=en-gb|http://www.linguee.de/deutsch-englisch/search?source=auto&query=%MyEdit%|http://www.verbix.com/webverbix/German/%MyEdit%.html|%ComSpec% /C %MyEdit%|http://%MyEdit%|h:\Progs\doublecmd\doublecmd.exe %MyEdit%|%MyEdit%|https://duckduckgo.com/?q=%MyEdit% autohotkey | https://duckduckgo.com/?q=%MyEdit% autohotkey !g
return

MyListBox:
; Otherwise, the user double-clicked a list item, so treat that the same as pressing OK.
; So fall through to the next label.
ButtonOK:
GuiControlGet, MyListBox, 4:  ; Retrieve the ListBox's current selection.
Run, %MyListBox%,, UseErrorLevel
4GuiClose:
4GuiEscape:
Gui, 4:Destroy
return
