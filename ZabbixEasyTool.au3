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

; #############################################################################################################################################################
Func FormMainRestore()

EndFunc

; #############################################################################################################################################################
Func FormSetupAPIButtonReadDataZabbixAgentClick()
EndFunc

; #############################################################################################################################################################
Func FormSetupAPIButtonTestCredentialsClick()
EndFunc

; #############################################################################################################################################################
Func FormSetupButtonCancelClick()
	Exit
EndFunc

; #############################################################################################################################################################
Func FormSetupButtonHelpClick()
EndFunc

; #############################################################################################################################################################
; Alle Einstellungen in der Registry speichern
Func FormSetupButtonOKClick()
	_SettingsWrite()
EndFunc

; #############################################################################################################################################################
Func FormSetupCheckCheckboxMaintenanceStatusClick()
EndFunc

; #############################################################################################################################################################
Func FormSetupCheckCheckboxTriggerClick()
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
EndFunc

; #############################################################################################################################################################
Func FormSetupTriggerInputColorDisasterChange()
EndFunc

; #############################################################################################################################################################
Func FormSetupTriggerInputColorHighChange()
EndFunc

; #############################################################################################################################################################
Func FormSetupTriggerInputColorInformationChange()
EndFunc

; #############################################################################################################################################################
Func FormSetupTriggerInputColorNotclassifiedChange()
EndFunc

; #############################################################################################################################################################
Func FormSetupTriggerInputColorWarningChange()
EndFunc

; #############################################################################################################################################################
Func FormSetupTriggerLabelColorAverageClick()
EndFunc

; #############################################################################################################################################################
Func FormSetupTriggerLabelColorDisasterClick()
EndFunc

; #############################################################################################################################################################
Func FormSetupTriggerLabelColorHighClick()
EndFunc

; #############################################################################################################################################################
Func FormSetupTriggerLabelColorInformationClick()
EndFunc

; #############################################################################################################################################################
Func FormSetupTriggerLabelColorNotclassifiedClick()
EndFunc

; #############################################################################################################################################################
Func FormSetupTriggerLabelColorWarningClick()
EndFunc

; #############################################################################################################################################################
; #############################################################################################################################################################
; #############################################################################################################################################################
; #############################################################################################################################################################
Func _SettingsWrite()
	; Tab "Zabbix API"
	RegWrite("HKEY_CURRENT_USER\Software\znil.net\ZabbixEasyTool\local","$FormSetupAPIInputURL",		"REG_SZ", GUICtrlRead($FormSetupAPIInputURL))
	RegWrite("HKEY_CURRENT_USER\Software\znil.net\ZabbixEasyTool\local","$FormSetupAPIInputHost",		"REG_SZ", GUICtrlRead($FormSetupAPIInputHost))
	RegWrite("HKEY_CURRENT_USER\Software\znil.net\ZabbixEasyTool\local","$FormSetupAPIInputUsername",	"REG_SZ", GUICtrlRead($FormSetupAPIInputUsername))
	RegWrite("HKEY_CURRENT_USER\Software\znil.net\ZabbixEasyTool\local","$FormSetupAPIInputPassword",	"REG_SZ", GUICtrlRead($FormSetupAPIInputPassword))
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
GUISetState(@SW_HIDE, $FormMain)




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
$FormSetupMaintenanceListTimes = GUICtrlCreateList("", 24, 134, 73, 4, BitOR($LBS_NOTIFY,$WS_VSCROLL))
GUICtrlSetData($FormSetupMaintenanceListTimes, "0,5|1|12|18|2|24|4|48|72|8")
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

GUICtrlSetState($FormSetupTabSheetZabbixAPI, $GUI_SHOW)
GUICtrlSetState($FormSetupInfoEditGPOisActive, $GUI_HIDE)
;~ _GUICtrlTab_SetCurFocus ( $hWnd, $iIndex )




While 1
	Sleep(100)
WEnd


