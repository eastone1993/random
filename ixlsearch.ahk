#SingleInstance, force 
#NoTrayIcon


OpenNewWindow() { ;ensures that new window is created properly when called 
	run, "chrome.exe"
	sleep 500
	WinSetTitle, New Tab,, search
	WinWait, New Tab,, 2 
	if ErrorLevel {
		OpenNewWindow()
	}
	else {
		return 
	}

}


NewWindowSetting(Byref new_window) {
    if(new_window = true)
    { 
        ;run, "chrome.exe" ; Creates new instance of Chrome - comment out LINE 114 if you wish to use this code
        ;sleep 500
        OpenNewWindow()
        winactivate ahk_exe chrome.exe
        sleep 500
        new_window := false 
        return    
    }
    else if(new_window = false)
    {
        Send, ^t
        sleep 100
        return 
    }
}

SendRightSearchSetting(Byref sr) {
    if (sr = true)
    {
        sleep 200
        Send, #+{Right} 
    }
    return 
}

SFSearch(Byref contents, Byref new_window) {
    NewWindowSetting(new_window)
    var1 := "https://ixl.my.salesforce.com/_ui/search/ui/UnifiedSearchResults?searchType=2&sen=0JZ&sen=001&sen=02s&sen=068&sen=003&sen=00T&sen=00U&sen=005&sen=500&sen=00O&str=" . contents
    var2 := var1 . "&isdtp=vw&isWsVw=true&nonce=02541659de9dde0d96e44d154840e14be6f2bb3fcc1022859c569e3e55629581&sfdcIFrameOrigin=https%3A%2F%2Fixl.my.salesforce.com"
    ClipWait
    Clipboard := var2
    sleep, 500 ;wait for page to load
    Send, ^v
    Send, {enter}
    Clipboard := contents 
    return 
}

SubmanSearch(Byref contents, Byref new_window) {
    NewWindowSetting(new_window)
    sleep 100
    Clipboard := "https://secure.quia.com/actions/subManager/search/sub"
    Send, ^v
    Send, {enter}
    sleep, 1250 ;wait for page to load
    Send {Tab 10} ;tab down for the win
    Clipboard := contents
    Send, ^v
    Send, {enter}
    return 
}

SubmanAccountSearch(Byref contents, Byref new_window) {
    NewWindowSetting(new_window)
    Variable := "https://secure.quia.com/actions/subManager/account/view/" . contents
    ClipWait    
    Clipboard := Variable
    sleep, 500
    Send, ^v
    Send, {enter}
    return 
}

QuiaSearch(Byref contents, Byref new_window) {
    NewWindowSetting(new_window)
    Variable := "https://secure.quia.com/servlets/quia.internal.userInfo.UserInfo?logicModule=1&email=" . contents
    ClipWait
    Clipboard := Variable
    Send, ^v
    Send, {enter}
    Clipboard := contents
    return 
}

IXLSearchSetting(Byref thing, Byref new_window, Byref sr, Byref sm, Byref sf) {
    
    new_window_setting := new_window ;saves new_window's mode 
    if RegExMatch(thing, "[\w-_.]+@(?:\w+(?::\d+)?\.){1,3}(?:\w+\.?){1,2}", contents) {
        QuiaSearch(contents, new_window)
        SFSearch(contents, new_window)
        if(sm = true)
        {
            SubmanSearch(contents, new_window)
        }

        ;send right setting 
        SendRightSearchSetting(sr)
    }
    else 
    {
        Length := StrLen(thing)
        ;MsgBox, %thing% %Length%
        if (Length=8) ;CASE NUMBERS ARE 8 DIGITS ALWAYS
        {
            SFSearch(thing, new_window)
        }
        else ;ACCOUNT NUMBER WITHOUT PREFIX
        {
            if(sf = true)
            { 
                SFSearch(thing, new_window)
            }
            SubmanAccountSearch(thing, new_window)
        }

        ;send right setting 
        SendRightSearchSetting(sr)
    }

    new_window := new_window_setting ;sets new_window to original mode 

    return 

}

