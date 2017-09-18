#include <Array.au3>
#include <Date.au3>
#include <GUIConstantsEx.au3>
#include <ButtonConstants.au3>
#include <TabConstants.au3>
#include <WindowsConstants.au3>
#include <ComboConstants.au3>
#include <EditConstants.au3>
#include <ListBoxConstants.au3>
#include <StaticConstants.au3>
#include <GuiTab.au3>
#include <GuiListView.au3>
#include <Misc.au3>
#include <GDIPlus.au3>
#include "resources.au3"

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

; Für die FormMain
Global $FormMain, $FormMainPicStatus, $FormMainListViewTriggers, $FormMainLabelStatusLine1, $FormMainComboTimes, $FormMainButtonMaintenanceSet
Global $FormMainButtonMaintenanceDelete, $FormMainButtonAcknowledge, $FormMainButtonSetup, $FormMainLabelStatusLine2, $FormMainLabelStatusLine3


; Für die FormSetup
Global $FormSetup
Global $FormSetupPageControl
Global $FormSetupTabSheetZabbixAPI, $FormSetupAPIInputURL, $FormSetupAPILabelURL, $FormSetupAPILabelUsername, $FormSetupAPIInputUsername, $FormSetupAPILabelPassword, $FormSetupAPIInputPassword, $FormSetupAPIButtonTestCredentials
Global $FormSetupAPILabelCredentialsTest, $FormSetupAPILabelHost, $FormSetupAPIInputHost, $FormSetupAPIButtonReadDataZabbixAgent
Global $FormSetupTabSheetMaintenance, $FormSetupMaintenanceLabelPrefix, $FormSetupMaintenanceInputPrefix, $FormSetupMaintenanceLabelDescription, $FormSetupMaintenanceInputDescription, $FormSetupMaintenanceListTimes
Global $FormSetupMaintenanceButtonAdd, $FormSetupMaintenanceInputTime, $FormSetupMaintenanceButtonDelete, $FormSetupMaintenanceLabelTimes, $FormSetupMaintenanceComboUnit
Global $FormSetupTabSheetTrigger
Global $FormSetupTriggerLabelNotclassified, $FormSetupTriggerInputNotclassified, $FormSetupTriggerLabelColorNotclassified, $FormSetupTriggerInputColorNotclassified
Global $FormSetupTriggerLabelInformation, $FormSetupTriggerInputInformation, $FormSetupTriggerLabelColorInformation, $FormSetupTriggerInputColorInformation
Global $FormSetupTriggerLabelWarning, $FormSetupTriggerInputWarning, $FormSetupTriggerLabelColorWarning, $FormSetupTriggerInputColorWarning
Global $FormSetupTriggerLabelAverage, $FormSetupTriggerInputAverage, $FormSetupTriggerLabelColorAverage, $FormSetupTriggerInputColorAverage
Global $FormSetupTriggerLabelHigh, $FormSetupTriggerInputHigh, $FormSetupTriggerLabelColorHigh, $FormSetupTriggerInputColorHigh
Global $FormSetupTriggerLabelDisaster, $FormSetupTriggerInputDisaster, $FormSetupTriggerLabelColorDisaster, $FormSetupTriggerInputColorDisaster
Global $FormSetupTabSheetCheck, $FormSetupCheckLabelEvery1, $FormSetupCheckCheckboxMaintenanceStatus, $FormSetupCheckComboTimesMaintenance, $FormSetupCheckCheckboxTrigger, $FormSetupCheckLabelEvery2, $FormSetupCheckComboTimesTrigger
Global $FormSetupTabSheetAcknowledge, $FormSetupAcknowledgeLabelDefaultMessage, $FormSetupAcknowledgeEditDefaultMessage, $FormSetupAcknowledgeCheckboxCloseProblems, $FormSetupAcknowledgeCheckboxNeverAsk
Global $FormSetupTabSheetInfo, $FormSetupInfoLabelVersionLeft, $FormSetupInfoLabelDateTimeLeft, $FormSetupInfoLabelAutorLeft, $FormSetupInfoLabelHomepageLeft, $FormSetupInfoLabelRepositoryLeft
Global $FormSetupInfoLabelHomepageRight, $FormSetupInfoLabelRepositoryRight, $FormSetupInfoLabelAutorRight, $FormSetupInfoLabelLicenseLeft, $FormSetupInfoLabelLicenseRight
Global $FormSetupInfoLabelVersionRight, $FormSetupInfoLabelDateTimeRight
Global $FormSetupButtonOK, $FormSetupButtonCancel, $FormSetupButtonHelp, $FormSetupInfoEditGPOisActive

; Die Auswahl an Zeiten für die Maintenance
;                                       30m   1h     2h    4h     8h    24h     48h     72h
Global $g_a_MaintenanceTimes[9] = [ 8, 1800, 3600, 7200, 14400, 28800, 86400, 172800, 259200 ]
Local $s_temp = ""

; Für den Countdown bei aktiver Maintenance
Global $g_i_Countdown = 0

; Trigger
Global $g_a_zbxHostTriggers[1][5]
$g_a_zbxHostTriggers[0][0] = 0

; Tray Icon
Global $g_ico_CurrentTrayIcon
Global $g_Icon_green, $g_Icon_grey, $g_Icon_red, $g_Icon_TrayGreen, $g_Icon_TrayGrey, $g_Icon_TrayRed
Global $g_Tray_Headline, $g_Tray_ShowGUI, $g_Tray_Setup, $g_Tray_Exit
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
	GUISetState(@SW_HIDE, $FormMain)
EndFunc
Func FormMainMinimize()

EndFunc

; #############################################################################################################################################################
Func FormMainRestore()

EndFunc

; #############################################################################################################################################################
Func FormMainButtonMaintenanceSetClick()
	GUISetCursor(15, 1, $FormMain)
	GUICtrlSetState($FormMainButtonMaintenanceSet, $GUI_DISABLE)
	GUICtrlSetState($FormMainButtonMaintenanceDelete, $GUI_DISABLE)
	GUICtrlSetState($FormMainComboTimes, $GUI_DISABLE)
	Local $__zbxURL = GUICtrlRead($FormSetupAPIInputURL)
	Local $__zbxUser = GUICtrlRead($FormSetupAPIInputUsername)
	Local $__zbxPassword = GUICtrlRead($FormSetupAPIInputPassword)
	Local $__zbxHostname = GUICtrlRead($FormSetupAPIInputHost)
	Local $__zbxSessionId = _zbx_Login( $__zbxURL, $__zbxUser, $__zbxPassword)
	Local $__zbxHostId = _zbx_HostGetId($__zbxURL, $__zbxSessionId, $__zbxHostname)
	Local $__zbxName = _ReplaceEnviromentVariables(GUICtrlRead($FormSetupMaintenanceInputPrefix)) & "- " & $__zbxHostname & " -- " & @YEAR & "-" & @MON & "-" & @MDAY & " - " & @HOUR & ":" & @MIN & ":" & @SEC
	Local $__zbxDescription = _ReplaceEnviromentVariables(GUICtrlRead($FormSetupMaintenanceInputDescription))
	Local $__zbxDurationTime = _TimeToSeconds(GUICtrlRead($FormMainComboTimes))
	If _zbx_HostAddMaintenance($__zbxURL, $__zbxSessionId, $__zbxHostId, $__zbxName, $__zbxDescription, $__zbxDurationTime) <> "" Then
		Sleep(1000)
		TrayTip("Maintenance set", $__zbxName & @CRLF & $__zbxDescription & _SecondsToTime($__zbxDurationTime),30)
		_CheckMaintenanceStatus()
	Else
		GUICtrlSetBkColor($FormMainLabelStatusLine1, 0xFF0000)
		GUICtrlSetData($FormMainLabelStatusLine1, "API ERROR")
		GUICtrlSetBkColor($FormMainLabelStatusLine2, 0xFF0000)
		GUICtrlSetData($FormMainLabelStatusLine2, "Failure adding Maintenance")
	EndIf
	If $__zbxSessionId <> "" Then
		_zbx_Logout( $__zbxURL, $__zbxSessionId)
	EndIf
	GUICtrlSetState($FormMainButtonMaintenanceSet, $GUI_ENABLE)
	GUICtrlSetState($FormMainButtonMaintenanceDelete, $GUI_ENABLE)
	GUICtrlSetState($FormMainComboTimes, $GUI_ENABLE)
	GUISetCursor("", 1, $FormMain)
EndFunc


; #############################################################################################################################################################
Func FormMainButtonMaintenanceDeleteClick()
	GUISetCursor(15, 1, $FormMain)
	GUICtrlSetState($FormMainButtonMaintenanceSet, $GUI_DISABLE)
	GUICtrlSetState($FormMainButtonMaintenanceDelete, $GUI_DISABLE)
	GUICtrlSetState($FormMainComboTimes, $GUI_DISABLE)
	Local $__zbxURL = GUICtrlRead($FormSetupAPIInputURL)
	Local $__zbxUser = GUICtrlRead($FormSetupAPIInputUsername)
	Local $__zbxPassword = GUICtrlRead($FormSetupAPIInputPassword)
	Local $__zbxHostname = GUICtrlRead($FormSetupAPIInputHost)
	Local $__zbxSessionId = _zbx_Login( $__zbxURL, $__zbxUser, $__zbxPassword)
	Local $__zbxHostId = _zbx_HostGetId($__zbxURL, $__zbxSessionId, $__zbxHostname)
	Local $__aMaintenanceIds = _zbx_HostGetMaintenanceIDs($__zbxURL, $__zbxSessionId, $__zbxHostId, _ReplaceEnviromentVariables(GUICtrlRead($FormSetupMaintenanceInputPrefix)))
;~ 	_ArrayDisplay($__aMaintenanceIds, "$__aMaintenanceIds")
		; $__aMaintenanceIds[x][1] = Id
		; $__aMaintenanceIds[x][2] = Name
		; $__aMaintenanceIds[x][3] = active_since
		; $__aMaintenanceIds[x][4] = active_till
	If $__aMaintenanceIds[0][0] > 0 Then
		For $i = 1 To $__aMaintenanceIds[0][0] Step 1
;~ 			ConsoleWrite("$i = " & $i & @CRLF)
			If _zbx_HostRemoveMaintenance($__zbxURL, $__zbxSessionId, $__zbxHostId, $__aMaintenanceIds[$i][1]) = $__aMaintenanceIds[$i][1] Then
				; Maintenance was deleted!
;~ 				ConsoleWrite("Deleted: " & $__aMaintenanceIds[$i][1] & @CRLF)
			Else
;~ 				ConsoleWrite("Error deleting" & $__aMaintenanceIds[$i][1] & @CRLF)
				; There was an error!
			EndIf
		Next
	EndIf
	If $__zbxSessionId <> "" Then
		_zbx_Logout( $__zbxURL, $__zbxSessionId)
	EndIf
	GUICtrlSetState($FormMainButtonMaintenanceSet, $GUI_ENABLE)
	GUICtrlSetState($FormMainButtonMaintenanceDelete, $GUI_ENABLE)
	GUICtrlSetState($FormMainComboTimes, $GUI_ENABLE)
	Sleep(1000)
	_CheckMaintenanceStatus()
	GUISetCursor("", 1, $FormMain)
EndFunc

; #############################################################################################################################################################
Func FormMainButtonAcknowledgeClick()
	GUICtrlSetState($FormMainButtonAcknowledge, $GUI_DISABLE)
	Local $__zbxURL = GUICtrlRead($FormSetupAPIInputURL)
	Local $__zbxUser = GUICtrlRead($FormSetupAPIInputUsername)
	Local $__zbxPassword = GUICtrlRead($FormSetupAPIInputPassword)
	Local $__zbxHostname = GUICtrlRead($FormSetupAPIInputHost)
	Local $__zbxSessionId = _zbx_Login( $__zbxURL, $__zbxUser, $__zbxPassword)
	Local $__bSkip = False
;~ 	Local $__zbxHostId = _zbx_HostGetId($__zbxURL, $__zbxSessionId, $__zbxHostname)
	;~ 	$__a_zbxHostTriggers[0][0] = 0
	;~ 	$__a_zbxHostTriggers[0][1] = "triggerid"
	;~ 	$__a_zbxHostTriggers[0][2] = "description"
	;~ 	$__a_zbxHostTriggers[0][3] = "priority"
	; Schritt 1: Welcher Trigger ist markiert?
	Local $__hListViewItem = GUICtrlRead($FormMainListViewTriggers)
	If $__hListViewItem > 0 Then
;~ 		_ArrayDisplay($g_a_zbxHostTriggers)
		For $i = 1 To $g_a_zbxHostTriggers[0][0]
			If $g_a_zbxHostTriggers[$i][4] = $__hListViewItem Then
				Local $__a_Events = _zbx_TriggerEventGet($__zbxURL, $__zbxSessionId, $g_a_zbxHostTriggers[$i][1])
;~ 				_ArrayDisplay($__a_Events)
				Local $__sMessageText = _ReplaceEnviromentVariables(GUICtrlRead($FormSetupAcknowledgeEditDefaultMessage))
				If $__sMessageText = "" Then
					$__sMessageText = "ZabbixEasyTool - no Message by User"
				EndIf
				If GUICtrlRead($FormSetupAcknowledgeCheckboxNeverAsk) <> $GUI_CHECKED Then
;~ 					MsgBox(64,"","Brauchen InputBox!")
					;InputBox features: Title=Yes, Prompt=Yes, Default Text=Yes, Mandatory
					AutoItSetOption("GUIOnEventMode", 0)
					Local $FormAcknowledge = GUICreate("Acknowledge Trigger", 434, 205, -1, -1)
					GUISetFont(10, 400, 0, "Arial")
					Local $FormAcknowledgeButtonOK = GUICtrlCreateButton("&OK", 270, 171, 75, 25)
					Local $FormAcknowledgeButtonCancel = GUICtrlCreateButton("&Cancel", 349, 172, 75, 25)
					Local $FormAcknowledgeLabelMessageText = GUICtrlCreateLabel("Default Message Text", 4, 5, 130, 20)
					Local $FormAcknowledgeEditMessage = GUICtrlCreateEdit("", 4, 29, 425, 137)
					GUICtrlSetData($FormAcknowledgeEditMessage, $__sMessageText)
					GUISetState(@SW_SHOW, $FormAcknowledge )
					WinSetOnTop($FormAcknowledge, "", $WINDOWS_ONTOP)
					Local $__nMsg
					While 1
						$__nMsg = GUIGetMsg()
						Switch $__nMsg
							Case $GUI_EVENT_CLOSE, $FormAcknowledgeButtonCancel
								$__bSkip = True
								ExitLoop
							Case $FormAcknowledgeButtonOK
								If GUICtrlRead($FormAcknowledgeEditMessage) <> "" Then
									$__sMessageText = GUICtrlRead($FormAcknowledgeEditMessage)
								EndIf
								$__bSkip = False
								ExitLoop
						EndSwitch
					WEnd
					GUIDelete($FormAcknowledge)
					AutoItSetOption("GUIOnEventMode", 1)
				EndIf
				For $j = 1 To $__a_Events[0] Step 1
					Local $__result = _zbx_EventAcknowledge($__zbxURL, $__zbxSessionId, $__a_Events[$j], StringReplace($__sMessageText, @CRLF, "\n"))
				Next
				ExitLoop
			EndIf
		Next
	EndIf
	If $__zbxSessionId <> "" Then
		_zbx_Logout( $__zbxURL, $__zbxSessionId)
	EndIf
	GUICtrlSetState($FormMainButtonAcknowledge, $GUI_ENABLE)
	_CheckTriggerStatus()
EndFunc
; #############################################################################################################################################################

Func FormMainButtonSetupClick()
	AdlibUnRegister("_CheckMaintenanceStatus")
	GUISetState(@SW_SHOW, $FormSetup)
	GUISetState(@SW_HIDE, $FormMain)
EndFunc

; #############################################################################################################################################################
Func FormMainLabelStatusClick()
	_CheckMaintenanceStatus()
EndFunc
; #############################################################################################################################################################
Func FormSetupAPIButtonReadDataZabbixAgentClick()
EndFunc

; #############################################################################################################################################################
Func FormSetupAPIButtonTestCredentialsClick()
EndFunc

; #############################################################################################################################################################
Func FormSetupButtonCancelClick()
	GUISetState(@SW_HIDE, $FormSetup)
	GUISetState(@SW_SHOW, $FormMain)
	If GUICtrlRead($FormSetupCheckCheckboxMaintenanceStatus) = $GUI_CHECKED Then
		AdlibRegister("_CheckMaintenanceStatus", _TimeToSeconds(GUICtrlRead($FormSetupCheckComboTimesMaintenance)) * 1000)
	EndIf
EndFunc

; #############################################################################################################################################################
Func FormSetupButtonHelpClick()
EndFunc

; #############################################################################################################################################################
; Alle Einstellungen in der Registry speichern
Func FormSetupButtonOKClick()
	_SettingsWrite()
	GUISetState(@SW_HIDE, $FormSetup)
	GUISetState(@SW_SHOW, $FormMain)
	If GUICtrlRead($FormSetupCheckCheckboxMaintenanceStatus) = $GUI_CHECKED Then
		_CheckMaintenanceStatus()
		AdlibRegister("_CheckMaintenanceStatus", _TimeToSeconds(GUICtrlRead($FormSetupCheckComboTimesMaintenance)) * 1000)
	EndIf
	If GUICtrlRead($FormSetupCheckCheckboxTrigger) = $GUI_CHECKED Then
		_CheckTriggerStatus()
		AdlibRegister("_CheckTriggerStatus", _TimeToSeconds(GUICtrlRead($FormSetupCheckComboTimesTrigger)) * 1000)
	EndIf
EndFunc

; #############################################################################################################################################################
Func FormSetupCheckCheckboxMaintenanceStatusClick()
	If GUICtrlRead($FormSetupCheckCheckboxMaintenanceStatus) = $GUI_CHECKED Then
		GUICtrlSetState($FormSetupCheckLabelEvery1, $GUI_ENABLE)
		GUICtrlSetState($FormSetupCheckComboTimesMaintenance, $GUI_ENABLE)
	Else
		GUICtrlSetState($FormSetupCheckLabelEvery1, $GUI_DISABLE)
		GUICtrlSetState($FormSetupCheckComboTimesMaintenance, $GUI_DISABLE)
	EndIf
EndFunc

; #############################################################################################################################################################
Func FormSetupCheckCheckboxTriggerClick()
	If GUICtrlRead($FormSetupCheckCheckboxTrigger) = $GUI_CHECKED Then
		GUICtrlSetState($FormSetupCheckLabelEvery2, $GUI_ENABLE)
		GUICtrlSetState($FormSetupCheckComboTimesTrigger, $GUI_ENABLE)
	Else
		GUICtrlSetState($FormSetupCheckLabelEvery2, $GUI_DISABLE)
		GUICtrlSetState($FormSetupCheckComboTimesTrigger, $GUI_DISABLE)
	EndIf
EndFunc

; #############################################################################################################################################################
Func FormSetupCheckComboTimesMaintenanceChange()
EndFunc

; #############################################################################################################################################################
Func FormSetupCheckComboTimesTriggerChange()
EndFunc

; #############################################################################################################################################################
Func FormSetupClose()
	FormSetupButtonCancelClick()
EndFunc

; #############################################################################################################################################################
Func FormSetupInfoLabelHomepageRightClick()
EndFunc

; #############################################################################################################################################################
Func FormSetupInfoLabelLicenseRightClick()
EndFunc

; #############################################################################################################################################################
Func FormSetupInfoLabelRepositoryRightClick()
EndFunc

; #############################################################################################################################################################
Func FormSetupMaintenanceButtonAddClick()
EndFunc

; #############################################################################################################################################################
Func FormSetupMaintenanceButtonDeleteClick()
EndFunc

; #############################################################################################################################################################
Func FormSetupMaintenanceComboUnitChange()
EndFunc

; #############################################################################################################################################################
Func FormSetupMaintenanceListTimesClick()
EndFunc

; #############################################################################################################################################################
Func FormSetupMinimize()
EndFunc

; #############################################################################################################################################################
Func FormSetupRestore()
EndFunc

; #############################################################################################################################################################
Func FormSetupTriggerInputColorAverageChange()
	_TriggerInputColor()
	GUICtrlSetBkColor($FormSetupTriggerLabelColorAverage, "0x" & GUICtrlRead($FormSetupTriggerInputColorAverage))
EndFunc

; #############################################################################################################################################################
Func FormSetupTriggerInputColorDisasterChange()
	_TriggerInputColor()
	GUICtrlSetBkColor($FormSetupTriggerLabelColorDisaster, "0x" & GUICtrlRead($FormSetupTriggerInputColorDisaster))
EndFunc

; #############################################################################################################################################################
Func FormSetupTriggerInputColorHighChange()
	_TriggerInputColor()
	GUICtrlSetBkColor($FormSetupTriggerLabelColorHigh, "0x" & GUICtrlRead($FormSetupTriggerInputColorHigh))
EndFunc

; #############################################################################################################################################################
Func FormSetupTriggerInputColorInformationChange()
	_TriggerInputColor()
	GUICtrlSetBkColor($FormSetupTriggerLabelColorInformation, "0x" & GUICtrlRead($FormSetupTriggerInputColorInformation))
EndFunc

; #############################################################################################################################################################
Func FormSetupTriggerInputColorNotclassifiedChange()
	_TriggerInputColor()
	GUICtrlSetBkColor($FormSetupTriggerLabelColorNotclassified, "0x" & GUICtrlRead($FormSetupTriggerInputColorNotclassified))
EndFunc

; #############################################################################################################################################################
Func FormSetupTriggerInputColorWarningChange()
	_TriggerInputColor()
	GUICtrlSetBkColor($FormSetupTriggerLabelColorWarning, "0x" & GUICtrlRead($FormSetupTriggerInputColorWarning))
EndFunc

; #############################################################################################################################################################
Func FormSetupTriggerLabelColorAverageClick()
	_TriggerChooseColor()
EndFunc

; #############################################################################################################################################################
Func FormSetupTriggerLabelColorDisasterClick()
	_TriggerChooseColor()
EndFunc

; #############################################################################################################################################################
Func FormSetupTriggerLabelColorHighClick()
	_TriggerChooseColor()
EndFunc

; #############################################################################################################################################################
Func FormSetupTriggerLabelColorInformationClick()
	_TriggerChooseColor()
EndFunc

; #############################################################################################################################################################
Func FormSetupTriggerLabelColorNotclassifiedClick()
	_TriggerChooseColor()
EndFunc

; #############################################################################################################################################################
Func FormSetupTriggerLabelColorWarningClick()
	_TriggerChooseColor()
EndFunc

; #############################################################################################################################################################
; #############################################################################################################################################################
; #############################################################################################################################################################
; #############################################################################################################################################################
Func _CheckMaintenanceStatus()
	AdlibUnRegister("_CountdownMaintenance")
	Local $__zbxURL = GUICtrlRead($FormSetupAPIInputURL)
	Local $__zbxUser = GUICtrlRead($FormSetupAPIInputUsername)
	Local $__zbxPassword = GUICtrlRead($FormSetupAPIInputPassword)
	Local $__zbxHostname = GUICtrlRead($FormSetupAPIInputHost)
	Local $__zbxSessionId = _zbx_Login( $__zbxURL, $__zbxUser, $__zbxPassword)
	If $__zbxSessionId = "" Then
		_SetLabelStatus(0xFF0000, "API Login", "Failure", "")
		GUICtrlSetState($FormMainButtonMaintenanceSet, $GUI_DISABLE)
		GUICtrlSetState($FormMainButtonMaintenanceDelete, $GUI_DISABLE)
		GUICtrlSetState($FormMainComboTimes, $GUI_DISABLE)
		_WinAPI_SetWindowTitleIcon($g_Icon_red, $FormMain)
		$g_ico_CurrentTrayIcon = $g_Icon_TrayRed
		Return
	EndIf
	_SetLabelStatus(Default , "", "Logged in ...", "")
	Local $__zbxHostId = _zbx_HostGetId($__zbxURL, $__zbxSessionId, $__zbxHostname)
	If $__zbxHostId = "" Then
		_SetLabelStatus(0xFF0000 , "Host not found:", $__zbxHostname, "")
		_zbx_Logout( $__zbxURL, $__zbxSessionId)
		GUICtrlSetState($FormMainButtonMaintenanceSet, $GUI_DISABLE)
		GUICtrlSetState($FormMainButtonMaintenanceDelete, $GUI_DISABLE)
		GUICtrlSetState($FormMainComboTimes, $GUI_DISABLE)
		_WinAPI_SetWindowTitleIcon($g_Icon_red, $FormMain)
		$g_ico_CurrentTrayIcon = $g_Icon_TrayRed
		Return
	EndIf
	_SetLabelStatus(Default , "", "Host found ..", "")
	GUICtrlSetState($FormMainButtonMaintenanceSet, $GUI_ENABLE)
	GUICtrlSetState($FormMainButtonMaintenanceDelete, $GUI_ENABLE)
	GUICtrlSetState($FormMainComboTimes, $GUI_ENABLE)
	Local $__aMaintenanceIds = _zbx_HostGetMaintenanceIDs($__zbxURL, $__zbxSessionId, $__zbxHostId, "")
;~ 	_ArrayDisplay($__aMaintenanceIds, "$__aMaintenanceIds")
	If $__aMaintenanceIds[0][0] = 0 Then
		_SetLabelStatus(0x008800 , "no maintenance", "periods found", "")
		_WinAPI_SetWindowTitleIcon($g_Icon_green, $FormMain)
		$g_ico_CurrentTrayIcon = $g_Icon_TrayGreen
	Else
		; there are maintenance periods, find a active one
		Local $__LocalTimeStructUTC = _Date_Time_GetSystemTime()
		Local $__dCurrentTime = _DateDiff('s', "1970/01/01 00:00:00", _Date_Time_SystemTimeToDateTimeStr($__LocalTimeStructUTC, 1))
;~ 		Local $__dCurrentTime = _DateDiff('s', "1970/01/01 00:00:00", _NowCalc())
		; $__aMaintenanceIds[x][1] = Id
		; $__aMaintenanceIds[x][2] = Name
		; $__aMaintenanceIds[x][3] = active_since
		; $__aMaintenanceIds[x][4] = active_till
		Local $__iMaintenanceTimeTill = 0
		Local $__sMaintenanceName = ""
		For $t = 1 To $__aMaintenanceIds[0][0] Step 1
			If $__dCurrentTime > $__aMaintenanceIds[$t][3] And $__dCurrentTime < $__aMaintenanceIds[$t][4] Then
				If $__iMaintenanceTimeTill < $__aMaintenanceIds[$t][4] Then
					$__iMaintenanceTimeTill = $__aMaintenanceIds[$t][4]
					$__sMaintenanceName = $__aMaintenanceIds[$t][2]
				EndIf
			EndIf
		Next
		If $__iMaintenanceTimeTill <> 0 Then
			_SetLabelStatus(0x880000 , "Host in maintenance", StringReplace(StringReplace(_SecondsToTime($__iMaintenanceTimeTill - $__dCurrentTime), "h", "h "),"m", "m "), $__sMaintenanceName)
			_WinAPI_SetWindowTitleIcon($g_Icon_red, $FormMain)
			$g_ico_CurrentTrayIcon = $g_Icon_TrayRed
			$g_i_Countdown = $__iMaintenanceTimeTill
			AdlibRegister("_CountdownMaintenance", 3000)
		Else
			_SetLabelStatus(0x008800 , "no active maintenance", "periods found", "")
			_WinAPI_SetWindowTitleIcon($g_Icon_green, $FormMain)
			$g_ico_CurrentTrayIcon = $g_Icon_TrayGreen

		EndIf

	EndIf



	If $__zbxSessionId <> "" Then
		_zbx_Logout( $__zbxURL, $__zbxSessionId)
	EndIf
EndFunc

; #############################################################################################################################################################
Func _CheckTriggerStatus()
	GUICtrlSetState($FormMainButtonAcknowledge, $GUI_DISABLE)
	Local $__zbxURL = GUICtrlRead($FormSetupAPIInputURL)
	Local $__zbxUser = GUICtrlRead($FormSetupAPIInputUsername)
	Local $__zbxPassword = GUICtrlRead($FormSetupAPIInputPassword)
	Local $__zbxHostname = GUICtrlRead($FormSetupAPIInputHost)
	Local $__zbxSessionId = _zbx_Login( $__zbxURL, $__zbxUser, $__zbxPassword)
	Local $__zbxHostId = _zbx_HostGetId($__zbxURL, $__zbxSessionId, $__zbxHostname)
	;~ 	$__a_zbxHostTriggers[0][0] = 0
	;~ 	$__a_zbxHostTriggers[0][1] = "triggerid"
	;~ 	$__a_zbxHostTriggers[0][2] = "description"
	;~ 	$__a_zbxHostTriggers[0][3] = "priority"
	$g_a_zbxHostTriggers = _zbx_HostTriggerGet($__zbxURL, $__zbxSessionId, $__zbxHostId)
	ReDim $g_a_zbxHostTriggers[ $g_a_zbxHostTriggers[0][0] + 1 ][5]
	$g_a_zbxHostTriggers[0][4] = "ListViewItem"
;~ 	_ArrayDisplay($__a_zbxHostTriggers)
	_GUICtrlListView_DeleteAllItems($FormMainListViewTriggers)
	If $g_a_zbxHostTriggers[0][0] > 0 Then
		Local $__hex_TriggerColors[6]
		$__hex_TriggerColors[0] = "0x" & GUICtrlRead($FormSetupTriggerInputColorNotclassified)
		$__hex_TriggerColors[1] = "0x" & GUICtrlRead($FormSetupTriggerInputColorInformation)
		$__hex_TriggerColors[2] = "0x" & GUICtrlRead($FormSetupTriggerInputColorWarning)
		$__hex_TriggerColors[3] = "0x" & GUICtrlRead($FormSetupTriggerInputColorAverage)
		$__hex_TriggerColors[4] = "0x" & GUICtrlRead($FormSetupTriggerInputColorHigh)
		$__hex_TriggerColors[5] = "0x" & GUICtrlRead($FormSetupTriggerInputColorDisaster)
		For $n = 1 To $g_a_zbxHostTriggers[0][0] Step 1
			$g_a_zbxHostTriggers[$n][4] = GUICtrlCreateListViewItem($g_a_zbxHostTriggers[$n][2], $FormMainListViewTriggers)
			GUICtrlSetBkColor($g_a_zbxHostTriggers[$n][4], $__hex_TriggerColors[ $g_a_zbxHostTriggers[$n][3] ])
		Next
	EndIf
;~ 	_ArrayDisplay($__a_zbxHostTriggers)
	If $__zbxSessionId <> "" Then
		_zbx_Logout( $__zbxURL, $__zbxSessionId)
	EndIf
	GUICtrlSetState($FormMainButtonAcknowledge, $GUI_ENABLE)
EndFunc
; #############################################################################################################################################################
Func _CountdownMaintenance()
	Local $__LocalTimeStructUTC = _Date_Time_GetSystemTime()
	Local $__dCurrentTime = _DateDiff('s', "1970/01/01 00:00:00", _Date_Time_SystemTimeToDateTimeStr($__LocalTimeStructUTC, 1))
	If $g_i_Countdown - $__dCurrentTime > 0 Then
		GUICtrlSetData($FormMainLabelStatusLine2, StringReplace(StringReplace(_SecondsToTime($g_i_Countdown - $__dCurrentTime), "h", "h "),"m", "m "))
	Else
		_CheckMaintenanceStatus()
	EndIf
EndFunc
; #############################################################################################################################################################
Func _Exit()
	Exit
EndFunc
; #############################################################################################################################################################
Func _TriggerInputColor()
	GUICtrlSetData(@GUI_CtrlId,StringLeft(StringRegExpReplace(StringUpper(GUICtrlRead(@GUI_CtrlId)),"[^[01723456789ABCDEF]*", ""),6))
EndFunc
; #############################################################################################################################################################
Func _TriggerChooseColor()
	Local $__hex_NewColor = _ChooseColor(2, "0x" & GUICtrlRead($FormSetupTriggerInputColorDisaster), 2, $FormSetup)
	Local $__cInput
	If $__hex_NewColor <> -1 Then
		Switch @GUI_CtrlId
			Case $FormSetupTriggerLabelColorNotclassified
				$__cInput = $FormSetupTriggerInputColorNotclassified
			Case $FormSetupTriggerLabelColorInformation
				$__cInput = $FormSetupTriggerInputColorInformation
			Case $FormSetupTriggerLabelColorWarning
				$__cInput = $FormSetupTriggerInputColorWarning
			Case $FormSetupTriggerLabelColorAverage
				$__cInput = $FormSetupTriggerInputColorAverage
			Case $FormSetupTriggerLabelColorHigh
				$__cInput = $FormSetupTriggerInputColorHigh
			Case $FormSetupTriggerLabelColorDisaster
				$__cInput = $FormSetupTriggerInputColorDisaster
		EndSwitch
		GUICtrlSetData($__cInput, StringTrimLeft($__hex_NewColor, 2))
		GUICtrlSetBkColor(@GUI_CtrlId, $__hex_NewColor)
	EndIf
EndFunc
; #############################################################################################################################################################
Func _SecondsToTime($__iSec)
	Local $__iRetH = 0, $__iRetM = 0, $__iRetS = 0, $__sReturn = ""
	If $__iSec / 3600 >= 1 Then
		$__iRetH = Floor($__iSec / 3600)
		$__iSec = Mod($__iSec, 3600)
	EndIf
	If $__iSec / 60 >= 1 Then
		$__iRetM = Floor($__iSec / 60)
		$__iSec = Mod($__iSec, 60)
	EndIf
	$__iRetS = $__iSec
	;Return StringFormat("%.2d:%.2d:%.2d",$__iRetH,$__iRetM,$__iRetS)
	$__sReturn = StringFormat("%.2dh%.2dm%.2ds", $__iRetH, $__iRetM, $__iRetS)
	$__sReturn = StringReplace($__sReturn, "00h", "")
	$__sReturn = StringReplace($__sReturn, "00m", "")
	$__sReturn = StringReplace($__sReturn, "00s", "")
;~ 	MsgBox(0,"",StringLeft($__sReturn, 1))
	If StringLeft($__sReturn, 1) = "0" Then
		$__sReturn = StringTrimLeft($__sReturn, 1)
	EndIf
	Return $__sReturn
EndFunc   ;==>_SecondsToTime

; #############################################################################################################################################################
Func _ShowGUI()
	GUISetState(@SW_SHOW, $FormMain)
EndFunc
; #############################################################################################################################################################
Func _ShowTrayIcon()
	_WinAPI_TraySetHIcon($g_ico_CurrentTrayIcon, $FormMain)
EndFunc
; #############################################################################################################################################################
Func _TimeToSeconds($__sTime)
	Local $__iResult = 0
	Local $__iFactor = 1
	Local $__aTime = StringSplit($__sTime, "")
	For $i = $__aTime[0] To 1 Step -1
;~ 		ConsoleWrite("$i = " & $i & @CRLF)
		Switch $__aTime[$i]
			Case "s"
				$__iFactor = 1
;~ 				ConsoleWrite("$__iFactor = 1" & @CRLF)
			Case "m"
				$__iFactor = 60
;~ 				ConsoleWrite("$__iFactor = 60" & @CRLF)
			Case "h"
				$__iFactor = 3600
;~ 				ConsoleWrite("$__iFactor = 3600" & @CRLF)
		EndSwitch
		If ($i - 1) > 0 Then
;~ 			ConsoleWrite("$i - 1 ist > 0" & @CRLF)
;~ 			ConsoleWrite('StringRegExp($__aTime[$i - 2], "^[01723456789]") = ' & StringRegExp($__aTime[$i - 2], "^[01723456789]") & @CRLF)
			If StringRegExp($__aTime[$i - 2], "^[01723456789]") = 1 And ($i - 2) <> 0 Then
;~ 				ConsoleWrite("IsNumber($__aTime[$i - 2]) And ($i - 2) > 0" & @CRLF)
				$__iResult = $__iResult + (Int($__aTime[$i - 2] & $__aTime[$i - 1]) * $__iFactor)
				$i = $i - 2
			Else
;~ 				ConsoleWrite("Keine Zahl oder $i -2 ist 0" & @CRLF)
				$__iResult = $__iResult + ($__aTime[$i - 1] * $__iFactor)
				$i = $i - 1
			EndIf
		Else
;~ 			ConsoleWrite("$i - 1 ist 0" & @CRLF)
			$__iResult = $__iResult + ($__aTime[$i - 1] * $__iFactor)
		    $i = $i - 1
		EndIf
	Next
	Return $__iResult
EndFunc
; #############################################################################################################################################################
Func _ReplaceEnviromentVariables($__SourceText)
	;~ 	Local $__repPID = Run(@ComSpec & " /c set", @SystemDir, @SW_HIDE, $STDOUT_CHILD)
	;~ 	Local $__repLine
	;~ 	While 1
	;~ 		$__repLine = $__repLine & StdoutRead($PID)
	;~ 		If @error Then ExitLoop
	;~ 	Wend
	;~ 	Local $
	;~ 	MsgBox(0, "SET", $line)
	Local $__sReturn = StringReplace($__SourceText, "%USERNAME%", @UserName)
	$__sReturn = StringReplace($__sReturn, "%USERDOMAIN%", EnvGet("USERDOMAIN"))
	$__sReturn = StringReplace($__sReturn, "%COMPUTERNAME%", @ComputerName)
	$__sReturn = StringReplace($__sReturn, "\", "\\")
	Return $__sReturn
EndFunc

; #############################################################################################################################################################
Func _SetLabelStatus($__StatusColor = 0x808080, $__TextLine1 = "unknown", $__TextLine2 = "status", $__TextLine3 = "")
	GUICtrlSetBkColor($FormMainLabelStatusLine1, $__StatusColor)
	GUICtrlSetBkColor($FormMainLabelStatusLine2, $__StatusColor)
	GUICtrlSetBkColor($FormMainLabelStatusLine3, $__StatusColor)
	GUICtrlSetData($FormMainLabelStatusLine1, $__TextLine1)
	GUICtrlSetData($FormMainLabelStatusLine2, $__TextLine2)
	GUICtrlSetData($FormMainLabelStatusLine3, $__TextLine3)
EndFunc
; #############################################################################################################################################################
Func _SettingsRead()
	; Tab "Zabbix API"

	_zetRegRead("$FormSetupAPIInputURL", 						$FormSetupAPIInputURL)
	_zetRegRead("$FormSetupAPIInputHost", 						$FormSetupAPIInputHost)
	_zetRegRead("$FormSetupAPIInputUsername", 					$FormSetupAPIInputUsername)
	_zetRegRead("$FormSetupAPIInputPassword", 					$FormSetupAPIInputPassword)

	; Tab "Maintenance"
	_zetRegRead("$FormSetupMaintenanceInputPrefix", 			$FormSetupMaintenanceInputPrefix)
	_zetRegRead("$FormSetupMaintenanceInputDescription", 		$FormSetupMaintenanceInputDescription)
	GUICtrlSetData($FormSetupMaintenanceListTimes, "")
	GUICtrlSetData($FormMainComboTimes, "")
	If _zetRegRead("MaintenanceTimes", "", True) <> "" Then
		$g_a_MaintenanceTimes = StringSplit(_zetRegRead("MaintenanceTimes", "", True), "|")
	EndIf
	Local $__s_temp = ""
	For $n = 1 To $g_a_MaintenanceTimes[0] Step 1
		$__s_temp = $__s_temp & _SecondsToTime($g_a_MaintenanceTimes[$n]) & "|"
	Next
	GUICtrlSetData($FormSetupMaintenanceListTimes, $__s_temp)
;~ 	MsgBox(0, "$g_a_MaintenanceTimes[1]", $g_a_MaintenanceTimes[1])
	GUICtrlSetData($FormMainComboTimes, $__s_temp, _SecondsToTime($g_a_MaintenanceTimes[1]))

	; Tab "Trigger"
	_zetRegRead("$FormSetupTriggerInputNotclassified", 			$FormSetupTriggerInputNotclassified)
	_zetRegRead("$FormSetupTriggerInputInformation", 			$FormSetupTriggerInputInformation)
	_zetRegRead("$FormSetupTriggerInputWarning", 				$FormSetupTriggerInputWarning)
	_zetRegRead("$FormSetupTriggerInputAverage", 				$FormSetupTriggerInputAverage)
	_zetRegRead("$FormSetupTriggerInputHigh", 					$FormSetupTriggerInputHigh)
	_zetRegRead("$FormSetupTriggerInputDisaster", 				$FormSetupTriggerInputDisaster)

	_zetRegRead("$FormSetupTriggerInputColorNotclassified", 	$FormSetupTriggerInputColorNotclassified)
	GUICtrlSetBkColor($FormSetupTriggerLabelColorNotclassified, "0x" & GUICtrlRead($FormSetupTriggerInputColorNotclassified))
	_zetRegRead("$FormSetupTriggerInputColorInformation", 		$FormSetupTriggerInputColorInformation)
	GUICtrlSetBkColor($FormSetupTriggerLabelColorInformation,	"0x" & GUICtrlRead($FormSetupTriggerInputColorInformation))
	_zetRegRead("$FormSetupTriggerInputColorWarning", 			$FormSetupTriggerInputColorWarning)
	GUICtrlSetBkColor($FormSetupTriggerLabelColorWarning, 		"0x" & GUICtrlRead($FormSetupTriggerInputColorWarning))
	_zetRegRead("$FormSetupTriggerInputColorAverage", 			$FormSetupTriggerInputColorAverage)
	GUICtrlSetBkColor($FormSetupTriggerLabelColorAverage, 		"0x" & GUICtrlRead($FormSetupTriggerInputColorAverage))
	_zetRegRead("$FormSetupTriggerInputColorHigh", 				$FormSetupTriggerInputColorHigh)
	GUICtrlSetBkColor($FormSetupTriggerLabelColorHigh, 			"0x" & GUICtrlRead($FormSetupTriggerInputColorHigh))
	_zetRegRead("$FormSetupTriggerInputColorDisaster", 			$FormSetupTriggerInputColorDisaster)
	GUICtrlSetBkColor($FormSetupTriggerLabelColorDisaster, 		"0x" & GUICtrlRead($FormSetupTriggerInputColorDisaster))

	; Tab "Check"
	_zetRegRead("$FormSetupCheckCheckboxMaintenanceStatus", 	$FormSetupCheckCheckboxMaintenanceStatus)
	FormSetupCheckCheckboxMaintenanceStatusClick()
	_zetRegRead("$FormSetupCheckCheckboxTrigger", 				$FormSetupCheckCheckboxTrigger)
	FormSetupCheckCheckboxTriggerClick()
	_zetRegRead("$FormSetupCheckComboTimesMaintenance", 		$FormSetupCheckComboTimesMaintenance)
	_zetRegRead("$FormSetupCheckComboTimesTrigger", 			$FormSetupCheckComboTimesTrigger)

	; Tab "Acknowledge"
	_zetRegRead("$FormSetupAcknowledgeEditDefaultMessage", 	$FormSetupAcknowledgeEditDefaultMessage)
	_zetRegRead("$FormSetupAcknowledgeCheckboxNeverAsk", 		$FormSetupAcknowledgeCheckboxNeverAsk)
	_zetRegRead("$FormSetupAcknowledgeCheckboxCloseProblems", 	$FormSetupAcknowledgeCheckboxCloseProblems)

;~ 	RegWrite("HKEY_CURRENT_USER\Software\znil.net\ZabbixEasyTool\local","", "REG_SZ", @HOUR & ":" & @MIN & ":" & @SEC & " - " & @MDAY & "." & @MON & "." & @YEAR)
EndFunc
; #############################################################################################################################################################
Func _zetRegRead($__sRegValueName, $__sRegValue, $__bNoRead = False)
	Local $__sCleanValueName
	If $__bNoRead = False Then
		$__sCleanValueName = StringReplace($__sRegValueName, "$FormSetup", "")
	Else
		$__sCleanValueName = $__sRegValueName
	EndIf
	Local $__sValue = RegRead("HKEY_CURRENT_USER\Software\znil.net\ZabbixEasyTool\local", $__sCleanValueName)
	If $__sValue <> "" And $__bNoRead = False Then
		If StringInStr($__sCleanValueName, "Checkbox") = 0 Then
			GUICtrlSetData($__sRegValue, StringReplace(RegRead("HKEY_CURRENT_USER\Software\znil.net\ZabbixEasyTool\local", $__sCleanValueName), "<br>", @CRLF))
		Else
			GUICtrlSetState($__sRegValue, RegRead("HKEY_CURRENT_USER\Software\znil.net\ZabbixEasyTool\local", $__sCleanValueName))
			Return 0
		EndIf
	Else
		Return $__sValue
	EndIf
EndFunc
; #############################################################################################################################################################
Func _SettingsWrite()
	; Tab "Zabbix API"
	_zetRegWrite("$FormSetupAPIInputURL", 						$FormSetupAPIInputURL)
	_zetRegWrite("$FormSetupAPIInputHost", 						$FormSetupAPIInputHost)
	_zetRegWrite("$FormSetupAPIInputUsername", 					$FormSetupAPIInputUsername)
	_zetRegWrite("$FormSetupAPIInputPassword", 					$FormSetupAPIInputPassword)

	; Tab "Maintenance"
	_zetRegWrite("$FormSetupMaintenanceInputPrefix", 			$FormSetupMaintenanceInputPrefix)
	_zetRegWrite("$FormSetupMaintenanceInputDescription", 		$FormSetupMaintenanceInputDescription)
	_zetRegWrite("MaintenanceTimes", 							_ArrayToString($g_a_MaintenanceTimes,"|",1), True)

	; Tab "Trigger"
	_zetRegWrite("$FormSetupTriggerInputNotclassified", 		$FormSetupTriggerInputNotclassified)
	_zetRegWrite("$FormSetupTriggerInputInformation", 			$FormSetupTriggerInputInformation)
	_zetRegWrite("$FormSetupTriggerInputWarning", 				$FormSetupTriggerInputWarning)
	_zetRegWrite("$FormSetupTriggerInputAverage", 				$FormSetupTriggerInputAverage)
	_zetRegWrite("$FormSetupTriggerInputHigh", 					$FormSetupTriggerInputHigh)
	_zetRegWrite("$FormSetupTriggerInputDisaster", 				$FormSetupTriggerInputDisaster)
	_zetRegWrite("$FormSetupTriggerInputColorNotclassified", 	$FormSetupTriggerInputColorNotclassified)
	_zetRegWrite("$FormSetupTriggerInputColorInformation", 		$FormSetupTriggerInputColorInformation)
	_zetRegWrite("$FormSetupTriggerInputColorWarning", 			$FormSetupTriggerInputColorWarning)
	_zetRegWrite("$FormSetupTriggerInputColorAverage", 			$FormSetupTriggerInputColorAverage)
	_zetRegWrite("$FormSetupTriggerInputColorHigh", 			$FormSetupTriggerInputColorHigh)
	_zetRegWrite("$FormSetupTriggerInputColorDisaster", 		$FormSetupTriggerInputColorDisaster)

	; Tab "Check"
	_zetRegWrite("$FormSetupCheckCheckboxMaintenanceStatus", 	$FormSetupCheckCheckboxMaintenanceStatus)
	_zetRegWrite("$FormSetupCheckCheckboxTrigger", 				$FormSetupCheckCheckboxTrigger)
	_zetRegWrite("$FormSetupCheckComboTimesMaintenance", 		$FormSetupCheckComboTimesMaintenance)
	_zetRegWrite("$FormSetupCheckComboTimesTrigger", 			$FormSetupCheckComboTimesTrigger)

	; Tab "Acknowledge"
	_zetRegWrite("$FormSetupAcknowledgeEditDefaultMessage", 	$FormSetupAcknowledgeEditDefaultMessage)
	_zetRegWrite("$FormSetupAcknowledgeCheckboxNeverAsk", 		$FormSetupAcknowledgeCheckboxNeverAsk)
	_zetRegWrite("$FormSetupAcknowledgeCheckboxCloseProblems", 	$FormSetupAcknowledgeCheckboxCloseProblems)

	RegWrite("HKEY_CURRENT_USER\Software\znil.net\ZabbixEasyTool\local","", "REG_SZ", @HOUR & ":" & @MIN & ":" & @SEC & " - " & @MDAY & "." & @MON & "." & @YEAR)
EndFunc

; ###############################################################################################################################################################################################
;======================================================================================
; Function Name:        _WinAPI_SetWindowTitleIcon
; Description:          Loads an image, scales it to desired width or height and creates and icon handle
;
; Parameters:           $sFile: image file to be loaded or bitmap handle
;                       $hWnd:  GUI handle where the new icon should be displayed
;                       $iW:    new image (icon) width. Default values is 32
;                       $iH:    new image (icon) height. Default values is 32
;
; Requirement(s):       GDIPlus.au3, _WinAPI_GetClassLongEx() and _WinAPI_SetClassLongEx()
; Return Value(s):      Success: HICON handle, Error: 0 (see below)
; Error codes:          1: Code is running as x64 - not supported yet
;                       2:  $sFile value is empty
;                       3:  $hWnd is not a windows handle
;                       4: filename doesn't exist or $sFile is not a valid bitmap handle
;                       5:  unable to create image from file
;                       6:  unable to create thumbnail from image handle
;                       7:  unable to create HICON from bitmap handle
;                       8:  unable to set ClassLongEx from GUI handle
;
; Limitation:           only x86 compatible currently
;
; Author(s):            UEZ, Yashied for _WinAPI_GetClassLongEx() and _WinAPI_SetClassLongEx()
; Version:              v0.98 Build 2016-11-21 Beta
;
; Remarks:              When finished release icon with _WinAPI_DestroyIcon()
;=======================================================================================
Func _WinAPI_SetWindowTitleIcon($sFile, $hWnd, $iW = 16, $iH = 16)
    If @AutoItX64 Then Return SetError(1, 0, 0)
    If $sFile = "" Then Return SetError(2, 0, 0)
    If Not IsHWnd($hWnd) Then Return SetError(3, 0, 0)
;~  Local Const $GCL_HICON = -14, $GCL_HICONSM = -34
    Local $hImage, $bExtHandle = False
    If Not FileExists($sFile) Then
        If _GDIPlus_ImageGetType($sFile) = -1 Then Return SetError(4, @error, 0)
        $hImage = $sFile ;interpret $sFile as a bitmap handle
        $bExtHandle = True
    Else
        $hImage = _GDIPlus_ImageLoadFromFile($sFile)
        If @error Then Return SetError(5, @error, 0)
    EndIf
    Local Const $hImageScaled = _GDIPlus_ImageScale($hImage, $iW, $iH)
    If @error Then Return SetError(6, @error, 0)
    If Not $bExtHandle Then _GDIPlus_ImageDispose($hImage)

    Local Const $hIconNew = _GDIPlus_HICONCreateFromBitmap($hImageScaled)
    If @error Then
        _GDIPlus_ImageDispose($hImageScaled)
        Return SetError(7, @error, 0)
    EndIf
;~  _WinAPI_SetClassLongEx($hWnd, $GCL_HICONSM, $hIconNew)
    _SendMessage($hWnd, $WM_SETICON, 1, $hIconNew)
    If @error Then
        _GDIPlus_ImageDispose($hImageScaled)
        Return SetError(8, @error, 0)
    EndIf
    _GDIPlus_ImageDispose($hImageScaled)
    Return $hIconNew
EndFunc   ;==>_WinAPI_SetWindowTitleIcon
; #############################################################################################################################################################
Func _WinAPI_TraySetHIcon($hIcon, $hWnd) ;function by Mat
    Local Const $tagNOTIFYICONDATA = _
                    "dword Size;" & _
                    "hwnd Wnd;" & _
                    "uint ID;" & _
                    "uint Flags;" & _
                    "uint CallbackMessage;" & _
                    "ptr Icon;" & _
                    "wchar Tip[128];" & _
                    "dword State;" & _
                    "dword StateMask;" & _
                    "wchar Info[256];" & _
                    "uint Timeout;" & _
                    "wchar InfoTitle[64];" & _
                    "dword InfoFlags;" & _
                    "dword Data1;word Data2;word Data3;byte Data4[8];" & _
                    "ptr BalloonIcon"
    Local Const $TRAY_ICON_GUI = WinGetHandle(AutoItWinGetTitle()), $NIM_ADD = 0, $NIM_MODIFY = 1, $NIF_MESSAGE = 1, $NIF_ICON = 2, $AUT_WM_NOTIFYICON = $WM_USER + 1, $AUT_NOTIFY_ICON_ID = 1
    Local $tNOTIFY = DllStructCreate($tagNOTIFYICONDATA)
    DllStructSetData($tNOTIFY, "Size", DllStructGetSize($tNOTIFY))
    DllStructSetData($tNOTIFY, "Wnd", $TRAY_ICON_GUI)
    DllStructSetData($tNOTIFY, "ID", $AUT_NOTIFY_ICON_ID)
    DllStructSetData($tNOTIFY, "Icon", $hIcon)
    DllStructSetData($tNOTIFY, "Flags", BitOR($NIF_ICON, $NIF_MESSAGE))
    DllStructSetData($tNOTIFY, "CallbackMessage", $AUT_WM_NOTIFYICON)
    Local $aRet = DllCall("shell32.dll", "int", "Shell_NotifyIconW", "dword", $NIM_MODIFY, "ptr", DllStructGetPtr($tNOTIFY))
    If (@error) Then Return SetError(1, 0, 0)
    Return $aRet[0] <> 0
EndFunc   ;==>_Tray_SetHIcon
; #############################################################################################################################################################
Func _zetRegWrite($__sRegValueName, $__sRegValue, $__bNoRead = False)
	If $__bNoRead = False Then
		Local $__sCleanValueName = StringReplace($__sRegValueName, "$FormSetup", "")
		RegWrite("HKEY_CURRENT_USER\Software\znil.net\ZabbixEasyTool\local",$__sCleanValueName, "REG_SZ", StringReplace(GUICtrlRead($__sRegValue), @CRLF, "<br>"))
	Else
		RegWrite("HKEY_CURRENT_USER\Software\znil.net\ZabbixEasyTool\local",$__sRegValueName, "REG_SZ", $__sRegValue)
	EndIf
EndFunc

; #############################################################################################################################################################
Func _zbx_Login( $__zbxURL, $__zbxUser, $__zbxPassword)
	Local $__zbxJSON = '{"params":{"password":"' & $__zbxPassword & '","user":"' & $__zbxUser & '","userData":true},"jsonrpc":"2.0","method":"user.login","id":42}'
	Local $__oHTTP = ObjCreate("winhttp.winhttprequest.5.1")
	Local $__zbxSessionId = ""
	$__oHTTP.Open("POST", $__zbxURL , False)
	; ignore all SSL errors
    $__oHTTP.Option("WinHttpRequestOption_SslErrorIgnoreFlags") = 0x3300
	;$__oHTTP.Option(4) = 0x3300
    ; Unknown certification authority (CA) or untrusted root   0x0100
    ; Wrong usage                                              0x0200
    ; Invalid common name (CN)                                 0x1000
    ; Invalid date or certificate expired                      0x2000
	$__oHTTP.SetRequestHeader("Content-Type", "application/json-rpc")
	$__oHTTP.Send($__zbxJSON)
	Local $__oReceived = $__oHTTP.ResponseText
	Local $__oStatusCode = $__oHTTP.Status
;~ 	MsgBox(0, "_zbx_Login", StringReplace($__oReceived,",", "," & @CRLF) & @CRLF & @CRLF & "Status Code: " & $__oStatusCode)
	If $__oStatusCode = 200 Then
		Local $__atemp = StringSplit($__oReceived, ",:", 0)
		For $i = 1 To $__atemp[0] Step 1
			If StringInStr($__atemp[$i], "sessionid") > 0 Then
				$__zbxSessionId = StringRegExpReplace($__atemp[$i + 1], '[^A-Za-z0-9_().+\%\-\s]+', "")
				ExitLoop
			EndIf
		Next
	EndIf
	Return $__zbxSessionId
EndFunc

; #############################################################################################################################################################
Func _zbx_Logout( $__zbxURL, $__zbxSessionId)
	Local $__zbxJSON = '{"jsonrpc": "2.0","method": "user.logout","params": [],"id": 42,"auth": "' & $__zbxSessionId & '"}'
	Local $__oHTTP = ObjCreate("winhttp.winhttprequest.5.1")
	Local $__zbxResult = 0
	$__oHTTP.Open("POST", $__zbxURL , False)
    $__oHTTP.Option("WinHttpRequestOption_SslErrorIgnoreFlags") = 0x3300
	$__oHTTP.SetRequestHeader("Content-Type", "application/json-rpc")
	$__oHTTP.Send($__zbxJSON)
	Local $__oReceived = $__oHTTP.ResponseText
	Local $__oStatusCode = $__oHTTP.Status
;~ 	MsgBox(0, "_zbx_Logout", StringReplace($__oReceived,",", "," & @CRLF) & @CRLF & @CRLF & "Status Code: " & $__oStatusCode)
	If $__oStatusCode = 200 Then
		Local $__atemp = StringSplit($__oReceived, ",:", 0)
		For $i = 1 To $__atemp[0] Step 1
			If StringInStr($__atemp[$i], "result") > 0 Then
				$__zbxResult = StringRegExpReplace($__atemp[$i + 1], '[^A-Za-z0-9_().+\%\-\s]+', "")
				ExitLoop
			EndIf
		Next
	EndIf
	Return $__zbxResult
EndFunc

; #############################################################################################################################################################
Func _zbx_HostGetId($__zbxURL, $__zbxSessionId, $__zbxHostname)
	Local $__zbxJSON = '{"params":{"filter":{"name":"' & $__zbxHostname & '"},"output":["hostid"]},"jsonrpc": "2.0","method": "host.get","auth": "' & $__zbxSessionId & '","id":42}'
	Local $__oHTTP = ObjCreate("winhttp.winhttprequest.5.1")
	Local $__zbxHostId = ""
	$__oHTTP.Open("POST", $__zbxURL , False)
    $__oHTTP.Option("WinHttpRequestOption_SslErrorIgnoreFlags") = 0x3300
	$__oHTTP.SetRequestHeader("Content-Type", "application/json-rpc")
	$__oHTTP.Send($__zbxJSON)
	Local $__oReceived = $__oHTTP.ResponseText
	Local $__oStatusCode = $__oHTTP.Status
;~ 	MsgBox(0, "_zbx_HostGetId", StringReplace($__oReceived,",", "," & @CRLF) & @CRLF & @CRLF & "Status Code: " & $__oStatusCode)
	If $__oStatusCode = 200 Then
		Local $__atemp = StringSplit($__oReceived, ",:", 0)
		For $i = 1 To $__atemp[0] Step 1
			If StringInStr($__atemp[$i], "hostid") > 0 Then
				$__zbxHostId = StringRegExpReplace($__atemp[$i + 1], '[^A-Za-z0-9_().+\%\-\s]+', "")
				ExitLoop
			EndIf
		Next
	EndIf
	Return $__zbxHostId
EndFunc

; #############################################################################################################################################################
Func _zbx_HostGetMaintenanceIDs($__zbxURL, $__zbxSessionId, $__zbxHostId, $__zbxFilterByName = "")
	Local $__bSkip = False
	Local $__zbxJSON = '{"params":{"output":"extend","selectHosts":"refer","selectGroups": "refer","hostids": "' & $__zbxHostId & '"},"jsonrpc": "2.0","method": "maintenance.get","auth": "' & $__zbxSessionId & '","id":42}'
	Local $__oHTTP = ObjCreate("winhttp.winhttprequest.5.1")
	Local $__a_zbxHostMaintenanceId[1][5]
	$__a_zbxHostMaintenanceId[0][0] = 0
	$__a_zbxHostMaintenanceId[0][1] = "maintenanceid"
	$__a_zbxHostMaintenanceId[0][2] = "name"
	$__a_zbxHostMaintenanceId[0][3] = "active_since"
	$__a_zbxHostMaintenanceId[0][4] = "active_till"
	$__oHTTP.Open("POST", $__zbxURL , False)
    $__oHTTP.Option("WinHttpRequestOption_SslErrorIgnoreFlags") = 0x3300
	$__oHTTP.SetRequestHeader("Content-Type", "application/json-rpc")
	$__oHTTP.Send($__zbxJSON)
	Local $__oReceived = $__oHTTP.ResponseText
	Local $__oStatusCode = $__oHTTP.Status
;~ 	MsgBox(0, "_zbx_HostGetMaintenanceIDs", StringReplace($__oReceived,",", "," & @CRLF) & @CRLF & @CRLF & "Status Code: " & $__oStatusCode)
;~ 	ConsoleWrite($__oReceived & @CRLF)
	If $__oStatusCode = 200 Then
		$__oReceived = StringReplace($__oReceived, '":"', '"§"')
		$__oReceived = StringReplace($__oReceived, '","', '"§"')
		$__oReceived = StringReplace($__oReceived, '":[{"', '"§"')
		$__oReceived = StringReplace($__oReceived, '"}],"', '"§"')
		$__oReceived = StringReplace($__oReceived, '"},{"', '"§"')
		$__oReceived = StringReplace($__oReceived, '":', '"§')
		Local $__atemp = StringSplit($__oReceived, "§", 0)
		For $i = 1 To $__atemp[0] Step 1
			If StringInStr($__atemp[$i], "maintenanceid") > 0 Then
				$__bSkip = True
				If $__zbxFilterByName <> "" Then
					For $j = 1 To 12 Step 1
						If StringInStr($__atemp[$i + $j], "ZabbixEasy") > 0 Then
							$__a_zbxHostMaintenanceId[0][0] = $__a_zbxHostMaintenanceId[0][0] + 1
							ReDim $__a_zbxHostMaintenanceId[ $__a_zbxHostMaintenanceId[0][0] + 1 ][5]
							$__a_zbxHostMaintenanceId[ $__a_zbxHostMaintenanceId[0][0] ][1] = StringRegExpReplace($__atemp[$i + 1], '[^A-Za-z0-9_().+\%\-\s]+', "")
							$i = $i + 1
							$__bSkip = False
							ExitLoop
						EndIf
					Next
				Else
					$__a_zbxHostMaintenanceId[0][0] = $__a_zbxHostMaintenanceId[0][0] + 1
					ReDim $__a_zbxHostMaintenanceId[ $__a_zbxHostMaintenanceId[0][0] + 1 ][5]
					$__a_zbxHostMaintenanceId[ $__a_zbxHostMaintenanceId[0][0] ][1] = StringRegExpReplace($__atemp[$i + 1], '[^A-Za-z0-9_().+\%\-\s]+', "")
					$i = $i + 1
					$__bSkip = False
				EndIf
			EndIf
			If $__bSkip = False Then
				If StringInStr($__atemp[$i], "name") > 0 Then
					$__a_zbxHostMaintenanceId[ $__a_zbxHostMaintenanceId[0][0] ][2] = StringTrimRight(StringTrimLeft($__atemp[$i + 1], 1), 1)
				EndIf
				If StringInStr($__atemp[$i], "active_since") > 0 Then
					$__a_zbxHostMaintenanceId[ $__a_zbxHostMaintenanceId[0][0] ][3] = StringRegExpReplace($__atemp[$i + 1], '[^A-Za-z0-9_().+\%\-\s]+', "")
				EndIf
				If StringInStr($__atemp[$i], "active_till") > 0 Then
					$__a_zbxHostMaintenanceId[ $__a_zbxHostMaintenanceId[0][0] ][4] = StringRegExpReplace($__atemp[$i + 1], '[^A-Za-z0-9_().+\%\-\s]+', "")
				EndIf
			EndIf
		Next
	EndIf
	Return $__a_zbxHostMaintenanceId
EndFunc
_Date_Time_GetTimeZoneInformation()
; #############################################################################################################################################################
Func _zbx_HostAddMaintenance($__zbxURL, $__zbxSessionId, $__zbxHostId, $__zbxName, $__zbxDescription, $__zbxDurationTime = 3600)
	Local $__StartTimeStructUTC = _Date_Time_GetSystemTime()
	Local $__StartTimeUTC = _DateDiff('s', "1970/01/01 00:00:00", _Date_Time_SystemTimeToDateTimeStr($__StartTimeStructUTC, 1))
	Local $__EndTimeUTC = $__StartTimeUTC + $__zbxDurationTime
	Local $__zbxJSON = '{"jsonrpc":"2.0","method":"maintenance.create","params":[{"groupids":[],"hostids":["' & $__zbxHostId & '"],' & _
        '"name":" ' & $__zbxName & '",' & _
        '"maintenance_type":"0","description":" ' & $__zbxDescription & '","active_since":"' & $__StartTimeUTC & '","active_till":"' & $__EndTimeUTC & '",' & _
        '"timeperiods":[{"timeperiod_type":0,"start_date":"' & $__StartTimeUTC & '","period":' & $__EndTimeUTC & '}]}],"auth":"' & $__zbxSessionId & '","id":42}'
	Local $__oHTTP = ObjCreate("winhttp.winhttprequest.5.1")
	Local $__zbxMaintenanceId = ""
	$__oHTTP.Open("POST", $__zbxURL , False)
    $__oHTTP.Option("WinHttpRequestOption_SslErrorIgnoreFlags") = 0x3300
	$__oHTTP.SetRequestHeader("Content-Type", "application/json-rpc")
	$__oHTTP.Send($__zbxJSON)
	Local $__oReceived = $__oHTTP.ResponseText
	Local $__oStatusCode = $__oHTTP.Status
;~ 	MsgBox(0, "_zbx_HostAddMaintenance", StringReplace($__oReceived,",", "," & @CRLF) & @CRLF & @CRLF & "Status Code: " & $__oStatusCode)
;~ 	ConsoleWrite($__zbxJSON & @CRLF)
	If $__oStatusCode = 200 Then
		Local $__atemp = StringSplit($__oReceived, ",:", 0)
		For $i = 1 To $__atemp[0] Step 1
			If StringInStr($__atemp[$i], "maintenanceid") > 0 Then
				$__zbxMaintenanceId = StringRegExpReplace($__atemp[$i + 1], '[^A-Za-z0-9_().+\%\-\s]+', "")
				ExitLoop
			EndIf
		Next
	EndIf
	Return $__zbxMaintenanceId
EndFunc

; #############################################################################################################################################################
Func _zbx_HostRemoveMaintenance($__zbxURL, $__zbxSessionId, $__zbxHostId, $__zbxMaintenanceId)
	Local $__zbxJSON = '{"jsonrpc":"2.0","method":"maintenance.delete","params":["' & $__zbxMaintenanceId & '"],"auth":"' & $__zbxSessionId & '","id":42}'
	Local $__oHTTP = ObjCreate("winhttp.winhttprequest.5.1")
	Local $__zbxResult = 0
	$__oHTTP.Open("POST", $__zbxURL , False)
    $__oHTTP.Option("WinHttpRequestOption_SslErrorIgnoreFlags") = 0x3300
	$__oHTTP.SetRequestHeader("Content-Type", "application/json-rpc")
	$__oHTTP.Send($__zbxJSON)
	Local $__oReceived = $__oHTTP.ResponseText
	Local $__oStatusCode = $__oHTTP.Status
;~ 	MsgBox(0, "_zbx_HostRemoveMaintenance", StringReplace($__oReceived,",", "," & @CRLF) & @CRLF & @CRLF & "Status Code: " & $__oStatusCode)
	If $__oStatusCode = 200 Then
		Local $__atemp = StringSplit($__oReceived, ",:", 0)
		For $i = 1 To $__atemp[0] Step 1
			If StringInStr($__atemp[$i], "maintenanceid") > 0 Then
				$__zbxResult = StringRegExpReplace($__atemp[$i + 1], '[^A-Za-z0-9_().+\%\-\s]+', "")
				ExitLoop
			EndIf
		Next
	EndIf
	Return $__zbxResult
EndFunc

; #############################################################################################################################################################
Func _zbx_HostTriggerGet($__zbxURL, $__zbxSessionId, $__zbxHostId)
	Local $__zbxJSON = '{"jsonrpc": "2.0","method": "trigger.get","params":{"withUnacknowledgedEvents":1,"output":["triggerid","description","priority"],' & _
        '"filter":{"value":1,"hostid":"' & $__zbxHostId & '"},"sortfield":"priority","sortorder":"DESC"},"auth": "' & $__zbxSessionId & '","id":42}'
	Local $__oHTTP = ObjCreate("winhttp.winhttprequest.5.1")
	Local $__a_zbxHostTriggers[1][4]	; [0][0] = Anzahl
										; [x][1] = triggerid
										; [x][2] = description
										; [x][3] = priority
	$__a_zbxHostTriggers[0][0] = 0
	$__a_zbxHostTriggers[0][1] = "triggerid"
	$__a_zbxHostTriggers[0][2] = "description"
	$__a_zbxHostTriggers[0][3] = "priority"

	$__oHTTP.Open("POST", $__zbxURL , False)
    $__oHTTP.Option("WinHttpRequestOption_SslErrorIgnoreFlags") = 0x3300
	$__oHTTP.SetRequestHeader("Content-Type", "application/json-rpc")
	$__oHTTP.Send($__zbxJSON)
	Local $__oReceived = $__oHTTP.ResponseText
	Local $__oStatusCode = $__oHTTP.Status
;~ 	MsgBox(0, "_zbx_HostTriggerGet", StringReplace($__oReceived,",", "," & @CRLF) & @CRLF & @CRLF & "Status Code: " & $__oStatusCode)
;~ 	ConsoleWrite($__oReceived & @CRLF & @CRLF)
	If $__oStatusCode = 200 Then
		$__oReceived = StringReplace($__oReceived, '":"', '"§"')
		$__oReceived = StringReplace($__oReceived, '","', '"§"')
		$__oReceived = StringReplace($__oReceived, '":[{"', '"§"')
		$__oReceived = StringReplace($__oReceived, '"}],"', '"§"')
		$__oReceived = StringReplace($__oReceived, '"},{"', '"§"')
		$__oReceived = StringReplace($__oReceived, '":', '"§')
		Local $__atemp = StringSplit($__oReceived, "§", 0)
;~ 		_ArrayDisplay($__atemp)
		For $i = 1 To $__atemp[0] Step 1
			If StringInStr($__atemp[$i], "triggerid") > 0 Then
				$__a_zbxHostTriggers[0][0] = $__a_zbxHostTriggers[0][0] + 1
				ReDim $__a_zbxHostTriggers[ $__a_zbxHostTriggers[0][0] + 1 ][4]
				$__a_zbxHostTriggers[ $__a_zbxHostTriggers[0][0] ][1] = StringRegExpReplace($__atemp[$i + 1], '[^A-Za-z0-9_().+\%\-\s]+', "")
				For $j = $i To $__atemp[0] Step 1
					If StringInStr($__atemp[$j], "description") > 0 Then
						$__a_zbxHostTriggers[ $__a_zbxHostTriggers[0][0] ][2] = StringTrimRight(StringTrimLeft($__atemp[$j + 1],1),1)
					EndIf
					If StringInStr($__atemp[$j], "priority") > 0 Then
						$__a_zbxHostTriggers[ $__a_zbxHostTriggers[0][0] ][3] = StringRegExpReplace($__atemp[$j + 1], '[^A-Za-z0-9_().+\%\-\s]+', "")
						ExitLoop
					EndIf
				Next
			EndIf
		Next
	EndIf
	Return $__a_zbxHostTriggers
EndFunc

; #############################################################################################################################################################
Func _zbx_TriggerEventGet($__zbxURL, $__zbxSessionId, $__zbxTriggerId)
	Local $__zbxJSON = '{"jsonrpc": "2.0","method": "event.get","params":{"output":"extend","select_acknowledges":"extend","objectids":"' & $__zbxTriggerId & _
		'","sortfield":["clock","eventid"],"sortorder": "DESC","filter":{"value":1}},"auth":"' & $__zbxSessionId & '","id":42}'
	Local $__oHTTP = ObjCreate("winhttp.winhttprequest.5.1")
	Local $__a_zbxTriggerEvents[1] = [ 0 ]
	$__oHTTP.Open("POST", $__zbxURL , False)
    $__oHTTP.Option("WinHttpRequestOption_SslErrorIgnoreFlags") = 0x3300
	$__oHTTP.SetRequestHeader("Content-Type", "application/json-rpc")
	$__oHTTP.Send($__zbxJSON)
	Local $__oReceived = $__oHTTP.ResponseText
	Local $__oStatusCode = $__oHTTP.Status
;~ 	MsgBox(0, "_zbxHostEventGet", StringReplace($__oReceived,",", "," & @CRLF) & @CRLF & @CRLF & "Status Code: " & $__oStatusCode)
;~ 	ConsoleWrite("$__zbxJSON:" & @CRLF & $__zbxJSON & @CRLF)
;~ 	ConsoleWrite("$__oReceived:" & @CRLF & $__oReceived & @CRLF)
	If $__oStatusCode = 200 Then
		Local $__atemp = StringSplit($__oReceived, ",:", 0)
		For $i = 1 To $__atemp[0] Step 1
			If StringInStr($__atemp[$i], '"eventid"') > 0 Then
				$__a_zbxTriggerEvents[0] = $__a_zbxTriggerEvents[0] + 1
				ReDim $__a_zbxTriggerEvents[ $__a_zbxTriggerEvents[0] + 1 ]
				$__a_zbxTriggerEvents[ $__a_zbxTriggerEvents[0] ] = StringRegExpReplace($__atemp[$i + 1], '[^A-Za-z0-9_().+\%\-\s]+', "")
				$i = $i + 1
			EndIf
		Next
	EndIf
	Return $__a_zbxTriggerEvents
EndFunc

; #############################################################################################################################################################
Func _zbx_EventAcknowledge($__zbxURL, $__zbxSessionId, $__zbxEvendId, $__zbxMessage = "ZabbixEasy")
	Local $__zbxJSON = '{"jsonrpc":"2.0","method":"event.acknowledge","params":{"eventids": "' & $__zbxEvendId & '","message":"' & $__zbxMessage & '","action":0},"auth": "' & $__zbxSessionId & '","id":42}'
	Local $__oHTTP = ObjCreate("winhttp.winhttprequest.5.1")
	Local $__zbxResult = 0
	$__oHTTP.Open("POST", $__zbxURL , False)
    $__oHTTP.Option("WinHttpRequestOption_SslErrorIgnoreFlags") = 0x3300
	$__oHTTP.SetRequestHeader("Content-Type", "application/json-rpc")
	$__oHTTP.Send($__zbxJSON)
	Local $__oReceived = $__oHTTP.ResponseText
	Local $__oStatusCode = $__oHTTP.Status
;~ 	MsgBox(0, "_zbx_HostRemoveMaintenance", StringReplace($__oReceived,",", "," & @CRLF) & @CRLF & @CRLF & "Status Code: " & $__oStatusCode)
;~ 	ConsoleWrite("$__zbxJSON:" & @CRLF & $__zbxJSON & @CRLF)
;~ 	ConsoleWrite("$__oReceived:" & @CRLF & $__oReceived & @CRLF)
	If $__oStatusCode = 200 Then
		Local $__atemp = StringSplit($__oReceived, ",:", 0)
		For $i = 1 To $__atemp[0] Step 1
			If StringInStr($__atemp[$i], "eventids") > 0 Then
				$__zbxResult = StringRegExpReplace($__atemp[$i + 1], '[^A-Za-z0-9_().+\%\-\s]+', "")
				ExitLoop
			EndIf
		Next
	EndIf
	Return $__zbxResult
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



#Region ### START Koda GUI section ### Form=C:\_AutoIt\ZabbixEasyTool\FormMain.kxf
$FormMain = GUICreate("ZabbixEasyTool", 405, 359, -1, -1, -1, BitOR($WS_EX_TOPMOST,$WS_EX_WINDOWEDGE))
GUISetFont(10, 400, 0, "Arial")
GUISetOnEvent($GUI_EVENT_CLOSE, "FormMainClose")
GUISetOnEvent($GUI_EVENT_MINIMIZE, "FormMainMinimize")
GUISetOnEvent($GUI_EVENT_RESTORE, "FormMainRestore")
$FormMainLabelStatusLine1 = GUICtrlCreateLabel("unknown", 0, 0, 404, 44, BitOR($SS_CENTER,$SS_CENTERIMAGE))
GUICtrlSetFont($FormMainLabelStatusLine1, 28, 400, 0, "Arial")
GUICtrlSetColor($FormMainLabelStatusLine1, 0xFFFFFF)
GUICtrlSetBkColor($FormMainLabelStatusLine1, 0x808080)
GUICtrlSetCursor ($FormMainLabelStatusLine1, 0)
GUICtrlSetOnEvent($FormMainLabelStatusLine1, "FormMainLabelStatusClick")
$FormMainComboTimes = GUICtrlCreateCombo("", 48, 122, 99, 25, BitOR($CBS_DROPDOWN,$CBS_AUTOHSCROLL))
GUICtrlSetFont($FormMainComboTimes, 12, 400, 0, "Arial")
$FormMainButtonMaintenanceSet = GUICtrlCreateButton("Set", 152, 121, 99, 28)
GUICtrlSetFont($FormMainButtonMaintenanceSet, 12, 400, 0, "Arial")
GUICtrlSetOnEvent($FormMainButtonMaintenanceSet, "FormMainButtonMaintenanceSetClick")
$FormMainListViewTriggers = GUICtrlCreateListView("Trigger Description", 0, 176, 404, 142, BitOR($GUI_SS_DEFAULT_LISTVIEW,$LVS_NOCOLUMNHEADER))
GUICtrlSendMsg($FormMainListViewTriggers, $LVM_SETCOLUMNWIDTH, 0, 400)
$FormMainButtonMaintenanceDelete = GUICtrlCreateButton("Delete all", 256, 121, 99, 28)
GUICtrlSetFont($FormMainButtonMaintenanceDelete, 12, 400, 0, "Arial")
GUICtrlSetOnEvent($FormMainButtonMaintenanceDelete, "FormMainButtonMaintenanceDeleteClick")
$FormMainButtonAcknowledge = GUICtrlCreateButton("Acknowledge", 48, 321, 109, 28)
GUICtrlSetFont($FormMainButtonAcknowledge, 12, 400, 0, "Arial")
GUICtrlSetOnEvent($FormMainButtonAcknowledge, "FormMainButtonAcknowledgeClick")
$FormMainButtonSetup = GUICtrlCreateButton("Setup", 246, 321, 109, 28)
GUICtrlSetFont($FormMainButtonSetup, 12, 400, 0, "Arial")
GUICtrlSetOnEvent($FormMainButtonSetup, "FormMainButtonSetupClick")
$FormMainLabelStatusLine2 = GUICtrlCreateLabel("status", 0, 44, 404, 44, BitOR($SS_CENTER,$SS_CENTERIMAGE))
GUICtrlSetFont($FormMainLabelStatusLine2, 28, 400, 0, "Arial")
GUICtrlSetColor($FormMainLabelStatusLine2, 0xFFFFFF)
GUICtrlSetBkColor($FormMainLabelStatusLine2, 0x808080)
GUICtrlSetCursor ($FormMainLabelStatusLine2, 0)
GUICtrlSetOnEvent($FormMainLabelStatusLine2, "FormMainLabelStatusClick")
$FormMainLabelStatusLine3 = GUICtrlCreateLabel("", 0, 88, 404, 28, BitOR($SS_CENTER,$SS_CENTERIMAGE))
GUICtrlSetColor($FormMainLabelStatusLine3, 0xFFFFFF)
GUICtrlSetBkColor($FormMainLabelStatusLine3, 0x808080)
GUICtrlSetCursor ($FormMainLabelStatusLine3, 0)
GUICtrlSetOnEvent($FormMainLabelStatusLine3, "FormMainLabelStatusClick")
GUISetState(@SW_SHOW)
#EndRegion ### END Koda GUI section ###
;~ GUISetState(@SW_HIDE, $FormMain)




#Region ### START Koda GUI section ### Form=C:\_AutoIt\ZabbixEasyTool\FormSetup.kxf
$FormSetup = GUICreate("Setup - ZabbixEasyTool", 458, 309, -1, -1)
GUISetFont(10, 400, 0, "Arial")
GUISetOnEvent($GUI_EVENT_CLOSE, "FormSetupClose")
GUISetOnEvent($GUI_EVENT_MINIMIZE, "FormSetupMinimize")
GUISetOnEvent($GUI_EVENT_RESTORE, "FormSetupRestore")
$FormSetupPageControl = GUICtrlCreateTab(8, 8, 444, 256)
GUICtrlSetFont($FormSetupPageControl, 10, 400, 0, "Arial")
$FormSetupTabSheetZabbixAPI = GUICtrlCreateTabItem("Zabbix API")
$FormSetupAPIInputURL = GUICtrlCreateInput("https://zabbix.znil.net/api_jsonrpc.php", 104, 47, 289, 24)
GUICtrlSetFont($FormSetupAPIInputURL, 10, 400, 0, "Arial")
$FormSetupAPILabelURL = GUICtrlCreateLabel("URL", 16, 50, 82, 20, $SS_RIGHT)
GUICtrlSetFont($FormSetupAPILabelURL, 10, 400, 0, "Arial")
GUICtrlSetBkColor($FormSetupAPILabelURL, 0xFFFFFF)
$FormSetupAPILabelUsername = GUICtrlCreateLabel("Username", 16, 146, 82, 20, $SS_RIGHT)
GUICtrlSetFont($FormSetupAPILabelUsername, 10, 400, 0, "Arial")
GUICtrlSetBkColor($FormSetupAPILabelUsername, 0xFFFFFF)
$FormSetupAPIInputUsername = GUICtrlCreateInput("apiuser", 104, 143, 289, 24)
GUICtrlSetFont($FormSetupAPIInputUsername, 10, 400, 0, "Arial")
$FormSetupAPILabelPassword = GUICtrlCreateLabel("Password", 16, 178, 82, 20, $SS_RIGHT)
GUICtrlSetFont($FormSetupAPILabelPassword, 10, 400, 0, "Arial")
GUICtrlSetBkColor($FormSetupAPILabelPassword, 0xFFFFFF)
$FormSetupAPIInputPassword = GUICtrlCreateInput("dummy&6", 104, 175, 289, 24, BitOR($GUI_SS_DEFAULT_INPUT,$ES_PASSWORD))
GUICtrlSetFont($FormSetupAPIInputPassword, 10, 400, 0, "Arial")
$FormSetupAPIButtonTestCredentials = GUICtrlCreateButton("Test Credentials", 104, 208, 139, 25)
GUICtrlSetFont($FormSetupAPIButtonTestCredentials, 10, 400, 0, "Arial")
GUICtrlSetOnEvent($FormSetupAPIButtonTestCredentials, "FormSetupAPIButtonTestCredentialsClick")
$FormSetupAPILabelCredentialsTest = GUICtrlCreateLabel("not tested", 254, 209, 139, 23, BitOR($SS_CENTER,$SS_CENTERIMAGE,$WS_BORDER))
GUICtrlSetFont($FormSetupAPILabelCredentialsTest, 10, 400, 0, "Arial")
GUICtrlSetBkColor($FormSetupAPILabelCredentialsTest, 0xC0C0C0)
$FormSetupAPILabelHost = GUICtrlCreateLabel("Host", 16, 82, 82, 20, $SS_RIGHT)
GUICtrlSetFont($FormSetupAPILabelHost, 10, 400, 0, "Arial")
GUICtrlSetBkColor($FormSetupAPILabelHost, 0xFFFFFF)
$FormSetupAPIInputHost = GUICtrlCreateInput("DC01", 104, 79, 289, 24)
GUICtrlSetFont($FormSetupAPIInputHost, 10, 400, 0, "Arial")
$FormSetupAPIButtonReadDataZabbixAgent = GUICtrlCreateButton("Read data from zabbix_agent configuration", 104, 110, 289, 25)
GUICtrlSetFont($FormSetupAPIButtonReadDataZabbixAgent, 10, 400, 0, "Arial")
GUICtrlSetOnEvent($FormSetupAPIButtonReadDataZabbixAgent, "FormSetupAPIButtonReadDataZabbixAgentClick")
$FormSetupTabSheetMaintenance = GUICtrlCreateTabItem("Maintenance")
GUICtrlSetState($FormSetupTabSheetMaintenance,$GUI_SHOW)
$FormSetupMaintenanceLabelPrefix = GUICtrlCreateLabel("Name Prefix", 16, 49, 82, 20, $SS_RIGHT)
GUICtrlSetFont($FormSetupMaintenanceLabelPrefix, 10, 400, 0, "Arial")
GUICtrlSetBkColor($FormSetupMaintenanceLabelPrefix, 0xFFFFFF)
$FormSetupMaintenanceInputPrefix = GUICtrlCreateInput("ZabbixEasyTool", 104, 46, 321, 24)
GUICtrlSetFont($FormSetupMaintenanceInputPrefix, 10, 400, 0, "Arial")
$FormSetupMaintenanceLabelDescription = GUICtrlCreateLabel("Description", 16, 81, 82, 20, $SS_RIGHT)
GUICtrlSetFont($FormSetupMaintenanceLabelDescription, 10, 400, 0, "Arial")
GUICtrlSetBkColor($FormSetupMaintenanceLabelDescription, 0xFFFFFF)
$FormSetupMaintenanceInputDescription = GUICtrlCreateInput("USERDOMAIN\USERNAME", 104, 78, 321, 24)
GUICtrlSetFont($FormSetupMaintenanceInputDescription, 10, 400, 0, "Arial")
$FormSetupMaintenanceListTimes = GUICtrlCreateList("", 24, 134, 73, 116, BitOR($LBS_NOTIFY,$WS_VSCROLL))
GUICtrlSetData($FormSetupMaintenanceListTimes, "30m|1h|2h|4h|8h|12h|18h|24h|48h|72h|")
GUICtrlSetFont($FormSetupMaintenanceListTimes, 10, 400, 0, "Arial")
GUICtrlSetOnEvent($FormSetupMaintenanceListTimes, "FormSetupMaintenanceListTimesClick")
$FormSetupMaintenanceButtonAdd = GUICtrlCreateButton("Add", 104, 166, 75, 24)
GUICtrlSetFont($FormSetupMaintenanceButtonAdd, 10, 400, 0, "Arial")
GUICtrlSetOnEvent($FormSetupMaintenanceButtonAdd, "FormSetupMaintenanceButtonAddClick")
$FormSetupMaintenanceInputTime = GUICtrlCreateInput("75", 104, 134, 35, 24, BitOR($GUI_SS_DEFAULT_INPUT,$ES_RIGHT,$ES_NUMBER))
GUICtrlSetFont($FormSetupMaintenanceInputTime, 10, 400, 0, "Arial")
$FormSetupMaintenanceButtonDelete = GUICtrlCreateButton("Delete", 104, 198, 75, 24)
GUICtrlSetFont($FormSetupMaintenanceButtonDelete, 10, 400, 0, "Arial")
GUICtrlSetOnEvent($FormSetupMaintenanceButtonDelete, "FormSetupMaintenanceButtonDeleteClick")
$FormSetupMaintenanceLabelTimes = GUICtrlCreateLabel("Times", 24, 112, 73, 22, $SS_CENTER)
GUICtrlSetFont($FormSetupMaintenanceLabelTimes, 12, 400, 0, "Arial")
GUICtrlSetBkColor($FormSetupMaintenanceLabelTimes, 0xE3E3E3)
$FormSetupMaintenanceComboUnit = GUICtrlCreateCombo("m", 144, 134, 33, 25, BitOR($CBS_DROPDOWN,$CBS_AUTOHSCROLL))
GUICtrlSetData($FormSetupMaintenanceComboUnit, "s|m|h|d")
GUICtrlSetFont($FormSetupMaintenanceComboUnit, 10, 400, 0, "Arial")
GUICtrlSetOnEvent($FormSetupMaintenanceComboUnit, "FormSetupMaintenanceComboUnitChange")
$FormSetupTabSheetTrigger = GUICtrlCreateTabItem("Trigger")
$FormSetupTriggerLabelNotclassified = GUICtrlCreateLabel("Not classified", 40, 58, 82, 20, $SS_RIGHT)
GUICtrlSetFont($FormSetupTriggerLabelNotclassified, 10, 400, 0, "Arial")
GUICtrlSetBkColor($FormSetupTriggerLabelNotclassified, 0xFFFFFF)
$FormSetupTriggerInputNotclassified = GUICtrlCreateInput("Not classified", 128, 55, 185, 24)
GUICtrlSetFont($FormSetupTriggerInputNotclassified, 10, 400, 0, "Arial")
$FormSetupTriggerLabelColorNotclassified = GUICtrlCreateLabel("", 320, 55, 24, 24)
GUICtrlSetFont($FormSetupTriggerLabelColorNotclassified, 10, 400, 0, "Arial")
GUICtrlSetCursor ($FormSetupTriggerLabelColorNotclassified, 0)
GUICtrlSetOnEvent($FormSetupTriggerLabelColorNotclassified, "FormSetupTriggerLabelColorNotclassifiedClick")
$FormSetupTriggerInputColorNotclassified = GUICtrlCreateInput("97AAB3", 352, 55, 65, 25)
GUICtrlSetFont($FormSetupTriggerInputColorNotclassified, 11, 400, 0, "Courier New")
GUICtrlSetOnEvent($FormSetupTriggerInputColorNotclassified, "FormSetupTriggerInputColorNotclassifiedChange")
$FormSetupTriggerLabelInformation = GUICtrlCreateLabel("Infomation", 40, 90, 82, 20, $SS_RIGHT)
GUICtrlSetFont($FormSetupTriggerLabelInformation, 10, 400, 0, "Arial")
GUICtrlSetBkColor($FormSetupTriggerLabelInformation, 0xFFFFFF)
$FormSetupTriggerInputInformation = GUICtrlCreateInput("Information", 128, 87, 185, 24)
GUICtrlSetFont($FormSetupTriggerInputInformation, 10, 400, 0, "Arial")
$FormSetupTriggerLabelColorInformation = GUICtrlCreateLabel("", 320, 87, 24, 24)
GUICtrlSetFont($FormSetupTriggerLabelColorInformation, 10, 400, 0, "Arial")
GUICtrlSetBkColor($FormSetupTriggerLabelColorInformation, 0xB9D1EA)
GUICtrlSetCursor ($FormSetupTriggerLabelColorInformation, 0)
GUICtrlSetOnEvent($FormSetupTriggerLabelColorInformation, "FormSetupTriggerLabelColorInformationClick")
$FormSetupTriggerInputColorInformation = GUICtrlCreateInput("7499FF", 352, 87, 65, 25)
GUICtrlSetFont($FormSetupTriggerInputColorInformation, 11, 400, 0, "Courier New")
GUICtrlSetOnEvent($FormSetupTriggerInputColorInformation, "FormSetupTriggerInputColorInformationChange")
$FormSetupTriggerLabelWarning = GUICtrlCreateLabel("Warning", 40, 122, 82, 20, $SS_RIGHT)
GUICtrlSetFont($FormSetupTriggerLabelWarning, 10, 400, 0, "Arial")
GUICtrlSetBkColor($FormSetupTriggerLabelWarning, 0xFFFFFF)
$FormSetupTriggerInputWarning = GUICtrlCreateInput("Warning", 128, 119, 185, 24)
GUICtrlSetFont($FormSetupTriggerInputWarning, 10, 400, 0, "Arial")
$FormSetupTriggerLabelColorWarning = GUICtrlCreateLabel("", 320, 119, 24, 24)
GUICtrlSetFont($FormSetupTriggerLabelColorWarning, 10, 400, 0, "Arial")
GUICtrlSetBkColor($FormSetupTriggerLabelColorWarning, 0xFF00FF)
GUICtrlSetCursor ($FormSetupTriggerLabelColorWarning, 0)
GUICtrlSetOnEvent($FormSetupTriggerLabelColorWarning, "FormSetupTriggerLabelColorWarningClick")
$FormSetupTriggerInputColorWarning = GUICtrlCreateInput("FFC859", 352, 119, 65, 25)
GUICtrlSetFont($FormSetupTriggerInputColorWarning, 11, 400, 0, "Courier New")
GUICtrlSetOnEvent($FormSetupTriggerInputColorWarning, "FormSetupTriggerInputColorWarningChange")
$FormSetupTriggerLabelAverage = GUICtrlCreateLabel("Average", 40, 154, 82, 20, $SS_RIGHT)
GUICtrlSetFont($FormSetupTriggerLabelAverage, 10, 400, 0, "Arial")
GUICtrlSetBkColor($FormSetupTriggerLabelAverage, 0xFFFFFF)
$FormSetupTriggerInputAverage = GUICtrlCreateInput("Average", 128, 151, 185, 24)
GUICtrlSetFont($FormSetupTriggerInputAverage, 10, 400, 0, "Arial")
$FormSetupTriggerLabelColorAverage = GUICtrlCreateLabel("", 320, 151, 24, 24)
GUICtrlSetFont($FormSetupTriggerLabelColorAverage, 10, 400, 0, "Arial")
GUICtrlSetBkColor($FormSetupTriggerLabelColorAverage, 0xFFFF00)
GUICtrlSetCursor ($FormSetupTriggerLabelColorAverage, 0)
GUICtrlSetOnEvent($FormSetupTriggerLabelColorAverage, "FormSetupTriggerLabelColorAverageClick")
$FormSetupTriggerInputColorAverage = GUICtrlCreateInput("FFA059", 352, 151, 65, 25)
GUICtrlSetFont($FormSetupTriggerInputColorAverage, 11, 400, 0, "Courier New")
GUICtrlSetOnEvent($FormSetupTriggerInputColorAverage, "FormSetupTriggerInputColorAverageChange")
$FormSetupTriggerLabelHigh = GUICtrlCreateLabel("High", 40, 186, 82, 20, $SS_RIGHT)
GUICtrlSetFont($FormSetupTriggerLabelHigh, 10, 400, 0, "Arial")
GUICtrlSetBkColor($FormSetupTriggerLabelHigh, 0xFFFFFF)
$FormSetupTriggerInputHigh = GUICtrlCreateInput("High", 128, 183, 185, 24)
GUICtrlSetFont($FormSetupTriggerInputHigh, 10, 400, 0, "Arial")
$FormSetupTriggerLabelColorHigh = GUICtrlCreateLabel("", 320, 183, 24, 24)
GUICtrlSetFont($FormSetupTriggerLabelColorHigh, 10, 400, 0, "Arial")
GUICtrlSetBkColor($FormSetupTriggerLabelColorHigh, 0x800000)
GUICtrlSetCursor ($FormSetupTriggerLabelColorHigh, 0)
GUICtrlSetOnEvent($FormSetupTriggerLabelColorHigh, "FormSetupTriggerLabelColorHighClick")
$FormSetupTriggerInputColorHigh = GUICtrlCreateInput("E97659", 352, 183, 65, 25)
GUICtrlSetFont($FormSetupTriggerInputColorHigh, 11, 400, 0, "Courier New")
GUICtrlSetOnEvent($FormSetupTriggerInputColorHigh, "FormSetupTriggerInputColorHighChange")
$FormSetupTriggerLabelDisaster = GUICtrlCreateLabel("Disaster", 40, 218, 82, 20, $SS_RIGHT)
GUICtrlSetFont($FormSetupTriggerLabelDisaster, 10, 400, 0, "Arial")
GUICtrlSetBkColor($FormSetupTriggerLabelDisaster, 0xFFFFFF)
$FormSetupTriggerInputDisaster = GUICtrlCreateInput("Disaster", 128, 215, 185, 24)
GUICtrlSetFont($FormSetupTriggerInputDisaster, 10, 400, 0, "Arial")
$FormSetupTriggerLabelColorDisaster = GUICtrlCreateLabel("", 320, 215, 24, 24)
GUICtrlSetFont($FormSetupTriggerLabelColorDisaster, 10, 400, 0, "Arial")
GUICtrlSetBkColor($FormSetupTriggerLabelColorDisaster, 0xFF0000)
GUICtrlSetCursor ($FormSetupTriggerLabelColorDisaster, 0)
GUICtrlSetOnEvent($FormSetupTriggerLabelColorDisaster, "FormSetupTriggerLabelColorDisasterClick")
$FormSetupTriggerInputColorDisaster = GUICtrlCreateInput("E45959", 352, 215, 65, 25)
GUICtrlSetFont($FormSetupTriggerInputColorDisaster, 11, 400, 0, "Courier New")
GUICtrlSetOnEvent($FormSetupTriggerInputColorDisaster, "FormSetupTriggerInputColorDisasterChange")
$FormSetupTabSheetCheck = GUICtrlCreateTabItem("Check")
$FormSetupCheckLabelEvery1 = GUICtrlCreateLabel("every", 80, 102, 50, 20, $SS_RIGHT)
GUICtrlSetFont($FormSetupCheckLabelEvery1, 10, 400, 0, "Arial")
GUICtrlSetBkColor($FormSetupCheckLabelEvery1, 0xFFFFFF)
$FormSetupCheckCheckboxMaintenanceStatus = GUICtrlCreateCheckbox("Check maintenance status", 64, 80, 361, 17)
GUICtrlSetState($FormSetupCheckCheckboxMaintenanceStatus, $GUI_CHECKED)
GUICtrlSetFont($FormSetupCheckCheckboxMaintenanceStatus, 10, 400, 0, "Arial")
GUICtrlSetOnEvent($FormSetupCheckCheckboxMaintenanceStatus, "FormSetupCheckCheckboxMaintenanceStatusClick")
$FormSetupCheckComboTimesMaintenance = GUICtrlCreateCombo("1m", 136, 100, 97, 25, BitOR($CBS_DROPDOWN,$CBS_AUTOHSCROLL))
GUICtrlSetData($FormSetupCheckComboTimesMaintenance, "30s|1m|2m|3m|5m|10m|15m|30m|1h")
GUICtrlSetFont($FormSetupCheckComboTimesMaintenance, 10, 400, 0, "Arial")
GUICtrlSetOnEvent($FormSetupCheckComboTimesMaintenance, "FormSetupCheckComboTimesMaintenanceChange")
$FormSetupCheckCheckboxTrigger = GUICtrlCreateCheckbox("Check unacknowledged trigger", 64, 158, 361, 17)
GUICtrlSetState($FormSetupCheckCheckboxTrigger, $GUI_CHECKED)
GUICtrlSetFont($FormSetupCheckCheckboxTrigger, 10, 400, 0, "Arial")
GUICtrlSetOnEvent($FormSetupCheckCheckboxTrigger, "FormSetupCheckCheckboxTriggerClick")
$FormSetupCheckLabelEvery2 = GUICtrlCreateLabel("every", 80, 180, 50, 20, $SS_RIGHT)
GUICtrlSetFont($FormSetupCheckLabelEvery2, 10, 400, 0, "Arial")
GUICtrlSetBkColor($FormSetupCheckLabelEvery2, 0xFFFFFF)
$FormSetupCheckComboTimesTrigger = GUICtrlCreateCombo("1m", 136, 178, 97, 25, BitOR($CBS_DROPDOWN,$CBS_AUTOHSCROLL))
GUICtrlSetData($FormSetupCheckComboTimesTrigger, "30s|1m|2m|3m|5m|10m|15m|30m|1h")
GUICtrlSetFont($FormSetupCheckComboTimesTrigger, 10, 400, 0, "Arial")
GUICtrlSetOnEvent($FormSetupCheckComboTimesTrigger, "FormSetupCheckComboTimesTriggerChange")
$FormSetupTabSheetAcknowledge = GUICtrlCreateTabItem("Acknowledge")
$FormSetupAcknowledgeLabelDefaultMessage = GUICtrlCreateLabel("Default Message Text", 16, 40, 130, 20)
GUICtrlSetFont($FormSetupAcknowledgeLabelDefaultMessage, 10, 400, 0, "Arial")
GUICtrlSetBkColor($FormSetupAcknowledgeLabelDefaultMessage, 0xFFFFFF)
$FormSetupAcknowledgeEditDefaultMessage = GUICtrlCreateEdit("", 16, 64, 425, 137)
GUICtrlSetData($FormSetupAcknowledgeEditDefaultMessage, StringFormat("This problem is ignored.\r\nIt is enough for the next occurrence of the problem to do something.\r\n\r\nUSERDOMAIN\USERNAME\r\n"))
GUICtrlSetFont($FormSetupAcknowledgeEditDefaultMessage, 10, 400, 0, "Arial")
$FormSetupAcknowledgeCheckboxCloseProblems = GUICtrlCreateCheckbox("Try to close problems", 16, 232, 201, 17)
GUICtrlSetFont($FormSetupAcknowledgeCheckboxCloseProblems, 10, 400, 0, "Arial")
$FormSetupAcknowledgeCheckboxNeverAsk = GUICtrlCreateCheckbox("Never ask - always use default message", 16, 208, 289, 17)
GUICtrlSetState($FormSetupAcknowledgeCheckboxNeverAsk, $GUI_CHECKED)
GUICtrlSetFont($FormSetupAcknowledgeCheckboxNeverAsk, 10, 400, 0, "Arial")
$FormSetupTabSheetInfo = GUICtrlCreateTabItem("Info")
$FormSetupInfoLabelVersionLeft = GUICtrlCreateLabel("Version:", 16, 48, 84, 20, $SS_RIGHT)
GUICtrlSetFont($FormSetupInfoLabelVersionLeft, 10, 400, 0, "Arial")
GUICtrlSetBkColor($FormSetupInfoLabelVersionLeft, 0xFFFFFF)
$FormSetupInfoLabelDateTimeLeft = GUICtrlCreateLabel("Date/Time:", 13, 72, 84, 20, $SS_RIGHT)
GUICtrlSetFont($FormSetupInfoLabelDateTimeLeft, 10, 400, 0, "Arial")
GUICtrlSetBkColor($FormSetupInfoLabelDateTimeLeft, 0xFFFFFF)
$FormSetupInfoLabelAutorLeft = GUICtrlCreateLabel("Autor:", 13, 120, 84, 20, $SS_RIGHT)
GUICtrlSetFont($FormSetupInfoLabelAutorLeft, 10, 400, 0, "Arial")
GUICtrlSetBkColor($FormSetupInfoLabelAutorLeft, 0xFFFFFF)
$FormSetupInfoLabelHomepageLeft = GUICtrlCreateLabel("Homepage:", 13, 144, 84, 20, $SS_RIGHT)
GUICtrlSetFont($FormSetupInfoLabelHomepageLeft, 10, 400, 0, "Arial")
GUICtrlSetBkColor($FormSetupInfoLabelHomepageLeft, 0xFFFFFF)
$FormSetupInfoLabelRepositoryLeft = GUICtrlCreateLabel("Repository", 13, 168, 84, 20, $SS_RIGHT)
GUICtrlSetFont($FormSetupInfoLabelRepositoryLeft, 10, 400, 0, "Arial")
GUICtrlSetBkColor($FormSetupInfoLabelRepositoryLeft, 0xFFFFFF)
$FormSetupInfoLabelHomepageRight = GUICtrlCreateLabel("https://znil.net", 101, 144, 308, 20)
GUICtrlSetFont($FormSetupInfoLabelHomepageRight, 10, 400, 4, "Arial")
GUICtrlSetColor($FormSetupInfoLabelHomepageRight, 0x0000FF)
GUICtrlSetBkColor($FormSetupInfoLabelHomepageRight, 0xFFFFFF)
GUICtrlSetCursor ($FormSetupInfoLabelHomepageRight, 0)
GUICtrlSetOnEvent($FormSetupInfoLabelHomepageRight, "FormSetupInfoLabelHomepageRightClick")
$FormSetupInfoLabelRepositoryRight = GUICtrlCreateLabel("https://github.com/znilnet/ZabbixEasyTool", 101, 168, 308, 20)
GUICtrlSetFont($FormSetupInfoLabelRepositoryRight, 10, 400, 4, "Arial")
GUICtrlSetColor($FormSetupInfoLabelRepositoryRight, 0x0000FF)
GUICtrlSetBkColor($FormSetupInfoLabelRepositoryRight, 0xFFFFFF)
GUICtrlSetCursor ($FormSetupInfoLabelRepositoryRight, 0)
GUICtrlSetOnEvent($FormSetupInfoLabelRepositoryRight, "FormSetupInfoLabelRepositoryRightClick")
$FormSetupInfoLabelAutorRight = GUICtrlCreateLabel("Bernhard Linz", 101, 120, 308, 20)
GUICtrlSetFont($FormSetupInfoLabelAutorRight, 10, 400, 0, "Arial")
GUICtrlSetBkColor($FormSetupInfoLabelAutorRight, 0xFFFFFF)
$FormSetupInfoLabelLicenseLeft = GUICtrlCreateLabel("License:", 13, 216, 84, 20, $SS_RIGHT)
GUICtrlSetFont($FormSetupInfoLabelLicenseLeft, 10, 400, 0, "Arial")
GUICtrlSetBkColor($FormSetupInfoLabelLicenseLeft, 0xFFFFFF)
$FormSetupInfoLabelLicenseRight = GUICtrlCreateLabel("https://github.com/znilnet/ZabbixEasyTool/./LICENSE.txt", 101, 216, 340, 20)
GUICtrlSetFont($FormSetupInfoLabelLicenseRight, 10, 400, 4, "Arial")
GUICtrlSetColor($FormSetupInfoLabelLicenseRight, 0x0000FF)
GUICtrlSetBkColor($FormSetupInfoLabelLicenseRight, 0xFFFFFF)
GUICtrlSetCursor ($FormSetupInfoLabelLicenseRight, 0)
GUICtrlSetOnEvent($FormSetupInfoLabelLicenseRight, "FormSetupInfoLabelLicenseRightClick")
$FormSetupInfoLabelVersionRight = GUICtrlCreateLabel("0.0.0.1", 101, 48, 308, 20)
GUICtrlSetFont($FormSetupInfoLabelVersionRight, 10, 400, 0, "Arial")
GUICtrlSetBkColor($FormSetupInfoLabelVersionRight, 0xFFFFFF)
$FormSetupInfoLabelDateTimeRight = GUICtrlCreateLabel("2017-09-16 08:59:00", 101, 72, 308, 20)
GUICtrlSetFont($FormSetupInfoLabelDateTimeRight, 10, 400, 0, "Arial")
GUICtrlSetBkColor($FormSetupInfoLabelDateTimeRight, 0xFFFFFF)
GUICtrlCreateTabItem("")
$FormSetupButtonOK = GUICtrlCreateButton("&OK", 214, 272, 75, 25)
GUICtrlSetOnEvent($FormSetupButtonOK, "FormSetupButtonOKClick")
$FormSetupButtonCancel = GUICtrlCreateButton("&Cancel", 294, 272, 75, 25)
GUICtrlSetOnEvent($FormSetupButtonCancel, "FormSetupButtonCancelClick")
$FormSetupButtonHelp = GUICtrlCreateButton("&Help", 376, 272, 75, 25)
GUICtrlSetOnEvent($FormSetupButtonHelp, "FormSetupButtonHelpClick")
$FormSetupInfoEditGPOisActive = GUICtrlCreateEdit("", 8, 264, 201, 41, BitOR($ES_CENTER,$ES_READONLY,$ES_WANTRETURN))
GUICtrlSetData($FormSetupInfoEditGPOisActive, StringFormat("Some Values are blocked by \r\nGroup Policy"))
GUICtrlSetFont($FormSetupInfoEditGPOisActive, 10, 800, 0, "Arial")
GUICtrlSetColor($FormSetupInfoEditGPOisActive, 0xFFFF00)
GUICtrlSetBkColor($FormSetupInfoEditGPOisActive, 0xFF0000)
GUISetState(@SW_SHOW)
#EndRegion ### END Koda GUI section ###
GUISetState(@SW_HIDE, $FormSetup)

GUICtrlSetState($FormSetupTabSheetZabbixAPI, $GUI_SHOW)
GUICtrlSetState($FormSetupInfoEditGPOisActive, $GUI_HIDE)

; Fill ListBox with ArrayValue
GUICtrlSetData($FormSetupMaintenanceListTimes, "")
$s_temp = ""
For $n = 1 To $g_a_MaintenanceTimes[0] Step 1
	$s_temp = $s_temp & _SecondsToTime($g_a_MaintenanceTimes[$n]) & "|"
Next
GUICtrlSetData($FormSetupMaintenanceListTimes, $s_temp)

; Set TriggerColors
GUICtrlSetBkColor($FormSetupTriggerLabelColorNotclassified, 	0x97AAB3)
GUICtrlSetBkColor($FormSetupTriggerLabelColorInformation, 		0x7499FF)
GUICtrlSetBkColor($FormSetupTriggerLabelColorWarning, 			0xFFC859)
GUICtrlSetBkColor($FormSetupTriggerLabelColorAverage, 			0xFFA059)
GUICtrlSetBkColor($FormSetupTriggerLabelColorHigh, 				0xE97659)
GUICtrlSetBkColor($FormSetupTriggerLabelColorDisaster, 			0xE45959)


;~ GUISetState(@SW_HIDE, $FormMain)
;~ MsgBox(262208,"TimeToSeconds",_TimeToSeconds(GUICtrlRead($FormSetupCheckComboTimesMaintenance)),10)
;~ exit
;~ _ReplaceEnviromentVariables("TEST")
;~ exit
; Startup
#Region Startup
_GDIPlus_Startup()
$g_Icon_green = _GDIPlus_BitmapCreateFromMemory(_Zeasy_greenico(), False)
$g_Icon_grey = _GDIPlus_BitmapCreateFromMemory(_Zeasy_greyico(), False)
$g_Icon_red = _GDIPlus_BitmapCreateFromMemory(_Zeasy_redico(), False)
;~ Global $g_Icon_green16 = _GDIPlus_BitmapCreateFromMemory(_Zeasy_green16ico(), False)
;~ Global $g_Icon_TrayGreen = _GDIPlus_HICONCreateFromBitmap($g_Icon_green16)
$g_Icon_TrayGreen = _GDIPlus_HICONCreateFromBitmap($g_Icon_green)
$g_Icon_TrayGrey = _GDIPlus_HICONCreateFromBitmap($g_Icon_grey)
$g_Icon_TrayRed = _GDIPlus_HICONCreateFromBitmap($g_Icon_red)

_WinAPI_SetWindowTitleIcon($g_Icon_grey, $FormMain)

AutoItSetOption("TrayOnEventMode", 1)
AutoItSetOption("TrayAutoPause", 0)
AutoItSetOption("TrayMenuMode", 3)


$g_Tray_Headline = TrayCreateItem("ZabbixEasyTool")
TrayItemSetOnEvent($g_Tray_Headline,"_ShowGUI")
TrayCreateItem("")
$g_Tray_ShowGUI = TrayCreateItem("Show GUI")
TrayItemSetOnEvent($g_Tray_ShowGUI,"_ShowGUI")
$g_Tray_Setup = TrayCreateItem("Setup")
TrayItemSetOnEvent($g_Tray_Setup,"FormMainButtonSetupClick")
$g_Tray_Exit = TrayCreateItem("Exit")
TrayItemSetOnEvent($g_Tray_Exit,"_Exit")
_WinAPI_TraySetHIcon($g_Icon_TrayGrey, $FormMain)
TraySetToolTip("ZabbixEasyTool" & @CRLF & "Maintenance periods + Trigger")

$g_ico_CurrentTrayIcon = $g_Icon_TrayGrey
AdlibRegister("_ShowTrayIcon", 1000)


_SettingsRead()
ControlFocus($FormMain, "", $FormMainButtonMaintenanceSet)

If GUICtrlRead($FormSetupCheckCheckboxMaintenanceStatus) = $GUI_CHECKED Then
	_CheckMaintenanceStatus()
	AdlibRegister("_CheckMaintenanceStatus", _TimeToSeconds(GUICtrlRead($FormSetupCheckComboTimesMaintenance)) * 1000)
EndIf
If GUICtrlRead($FormSetupCheckCheckboxTrigger) = $GUI_CHECKED Then
	_CheckTriggerStatus()
	AdlibRegister("_CheckTriggerStatus", _TimeToSeconds(GUICtrlRead($FormSetupCheckComboTimesTrigger)) * 1000)
EndIf



While 1
	Sleep(100)
WEnd
#EndRegion Startup

