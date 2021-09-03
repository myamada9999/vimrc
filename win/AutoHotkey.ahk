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
vk1Dsc07B::Send,{Blind}{sc029}      ;���ϊ��P�� = �S�p/���p�L�[
vk1Dsc07B & j::Send,^j              ;���ϊ��P��+j = Ctr+j
vk1Csc079::Send,{Blind}{Esc}        ;�ϊ��P�� = Escape
Insert & s::Shutdown,1              ;Insert+s = �V���b�g�_�E��
Insert & l::Shutdown,0              ;Insert+l = ���O�I�t
Insert & r::Shutdown,2              ;Insert+r = ���u�[�g

; Win�L�[�{���Ƀv���Z�X�N���̊��蓖��
; ���łɋN���ς݂̏ꍇ�̓E�B���h�E��O�ʂɂ���D
RunProcess(x){
    if(x = "f"){    			; firefox�̋N��
        Process,Exist,firefox.exe
        if ErrorLevel<>0
            WinActivate,ahk_pid %ErrorLevel%
        else
            Run,C:\Program Files\Mozilla Firefox\firefox.exe
    }else if(x = "t"){			; thunderbird�̋N��
        Process,Exist,thunderbird.exe
        if ErrorLevel<>0
            WinActivate,ahk_pid %ErrorLevel%
        else
            Run,C:\Program Files\Mozilla Thunderbird\thunderbird.exe
    }else if(x = "i"){			; IE�̋N��
        Process,Exist,iexplore.exe
        if ErrorLevel<>0
            WinActivate,ahk_pid %ErrorLevel%
        else
            Run,"C:\Program Files\Internet Explorer\iexplore.exe"
    }else if(x = "p"){			; puppy�̋N��
        Process,Exist,putty.exe
        if ErrorLevel<>0
            WinActivate,ahk_pid %ErrorLevel%
        else
            Run,"C:\Program Files\Putty\putty.exe"
    }else if(x = "w"){			; WinSCP�̋N��
        Process,Exist,WinSCP.exe
        if ErrorLevel<>0
            WinActivate,ahk_pid %ErrorLevel%
        else
            Run,"C:\Program Files (x86)\WinSCP\WinSCP.exe"
    }else if(x = "v"){			; VMWare�̋N��
        Process,Exist,vmplayer.exe
        if ErrorLevel<>0
            WinActivate,ahk_pid %ErrorLevel%
        else
            Run,"C:\Program Files (x86)\VMware\VMware Player\vmplayer.exe"
    }else if(x = "g"){			; Gvim�̋N��
        Process,Exist,gvim.exe
        if ErrorLevel<>0
            WinActivate,ahk_pid %ErrorLevel%
        else
            Run,"C:\Program Files\Gvim\vim74-kaoriya-win32\gvim.exe"
    }else if(x = "o"){			; Outlook�̋N��
        Process,Exist,outlook.exe
        if ErrorLevel<>0
            WinActivate,ahk_pid %ErrorLevel%
        else
            Run,"C:\Program Files\Microsoft Office\Office15\OUTLOOK.EXE"
    }else if(x = "q"){			; �E�B���h�E�����
        Send,!{F4}
    }
}


; �E�B���h�E����� Win+q��Alt+F4
#q::RunProcess("q")

; Win+F��firefox�̋N��
#f::RunProcess("f")

; Win+T��Thunderbird�̋N��
#t::RunProcess("t")

; Win+i��IE�̋N��
#i::RunProcess("i")

; Win+p��puppy�̋N��
#p::RunProcess("p")

; Win+w��WinSCP�̋N��
#w::RunProcess("w")

; Win+v��VMwarePlayer�̋N��
#v::RunProcess("v")

; Win+g��Gvim�̋N��
#g::RunProcess("g")

; Win+o��Outlook�̋N��
#o::RunProcess("o")
