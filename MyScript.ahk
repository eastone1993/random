;----------------------------------- MY SCRIPT -------------------------------------------------------------------------------------------------------------
#IfWinNotExist, `%A_WorkingDir`%\testfile.ahk 
{
    Run, %A_WorkingDir%\testfile.ahk
} 

OnExit("ExitFunc")

ExitFunc()
{
    DetectHiddenWindows, On 
    WinClose, %A_WorkingDir%\testfile.ahk ahk_class AutoHotkey
}

;C:\Users\estone\Desktop\AHK\MyScripts\MyScript.ahk.ahk 

;PUT HOTSTRINGS HERE
::xsig::Sincerely,{enter}{enter}Evan Stone{enter}IXL Account Services{enter}{enter}Mailing Address:{enter}IXL Learning{enter}777 Mariners Island Blvd., Suite 600{enter}San Mateo, CA 94404 USA{enter}{enter}Toll-free 1.855.255.8800 | Direct 1.650.372.4300 | Fax: 1.650.372.4301
::lmk::Please let me know if you have any questions.
::tfyr::Thanks for your reply.
::tfcu::Thanks for contacting us.
::ihte::I hope this e-mail finds you well.
::tro::Thanks for reaching out{!}
::tgb::Thanks for getting back to me{!}
::gq::Great question{!}
::xur:: We have a new tool available in your administrator account  to ensure security and privacy for your data. You can simply click the  “Upload roster files” link found under the Account Management tab to access a secure upload page for all of your student and teacher information.
::ixlfdos::My name is Evan, I'll be your account services coordinator moving forward. I'm reaching out because I've noticed you haven't uploaded any students to your roster yet. Is there anything I can do to help get your account set up?
::xsi::Please send me a complete student list with the following student information in separate columns of an Excel spreadsheet:{enter}{enter}    -First name{enter}    -Last name{enter}    -Student ID number{enter}    -Grade level{enter}    -Teacher last name or teacher email{enter}{enter}Note that student's first name, last name, student ID, and grade level are required. 
::fsu::Your account currently has fall setup enabled. IXL’s fall setup tool will help automatically promote students to the next grade level and clear class rosters two weeks prior to your first day of school, on [date]. Please advise if you would like this tool to remain enabled, or I am happy to assist you if you would like to have it turned off. 
::ifhb::I look forward to hearing back from you{!}
::ilfw::I look forward to working with you{!}
::yrsa::Your roster has been successfully added. 
::ysbr::Your student has been restored.
::orfdos::My name is Evan, I'll be your account services coordinator moving forward. I'm reaching out because I've noticed you don't have your school's first day of classes listed on your account. This information is important for our internal systems. I look forward to hearing back from you{!} 
::ccadmin::I have copied your IXL administrator in this email for reference. 
::bbb::Teach was a shrewd and calculating leader who spurned the use of force, relying instead on his fearsome image to elicit the response that he desired from those whom he robbed. Contrary to the modern-day picture of the traditional tyrannical pirate, he commanded his vessels with the consent of their crews and there is no known account of his ever having harmed or murdered those whom he held captive. He was romanticized after his death and became the inspiration for an archetypal pirate in works of fiction across many genres.
::xchkin::I'm just reaching out to check-in on how your IXL account set-up is going?
::xecom::My name is Evan, I am your IXL Account Coordinator. I'm not sure if you are receiving my emails. Is this the proper e-mail to communicate with you? 
::xevan::My name is Evan, I am your school's IXL Account Coordinator. 
::xcov::My name is Evan, I am covering for Gabriella today. 
::xpswd::I've sent you a password reset link to your e-mail. Let me know if you don't see it.


;spellcorrect
:*?:signin::sign-in
:*?:sign in::sign-in 
:*?:recieve::receive 
::setup::set-up
::checkin::check-in
:*?:email::e-mail
:*?:seperate::separate
:*?:reccommend::recommend 
::ixl::IXL 
::teh::the 
::managment::management 
:*?:neccessary::necessary
:*:alot::a lot 
::can not::cannot 
::math::Math 
::ela::ELA
::science::Science 
::social studies::Social Studies 
;date function 
:R*?:ddd::
FormatTime, CurrentDateTime,, MM/dd/yyyy
SendInput %CurrentDateTime% + ES--------------------------------------------------------------------------{enter}{enter}{enter}{enter}{Up}{Up}
Return

;eric's requested hotstrings 
::qssr::https://www.ixl.com/userguides/IXLQuickStart_SiteRoster.pdf 
::afaq::https://www.ixl.com/help-center/School-administrators/665924
::aqsg::https://www.ixl.com/userguides/IXLQuickStart_Administrator.pdf
::xfileupload::https://www.ixl.com/admin/upload-roster-files

;----------------------------------- E-MAIL TEMPLATES -------------------------------------------------------------------------------------------------------------
;3.5 ACCOUNT ON HOLD
::xhold::I hope this e-mail finds you well. I wanted to check-in and see if you had any questions regarding the information I need to create accounts for your students. Since we have not received a student list, your account has automatically gone on hold. Once I receive your list and create student accounts, the hold on your account will be lifted, and your students will be able to practice right away{!}{Enter}{Enter} I look forward to hearing from you and helping you get started with IXL{!}
::xwelcome::
(
Welcome to IXL! My name is Evan, I am your school's IXL Account Coordinator. I will be assisting you in getting your students and teachers started with the program. 

To get started, using an Excel spreadsheet, please compile a roster with the following information in separate columns:

    - First name
    - Last name
    - Student ID number
    - Grade level
    - School (if applicable)
    - Student or parent email (recommended)
    - Teacher name
    - Teacher email

The last two columns will allow me to create teacher accounts and class rosters right away. If a student is associated with more than one teacher, please list each additional teacher in a separate column. 

If a teacher has a trial account, please exclude them from the teacher list. I will send instructions on how to merge their trial account once the subscription is activated. 

Once the file is ready, please submit it to our secure uploading page using the following link: https://www.ixl.com/admin/upload-roster-files

I look forward to hearing from you and helping you get started with IXL!

    )
;----------------------------------- CODING SCRIPTS -------------------------------------------------------------------------------------------------------------
:*:x;::;-----------------------------------  -------------------------------------------------------------------------------------------------------------{ctrl}{Left 110}
:*:xtempheader::
(

Name: <FIRSTNAME> <LASTNAME>
Username: <USERNAME>
Initials: <INITIALS> 
Senior Specialist/Coordinator: <SENIORSPECIALIST>
Roster File Path: C:\Users\<USERNAME>\Desktop\Rosters

    )
:*:xspecheader::
(

Name: <FIRSTNAME> <LASTNAME>
Username: <USERNAME>
Initials: <INITIALS> 
Assistant: <ASSISTANT>
Roster File Path: C:\Users\<USERNAME>\Desktop\Rosters

    )

:*:x/::/*{enter}{enter}*/{Up}


;----------------------------------- EXCEL FUNCTIONS -------------------------------------------------------------------------------------------------------------

;FILE SCRUBBING
^+q::
;enables editing 
Send !f
sleep, 250
Send i
sleep, 250
Send e
sleep, 250

;resets to main window 
Send {Esc}{Esc}{Esc}
sleep, 500

;scrubbing block 
Send ^{Home}
sleep, 500
Send, ^+{End}
sleep, 250
Send ^c
sleep, 250
Send +{F11}
sleep, 250
Send ^!v
sleep, 250
Send v
Send {enter}
sleep, 250

;sorts file to eliminate blank lines 
Send ^{Home}
sleep, 250
Send, {down}
sleep, 250
Send ^+{End}
sleep, 250
Send {alt}
sleep, 250
Send a 
sleep, 250
send sa 
sleep, 500

Return

;FILE SAVING
/*ALT+F, I, E, F12, TAB, DOWNARROW*7, ENTER
*/
^+w::
Send !f
Send i
Send e
sleep, 50
Send {Esc}{Esc}{Esc}
sleep, 500
Send {F12}
Send {TAB}
Send c
Send +{TAB}
Return

;ALL IN ONE SCRUBBING AND SAVING FUNCTION ---------------------------------------------------------------------
^+l::
;enables editing 
Send !f
sleep, 250
Send i
sleep, 250
Send e
sleep, 250

;resets to main window 
Send {Esc}{Esc}{Esc}
sleep, 500

;scrubbing block 
Send ^{Home}
sleep, 500
Send, ^+{End}
sleep, 250
Send ^c
sleep, 250
Send +{F11}
sleep, 250
Send ^!v
sleep, 250
Send v
Send {enter}
sleep, 250

;sorts file to eliminate blank lines 
Send ^{Home}
sleep, 250
Send, {down}
sleep, 250
Send ^+{End}
sleep, 250
Send {alt}
sleep, 250
Send a 
sleep, 250
send sa 
sleep, 500

;saving block 
Send {F12}
sleep, 500
Send {Esc}
sleep, 250
Send {F12}
sleep, 500
Send {F4}
Send {F6}{F6}{F6}{F6}{F6}{F6}
sleep, 500
Send d ;resets file type
Send c ;sets file type to csv 
Send !d ;moves to address bar 
sleep, 250
Send ^a
sleep, 250
Send %A_Desktop%\Rosters ;file path
Send, {enter}
sleep, 250
Send {Tab}{Tab}{Tab}{Tab}{Tab}{Tab} ;navigates back to filename bar 
;MsgBox, Done
Return
;------------------SEARCH FUNCTIONS--------------------------------------------

;search google
^+f::
Clipboard = 
Send ^c
ClipWait
contents := Clipboard
winactivate ahk_exe chrome.exe
Send ^t
sleep, 250
Send, ^v
Send, {enter}
Return


/*
Ctrl+Shift+S EMAIL, ACCOUNT NUMBER, OR CASE NUMBER
EMAIL: Searches Quia, SubMan, and SalesForce
ACC#: Searches SubMan and salesforce
Case#: Searches SalesForce
*/
^+s:: 
Clipboard =
Send ^c
ClipWait
contents := Clipboard
contentsTrimmed = %contents%
if RegExMatch(contentsTrimmed, "[\w-_.]+@(?:\w+(?::\d+)?\.){1,3}(?:\w+\.?){1,2}", email) {
    ;QUIA SEARCH
    Run, "chrome.exe" ; Creates new instance of Chrome - comment out LINE 114 if you wish to use this code
    winactivate ahk_exe chrome.exe
;    Send, ^t
    Variable := "https://secure.quia.com/servlets/quia.internal.userInfo.UserInfo?logicModule=1&email=" . email
    Clipboard := Variable
    Send, ^v
    Send, {enter}
    Clipboard := email

    ;SALESFORCE SEARCH
    Send, ^t
    var1 := "https://ixl.my.salesforce.com/_ui/search/ui/UnifiedSearchResults?searchType=2&sen=0JZ&sen=001&sen=02s&sen=068&sen=003&sen=00T&sen=00U&sen=005&sen=500&sen=00O&str=" . email
    var2 := var1 . "&isdtp=vw&isWsVw=true&nonce=02541659de9dde0d96e44d154840e14be6f2bb3fcc1022859c569e3e55629581&sfdcIFrameOrigin=https%3A%2F%2Fixl.my.salesforce.com"
    ClipWait
    Clipboard := var2
    sleep, 500 ;wait for page to load
    Send, ^v
    Send, {enter}
    Clipboard := email

    ;SUBMANAGER SEARCH
    var3 := Clipboard
    Send, ^t
    Clipboard := "https://secure.quia.com/actions/subManager/search/sub"
    Send, ^v
    Send, {enter}
    sleep, 1000 ;wait for page to load
    Send {Tab}{Tab}{Tab}{Tab}{Tab}{Tab}{Tab}{Tab}{Tab}{Tab} ;tab down for the win
    Clipboard := var3
    Send, ^v
    Send, {enter}
   
    ;sends the screen to the right 
    sleep, 500
    Send, #+{Right} 

} else {
    Length := StrLen(contentsTrimmed)
    if (Length=8){
        ;SALESFORCE SEARCH
        winactivate ahk_exe chrome.exe
        Send, ^t
        var1 := "https://ixl.my.salesforce.com/_ui/search/ui/UnifiedSearchResults?searchType=2&sen=0JZ&sen=001&sen=02s&sen=068&sen=003&sen=00T&sen=00U&sen=005&sen=500&sen=00O&str=" . contentsTrimmed
        var2 := var1 . "&isdtp=vw&isWsVw=true&nonce=02541659de9dde0d96e44d154840e14be6f2bb3fcc1022859c569e3e55629581&sfdcIFrameOrigin=https%3A%2F%2Fixl.my.salesforce.com"
        ClipWait
        Clipboard := var2
        sleep, 500
        Send, ^v
        Send, {enter}

    } else if (Length>8) { ;account number search WITH preceding notation
        ;SUBMANAGER SEARCH
        winactivate ahk_exe chrome.exe
        StringTrimLeft, NewStr, contentsTrimmed, 4 ;trims off the A##- 
        Send, ^t
        Variable := "https://secure.quia.com/actions/subManager/account/view/" . contentsTrimmed
        ClipWait    
        Clipboard := Variable
        sleep, 500
        Send, ^v
        Send, {enter} 
/*
        ;SALESFORCE SEARCH
        Send, ^t
        var1 := "https://ixl.my.salesforce.com/_ui/search/ui/UnifiedSearchResults?searchType=2&sen=0JZ&sen=001&sen=02s&sen=068&sen=003&sen=00T&sen=00U&sen=005&sen=500&sen=00O&str=" . NewStr
        var2 := var1 . "&isdtp=vw&isWsVw=true&nonce=02541659de9dde0d96e44d154840e14be6f2bb3fcc1022859c569e3e55629581&sfdcIFrameOrigin=https%3A%2F%2Fixl.my.salesforce.com"   
        ClipWait
        Clipboard := var2
        sleep, 500 ;wait for page to load
        Send, ^v
        Send, {enter}
*/
    } else { ;account number search WITHOUT preceding notation
        ;SUBMANAGER SEARCH
        winactivate ahk_exe chrome.exe
        Send, ^t
        Variable := "https://secure.quia.com/actions/subManager/account/view/" . contentsTrimmed
        ClipWait    
        Clipboard := Variable
        sleep, 500
        Send, ^v
        Send, {enter}   
/*
        ;SALESFORCE SEARCH
        Send, ^t
        var1 := "https://ixl.my.salesforce.com/_ui/search/ui/UnifiedSearchResults?searchType=2&sen=0JZ&sen=001&sen=02s&sen=068&sen=003&sen=00T&sen=00U&sen=005&sen=500&sen=00O&str=" . contentsTrimmed
        var2 := var1 . "&isdtp=vw&isWsVw=true&nonce=02541659de9dde0d96e44d154840e14be6f2bb3fcc1022859c569e3e55629581&sfdcIFrameOrigin=https%3A%2F%2Fixl.my.salesforce.com"   
        ClipWait
        Clipboard := var2
        sleep, 500 ;wait for page to load
        Send, ^v
        Send, {enter}
*/  
    }
}

Return



;SHORTCUT SEARCH
^+d::
; Identifies selected text as username or e-mail and searches for account
; Start off empty to allow ClipWait to detect when the text has arrived.
Clipboard =
Send ^c
; Wait for the clipboard to contain text.
ClipWait
contents := Clipboard
contentsTrimmed = %contents%
winactivate ahk_exe chrome.exe
Send, ^t
Variable := "https://secure.quia.com/servlets/quia.internal.userInfo.UserInfo?logicModule=1&email=" . contentsTrimmed
Clipboard := Variable
Send, ^v
Send, {enter}
Clipboard := email
Return

/*
^+e::
Clipboard = 
send ^c 
ClipWait 
contents := Clipboard
FileAppend, `n%contents%`n, %A_Desktop%\derp.txt 
MsgBox, Stuff done 
*/



/*



if RegExMatch(contentsTrimmed, "[\w-_.]+@(?:\w+(?::\d+)?\.){1,3}(?:\w+\.?){1,2}", email) {
    winactivate ahk_exe chrome.exe
    Send, ^t
    Variable := "https://secure.quia.com/servlets/quia.internal.userInfo.UserInfo?logicModule=1&email=" . email
    Clipboard := Variable
    Send, ^v
    Send, {enter}
    Clipboard := email
    
} else {
    winactivate ahk_exe chrome.exe
    var1 := Clipboard
    Send, ^t
    Clipboard := "https://secure.quia.com/actions/subManager/search/sub"
    Send, ^v
    Send, {enter}
    sleep, 1000
    Send {Tab}{Tab}{Tab}{Tab}{Tab}{Tab}{Tab}{Tab}
    Clipboard := var1
    Send, ^v
    Send, {enter}
}
*/



/*
^+e::
Clipboard = 
Send ^c
ClipWait
winactivate ahk_exe chrome.exe
var1 := Clipboard
Send, ^t
Clipboard := "https://secure.quia.com/actions/subManager/search/sub"
Send, ^v
Send, {enter}
sleep, 1000
Send {Tab}{Tab}{Tab}{Tab}{Tab}{Tab}{Tab}{Tab}
Clipboard := var1
Send, ^v
Send, {enter}
Return


^+a::
Clipboard = 
Send ^c
ClipWait
contents := Clipboard
contents = %contents%
Length := StrLen(contents)
if (Length=8){
    winactivate ahk_exe chrome.exe
    Send, ^t
    var1 := "https://ixl.my.salesforce.com/_ui/search/ui/UnifiedSearchResults?searchType=2&sen=0JZ&sen=001&sen=02s&sen=068&sen=003&sen=00T&sen=00U&sen=005&sen=500&sen=00O&str=" . contents
    var2 := var1 . "&isdtp=vw&isWsVw=true&nonce=02541659de9dde0d96e44d154840e14be6f2bb3fcc1022859c569e3e55629581&sfdcIFrameOrigin=https%3A%2F%2Fixl.my.salesforce.com"
    ClipWait
    Clipboard := var2
    Send, ^v
    Send, {enter}
} else {
    winactivate ahk_exe chrome.exe
    Send, ^t
    Variable := "https://secure.quia.com/actions/subManager/account/view/" . contents
    ClipWait    
    Clipboard := Variable
    Send, ^v
    Send, {enter} 
}
Return
*/

;-----------------------------------E-MAIL TEMPLATES-----------------------------------------------------------------------------------------------------


/*
E-MAIL TEMPLATES FOR TEMPS TO USE
*/
/*
;----------------------------------- INTRODUCTIONS-------------------------------------------------------------------------------------------------------------
::xintro::My name is FIRSTNAME and I am assisting SENIORSPECIALIST during this busy time of year. 

;----------------------------------- CONFIRMATIONS -------------------------------------------------------------------------------------------------------------
;1.01 NEW SET-UP (Teacher info NOT included)
::x101::
(
Thanks for uploading/sending your student list. I've uploaded your master roster and created student accounts.  

Your admin account information has been sent to XXXXX in a separate e-mail. From your admin account you will be able to manage student and teacher accounts, and monitor student performance.  

You can access [ORG NAME's] sign-in page at XXXX. Your custom sign-in page allows for simple and personalized access to IXL for administrators, teachers, and students. I recommend bookmarking this page for your students!

TEACHER ACCOUNTS AND CLASS ROSTERS
The next step is to create teacher accounts and class rosters in one of the following three ways.
        
    - The quickest and most convenient way to create teacher accounts is to submit your student list with additional columns for “teacher name” and “teacher e-mail.” As soon as I receive it, I'll create teacher accounts and assign students to class rosters for you. 
    - You can create teacher accounts yourself from the “Teachers” page in your admin account. Once their accounts are created, each teacher will receive an        
    - You can instruct teachers to create their own accounts by sharing the attached activation instructions with them. Once their accounts are created, teachers can follow the instructions found in our Teacher Quick-start Guide to set up their class rosters.
    
Teachers who have trial accounts should follow the attached instructions under the heading, "If you already have a trial account," to ensure that their trial is successfully merged into your new subscription.

GETTING STARTED TOOLKIT FOR ADMINISTRATORS
Need help getting started? We've created a toolkit of resources to help administrators get their school set up using IXL.

    - Administrator Quick-start Guide - https://www.ixl.com/userguides/IXLQuickStart_Administrator.pdf - The illustrated guide provides step-by-step instructions for how to manage student accounts and run school-wide reports.
    - Frequently Asked Questions - https://www.ixl.com/help-center/School-administrators/665924 - Need more help? IXL's Help Center offers answers to commonly asked questions.

In addition to the resources listed above, our Professional Learning team offers customized professional development services for you and your teachers. Check out IXL's Professional Learning  to discover how our extensive professional development services can help your school have the best IXL experience possible!
    
Please feel free to reach out and let me know if you'd like assistance setting up teacher accounts, or if there is anything I can do to help you get started. 

I look forward to working with you this year!       
    )
;1.02 New Setup (Teacher info included, students not attached)
::x102::
(
Thanks for submitting  your student list. I have uploaded your master roster and created student and teacher accounts.  

Your admin account information has been sent to XXXXX in a separate e-mail. From your admin account you will be able to manage student and teacher accounts, and monitor student performance.  

You can access [ORG NAME's] sign-in page at XXXX.  Your custom sign-in page allows for simple and personalized access to IXL for administrators, teachers, and students. I recommend bookmarking this page for your students!

TEACHER ACCOUNTS AND CLASS ROSTERS
Your teachers' accounts have been created, and each teacher will receive an e-mail confirming their account information. New teachers can create accounts at any time by following the attached instructions. 

    - The next step is to create class rosters, in one of the following ways. 
    - The quickest and most convenient way to create class rosters is to submit your student list with additional columns for “teacher name.” As soon as I receive it, I'll upload it and assign students to teachers for you. 
    - Teachers can set-up their own class rosters by following the instructions found in our Teacher Quick-start Guide. Please share these instructions with your teachers.

Teachers who have trial accounts may now merge into your new subscription by following the attached instructions under the heading, "If you already have a trial account.”

Once students are rostered they are ready to  begin practicing and teachers will be able to begin monitoring their progress right away!
 
GETTING STARTED TOOLKIT FOR ADMINISTRATORS
Need help getting started? We've created a toolkit of resources to help you, as an administrator, get your school set up using IXL.
    - Administrator Quick-start Guide - https://www.ixl.com/userguides/IXLQuickStart_Administrator.pdf - The illustrated guide provide step-by-step instructions for how to manage student accounts and run school-wide reports.
    - Frequently Asked Questions - https://www.ixl.com/help-center/School-administrators/665924 - Need more help? IXL's Help Center offers answers to common questions.

In addition to the resources listed above, our Professional Learning team offers customized professional development services for you and your teachers. Check out IXL's Professional Learning to discover how our extensive professional development services can help your school have the best IXL experience possible!
    
Please feel free to reach out and let me know if you'd like assistance setting up teacher accounts, or if there is anything I can do to help you get started. 

I look forward to working with you this year!

    )

;1.03 New Setup (Students attached to teachers)
::x103::
(
Congratulations - your student and teacher accounts have been created, and your class rosters are in place! Students can begin practicing and teachers will be able to begin monitoring their progress right away.

Your admin account information has been sent to XXXXX in a separate e-mail. From your admin account you will be able to manage student and teacher accounts, and monitor student performance.  

You can access [ORG NAME's] sign-in page at XXXXXXXX. Your custom sign-in page allows for simple and personalized access to IXL for administrators, teachers, and students. I recommend bookmarking this page for your students!

Teachers will also receive e-mails confirming their account information. New teachers can create accounts at any time by following the attached instructions. 

Teachers who have trial accounts should follow the attached instructions under the heading, "If you already have a trial account," to ensure that their trial is successfully merged into your new subscription.
 
GETTING STARTED TOOLKIT FOR ADMINISTRATORS 
Need help getting started? We've created a toolkit of resources to help you, as anadministrator, get your school set up using IXL.
    - Administrator Quick-start Guide - https://www.ixl.com/userguides/IXLQuickStart_Administrator.pdf - The illustrated guide provide step-by-step instructions for how to manage student accounts and run school-wide reports.
    - Frequently Asked Questions - https://www.ixl.com/help-center/School-administrators/665924 - Need more help? IXL's Help Center offers answers to common questions.

In addition to the resources listed above, our Professional Learning Group offers customized professional development services for you and your teachers. Check out IXL's Professional Learning to discover how our extensive professional development services can help your school have the best IXL experience possible!
    
Please let me know if you have any questions - I'm happy to be a resource for you and your teachers so feel free to contact me anytime!

    )

;1.04 Students Added (Teacher info NOT included)
::x104::
(
Thanks for submitting your student list. I have created accounts for your students, and you can view their usernames and passwords on your master roster. 

The next step is to create teacher accounts and class rosters in one of the following three ways. 
    - The quickest and most convenient way to create teacher accounts is to submit your student list with additional columns for “teacher name” and “teacher e-mail.” As soon as I receive it, I'll create teacher accounts and assign students to class rosters for you. 
    - You can create teacher accounts yourself from the “Teachers” page in your admin account. Once their accounts are created, each teacher will receive an e-mail with steps to access their accounts and set up their class rosters. 
    - You can instruct teachers to create their own accounts by sharing the attached activation instructions with them. Once their accounts are created, teachers can follow the instructions found in our Teacher Quick-start Guide to set up their class rosters.

Let me know if you have any questions. I look forward to hearing from you!

    )

;1.05 Students Added (Teacher info included)
::x105::
(
Thanks for submitting your student and teacher information. I have created accounts for your new students and uploaded them to their teachers' rosters. 

New teachers have been sent their login information. Once logged in, teachers can view their students' usernames and passwords on their rosters. You can also view students' login information through the master roster in your admin account. 

Let me know if you have any questions or if there's anything else I can assist you with!

    )

;1.06 Deactivation
::x106::
(
Thanks for submitting your student list. I have removed those students from your subscription, and the licenses are now free to use for new students. 

Let me know if you have any questions!
    )

;1.07 Reactivation
::x107::
(
Thanks for submitting your student list. I have reactivated those students to your subscription and they are now free to begin practicing once again. Additionally, their teacher can now pull them onto their roster to start monitoring their practice.

Let me know if there's anything else I can help you with!
    )


;----------------------------------- CORRECTIONS -------------------------------------------------------------------------------------------------------------

;2.01 MISSING STUDENT IDS
::x201::
(
Thanks for submitting your student list. 

I noticed that your spreadsheet does not contain student ID numbers. In order to upload your student list, I will need a unique student ID assigned to each student. We ask for student IDs so that we can uniquely identify each student account on your license to prevent duplicate accounts. Do you have any type of unique identifier such as a school assigned student number of a lunch pin/library card number?

Please submit an updated list, including an ID number and I'll be happy to upload the student list and create student accounts right away. I look forward to hearing from you soon!

    )

;2.02 MISSING GRADE LEVELS
::x202::
(
Thanks for submitting your student list. 

I noticed that your spreadsheet does not contain grade levels for students. We ask for grade levels to ensure that the students receive proper access to your IXL subscription. 

Please send me an updated list, including grade levels, and I'll be happy to upload the student list and create student accounts right away. I look forward to hearing from you soon!

    )

;2.03 MISSING BOTH
::x203::
(
Thanks for submitting your student list. 

I noticed that your spreadsheet does not contain student ID numbers nor grade levels. We ask for student IDs so that we can uniquely identify each student account on your license to prevent duplicate accounts. Additionally, we ask for grade levels to ensure that the students receive proper access to your IXL subscription. 

Please send me an updated list, including grade levels and student IDs, and I'll be happy to upload the student list and create student accounts right away. I look forward to hearing from you soon!

    )

;2.04 MISSING SCHOOL 
::x204::
(
Thanks for submitting your student list. 

I noticed that your spreadsheet does not contain schools. In order to upload your student list, I will need a school listed for each student. Since you have a district subscription we will need to separate the students according to their school/campus.

Please send me an updated list, including schools and I'll be happy to upload the student list and create student accounts right away. I look forward to hearing from you soon!

    )

;2.05 MISSING CUSTOM LABEL
::x205::
(
Thanks for submitting your student list. 

I noticed that your spreadsheet does not contain custom labels. In order to upload your student list, I will need the custom label [CUSTOM LABEL] assigned to each student that will need access to [SUBJECTS]. We ask for a custom label so that we can separate students according to specific bundles to ensure they get access to the correct subjects.

Please send me an updated list, including the custom label and I'll be happy to upload the student list and create student accounts right away. I look forward to hearing from you soon!

    )

;2.06 TOO MANY STUDENTS
::x206::
(
Thanks for your message. I see that your list includes ### students, while your subscription was purchased for ### student licenses. Should all of the students on the list provided have IXL accounts? If not, please send me an updated list and I'll be happy to update your master roster for you.

If you'd like all students to have access, and are interested in finding out more about purchasing additional licenses, I'll be happy to put you in touch with REPSNAME, your sales coordinator.

I look forward to hearing from you soon.

    )

;2.07 Incorrect File Format (PDF or Word)
::x207::
(
Thank you for submitting your roster. 

I see that your file is not an Excel document and that is the only file type that our system will accept. For your convenience, I have attached a template of the file format that I need to get your students set up. 

Once the file is ready, please submit it through our secure uploading page using the following link: XXXX

I look forward to hearing from you and helping you get started with IXL!

    )

;2.08 Incorrect File Format (Google Sheet)
::x208::
(
Thanks for submitting your student list. 

I'm afraid I'm unable to access your Google Sheet. In order to upload I will need your document in an Excel file. To do download your Google Sheet as an Excel file, please follow these steps: 
    1. Click on "File"
    2. Select "Download As"
    3. Select the Excel  format. 

Once the file is ready, please submit it through our secure uploading page using the following link: XXXX

I look forward to hearing from you and helping you get started with IXL!

    )

;2.09 Incorrect File Format (Body of E-Mail)
::x209::
(
Thank you for reaching out! 

We have recently updated our security and privacy practices and we are no longer able to accept student information in the body of an e-mail. There are two options for adding new students:

    1. Sign in to an admin or teacher account. Go to the roster and click, "add new student". Then simply type in the student information and they will be added!

    2. Submit an Excel spreadsheet through the secure file upload page with the following student information in separate columns of an Excel file:
        - First Name
        - Last Name
        - Grade
        - ID Number
        - Teacher Email

    )
;----------------------------------- HOW TO -------------------------------------------------------------------------------------------------------------

;3.01 Add Students-ADMIN
::x301::
(
Thank you for reaching out! The easiest way to add students is through our new tool available in your administrator account  to ensure security and privacy for your data. You can simply click the  “Upload roster files” link found under the Account Management tab to access a secure upload page for all of your student and teacher information. 

If you would like to add them yourself, here are the steps you can take to add students. You can also see this through our Setting Up Your Roster guide here: https://www.ixl.com/userguides/IXLQuickStart_SiteRoster.pdf 
    1. Go to the Account Management tab
    2. Click on the Students page
    3. Click “Add new students” at the top of the page
    4. Enter the student's information 
    5. Click “Submit” 

Teachers can now pull this student onto their rosters by doing the following:
    1. Click on their name in the top right corner of the page
    2. Click on “Roster”
    3. Click “Add students” at the bottom of the page
    4. Begin to enter the student's last name. If the student appears, click on their name to add them to your roster.
    5. If they do not appear, type in their information and click “Save”

If you would like to find out more about your admin account check out some of our helpful links:

Administrator Frequently Asked Questions - https://www.ixl.com/help-center/School-administrators/665924 

Administrator Quick-Start Guide - https://www.ixl.com/userguides/IXLQuickStart_Administrator.pdf 

Please let me know if you have any other questions or problems with this process and I will be happy to answer them.

    )

;3.02 Remove students-ADMIN
::x302::
(
Thank you for reaching out! Admins can remove students through their admin account by doing the following:

    1. Sign into your administrator account
    2. Go to the Account Management tab
    3. Click on the Students page
    4. Find the student
    5. Click the red "X" in that student's row

The student is now deactivated and you may delete another in the same manner. Please note that student accounts can be retrieved and added back to your roster if necessary.

If you would like to remove a number of students, we can remove them for you by using our new tool available in your administrator account  to ensure security and privacy for your data. You can simply click the  “Upload roster files” link found under the Account Management tab to access a secure upload page. Just click the “Remove these students/teachers from my roster” option once you have submitted the file. 

Please let me know if you have any other questions or problems with this process and I will be happy to answer them. Feel free to check out our Administrator Frequently Asked Questions page as well for more administrator related questions.

    )

;3.03 Add students to roster-TEACHER
::x303::
(
Thank you for reaching out! You can use our Setting Up Your Roster Guide to help guide you in this process as well. 

Here is how you can add students to your teacher roster. 

    1. Sign in to your IXL account
    2. Click the drop-down menu at the top-right of the screen 
    3. Click "Roster"
    4. Click “Add Students” at the bottom of the page
    5. Type your student's name into the blank entry field that appears. 

If the student is already on your school's master roster, their name will auto-populate, and all you have to do is click to add them!

If the student is not on the master roster, simply type their full information into the blank entry fields, then click "Save". This will add the student to your teacher roster and to your school's master roster.

Please let me know if you have any other questions or problems with this process and I will be happy to answer them.

    )

;3.04 Assign students to teacher-ADMIN
::x304::
(
Thanks for reaching out! Although there isn't a way to build class rosters through the admin account, we do recognize the need for this feature. In the meantime, students can be added to teacher rosters in one of two ways:

The quickest and most convenient way is for me to set them up for you! You can simply click the  “Upload roster files” link found under the Account Management tab to access a secure upload page for all of your student and teacher information. Just submit the following information in separate columns of an Excel file: 
    - First name
    - Last name
    - Student ID number
    - Grade level
    - Student e-mail (recommended)
    - Preferred password (optional)
    - Teacher last name (this column will allow us to add students to teachers' rosters) 
As soon as I receive it, I'll upload the information and add students to class rosters for you. 

Through each teacher's account, they can follow these steps: 
    1. Go to the Roster tab
    2. Click on “Add students” at the bottom of the class roster
    3. In the “Last name” field, begin to type in the student's last name
    4. Choose the student from the drop-down menu - this will auto-populate the rest of the student's information
    5. If the student does not show up in the drop-down menu, then the student will need an account created. Enter the student's information and click “Save.” If you are unsure what the student's ID is, please check with your IXL admin.
If you would like a simple guide to send to teachers click here: Teacher Quick-start Guide

Please let me know if you have any other questions or problems with this process and I will be happy to answer them.
 
    )

;3.05 Make classes-TEACHER
::x305::
(
Thank you for reaching out! Teachers can create classes within their rosters by taking the following steps: 
    1. From your account menu in the upper-right corner, select “Roster”. 
    2. Click "Start using classes" on the right side of the page, just above your roster. If this link is unavailable, it has already been clicked and you can skip to step 5. 
    3. Type in a name for each class you would like to create. 
    4. Click "Submit." Your classes have now been created! 
    5. Click on the blank space in a student's "Class" column to choose a class in which to place that student. 
    6. Click "Save" after you have selected the class. 
    7. To create additional classes, click on the blank space in a student's "Class" column and click "Add a class." 

Please let me know if you have any other questions or problems with this process and I will be happy to answer them.

    )

;3.06 Add new admin
::x306::
(
Thank you for reaching out! You can add a new administrator for your account by following these steps:
    1. Sign in to your IXL admin account
    2. Go to "account management"
    3. Select the "administrators" tab 
    4. Press "add new administrator"
This new account will then receive their credentials automatically after you add them. 

If you would like to find out more about your admin account check out some of our helpful links:

Administrator Frequently Asked Questions - https://www.ixl.com/help-center/School-administrators/665924 

Administrator Quick-Start Guide - https://www.ixl.com/userguides/IXLQuickStart_Administrator.pdf 

Please let me know if you have any other questions or problems with this process and I will be happy to answer them.

    )

;3.07 Add multiple teachers for students
::x307::
(
Thank you for reaching out! To add multiple teachers for one student in your Excel sheet please add additional columns in your student list for each additional teacher. You can title each column “Teacher 1”, “Teacher 2”, etc. 
 
Please let me know if you have any other questions or problems with this process and I will be happy to answer them.

    )

;3.08 Add a custom label
::x308::
(
Thank you for reaching out! You're welcome to adjust students' access through your admin account by doing the following:
    
    1. Go to the Students page under the Account management tab
    2. Click in the Custom Label column for a student
    3. Select the "XXXX" label
    4. Click "Save"

Please let me know if you have any other questions or problems with this process and I will be happy to answer them.

    )

;3.09 Set up for the Fall
::x309::
(
Thank you for reaching out! When you're ready to prepare your account for the new school year, send us an updated master student list, I'll be happy to update your master roster and class rosters. Please submit the following information using the secure file uploader tool (LINK) I would need the following student information in separate columns of an Excel file:

    - First name
    - Last name
    - Student ID number
    - Grade
    - Teacher name 
    - Teacher e-mail 
    - Student or parent e-mail (recommended)
    - School (for district licenses)

Alternatively, you have access to the Fall setup tool which will help you promote students one grade level, clear class rosters, and submit new students. To access this tool:
   1. Log into your admin account
   2. Go to the Students page
   3. Click on "Set up for the new school year" at the top of the page
If you do not complete these steps by 2 weeks before your first day of school, the tool will automatically make the changes for you. 

Please let me know if you have any other questions or problems with this process and I will be happy to answer them.

    )

*/