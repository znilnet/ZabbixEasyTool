#include <Array.au3>
#include <Date.au3>
#include <GUIConstantsEx.au3>
#include <ButtonConstants.au3>
#include <TabConstants.au3>
#include <WindowsConstants.au3>
AutoItSetOption("MustDeclareVars", 1)
Opt("GUIOnEventMode", 1)

#Region Variablen
; #####################################################################################
;   ##     ##    ###    ########  ####    ###    ########  ##       ######## ##    ##
;   ##     ##   ## ##   ##     ##  ##    ## ##   ##     ## ##       ##       ###   ##
;   ##     ##  ##   ##  ##     ##  ##   ##   ##  ##     ## ##       ##       ####  ##
;   ##     ## ##     ## ########   ##  ##     ## ########  ##       ######   ## ## ##
;    ##   ##  ######### ##   ##    ##  ######### ##     ## ##       ##       ##  ####
;     ## ##   ##     ## ##    ##   ##  ##     ## ##     ## ##       ##       ##   ###
;      ###    ##     ## ##     ## #### ##     ## ########  ######## ######## ##    ##
;~ ####################################################################################
#EndRegion Variablen

#Region Funktionen
; ###############################################################################################################################################################################################
;   ######## ##     ## ##    ## ##    ## ######## ####  #######  ##    ## ######## ##    ##
;   ##       ##     ## ###   ## ##   ##     ##     ##  ##     ## ###   ## ##       ###   ##
;   ##       ##     ## ####  ## ##  ##      ##     ##  ##     ## ####  ## ##       ####  ##
;   ######   ##     ## ## ## ## #####       ##     ##  ##     ## ## ## ## ######   ## ## ##
;   ##       ##     ## ##  #### ##  ##      ##     ##  ##     ## ##  #### ##       ##  ####
;   ##       ##     ## ##   ### ##   ##     ##     ##  ##     ## ##   ### ##       ##   ###
;   ##        #######  ##    ## ##    ##    ##    ####  #######  ##    ## ######## ##    ##
; ###############################################################################################################################################################################################
Func FormMainClose()
	Exit
EndFunc
Func FormMainMinimize()

EndFunc
Func FormMainRestore()

EndFunc

Func FormSetupButtonCancelClick()

EndFunc
Func FormSetupButtonHelpClick()

EndFunc
Func FormSetupButtonOKClick()

EndFunc
Func FormSetupClose()

EndFunc
Func FormSetupMinimize()

EndFunc
Func FormSetupRestore()

EndFunc
#EndRegion Funktionen



; ###############################################################################################################################################################################################
;    ######   ##     ## ####
;   ##    ##  ##     ##  ##
;   ##        ##     ##  ##
;   ##   #### ##     ##  ##
;   ##    ##  ##     ##  ##
;   ##    ##  ##     ##  ##
;    ######    #######  ####
; ###############################################################################################################################################################################################



Global $FormMain, $FormMainPicStatus, $FormMainListViewTriggers
#Region ### START Koda GUI section ### Form=C:\_AutoIt\ZabbixEasyTool\FormMain.kxf
$FormMain = GUICreate("ZabbixEasyTool", 405, 293, 611, 232, BitOR($GUI_SS_DEFAULT_GUI,$WS_SIZEBOX,$WS_THICKFRAME), BitOR($WS_EX_TOPMOST,$WS_EX_WINDOWEDGE))
GUISetOnEvent($GUI_EVENT_CLOSE, "FormMainClose")
GUISetOnEvent($GUI_EVENT_MINIMIZE, "FormMainMinimize")
GUISetOnEvent($GUI_EVENT_RESTORE, "FormMainRestore")
$FormMainPicStatus = GUICtrlCreatePic("", 0, 0, 404, 84)
$FormMainListViewTriggers = GUICtrlCreateListView("", 0, 120, 402, 134)
GUISetState(@SW_SHOW)
#EndRegion ### END Koda GUI section ###



#Region ### START Koda GUI section ### Form=C:\_AutoIt\ZabbixEasyTool\FormSetup.kxf
$FormSetup = GUICreate("Setup - ZabbixEasyTool", 414, 308, -1, -1)
GUISetOnEvent($GUI_EVENT_CLOSE, "FormSetupClose")
GUISetOnEvent($GUI_EVENT_MINIMIZE, "FormSetupMinimize")
GUISetOnEvent($GUI_EVENT_RESTORE, "FormSetupRestore")
$FormSetupPageControl = GUICtrlCreateTab(8, 8, 396, 256)
$TabSheet1 = GUICtrlCreateTabItem("Zabbix API")
$TabSheet2 = GUICtrlCreateTabItem("Maintenance")
$TabSheet3 = GUICtrlCreateTabItem("Trigger")
GUICtrlCreateTabItem("")
$FormSetupButtonOK = GUICtrlCreateButton("&OK", 166, 272, 75, 25)
GUICtrlSetOnEvent($FormSetupButtonOK, "FormSetupButtonOKClick")
$FormSetupButtonCancel = GUICtrlCreateButton("&Cancel", 246, 272, 75, 25)
GUICtrlSetOnEvent($FormSetupButtonCancel, "FormSetupButtonCancelClick")
$FormSetupButtonHelp = GUICtrlCreateButton("&Help", 328, 272, 75, 25)
GUICtrlSetOnEvent($FormSetupButtonHelp, "FormSetupButtonHelpClick")
GUISetState(@SW_SHOW)
#EndRegion ### END Koda GUI section ###







While 1
	Sleep(100)
WEnd


