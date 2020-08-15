#SingleInstance, Force
SendMode Input
SetWorkingDir, %A_ScriptDir%

class TimerHelper
{
    __New(timings, alerts, initial_dialogue){
        this.timings := timings
        this.initial_dialogue := initial_dialogue        
        this.timer_functions := []
        for index, element in alerts ; Enumeration is the recommended approach in most cases.
        {
            this.timer_functions.Push(ObjBindMethod(this, "TimerFunction", element))
        }        

    }

    StartTimers(){
        ComObjCreate("SAPI.SpVoice").Speak(this.initial_dialogue)
        for index, element in this.timings ; Enumeration is the recommended approach in most cases.
        {
            timer := this.timer_functions[index]
            timer_interval := element * 1000
            SetTimer, % timer, Off
            SetTimer, % timer, % timer_interval
        }
    }

    TimerFunction(dialogue) {
        ComObjCreate("SAPI.SpVoice").Speak(dialogue)
        SetTimer,, Off
    }
    
}

red_timer := new TimerHelper([15, 25], ["Red 10 seconds", "Red now"], "Starting Red Timer")
mega_timer := new TimerHelper([25, 35], ["Mega 10 seconds", "Mega now"], "Starting Mega Timer")


#IfWinActive, ahk_exe diabotical.exe
1::
red_timer.StartTimers()
return
2::
mega_timer.StartTimers()
return
#IfWinActive