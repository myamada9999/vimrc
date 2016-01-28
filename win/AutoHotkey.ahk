; IMPORTANT INFO ABOUT GETTING STARTED: Lines that start with a
; semicolon, such as this one, are comments.  They are not executed.

; This script has a special filename and path because it is automatically
; launched when you run the program directly.  Also, any text file whose
; name ends in .ahk is associated with the program, which means that it
; can be launched simply by double-clicking it.  You can have as many .ahk
; files as you want, located in any folder.  You can also run more than
; one ahk file simultaneously and each will get its own tray icon.

; SAMPLE HOTKEYS: Below are two sample hotkeys.  The first is Win+Z and it
; launches a web site in the default browser.  The second is Control+Alt+N
; and it launches a new Notepad window (or activates an existing one).  To
; try out these hotkeys, run AutoHotkey again, which will load this file.

#z::Run www.autohotkey.com

^!n::
IfWinExist Untitled - Notepad
	WinActivate
else
	Run Notepad
return


; Note: From now on whenever you run AutoHotkey directly, this script
; will be loaded.  So feel free to customize it to suit your needs.

; Please read the QUICK-START TUTORIAL near the top of the help file.
; It explains how to perform common automation tasks such as sending
; keystrokes and mouse clicks.  It also explains more about hotkeys.
vk1Dsc07B::Send,{Blind}{sc029}      ;無変換単独 = 全角/半角キー
vk1Dsc07B & j::Send,^j              ;無変換単独+j = Ctr+j
vk1Csc079::Send,{Blind}{Esc}        ;変換単独 = Escape
Insert & s::Shutdown,1              ;Insert+s = シャットダウン
Insert & l::Shutdown,0              ;Insert+l = ログオフ
Insert & r::Shutdown,2              ;Insert+r = リブート

; Winキー＋αにプロセス起動の割り当て
; すでに起動済みの場合はウィンドウを前面にする．
RunProcess(x){
    if(x = "f"){    			; firefoxの起動
        Process,Exist,firefox.exe
        if ErrorLevel<>0
            WinActivate,ahk_pid %ErrorLevel%
        else
            Run,C:\Program Files\Mozilla Firefox\firefox.exe
    }else if(x = "t"){			; thunderbirdの起動
        Process,Exist,thunderbird.exe
        if ErrorLevel<>0
            WinActivate,ahk_pid %ErrorLevel%
        else
            Run,C:\Program Files\Mozilla Thunderbird\thunderbird.exe
    }else if(x = "i"){			; IEの起動
        Process,Exist,iexplore.exe
        if ErrorLevel<>0
            WinActivate,ahk_pid %ErrorLevel%
        else
            Run,"C:\Program Files\Internet Explorer\iexplore.exe"
    }else if(x = "p"){			; puppyの起動
        Process,Exist,putty.exe
        if ErrorLevel<>0
            WinActivate,ahk_pid %ErrorLevel%
        else
            Run,"C:\Program Files\Putty\putty.exe"
    }else if(x = "w"){			; WinSCPの起動
        Process,Exist,WinSCP.exe
        if ErrorLevel<>0
            WinActivate,ahk_pid %ErrorLevel%
        else
            Run,"C:\Program Files (x86)\WinSCP\WinSCP.exe"
    }else if(x = "v"){			; VMWareの起動
        Process,Exist,vmplayer.exe
        if ErrorLevel<>0
            WinActivate,ahk_pid %ErrorLevel%
        else
            Run,"C:\Program Files (x86)\VMware\VMware Player\vmplayer.exe"
    }else if(x = "g"){			; Gvimの起動
        Process,Exist,gvim.exe
        if ErrorLevel<>0
            WinActivate,ahk_pid %ErrorLevel%
        else
            Run,"C:\Program Files\Gvim\vim74-kaoriya-win32\gvim.exe"
    }else if(x = "o"){			; Outlookの起動
        Process,Exist,outlook.exe
        if ErrorLevel<>0
            WinActivate,ahk_pid %ErrorLevel%
        else
            Run,"C:\Program Files\Microsoft Office\Office15\OUTLOOK.EXE"
    }else if(x = "q"){			; ウィンドウを閉じる
        Send,!{F4}
    }
}


; ウィンドウを閉じる Win+qでAlt+F4
#q::RunProcess("q")

; Win+Fにfirefoxの起動
#f::RunProcess("f")

; Win+TにThunderbirdの起動
#t::RunProcess("t")

; Win+iにIEの起動
#i::RunProcess("i")

; Win+pにpuppyの起動
#p::RunProcess("p")

; Win+wにWinSCPの起動
#w::RunProcess("w")

; Win+vにVMwarePlayerの起動
#v::RunProcess("v")

; Win+gにGvimの起動
#g::RunProcess("g")

; Win+oにOutlookの起動
#o::RunProcess("o")
