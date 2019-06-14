F12::
Run, gvim.exe D:\.lscsafe.gpg
return

F11::
Run, powershell.exe
return

F10::
if WinExist("ahk_exe firefox.exe")
    WinActivate, ahk_exe firefox.exe
else
    Run, firefox.exe
return

F9::
if WinExist("ahk_exe outlook.exe")
    WinActivate, ahk_exe outlook.exe
else
    Run, outlook.exe
return

<^>!a::
Send, {{}
return

<^>!s::
Send, {}}
return

<^>!d::
Send, {[}
return

<^>!f::
Send, {]}
return

<^>!=::
Send, {±}
return

<^>!m::
Send, {μ}
return
