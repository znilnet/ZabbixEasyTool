#include <Array.au3>
#include <Date.au3>
AutoItSetOption("MustDeclareVars", 1)


;~ Global $g_ZabbixAPI_URL = "http://192.168.45.15/api_jsonrpc.php"
Global $g_ZabbixAPI_URL = "https://zabbix.znil.net/api_jsonrpc.php"
Global $g_ZabbixAPI_User = "zbxapi"
Global $g_ZabbixAPI_Password = "2015zbxapi2015"
Global $g_ZabbixSessionId = ""
Global $g_ZabbixHostId = ""
Global $g_a_ZabbixMaintainanceId[1] = [ 0 ]

Global $g_ZabbixHostname = "EXCHANGE2.znil.local"



; Funktionen

Func _SecondsToTime($__iSec)
	Local $__iRetH = 0, $__iRetM = 0, $__iRetS = 0
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
	Return StringFormat("%.2dh %.2dm %.2ds", $__iRetH, $__iRetM, $__iRetS)
EndFunc   ;==>_SecondsToTime

Func _zbx_Login( $__zbxURL, $__zbxUser, $__zbxPassword)
	Local $__zbxJSON = '{"params":{"password":"' & $__zbxPassword & '","user":"' & $__zbxUser & '","userData":true},"jsonrpc":"2.0","method":"user.login","id":42}'
	Local $__oHTTP = ObjCreate("winhttp.winhttprequest.5.1")
	Local $__zbxSessionId = 0
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
	MsgBox(0, "_zbx_Logout", StringReplace($__oReceived,",", "," & @CRLF) & @CRLF & @CRLF & "Status Code: " & $__oStatusCode)
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

Func _zbx_HostGetId($__zbxURL, $__zbxSessionId, $__zbxHostname)
	Local $__zbxJSON = '{"params":{"filter":{"name":"' & $__zbxHostname & '"},"output":["hostid"]},"jsonrpc": "2.0","method": "host.get","auth": "' & $__zbxSessionId & '","id":42}'
	Local $__oHTTP = ObjCreate("winhttp.winhttprequest.5.1")
	Local $__zbxHostId = 0
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

Func _zbx_HostGetMaintenanceIDs($__zbxURL, $__zbxSessionId, $__zbxHostId, $__zbxFilterByName = "")
	Local $__zbxJSON = '{"params":{"output":"extend","selectHosts":"refer","selectGroups": "refer","hostids": "' & $__zbxHostId & '"},"jsonrpc": "2.0","method": "maintenance.get","auth": "' & $__zbxSessionId & '","id":42}'
	Local $__oHTTP = ObjCreate("winhttp.winhttprequest.5.1")
	Local $__a_zbxHostMaintenanceId[1] = [ 0 ]
	$__oHTTP.Open("POST", $__zbxURL , False)
    $__oHTTP.Option("WinHttpRequestOption_SslErrorIgnoreFlags") = 0x3300
	$__oHTTP.SetRequestHeader("Content-Type", "application/json-rpc")
	$__oHTTP.Send($__zbxJSON)
	Local $__oReceived = $__oHTTP.ResponseText
	Local $__oStatusCode = $__oHTTP.Status
;~ 	MsgBox(0, "_zbx_HostGetMaintenanceIDs", StringReplace($__oReceived,",", "," & @CRLF) & @CRLF & @CRLF & "Status Code: " & $__oStatusCode)
	If $__oStatusCode = 200 Then
		Local $__atemp = StringSplit($__oReceived, ",:", 0)
		For $i = 1 To $__atemp[0] Step 1
			If StringInStr($__atemp[$i], "maintenanceid") > 0 Then
				If $__zbxFilterByName <> "" Then
					For $j = 1 To 12 Step 1
						If StringInStr($__atemp[$i + $j], "ZabbixEasy") > 0 Then
							$__a_zbxHostMaintenanceId[0] = $__a_zbxHostMaintenanceId[0] + 1
							ReDim $__a_zbxHostMaintenanceId[ $__a_zbxHostMaintenanceId[0] + 1 ]
							$__a_zbxHostMaintenanceId[ $__a_zbxHostMaintenanceId[0] ] = StringRegExpReplace($__atemp[$i + 1], '[^A-Za-z0-9_().+\%\-\s]+', "")
							$i = $i + 1
							ExitLoop
						EndIf
					Next
				Else
					$__a_zbxHostMaintenanceId[0] = $__a_zbxHostMaintenanceId[0] + 1
					ReDim $__a_zbxHostMaintenanceId[ $__a_zbxHostMaintenanceId[0] + 1 ]
					$__a_zbxHostMaintenanceId[ $__a_zbxHostMaintenanceId[0] ] = StringRegExpReplace($__atemp[$i + 1], '[^A-Za-z0-9_().+\%\-\s]+', "")
					$i = $i + 1
				EndIf
			EndIf
		Next
	EndIf
	Return $__a_zbxHostMaintenanceId
EndFunc

Func _zbx_HostAddMaintenance($__zbxURL, $__zbxSessionId, $__zbxHostId, $__zbxDurationTime = 3600)
	Local $__StartTimeStructUTC = _Date_Time_GetSystemTime()
	Local $__StartTimeUTC = _DateDiff('s', "1970/01/01 00:00:00", _Date_Time_SystemTimeToDateTimeStr($__StartTimeStructUTC, 1))
	Local $__EndTimeUTC = $__StartTimeUTC + $__zbxDurationTime
	Local $__zbxJSON = '{"jsonrpc":"2.0","method":"maintenance.create","params":[{"groupids":[],"hostids":["' & $__zbxHostId & '"],' & _
        '"name":"ZabbixEasy - ' & $g_ZabbixHostname & ' - ' & @YEAR & '-' & @MON & '-' & @MDAY & ' ' & @HOUR & ':' & @MIN & ':' & @SEC & ' => ' & _SecondsToTime($__zbxDurationTime) & '",' & _
        '"maintenance_type":"0","description":"set by ' & @UserName & '","active_since":"' & $__StartTimeUTC & '","active_till":"' & $__EndTimeUTC & '",' & _
        '"timeperiods":[{"timeperiod_type":0,"start_date":"' & $__StartTimeUTC & '","period":' & $__EndTimeUTC & '}]}],"auth":"' & $__zbxSessionId & '","id":42}'
	Local $__oHTTP = ObjCreate("winhttp.winhttprequest.5.1")
	Local $__zbxMaintenanceId = 0
	$__oHTTP.Open("POST", $__zbxURL , False)
    $__oHTTP.Option("WinHttpRequestOption_SslErrorIgnoreFlags") = 0x3300
	$__oHTTP.SetRequestHeader("Content-Type", "application/json-rpc")
	$__oHTTP.Send($__zbxJSON)
	Local $__oReceived = $__oHTTP.ResponseText
	Local $__oStatusCode = $__oHTTP.Status
;~ 	MsgBox(0, "_zbx_HostAddMaintenance", StringReplace($__oReceived,",", "," & @CRLF) & @CRLF & @CRLF & "Status Code: " & $__oStatusCode)
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

Func _zbxHostRemoveMaintenance($__zbxURL, $__zbxSessionId, $__zbxHostId, $__zbxMaintenanceId)
	Local $__zbxJSON = '{"jsonrpc":"2.0","method":"maintenance.delete","params":["' & $__zbxMaintenanceId & '"],"auth":"' & $__zbxSessionId & '","id":42}'
	Local $__oHTTP = ObjCreate("winhttp.winhttprequest.5.1")
	Local $__zbxResult = 0
	$__oHTTP.Open("POST", $__zbxURL , False)
    $__oHTTP.Option("WinHttpRequestOption_SslErrorIgnoreFlags") = 0x3300
	$__oHTTP.SetRequestHeader("Content-Type", "application/json-rpc")
	$__oHTTP.Send($__zbxJSON)
	Local $__oReceived = $__oHTTP.ResponseText
	Local $__oStatusCode = $__oHTTP.Status
	MsgBox(0, "_zbxHostRemoveMaintenance", StringReplace($__oReceived,",", "," & @CRLF) & @CRLF & @CRLF & "Status Code: " & $__oStatusCode)
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

Func _zbxHostTriggerGet($__zbxURL, $__zbxSessionId, $__zbxHostId)
	Local $__zbxJSON = '{"jsonrpc": "2.0","method": "trigger.get","params":{"output":["triggerid","description","priority"],' & _
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
	MsgBox(0, "_zbxHostTriggerGet", StringReplace($__oReceived,",", "," & @CRLF) & @CRLF & @CRLF & "Status Code: " & $__oStatusCode)
	If $__oStatusCode = 200 Then
		Local $__atemp = StringSplit($__oReceived, ",:", 0)
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

Func _zbxTriggerEventGet($__zbxURL, $__zbxSessionId, $__zbxTriggerId)
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
	MsgBox(0, "_zbxHostEventGet", StringReplace($__oReceived,",", "," & @CRLF) & @CRLF & @CRLF & "Status Code: " & $__oStatusCode)
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

Func _zbxEventAcknowledge($__zbxURL, $__zbxSessionId, $__zbxEvendId, $__zbxMessage = "ZabbixEasy")
	Local $__zbxJSON = '{"jsonrpc":"2.0","method":"event.acknowledge","params":{"eventids": "' & $__zbxEvendId & '","message":"' & $__zbxMessage & '","action":0},"auth": "' & $__zbxSessionId & '","id":42}'
	Local $__oHTTP = ObjCreate("winhttp.winhttprequest.5.1")
	Local $__zbxResult = 0
	$__oHTTP.Open("POST", $__zbxURL , False)
    $__oHTTP.Option("WinHttpRequestOption_SslErrorIgnoreFlags") = 0x3300
	$__oHTTP.SetRequestHeader("Content-Type", "application/json-rpc")
	$__oHTTP.Send($__zbxJSON)
	Local $__oReceived = $__oHTTP.ResponseText
	Local $__oStatusCode = $__oHTTP.Status
	MsgBox(0, "_zbxHostRemoveMaintenance", StringReplace($__oReceived,",", "," & @CRLF) & @CRLF & @CRLF & "Status Code: " & $__oStatusCode)
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

;~ MsgBox(0,"",IsAdmin())
;~ Exit

; Main
$g_ZabbixSessionId = _zbx_Login($g_ZabbixAPI_URL, $g_ZabbixAPI_User, $g_ZabbixAPI_Password)
;~ MsgBox(262144, 'Debug line ~' & @ScriptLineNumber, 'Selection:' & @CRLF & '$g_ZabbixSessionId' & @CRLF & @CRLF & 'Return:' & @CRLF & $g_ZabbixSessionId) ;### Debug MSGBOX

$g_ZabbixHostId = _zbx_HostGetId($g_ZabbixAPI_URL, $g_ZabbixSessionId, $g_ZabbixHostname)
;~ MsgBox(262144, 'Debug line ~' & @ScriptLineNumber, 'Selection:' & @CRLF & '$g_ZabbixHostId' & @CRLF & @CRLF & 'Return:' & @CRLF & $g_ZabbixHostId) ;### Debug MSGBOX


Local $g_a_Triggers = _zbxHostTriggerGet($g_ZabbixAPI_URL, $g_ZabbixSessionId, $g_ZabbixHostId)
_ArrayDisplay($g_a_Triggers, "Trigger im Status PROBLEM")
Local $g_a_Events = _zbxTriggerEventGet($g_ZabbixAPI_URL, $g_ZabbixSessionId, $g_a_Triggers[1][1])
_ArrayDisplay($g_a_Events, "Events für Trigger " & $g_a_Triggers[1][1])

For $i = 1 To $g_a_Events[0] Step 1
	Local $g_result = _zbxEventAcknowledge($g_ZabbixAPI_URL, $g_ZabbixSessionId, $g_a_Events[$i])
	MsgBox(262144, 'Debug line ~' & @ScriptLineNumber, 'Selection:' & @CRLF & '$g_result' & @CRLF & @CRLF & 'Return:' & @CRLF & $g_result) ;### Debug MSGBOX
Next
Exit

Local $test = _zbx_HostAddMaintenance($g_ZabbixAPI_URL, $g_ZabbixSessionId, $g_ZabbixHostId, 60000)
;~ MsgBox(262144, 'Debug line ~' & @ScriptLineNumber, 'Selection:' & @CRLF & '$test' & @CRLF & @CRLF & 'Return:' & @CRLF & $test) ;### Debug MSGBOX

$g_a_ZabbixMaintainanceId = _zbx_HostGetMaintenanceIDs($g_ZabbixAPI_URL, $g_ZabbixSessionId, $g_ZabbixHostId, "ZabbixEasy")
_ArrayDisplay($g_a_ZabbixMaintainanceId, "Nur Maintenance Modes mit ZabbixEasy im Namen")

$g_a_ZabbixMaintainanceId = _zbx_HostGetMaintenanceIDs($g_ZabbixAPI_URL, $g_ZabbixSessionId, $g_ZabbixHostId)
_ArrayDisplay($g_a_ZabbixMaintainanceId, "Alle Maintenance Modes")

;~ Local $test = _zbxHostRemoveMaintenance($g_ZabbixAPI_URL, $g_ZabbixSessionId, $g_ZabbixHostId, $g_a_ZabbixMaintainanceId[1])
MsgBox(262144, 'Debug line ~' & @ScriptLineNumber, 'Selection:' & @CRLF & '$test' & @CRLF & @CRLF & 'Return:' & @CRLF & $test) ;### Debug MSGBOX

_zbx_Logout($g_ZabbixAPI_URL, $g_ZabbixSessionId)
