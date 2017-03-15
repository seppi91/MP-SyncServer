#Region ;**** Directives created by AutoIt3Wrapper_GUI ****
#AutoIt3Wrapper_icon=Icons\Sync.ico
#AutoIt3Wrapper_outfile=SyncServer.exe
#AutoIt3Wrapper_UseX64=n
#AutoIt3Wrapper_Res_Fileversion=1.1.1.7
#AutoIt3Wrapper_Res_Language=1031
#AutoIt3Wrapper_Res_Icon_Add=Icons\online.ico
#AutoIt3Wrapper_Res_Icon_Add=Icons\offline.ico
#AutoIt3Wrapper_Res_Icon_Add=Icons\sync.ico
#AutoIt3Wrapper_Run_After=D:\Benutzer\Seppi\Documents\AutoIT\SetTxtVersion.exe -SyncServer
#EndRegion ;**** Directives created by AutoIt3Wrapper_GUI ****

;#### Includes ####
#Include <GuiButton.au3>
#include <GuiStatusBar.au3>
#Include <GuiListView.au3>
#include <GuiImageList.au3>
#include <File.au3>
#include <GuiEdit.au3>
#include <Date.au3>
#include <GuiTreeView.au3>
#include <SQLite.au3>

#include <ButtonConstants.au3>
#include <ComboConstants.au3>
#include <EditConstants.au3>
#include <GUIConstantsEx.au3>
#include <GuiIPAddress.au3>
#include <ListViewConstants.au3>
#include <StaticConstants.au3>
#include <WindowsConstants.au3>

;Includes für SyncTool
#include <Array.au3>
#include <Crypt.au3>
;###################


Opt("GUIOnEventMode", 1)
Opt("TrayMenuMode", 3)
Opt("TrayOnEventMode", 1)
#Region ### START Koda GUI section ### Form=D:\Benutzer\Seppi\Documents\AutoIT\SyncServer\Source\syncserver.kxf
$Form2 = GUICreate("Settings", 579, 808, -1, -1)
GUISetOnEvent($GUI_EVENT_CLOSE, "BtnCloseClick")
GUISetOnEvent($GUI_EVENT_MINIMIZE, "BtnTrayClick")
$BtnSave = GUICtrlCreateButton("Save", 447, 732, 123, 49, $WS_GROUP)
GUICtrlSetOnEvent($BtnSave, "BtnSaveClick")
$BtnStart = GUICtrlCreateButton("Start Now", 319, 732, 123, 49, $WS_GROUP)
GUICtrlSetOnEvent($BtnStart, "BtnStartClick")
$TabSheet = GUICtrlCreateTab(8, 8, 561, 721)
GUICtrlSetResizing($TabSheet, $GUI_DOCKWIDTH+$GUI_DOCKHEIGHT)
$TabSheet1 = GUICtrlCreateTabItem("Settings")
$Shutdown = GUICtrlCreateGroup("Standby Options", 16, 616, 225, 105)
$Label19 = GUICtrlCreateLabel("Time go to standby:", 48, 667, 97, 17)
$InputStandbyTime = GUICtrlCreateInput("", 48, 688, 57, 21, BitOR($ES_CENTER,$ES_AUTOHSCROLL,$ES_NUMBER))
$Label20 = GUICtrlCreateLabel("min", 112, 692, 20, 17)
$ChkStandby = GUICtrlCreateCheckbox("Block standby when a client is online", 32, 640, 193, 17)
GUICtrlCreateGroup("", -99, -99, 1, 1)
$Group1 = GUICtrlCreateGroup("Update/Sync Databases", 256, 616, 305, 105)
$Label21 = GUICtrlCreateLabel("day(s)", 464, 685, 32, 17)
$ChkEpg = GUICtrlCreateCheckbox("Web EPG", 273, 639, 65, 17)
GUICtrlSetOnEvent($ChkEpg, "ChkEpgClick")
$ChkMP = GUICtrlCreateCheckbox("Moving Pictures", 273, 663, 97, 17)
GUICtrlSetOnEvent($ChkMP, "ChkMPClick")
$ChkSeries = GUICtrlCreateCheckbox("TV Series", 273, 687, 97, 17)
GUICtrlSetOnEvent($ChkSeries, "ChkSeriesClick")
$ChkMusic = GUICtrlCreateCheckbox("Music", 417, 639, 57, 17)
GUICtrlSetOnEvent($ChkMusic, "ChkMusicClick")
$Label14 = GUICtrlCreateLabel("Music update interval", 433, 665, 110, 13)
$InputMusicInterval = GUICtrlCreateInput("", 433, 683, 25, 21, BitOR($ES_CENTER,$ES_AUTOHSCROLL,$ES_NUMBER))
GUICtrlCreateGroup("", -99, -99, 1, 1)
$Group2 = GUICtrlCreateGroup("Clients", 16, 40, 545, 377)
$Label1 = GUICtrlCreateLabel("PC-Name:", 27, 65, 52, 17)
$InputClient = GUICtrlCreateInput("", 27, 83, 121, 21)
$Label2 = GUICtrlCreateLabel("IP-Adresse:", 28, 121, 58, 17)
$IPAddress = _GUICtrlIpAddress_Create($Form2, 27, 139, 122, 21)
_GUICtrlIpAddress_Set($IPAddress, "192.168.0.0")
$BtnGetIP = GUICtrlCreateButton("Get IP/MAC", 163, 80, 75, 25, $WS_GROUP)
GUICtrlSetOnEvent($BtnGetIP, "BtnGetIPClick")
$Label5 = GUICtrlCreateLabel("User:", 27, 169, 29, 17)
$InputUser = GUICtrlCreateInput("", 27, 187, 121, 21)
$BtnClientAdd = GUICtrlCreateButton("Add", 291, 137, 83, 73, $WS_GROUP)
GUICtrlSetOnEvent($BtnClientAdd, "BtnClientAddClick")
$Label6 = GUICtrlCreateLabel("Password:", 163, 169, 53, 17)
$InputPass = GUICtrlCreateInput("", 163, 187, 121, 21, BitOR($ES_PASSWORD,$ES_AUTOHSCROLL))
$Label3 = GUICtrlCreateLabel("MAC-Adresse:", 164, 122, 71, 17)
$InputMac = GUICtrlCreateInput("", 164, 140, 121, 21)
$ListViewClients = GUICtrlCreateListView("Name|IP|MAC|User|Password", 27, 230, 426, 150, -1, BitOR($WS_EX_CLIENTEDGE,$LVS_EX_CHECKBOXES,$LVS_EX_FULLROWSELECT))
GUICtrlSendMsg($ListViewClients, $LVM_SETCOLUMNWIDTH, 0, 80)
GUICtrlSendMsg($ListViewClients, $LVM_SETCOLUMNWIDTH, 1, 80)
GUICtrlSendMsg($ListViewClients, $LVM_SETCOLUMNWIDTH, 2, 80)
GUICtrlSendMsg($ListViewClients, $LVM_SETCOLUMNWIDTH, 3, 80)
GUICtrlSendMsg($ListViewClients, $LVM_SETCOLUMNWIDTH, 4, 80)
$BtnClientUnmark = GUICtrlCreateButton("Un-Mark All", 462, 235, 80, 25, $WS_GROUP)
GUICtrlSetOnEvent($BtnClientUnmark, "BtnClientUnmarkClick")
$BtnClientMark = GUICtrlCreateButton("Mark All", 463, 264, 80, 25, $WS_GROUP)
GUICtrlSetOnEvent($BtnClientMark, "BtnClientMarkClick")
$BtnClientDel = GUICtrlCreateButton("Delete", 463, 292, 80, 25, $WS_GROUP)
GUICtrlSetOnEvent($BtnClientDel, "BtnClientDelClick")
$Rescan = GUICtrlCreateButton("Rescan Now", 463, 338, 80, 25, $WS_GROUP)
GUICtrlSetOnEvent($Rescan, "BtnRescanClick")
$ChkIPs = GUICtrlCreateCheckbox("Auto refresh IPs", 465, 366, 97, 17)
$BtnShutdown = GUICtrlCreateButton("Shutdown selected", 144, 384, 115, 25, $WS_GROUP)
GUICtrlSetOnEvent($BtnShutdown, "BtnShutdownClick")
$BtnWOL = GUICtrlCreateButton("Wakeup selected", 24, 384, 115, 25, $WS_GROUP)
GUICtrlSetOnEvent($BtnWOL, "BtnWOLClick")
$Label22 = GUICtrlCreateLabel("*Checked clients will be synchronized", 272, 382, 181, 17)
GUICtrlSetColor($Label22, 0x808080)
$Group5 = GUICtrlCreateGroup("Internet Update", 424, 48, 129, 49)
$ComboUpdate = GUICtrlCreateCombo("No Update", 432, 68, 113, 25)
GUICtrlSetData($ComboUpdate, "Check for SVN|Check for Stable")
GUICtrlCreateGroup("", -99, -99, 1, 1)
GUICtrlCreateGroup("", -99, -99, 1, 1)
$Group3 = GUICtrlCreateGroup("Network Adapters", 16, 424, 545, 185)
$ListViewAdapters = GUICtrlCreateListView("Name           |IP", 24, 449, 525, 150, -1, BitOR($WS_EX_CLIENTEDGE,$LVS_EX_CHECKBOXES,$LVS_EX_FULLROWSELECT))
GUICtrlSendMsg($ListViewAdapters, $LVM_SETCOLUMNWIDTH, 0, 50)
GUICtrlSendMsg($ListViewAdapters, $LVM_SETCOLUMNWIDTH, 1, 50)
$ListViewAdapters_0 = GUICtrlCreateListViewItem("aNetWorkAdapters[i][0]|aNetWorkAdapters[i][1]", $ListViewAdapters)
GUICtrlCreateGroup("", -99, -99, 1, 1)
$TabSheet2 = GUICtrlCreateTabItem("Paths")
$Group4 = GUICtrlCreateGroup("Program Paths", 15, 47, 545, 121)
$Label7 = GUICtrlCreateLabel("SyncBack.exe", 32, 72, 118, 17, $SS_RIGHT)
$InputSyncBackExe = GUICtrlCreateInput("", 152, 69, 337, 21)
$BtnSyncBrowse = GUICtrlCreateButton("Browse", 491, 68, 57, 22, $WS_GROUP)
GUICtrlSetOnEvent($BtnSyncBrowse, "BtnSyncBrowseClick")
$Label12 = GUICtrlCreateLabel("Mediaportal Programdir", 32, 120, 118, 17, $SS_RIGHT)
$InputMPDir = GUICtrlCreateInput("", 152, 117, 337, 21)
$BtnMPProgBrowse = GUICtrlCreateButton("Browse", 491, 116, 57, 22, $WS_GROUP)
GUICtrlSetOnEvent($BtnMPProgBrowse, "BtnMPProgBrowseClick")
$Label13 = GUICtrlCreateLabel("Mediaportal Appdir", 32, 144, 118, 17, $SS_RIGHT)
$InputMPAppDir = GUICtrlCreateInput("", 152, 141, 337, 21)
$BtnMPAppBrowse = GUICtrlCreateButton("Browse", 491, 140, 57, 22, $WS_GROUP)
GUICtrlSetOnEvent($BtnMPAppBrowse, "BtnMPAppBrowseClick")
$Label16 = GUICtrlCreateLabel("WebEPG.exe", 32, 96, 118, 17, $SS_RIGHT)
$InputWebEPGExe = GUICtrlCreateInput("", 152, 93, 337, 21)
$BtnWebEPGExeBrowse = GUICtrlCreateButton("Browse", 491, 92, 57, 22, $WS_GROUP)
GUICtrlSetOnEvent($BtnWebEPGExeBrowse, "BtnWebEPGExeBrowseClick")
GUICtrlCreateGroup("", -99, -99, 1, 1)
$Group6 = GUICtrlCreateGroup("Synchronisation", 16, 176, 545, 545)
$Group7 = GUICtrlCreateGroup("Profiles", 28, 247, 519, 465)
$ListViewProfiles = GUICtrlCreateListView("Name|Source|Destination|Type", 44, 363, 497, 241, -1, BitOR($WS_EX_CLIENTEDGE,$LVS_EX_CHECKBOXES,$LVS_EX_FULLROWSELECT))
GUICtrlSendMsg($ListViewProfiles, $LVM_SETCOLUMNWIDTH, 0, 100)
GUICtrlSendMsg($ListViewProfiles, $LVM_SETCOLUMNWIDTH, 1, 100)
GUICtrlSendMsg($ListViewProfiles, $LVM_SETCOLUMNWIDTH, 2, 100)
GUICtrlSendMsg($ListViewProfiles, $LVM_SETCOLUMNWIDTH, 3, 50)
GUICtrlSetState($ListViewProfiles, $GUI_DISABLE)
$InputSource = GUICtrlCreateInput("", 108, 306, 305, 21)
GUICtrlSetState($InputSource, $GUI_DISABLE)
$Label8 = GUICtrlCreateLabel("Source", 48, 308, 38, 17, $SS_RIGHT)
$BtnProfileAdd = GUICtrlCreateButton("Add", 475, 304, 67, 49, $WS_GROUP)
GUICtrlSetState($BtnProfileAdd, $GUI_DISABLE)
GUICtrlSetOnEvent($BtnProfileAdd, "BtnProfileAddClick")
$BtnProfileUnmark = GUICtrlCreateButton("Un-Mark All", 44, 611, 75, 25, $WS_GROUP)
GUICtrlSetState($BtnProfileUnmark, $GUI_DISABLE)
GUICtrlSetOnEvent($BtnProfileUnmark, "BtnProfileUnmarkClick")
$BtnProfileMark = GUICtrlCreateButton("Mark All", 124, 611, 75, 25, $WS_GROUP)
GUICtrlSetState($BtnProfileMark, $GUI_DISABLE)
GUICtrlSetOnEvent($BtnProfileMark, "BtnProfileMarkClick")
$BtnProfileDel = GUICtrlCreateButton("Delete", 466, 611, 75, 25, $WS_GROUP)
GUICtrlSetState($BtnProfileDel, $GUI_DISABLE)
GUICtrlSetOnEvent($BtnProfileDel, "BtnProfileDelClick")
$InputDestination = GUICtrlCreateInput("", 108, 330, 305, 21)
GUICtrlSetState($InputDestination, $GUI_DISABLE)
$Label9 = GUICtrlCreateLabel("Destination", 47, 332, 57, 17, $SS_RIGHT)
$BtnSourceBrowse = GUICtrlCreateButton("Browse", 415, 305, 59, 21, $WS_GROUP)
GUICtrlSetState($BtnSourceBrowse, $GUI_DISABLE)
GUICtrlSetOnEvent($BtnSourceBrowse, "BtnSourceBrowseClick")
$BtnDestinationBrowse = GUICtrlCreateButton("Browse", 415, 329, 59, 21, $WS_GROUP)
GUICtrlSetState($BtnDestinationBrowse, $GUI_DISABLE)
GUICtrlSetOnEvent($BtnDestinationBrowse, "BtnDestinationBrowseClick")
$Label10 = GUICtrlCreateLabel("Name", 47, 276, 32, 17, $SS_RIGHT)
$InputProfileName = GUICtrlCreateInput("", 108, 274, 257, 21)
GUICtrlSetState($InputProfileName, $GUI_DISABLE)
$BtnProfileEdit = GUICtrlCreateButton("Edit", 388, 611, 75, 25, $WS_GROUP)
GUICtrlSetState($BtnProfileEdit, $GUI_DISABLE)
GUICtrlSetOnEvent($BtnProfileEdit, "BtnProfileEditClick")
$Label11 = GUICtrlCreateLabel("Type", 380, 275, 28, 17)
$ComboProfileTypes = GUICtrlCreateCombo("", 412, 275, 129, 25, BitOR($CBS_DROPDOWNLIST,$CBS_AUTOHSCROLL))
GUICtrlSetData($ComboProfileTypes, "MovingPictures|TVSeries|Music|WebEPG|Other")
GUICtrlSetState($ComboProfileTypes, $GUI_DISABLE)
$Group8 = GUICtrlCreateGroup("Verifymethod", 48, 647, 489, 49)
$ComboVerifyMethod = GUICtrlCreateCombo("Exist & Size", 272, 664, 257, 25)
GUICtrlSetData($ComboVerifyMethod, "Exist|Size|MD5 (slow)")
GUICtrlCreateGroup("", -99, -99, 1, 1)
GUICtrlCreateGroup("", -99, -99, 1, 1)
$ChkNas = GUICtrlCreateCheckbox("Save to available NAS", 32, 200, 145, 17)
GUICtrlSetOnEvent($ChkNas, "ChkNasClick")
$InputNasPath = GUICtrlCreateInput("", 72, 221, 297, 21)
GUICtrlSetState($InputNasPath, $GUI_DISABLE)
GUICtrlSetOnEvent($InputNasPath, "InputNasPathChange")
$Label4 = GUICtrlCreateLabel("Path", 40, 225, 26, 17)
$BtnNasPathBrowse = GUICtrlCreateButton("Browse", 368, 221, 59, 21, $WS_GROUP)
GUICtrlSetState($BtnNasPathBrowse, $GUI_DISABLE)
GUICtrlSetOnEvent($BtnNasPathBrowse, "BtnNasPathBrowseClick")
$BtnProfileRefresh = GUICtrlCreateButton("Refresh default Paths!", 432, 221, 115, 21, $WS_GROUP)
GUICtrlSetState($BtnProfileRefresh, $GUI_DISABLE)
GUICtrlSetOnEvent($BtnProfileRefresh, "BtnProfileRefreshClick")
GUICtrlCreateGroup("", -99, -99, 1, 1)
$TabSheet3 = GUICtrlCreateTabItem("LOG")
$BtnDelLog = GUICtrlCreateButton("Delete Log", 19, 696, 405, 25, $WS_GROUP)
GUICtrlSetOnEvent($BtnDelLog, "BtnDelLogClick")
$EditLog = GUICtrlCreateEdit("", 19, 40, 539, 657, BitOR($ES_AUTOVSCROLL,$ES_AUTOHSCROLL,$ES_READONLY,$ES_WANTRETURN,$WS_VSCROLL))
GUICtrlSetData($EditLog, "")
$BtnRefreshLog = GUICtrlCreateButton("Refresh Log", 423, 696, 135, 25, $WS_GROUP)
GUICtrlSetOnEvent($BtnRefreshLog, "BtnRefreshLogClick")
GUICtrlCreateTabItem("")
GUICtrlSetOnEvent($TabSheet, "TabSheetChange")
$StatusBar1 = _GUICtrlStatusBar_Create($Form2)
Dim $StatusBar1_PartsWidth[1] = [-1]
_GUICtrlStatusBar_SetParts($StatusBar1, $StatusBar1_PartsWidth)
_GUICtrlStatusBar_SetText($StatusBar1, "", 0)
$LblVersion = GUICtrlCreateLabel("Version:", 11, 738, 189, 20)
GUICtrlSetFont($LblVersion, 10, 400, 0, "MS Sans Serif")
TraySetClick("9")
$BtnTrayShow = TrayCreateItem("Show")
$MenuItem1 = TrayCreateItem("Exit")
TrayItemSetOnEvent($BtnTrayShow, "BtnTrayShowClick")
TrayItemSetOnEvent($MenuItem1, "BtnCloseClick")
GUISetState(@SW_SHOW)
#EndRegion ### END Koda GUI section ###
GUICtrlSetData($LblVersion,"Version: " & FileGetVersion(@ScriptFullPath))


#Region ### START Koda GUI section ### Form=D:\Benutzer\Seppi\Documents\AutoIT\SyncServer\Source\Start.kxf
$Form1 = GUICreate("SyncServer", 475, 235, 339, 206)
$ListViewTasks = GUICtrlCreateListView("Task|Status", 16, 40, 432, 150, BitOR($LVS_REPORT,$LVS_NOCOLUMNHEADER,$LVS_NOSORTHEADER,$LVS_SHOWSELALWAYS,$LVS_AUTOARRANGE))
GUICtrlSendMsg($ListViewTasks, $LVM_SETCOLUMNWIDTH, 0, 200)
GUICtrlSendMsg($ListViewTasks, $LVM_SETCOLUMNWIDTH, 1, 100)
$LblTasks = GUICtrlCreateLabel("Tasks:", 16, 16, 36, 17)
$LblProcess = GUICtrlCreateLabel("LblProcess", 16, 200, 56, 17)
GUISetState(@SW_HIDE)
#EndRegion ### END Koda GUI section ###


;#### Variablen ####

Global $aNetWorkAdapters [1] [2] ;  array for network adapter and ip
Global $DefaultIP="192.168.0.0"
Global $MusicUpdateDif,$LastMusicUpdate
Global $MusicUpdateInterval=_GUICtrlEdit_GetText($InputMusicInterval)
Global $error=0
Global $MusicUpdate
Global $OnlineClients
Global $LastStatus=2, $StandbyTime, $StandbyCheck
Global $LastCheck=0
Global $Update,$verifyMethod
Dim $MPPath, $MPConfPath, $WebEPGExe, $LastClientState[1]

dim $EPGProfile[4]
$EPGProfile[0]="WebEPG"
$EPGProfile[1]="\xmltv\"
$EPGProfile[2]="\xmltv\"
$EPGProfile[3]="WebEPG"

dim $MPDatabaseProfile[4]
$MPDatabaseProfile[0]="MovingPictures Database"
$MPDatabaseProfile[1]="\database\movingpictures.db3"
$MPDatabaseProfile[2]="\database\movingpictures.db3"
$MPDatabaseProfile[3]="MovingPictures"

dim $MPThumbProfile[4]
$MPThumbProfile[0]="MovingPictures Thumbs"
$MPThumbProfile[1]="\thumbs\MovingPictures\"
$MPThumbProfile[2]="\thumbs\MovingPictures\"
$MPThumbProfile[3]="MovingPictures"

dim $TVThumbProfile[4]
$TVThumbProfile[0]="TVSeries Thumbs"
$TVThumbProfile[1]="\thumbs\MPTVSeriesBanners\"
$TVThumbProfile[2]="\thumbs\MPTVSeriesBanners\"
$TVThumbProfile[3]="TVSeries"

dim $TVDatabaseProfile[4]
$TVDatabaseProfile[0]="TVSeries Database"
$TVDatabaseProfile[1]="\database\TVSeriesDatabase4.db3"
$TVDatabaseProfile[2]="\database\TVSeriesDatabase4.db3"
$TVDatabaseProfile[3]="TVSeries"

dim $TVFanartProfile[4]
$TVFanartProfile[0]="TVSeries Fanarts"
$TVFanartProfile[1]="\thumbs\Fan Art"
$TVFanartProfile[2]="\thumbs\Fan Art"
$TVFanartProfile[3]="TVSeries"

dim $MusicThumbProfile[4]
$MusicThumbProfile[0]="Music Thumbs"
$MusicThumbProfile[1]="\thumbs\Music\"
$MusicThumbProfile[2]="\thumbs\Music\"
$MusicThumbProfile[3]="Music"

dim $MusicDatabaseProfile[4]
$MusicDatabaseProfile[0]="Music Database"
$MusicDatabaseProfile[1]="\database\MusicDatabaseV11.db3"
$MusicDatabaseProfile[2]="\database\MusicDatabaseV11.db3"
$MusicDatabaseProfile[3]="Music"

#Region SyncTool-Variablen
;~ configure all options nexessary for start
Dim $started = False
Dim $marqueeScroll = False
Dim $marqueeProgress = 0

Dim $elapsedSeconds = 0
Dim $elapsedMinutes = 0
Dim $elapsedHours = 0

Dim $syncedFiles = 0
Dim $skippedFiles = 0

Dim $size = 0
Dim $fileCount = 0
Dim $totalSize = 0
Dim $copySize = 0
Dim $showPercent = 0

Dim $verifyMethod = "Nothing"
Dim $finishedAction = "Nothing"
Dim $deleteAfterSync = False
Dim $time = 0
Dim $showElapsedTime = 0

Local $array, $oldTitle, $PID, $copySource, $copyDestination
Local $failedFiles[1] = [0]
Local $stats[8] = [7, 0, 0, 0, 0, 0, 0, 0]

Local $rKey = "HKCU\Control Panel\International"
Local $sThousands = ',', $sDecimal = '.'
If $sDecimal = -1 Then $sDecimal = RegRead($rKey, "sDecimal")
If $sThousands = -1 Then $sThousands = RegRead($rKey, "sThousand")

Dim $syncedFilesize = 0
#EndRegion SyncTool-Variablen

;###################


; ##Required ImageList for IP-Status ##
$ImageList=_GUIImageList_Create()
_GUIImageList_Add($ImageList, _GUICtrlListView_CreateSolidBitMap($ListViewClients, 0x00FF00, 16, 16))
_GUIImageList_Add($ImageList, _GUICtrlListView_CreateSolidBitMap($ListViewClients, 0xFF0000, 16, 16))
_GUIImageList_Add($ImageList, _GUICtrlListView_CreateSolidBitMap($ListViewClients, 0x00FF00, 16, 16))
_GUIImageList_Add($ImageList, _GUICtrlListView_CreateSolidBitMap($ListViewClients, 0x00FF00, 16, 16))
_GUICtrlListView_SetImageList($ListViewClients,$ImageList, 1)
; #########################

_getnetworkadapter ()
addNetworkAdapters2ListView()
Load()

If $LastMusicUpdate<>"" then $MusicUpdateDif=_DateDiff("D",$LastMusicUpdate,_NowCalc())
;Startoptionen

Select
	case $cmdline[0] and $cmdline[1]="-start"	;Startoption: Nur Databaseupdate
		GUISetState(@SW_HIDE, $Form2)
		GUISetState(@SW_SHOW, $Form1)
		If $LastMusicUpdate="" or $MusicUpdateDif>=$MusicUpdateInterval then ;Prüfe auf Zeitintervall zwischen Musikupdate
			$MusicUpdate=1
		Else
			$MusicUpdate=0
		EndIf
		start()
		exit

	case Else
		WriteLog("INFO","Configuration has been started!")
		CheckAllClients()	;Alle Clients mit Ping prüfen ob online oder nicht
		AdlibRegister("CheckAllClients",10000)	;Funktion CheckAllClients alle x Sekunden im Hintergrund ausführen
		$MusicUpdate=1 ;Immer Musikupdate durchführen, sofern angehakt

		GUISetState(@SW_SHOW, $Form2)
		GUISetState(@SW_HIDE, $Form1)

		While 1
			sleep(3000)
			;-------------------------------
			;Onlinestatus der Clients Prüfen
			Select
				Case $OnlineClients>0 and $LastStatus<>1
					Trayseticon(@ScriptFullPath, -5) ;Setzt Icon auf Grün
					$LastStatus=1	;Zustand Clients-online
					If $StandbyCheck=$GUI_CHECKED then
						;Der automatische Standby in Energieoptionen wird deaktiviert
						Run(@ComSpec & " /c " & 'powercfg  -change  -standby-timeout-ac 0', "", @SW_HIDE)
						WriteLog("INFO",'Automatischer Standby deaktiviert!')
					Endif

				Case $OnlineClients=0 and $LastStatus<>0
					Trayseticon(@ScriptFullPath, -6) ;Setzt Icon auf Rot
					$LastStatus=0 ;Zustand Clients-offline
					If $StandbyCheck=$GUI_CHECKED then
						;Die Standby-Zeit in Energieoptionen wird gesetzt
						Run(@ComSpec & " /c " & 'powercfg  -change  -standby-timeout-ac ' & $StandbyTime, "", @SW_HIDE)
						WriteLog("INFO",'Standbyzeit auf ' & $StandbyTime & ' gesetzt!')
					Endif
			EndSelect

			If $LastCheck=0 or _DateDiff("h",$LastCheck,_NowCalc())>1 Then CheckVersion()
		WEnd

EndSelect

#Region Functions
#Region Gui-Function
; ===================================================================
; GUI-Functions
; ===================================================================

Func TabSheetChange()
    Switch GUICtrlRead($TabSheet,1)
        Case $TabSheet1	;Settings
             _GUICtrlIpAddress_ShowHide ($IPAddress, @SW_SHOW)
		Case $TabSheet2 ;Paths
			 _GUICtrlIpAddress_ShowHide ($IPAddress, @SW_HIDE)
        Case $Tabsheet3	;Log
             _GUICtrlIpAddress_ShowHide ($IPAddress, @SW_HIDE)
			 BtnRefreshLogClick()
	EndSwitch
EndFunc



Func SetDefaultProfile($Profile)
		Local $count=0
		Local $Items = _GUICtrlListView_GetItemCount($ListViewProfiles)
		For $i = 0 To $Items - 1
			Local $itemTxt = _GUICtrlListView_GetItemTextArray($ListViewProfiles, $i)
			If $itemTxt[1] = $Profile[0] Then
				_GUICtrlListView_SetItemChecked($ListViewProfiles,$i)
				$count+=1
			Endif
		Next

		$Profile[1]=$MPConfPath & $Profile[1]
		$Profile[2]=GUICtrlRead($InputNasPath) & $Profile[2]

		If $count=0 then
			SetProfile($Profile)
		EndIf
Endfunc

Func DelProfileType($Profile)
	Local $Items = _GUICtrlListView_GetItemCount($ListViewProfiles)
	local $return = MsgBox(4, "Request", "Do you like also to delete the Syncronisationprofile(s) from type " & $Profile[3] & " ?",0,$Form2)
	For $i = 0 To $Items - 1
		Local $itemTxt = _GUICtrlListView_GetItemTextArray($ListViewProfiles, $i)
		If $itemTxt[4] = $Profile[3] then
			Switch $return
				Case 6 ;ja
					_GUICtrlListView_DeleteItem(GUICtrlGetHandle($ListViewProfiles), $i)
					$i -= 1
				Case 7 ;nein
					_GUICtrlListView_SetItemChecked($ListViewProfiles,$i,false)
			EndSwitch
		EndIf
	Next
EndFunc

Func ChkMPClick()
	If GUICtrlRead($ChkMP)=1 then
		SetDefaultProfile($MPThumbProfile)
		SetDefaultProfile($MPDatabaseProfile)
	Else
		DelProfileType($MPThumbProfile)
	Endif
EndFunc

Func ChkMusicClick()
	If GUICtrlRead($ChkMusic)=1 then
		SetDefaultProfile($MusicThumbProfile)
		SetDefaultProfile($MusicDatabaseProfile)
	Else
		DelProfileType($MusicThumbProfile)
	Endif
EndFunc

Func ChkSeriesClick()
	If GUICtrlRead($ChkSeries)=1 then
		SetDefaultProfile($TVThumbProfile)
		SetDefaultProfile($TVDatabaseProfile)
		SetDefaultProfile($TVFanartProfile)
	Else
		DelProfileType($TVThumbProfile)
	Endif
EndFunc

Func ChkEpgClick()
	If GUICtrlRead($ChkEpg)=1 then
		SetDefaultProfile($EPGProfile)
	Else
		DelProfileType($EPGProfile)
	Endif
EndFunc

Func ChkNasClick()
	If GUICtrlRead($ChkNas) = 1 then
		GUICtrlSetState($Group6,$GUI_ENABLE)
		GUICtrlSetState($BtnNasPathBrowse,$GUI_ENABLE)
		GUICtrlSetState($InputNasPath,$GUI_ENABLE)
		GUICtrlSetState($BtnProfileRefresh,$GUI_ENABLE)
		GUICtrlSetState($BtnProfileAdd,$GUI_ENABLE)
		GUICtrlSetState($BtnProfileDel,$GUI_ENABLE)
		GUICtrlSetState($BtnProfileEdit,$GUI_ENABLE)
		GUICtrlSetState($BtnProfileMark,$GUI_ENABLE)
		GUICtrlSetState($BtnProfileUnmark,$GUI_ENABLE)
		GUICtrlSetState($InputProfileName,$GUI_ENABLE)
		GUICtrlSetState($InputSource,$GUI_ENABLE)
		GUICtrlSetState($InputDestination,$GUI_ENABLE)
		GUICtrlSetState($ListViewProfiles,$GUI_ENABLE)
		GUICtrlSetState($ComboProfileTypes,$GUI_ENABLE)
		GUICtrlSetState($BtnSourceBrowse,$GUI_ENABLE)
		GUICtrlSetState($BtnDestinationBrowse,$GUI_ENABLE)
	else
		GUICtrlSetState($InputProfileName,$GUI_DISABLE)
		GUICtrlSetState($InputSource,$GUI_DISABLE)
		GUICtrlSetState($InputDestination,$GUI_DISABLE)
		GUICtrlSetState($ListViewProfiles,$GUI_DISABLE)
		GUICtrlSetState($BtnProfileAdd,$GUI_DISABLE)
		GUICtrlSetState($BtnProfileDel,$GUI_DISABLE)
		GUICtrlSetState($BtnProfileEdit,$GUI_DISABLE)
		GUICtrlSetState($BtnProfileMark,$GUI_DISABLE)
		GUICtrlSetState($BtnProfileUnmark,$GUI_DISABLE)
		GUICtrlSetState($BtnNasPathBrowse,$GUI_DISABLE)
		GUICtrlSetState($InputNasPath,$GUI_DISABLE)
		GUICtrlSetState($BtnProfileRefresh,$GUI_DISABLE)
		GUICtrlSetState($ComboProfileTypes,$GUI_DISABLE)
		GUICtrlSetState($BtnSourceBrowse,$GUI_DISABLE)
		GUICtrlSetState($BtnDestinationBrowse,$GUI_DISABLE)
	EndIf
EndFunc

Func BtnRefreshLogClick()
	GUICtrlSetData($EditLog,"")
	$logfile = FileOpen(@ScriptDir & "\log.txt",0)
	GUICtrlSetData($EditLog,FileRead($logfile))
	FileClose($logfile)
	_GUICtrlEdit_LineScroll($EditLog, 0, _GUICtrlEdit_GetLineCount($EditLog))
EndFunc

Func InputNasPathChange()
	Local $NasPath=GUICtrlRead($InputNasPath)
	If StringRight($NasPath,1)="\" then GUICtrlSetData($InputNasPath,StringTrimRight($NasPath,1))
	GUICtrlSetBkColor($BtnProfileRefresh,0xCCFFFF)
EndFunc

Func BtnProfileRefreshClick()
	Local $NasPath=GUICtrlRead($InputNasPath)
	Local $return=Msgbox(1,"Warning","WARNING: All destinations except of the profiles from type 'other' will be set to default! Sure?",0,$Form2)
	Switch $return
		Case 1 ;OK
			;Alle Profile bis auf Typ "Others" aus ListView löschen
			Local $Items = _GUICtrlListView_GetItemCount($ListViewProfiles)
			If StringRight($NasPath,1)="\" then GUICtrlSetData($InputNasPath,StringTrimRight($NasPath,1))
			For $i=$Items-1 To 0 Step -1
				Local $itemTxt = _GUICtrlListView_GetItemTextArray($ListViewProfiles, $i)
				If $itemtxt[4]<>"Others" Then
					_GUICtrlListView_DeleteItem(GUICtrlGetHandle($ListViewProfiles),$i)
				EndIf
			Next

			;Alle gecheckten Profile neu hinzufügen
			If GUICtrlRead($ChkEpg)=1 then SetDefaultProfile($EPGProfile)

			If GUICtrlRead($ChkSeries)=1 then
				SetDefaultProfile($TVFanartProfile)
				SetDefaultProfile($TVThumbProfile)
				SetDefaultProfile($TVDatabaseProfile)
			EndIf

			If GUICtrlRead($ChkMP)=1 then
				SetDefaultProfile($MPThumbProfile)
				SetDefaultProfile($MPDatabaseProfile)
			Endif

			If GUICtrlRead($ChkMusic)=1 then
				SetDefaultProfile($MusicThumbProfile)
				SetDefaultProfile($MusicDatabaseProfile)
			Endif

		Case 2 ;Abbr

	EndSwitch

	GUICtrlSetDefBkColor($BtnProfileRefresh)
EndFunc

Func SetProfile($Profile)
	;Prüfung ob Profilname bereits vergeben
	Local $Items = _GUICtrlListView_GetItemCount($ListViewProfiles)
	For $i = 0 To $Items - 1
		Local $itemTxt = _GUICtrlListView_GetItemTextArray($ListViewProfiles, $i)
		If $itemTxt[1] = $Profile[0] Then
			MsgBox(0, "Invalid profile name!", "Profile name already used!")
			Return
		EndIf
	Next

	;Profil wird zur Listview hinzugefügt
	Local $Item = _GUICtrlListView_AddItem($ListViewProfiles, $Profile[0])
	_GUICtrlListView_AddSubItem($ListViewProfiles, $Item, $Profile[1], 1)
	_GUICtrlListView_AddSubItem($ListViewProfiles, $Item, $Profile[2], 2)
	_GUICtrlListView_AddSubItem($ListViewProfiles, $Item, $Profile[3], 3)
	_GUICtrlListView_SetItemChecked($ListViewProfiles,$Item)

	AutosizeColumns($ListViewProfiles)
Endfunc

Func EditProfil($Item,$Profile)
	;Profil der Reihe $Item wird inListview editiert
	_GUICtrlListView_SetItem($ListViewProfiles, $Profile[0], $Item, 0)
	_GUICtrlListView_SetItem($ListViewProfiles, $Profile[1], $Item, 1)
	_GUICtrlListView_SetItem($ListViewProfiles, $Profile[2], $Item, 2)
	_GUICtrlListView_SetItem($ListViewProfiles, $Profile[3], $Item, 3)
	AutosizeColumns($ListViewProfiles)
Endfunc

Func BtnProfileAddClick()
	Local $Profile[4]
	$Profile[0] = GUICtrlRead($InputProfileName)
	$Profile[1] = GUICtrlRead($InputSource)
	$Profile[2] = GUICtrlRead($InputDestination)
	$Profile[3] = GUICtrlRead($ComboProfileTypes)

	;Prüfung ob Source/Destination-Path existiert
	Select
		Case $Profile[1] = "" Or FileExists($Profile[1]) = 0
			MsgBox(64, "Error", "The source path doesn't exist!")
			Return
		Case $Profile[2] = ""
			MsgBox(64, "Error", "The destination path doesn't exist!")
			Return
		Case $Profile[0] = ""
			MsgBox(64, "Error", "Please enter a valid Profiletype!")
			Return
		Case $Profile[4] = ""
			MsgBox(64, "Error", "Please enter a valid Profilename!")
			Return
	EndSelect

	Select
		Case _GUICtrlButton_GetText($BtnProfileAdd) = "Confirm"
			Local $EditItem = _GUICtrlListView_GetSelectedIndices($ListViewProfiles, True)
			;Eintrag in Listview editieren
			EditProfil($EditItem[1],$Profile)

			;Anpassen der Gui
			_GUICtrlButton_SetText($BtnProfileAdd, "Add")
			_GUICtrlButton_Enable($BtnProfileEdit, True)
			_GUICtrlButton_Enable($BtnProfileDel, True)
			_GUICtrlButton_Enable($BtnProfileMark, True)
			_GUICtrlButton_Enable($BtnProfileUnmark, True)
			GUICtrlSetState($ListViewProfiles, $GUI_ENABLE)

		Case _GUICtrlButton_GetText($BtnProfileAdd) = "Add"
			SetProfile($Profile)
	EndSelect

	GUICtrlSetData($InputSource, "")
	GUICtrlSetData($InputDestination, "")
	GUICtrlSetData($InputProfileName, "")
EndFunc

Func BtnProfileEditClick()
	Local $Edititems = _GUICtrlListView_GetSelectedIndices($ListViewProfiles, True)
	If $Edititems[0] = 0 Then
		MsgBox(0, "Error", "No item selected!")
	Else
		GUICtrlSetState($ListViewProfiles, $GUI_DISABLE)
		Local $itemTxt = _GUICtrlListView_GetItemTextArray($ListViewProfiles, _GUICtrlListView_GetSelectedColumn($ListViewProfiles))
		GUICtrlSetData($InputProfileName, $itemTxt[1])
		GUICtrlSetData($InputSource, $itemTxt[2])
		GUICtrlSetData($InputDestination, $itemTxt[3])
		GUICtrlSetData($ComboProfileTypes, $itemTxt[4])
		_GUICtrlButton_SetText($BtnProfileAdd, "Confirm")
		_GUICtrlButton_Enable($BtnProfileEdit, False)
		_GUICtrlButton_Enable($BtnProfileDel, False)
		_GUICtrlButton_Enable($BtnProfileMark, False)
		_GUICtrlButton_Enable($BtnProfileUnmark, False)
	EndIf
EndFunc   ;==>BtnProfileEditClick

Func BtnProfileDelClick()
	Local $DelItem = _GUICtrlListView_GetSelectedIndices($ListViewProfiles, True)
	If Not $DelItem[0] = 0 Then
		_GUICtrlListView_DeleteItem(GUICtrlGetHandle($ListViewProfiles), $DelItem[1])
	Else
		MsgBox(0, "Error", "No item selected!")
	EndIf
EndFunc

Func BtnProfileMarkClick()
	_GUICtrlListView_SetItemChecked($ListViewProfiles, -1, True)
EndFunc   ;==>BtnProfileMarkClick

Func BtnProfileUnmarkClick()
	_GUICtrlListView_SetItemChecked($ListViewProfiles, -1, False)
EndFunc   ;==>BtnProfileUnmarkClick

Func BtnSourceBrowseClick()
	$var = FileSelectFolder("Please choose your source directory:", "", 7, "")
	If @error <> 1 Then
		$Source = $var
		_GUICtrlEdit_SetText($InputSource, $Source)
	EndIf
EndFunc   ;==>BtnSourceBrowseClick

Func BtnNasPathBrowseClick()
	$var = FileSelectFolder("Please choose your source directory:", "", 7, "")
	If @error <> 1 Then
		$NasPath = $var
		_GUICtrlEdit_SetText($InputNasPath, $NasPath)
	EndIf
EndFunc   ;==>BtnSourceBrowseClick

Func BtnDestinationBrowseClick()
	$var = FileSelectFolder("Please choose your destination directory:", "", 7, "")
	If @error <> 1 Then
		$Destination = $var
		_GUICtrlEdit_SetText($InputDestination, $Destination)
	EndIf
EndFunc   ;==>BtnDestinationBrowseClick

Func BtnClientAddClick()
	local $name=GUICtrlRead($InputClient)
	local $IP=_GUICtrlIpAddress_Get($IPAddress)
	local $Mac=GUICtrlRead($InputMac)
	local $user=GUICtrlRead($InputUser)
	local $pass=GUICtrlRead($InputPass)
	local $i=_GUICtrlListView_GetItemCount($ListViewClients)
	Select
		case $IP=$DefaultIp Or $Mac=""
			MsgBox(16,"Error","Please enter a correct IP- and MAC-Adress first!")
			Return
		case $name=""
			Local $answer=MsgBox(65,"Info","Please note:" & @CRLF & "On clients without a logical network name, automatical IP refresh isn't possible!")
			If $answer=2 Then
				Return
			Else
				ContinueCase
			Endif
		case $user="" or $pass=""
			Local $answer=MsgBox(65,"Info","Please note:" & @CRLF & "On clients without a valid username and password, the remote shutdown process couldn't work correctly!")
			If $answer=2 Then Return
	EndSelect
	_GUICtrlListView_AddItem($ListViewClients, $name)
	_GUICtrlListView_AddSubItem($ListViewClients, $i, $IP, 1)
	_GUICtrlListView_AddSubItem($ListViewClients, $i, $Mac, 2)
	_GUICtrlListView_AddSubItem($ListViewClients, $i, $user, 3)
	_GUICtrlListView_AddSubItem($ListViewClients, $i, $pass, 4)
	AutosizeColumns($ListViewClients)
	CheckClient($i)
	setStatusMsg("OK",'Client "'& $name & '(' & $IP & ')' &'" has been added!')
Endfunc

Func BtnSyncBrowseClick()
	$var = FileOpenDialog("Durchsuchen", @ProgramFilesDir, "(*.exe)", 1)
		If @error <> 1 Then
			$SyncBackExe = $var
			_GUICtrlEdit_SetText($InputSyncBackExe, $SyncBackExe)
		EndIf
EndFunc

Func BtnMPAppBrowseClick()
	$var = FileSelectFolder ("Choose a folder:","",4,@ProgramFilesDir)
		If @error <> 1 Then
			$MPConfPath = $var
			_GUICtrlEdit_SetText($InputMPAppDir, $MPConfPath)
		EndIf
EndFunc

Func BtnMPProgBrowseClick()
	$var = FileSelectFolder ("Choose a folder:","",4,@ProgramFilesDir)
		If @error <> 1 Then
			$MPPath = $var
			_GUICtrlEdit_SetText($InputMPDir, $MPPath)
		EndIf
EndFunc

Func BtnWebEPGExeBrowseClick()
	$var = FileOpenDialog("Durchsuchen", @ProgramFilesDir, "(*.exe)", 1)
		If @error <> 1 Then
			$WebEPGExe = $var
			_GUICtrlEdit_SetText($InputWebEPGExe, $WebEPGExe)
		EndIf
EndFunc

Func BtnGetIPClick()
	Local $IP, $Mac=""
	$IP=get_ip(GUICtrlRead($InputClient))
	_GUICtrlIpAddress_Set($IPAddress, $IP)
	If $IP<>$DefaultIP then $Mac=get_mac(_GUICtrlIpAddress_Get($IPAddress))
	GUICtrlSetData($InputMac,$Mac)
Endfunc

Func BtnClientMarkClick()
	_GUICtrlListView_SetItemChecked($ListViewClients, -1, True)
Endfunc

Func BtnSaveClick()
	filedelete(@ScriptDir & "\settings.ini")

	;Clients
	Local $Items=_GUICtrlListView_GetItemCount($ListViewClients)
	IniWrite(@ScriptDir & "\settings.ini", "Clients", "Count", $Items)
	For $i=0 to $Items-1
		Local $ItemTxt=_GUICtrlListView_GetItemTextArray($ListViewClients,$i)
		IniWrite(@ScriptDir & "\settings.ini", "Clients", "Data" & $i, _GUICtrlListView_GetItemChecked($ListViewClients, $i))
		For $j=0 to UBound($ItemTxt)-1
			IniWrite(@ScriptDir & "\settings.ini", "Clients", "Data" & $i & $j, $ItemTxt[$j])
		Next
	Next

	;Adapters
	$Adapters=_GUICtrlListView_GetItemCount($ListViewAdapters)
	For $i=0 to $Adapters-1
		if _GUICtrlListView_GetItemChecked($ListViewAdapters, $i) Then
			$AdapterName=_GUICtrlListView_GetItemText($ListViewAdapters, $i)
			IniWrite(@ScriptDir & "\settings.ini", "Adapters", "Data" & $i, $AdapterName)
		Endif
	Next

	;Settings
	IniWrite(@ScriptDir & "\settings.ini", "Settings", "AutoIP", GUICtrlRead($ChkIps))
	IniWrite(@ScriptDir & "\settings.ini", "Settings", "EpgDB", GUICtrlRead($ChkEpg))
	IniWrite(@ScriptDir & "\settings.ini", "Settings", "MusicDB", GUICtrlRead($ChkMusic))
	IniWrite(@ScriptDir & "\settings.ini", "Settings", "MovPicDB", GUICtrlRead($ChkMP))
	IniWrite(@ScriptDir & "\settings.ini", "Settings", "SeriesDB", GUICtrlRead($ChkSeries))
	IniWrite(@ScriptDir & "\settings.ini", "Settings", "StandbyTime",GUICtrlRead($InputStandbyTime))
	IniWrite(@ScriptDir & "\settings.ini", "Settings", "MusicUpdateInterval",GUICtrlRead($InputMusicInterval))
	IniWrite(@ScriptDir & "\settings.ini", "Settings", "StandbyCheck", GUICtrlRead($ChkStandby))
	IniWrite(@ScriptDir & "\settings.ini", "Settings", "Update", GUICtrlRead($ComboUpdate))
	IniWrite(@ScriptDir & "\settings.ini", "Settings", "NasCheck", GUICtrlRead($ChkNas))
	IniWrite(@ScriptDir & "\settings.ini", "Settings", "Verifymethod", GUICtrlRead($ComboVerifyMethod))

	;Paths
	IniWrite(@ScriptDir & "\settings.ini", "Paths", "MPDir",GUICtrlRead($InputMPDir))
	IniWrite(@ScriptDir & "\settings.ini", "Paths", "MPAppDir",GUICtrlRead($InputMPAppDir))
	IniWrite(@ScriptDir & "\settings.ini", "Paths", "WebEPGExe",GUICtrlRead($InputWebEPGExe))
	IniWrite(@ScriptDir & "\settings.ini", "Paths", "NasPath",GUICtrlRead($InputNasPath))

	;------------------;
	;-----Profiles-----;
	;------------------;
	IniDelete(@ScriptDir & "\settings.ini", "Profiles")
	Local $Items = _GUICtrlListView_GetItemCount($ListViewProfiles)
	IniWrite(@ScriptDir & "\settings.ini", "Profiles", "Count", $Items)
	For $i = 0 To $Items - 1
		Local $itemTxt = _GUICtrlListView_GetItemTextArray($ListViewProfiles, $i)
		IniWrite(@ScriptDir & "\settings.ini", "Profiles", "Data" & $i, _GUICtrlListView_GetItemChecked($ListViewProfiles, $i))
		For $j = 0 To UBound($itemTxt) - 1
			IniWrite(@ScriptDir & "\settings.ini", "Profiles", "Data" & $i & $j, $itemTxt[$j])
		Next
	Next
	;-----------------;
	;-----------------;

	;Dates
	IniWrite(@ScriptDir & "\settings.ini","Date","LastDate",$LastMusicUpdate)

	setStatusMsg("OK","Settings saved!")
Endfunc

Func BtnRescanClick()
	CheckAllClients()
	setStatusMsg("OK","Rescan complete!")
Endfunc

Func BtnClientUnmarkClick()
	_GUICtrlListView_SetItemChecked($ListViewClients, -1, False)
Endfunc

Func BtnStartClick()
	GUISetState(@SW_HIDE, $Form2)
	GUISetState(@SW_SHOW, $Form1)
	start()
	GUISetState(@SW_SHOW, $Form2)
	GUISetState(@SW_HIDE, $Form1)
EndFunc

Func BtnCloseClick()
	WriteLog("INFO","Configuration has been closed!")
	Exit
EndFunc

Func BtnTrayClick()
	GUISetState(@SW_HIDE,$Form2)
EndFunc

Func BtnTrayShowClick()
	GUISetState(@SW_SHOW,$Form2)
	GUISetState(@SW_RESTORE,$Form2)
EndFunc

Func BtnClientDelClick()
	Local $DelItem=_GUICtrlListView_GetSelectedIndices($ListViewClients,True)
	If not $DelItem[0]=0 then
		_GUICtrlListView_DeleteItem(GUICtrlGetHandle($ListViewClients), $DelItem[1])
		AutosizeColumns($ListViewClients)
		setStatusMsg("OK",'Selected client has been deleted!')
	Else
		MsgBox(0,"Error","No item selected!")
	EndIf
EndFunc

Func BtnDelLogClick()
	If FileDelete(@ScriptDir & "\log.txt")=1 then
		_GUICtrlEdit_SetText($EditLog, "")
		setStatusMsg("OK",'LOG-File has been deleted!')
	Else
		setStatusMsg("ERROR","Couldn't delete LOG-File!")
	Endif
EndFunc

Func BtnWOLClick()
	Local $Item=_GUICtrlListView_GetSelectedIndices($ListViewClients, True)
	wol_marked($Item[1])
EndFunc

Func BtnShutdownClick()
	Local $Item=_GUICtrlListView_GetSelectedIndices($ListViewClients, True)
	RemoteShutdown($Item[1])
EndFunc
#EndRegion
#Region Config-Funktionen
; ===================================================================
; Functions
; ===================================================================

Func GetUserSID($ComputerName,$Username)
    Dim $UserSID, $oWshNetwork, $oUserAccount
    $objWMIService = objGet( "winmgmts:{impersonationLevel=impersonate}!//"  & $ComputerName & "/root/cimv2")
    $oUserAccounts = $objWMIService.ExecQuery("Select Name, SID from Win32_UserAccount")
    For $oUserAccount In $oUserAccounts
        If $Username =  $oUserAccount.Name Then Return $oUserAccount.SID
    Next
    Return ""
EndFunc


Func RemoteShutdown($i)
	local $port=56789
	local $pc=_GUICtrlListView_GetItemText($ListViewClients,$i,0)
	local $ip=_GUICtrlListView_GetItemText($ListViewClients,$i,1)

	setStatusMsg('INFO','Try to shutdown:' & $pc)
	WriteLog('INFO','Try to shutdown:' & $pc)

	TCPStartup()
	; Versucht solange eine Verbindung zum Server aufzubauen bis Erfolg oder Timeout gemeldet wird. SocketID wird in "$socket" abgespeichert.
	Local $t=0
	Do
		$socket=TCPConnect($ip, $port)
		$t+=1
	Until $socket<>-1 or $t>10

	If $socket=-1 then
		WriteLog("ERROR","Kann keine Verbindung zu " & $pc & " herstellen! Errorcode:" & @Error)
		setStatusMsg('ERROR',"Kann keine Verbindung zu " & $pc & " herstellen!")
		TCPCloseSocket($socket)
		TCPShutdown()
		Return 0
	EndIf

	$sendedBytes = TCPSend($socket, "standby") ; Sendet den Text an unseren verbundenen Socket
	TCPCloseSocket($socket)
	TCPShutdown()

	If $sendedBytes = 0 Then ; Wenn der Rückgabewert von TCPSend(...) 0 ist, Fehlermeldung ausgeben
		setStatusMsg('ERROR',"Standby-Befehl konnte nicht zu " & $pc & " gesendet werden!")
		WriteLog("ERROR","Standby-Befehl konnte nicht zu " & $pc & " gesendet werden!")
		Return 0
	Else
		If CheckShutdown($i)=1 Then
			Return 1
		Else
			Return 0
		Endif
	EndIf
EndFunc


;Fährt die angehakten Clients in ListViewClients nacheinander in den Standby
Func ShutdownAll()
	local $error
	for $i = 0 to _GUICtrlListView_GetItemCount($ListViewClients)-1
		if _GUICtrlListView_GetItemChecked($ListViewClients, $i) and CheckClient($i)=1 and $LastClientState[$i]=0 then
			if RemoteShutdown($i)=0 Then
				$error=$error+1
			EndIf
		EndIf
	Next
	return $error
EndFunc

;Checkt welche Clients vor WOL eingeschaltet waren, damit ein Standby danach verhindert werden kann
Func LastClientState()
	for $i = 0 to _GUICtrlListView_GetItemCount($ListViewClients)-1
		ReDim $LastClientState[_GUICtrlListView_GetItemCount($ListViewClients)]
		local $state=CheckClient($i)
		$LastClientState[$i]=$state
	Next
EndFunc

Func CheckShutdown($i)
	local $pc=_GUICtrlListView_GetItemText($ListViewClients,$i,0)
	local $j=120 ;Timeout
	$Splash=SplashTextOn('StateCheck','Wait for shutdown of '&$pc&@LF&$j&'sec. until timout')

	while CheckClient($i)=1 and $j>0
		SplashTextOn('StateCheck','Wait for shutdown of '&$pc&@LF&$j-1&'sec. until timout',-1,100)
		sleep(1000)
		$j=$j-1
	WEnd
	SplashOff()

	If $j=0 then
		setStatusMsg("ERROR","Can't shutdown " & $pc & "! Pc is still switched on.")
		WriteLog("ERROR","Can't shutdown " & $pc & "! Pc is still switched on.")
		return 0
	Else
		return 1
		setStatusMsg("INFO",$pc & "has been powered off!")
		WriteLog("INFO",$pc & "has been powered off!")
	Endif
EndFunc

Func AutosizeColumns($ListView)
	For $i=0 to _GUICtrlListView_GetColumnCount($ListView)-1
		_GUICtrlListView_SetColumnWidth($ListView,$i,$LVSCW_AUTOSIZE)
	Next
EndFunc

Func Load()
	If not FileExists(@ScriptDir & "\settings.ini") then BtnSaveClick()
	;Clients
	Local $Items=IniRead(@ScriptDir & "\settings.ini", "Clients", "Count","0")
	If $Items>0 then
	Local $Txt[$Items][5]
		For $i=0 to $Items-1
			For $j=0 to UBound($Txt,2)-1
				$Txt[$i][$j]=IniRead(@ScriptDir & "\settings.ini", "Clients", "Data" & $i & $j+1,"")
			Next
		Next
		_GUICtrlListView_AddArray($ListViewClients, $Txt)

		For $i=0 to $Items-1
			$Selected=IniRead(@ScriptDir & "\settings.ini", "Clients", "Data" & $i,"False")
			If $Selected="True" Then
				_GUICtrlListView_SetItemChecked($ListViewClients, $i)
			Endif
		Next
	AutosizeColumns($ListViewClients)
	Endif


	;Adapters
	local $index=0
	$Adapters=IniReadSection(@ScriptDir & "\settings.ini", "Adapters")
	For $i=1 to Ubound($Adapters)-1
		$index=_GUICtrlListView_FindText($ListViewAdapters, $Adapters[$i][1], -1, false, true)
		if  $index <> -1 Then
			_GUICtrlListView_SetItemChecked($ListViewAdapters, $index)
		Else
			MsgBox(1,"Error","The last saved network adapter: " & $Adapters[$i][1] & " doesn't exist anymore!")
			WriteLog("Error","The last saved network adapter: " & $Adapters[$i][1] & " doesn't exist anymore!")
		Endif
	Next

	;Settings
	GUICtrlSetState($ChkIps,IniRead(@ScriptDir & "\settings.ini", "Settings", "AutoIP", $GUI_UNCHECKED))
	GUICtrlSetState($ChkEpg,IniRead(@ScriptDir & "\settings.ini", "Settings", "EpgDB", $GUI_UNCHECKED))
	GUICtrlSetState($ChkMusic,IniRead(@ScriptDir & "\settings.ini", "Settings", "MusicDB", $GUI_UNCHECKED))
	GUICtrlSetState($ChkMP,IniRead(@ScriptDir & "\settings.ini", "Settings", "MovPicDB", $GUI_UNCHECKED))
	GUICtrlSetState($ChkSeries,IniRead(@ScriptDir & "\settings.ini", "Settings", "SeriesDB", $GUI_UNCHECKED))
	$StandbyTime=IniRead(@ScriptDir & "\settings.ini", "Settings", "StandbyTime","10")
	GUICtrlSetData($InputStandbyTime,$StandbyTime)
	$MusicUpdateInterval=IniRead(@ScriptDir & "\settings.ini", "Settings", "MusicUpdateInterval","7")
	GUICtrlSetData($InputMusicInterval,$MusicUpdateInterval)
	$StandbyCheck=IniRead(@ScriptDir & "\settings.ini", "Settings", "StandbyCheck", $GUI_UNCHECKED)
	GUICtrlSetState($ChkStandby,$StandbyCheck)
	$Update = IniRead(@ScriptDir & "\settings.ini", "Settings", "Update", "Check for Stable")
	GUICtrlSetData($ComboUpdate, $Update)
	GUICtrlSetState($ChkNas,IniRead(@ScriptDir & "\settings.ini", "Settings", "NasCheck", $GUI_UNCHECKED))
	$verifyMethod = IniRead(@ScriptDir & "\settings.ini", "Settings", "Verifymethod", "Exist & Size")
	GUICtrlSetData($ComboVerifyMethod, $verifyMethod)


	;Paths
	$MPPath=IniRead(@ScriptDir & "\settings.ini", "Paths", "MPDir",@ProgramFilesDir & "\Team MediaPortal\MediaPortal\")
	GUICtrlSetData($InputMPDir,$MPPath)
	$MPConfPath=IniRead(@ScriptDir & "\settings.ini", "Paths", "MPAppDir",@AppDataCommonDir & "\Team MediaPortal\MediaPortal\")
	GUICtrlSetData($InputMPAppDir,$MPConfPath)
	$WebEPGExe=IniRead(@ScriptDir & "\settings.ini", "Paths", "WebEPGExe","")
	GUICtrlSetData($InputWebEPGExe,$WebEPGExe)
	$NasPath=IniRead(@ScriptDir & "\settings.ini", "Paths", "NasPath","")
	GUICtrlSetData($InputNasPath,$NasPath)

	;--------------------;
	;------Profiles------;
	;--------------------;
	_GUICtrlListView_DeleteAllItems(GUICtrlGetHandle($ListViewProfiles))
	Local $Items = IniRead(@ScriptDir & "\settings.ini", "Profiles", "Count", "0")
	If $Items > 0 Then
		Local $Txt[$Items][4]
		For $i = 0 To $Items - 1
			For $j = 0 To UBound($Txt, 2) - 1
				$Txt[$i][$j] = IniRead(@ScriptDir & "\settings.ini", "Profiles", "Data" & $i & $j + 1, "")
			Next
		Next
		_GUICtrlListView_AddArray($ListViewProfiles, $Txt)

		For $i = 0 To $Items - 1
			$Selected = IniRead(@ScriptDir & "\settings.ini", "Profiles", "Data" & $i, "False")
			If $Selected = "True" Then
				_GUICtrlListView_SetItemChecked($ListViewProfiles, $i)
			EndIf
		Next
		AutosizeColumns($ListViewProfiles)
	EndIf

	;--------------------;
	;--------------------;

	;Date
	$LastMusicUpdate=IniRead(@ScriptDir & "\settings.ini", "Date", "LastMusicUpdate","")

	ChkNasClick()
Endfunc



; ===================================================================
;Prüft ob der Client des ListViewCLients an der Stelle $i online ist und ruft "Func RefreshIP" auf falls Checkbox $ChkIPs angehakt
;Return:	1 - Client ist online
;			0 - Client ist offline
; ===================================================================
Func CheckClient($i)
	If GUICtrlRead($ChkIPs)=$GUI_CHECKED then RefreshIP($i)
	Local $ip=_GUICtrlListView_GetItemText($ListViewClients,$i,1)
	If Ping($ip,30)<>0 Then
		_GUICtrlListView_SetItemImage($ListViewClients,$i,0)
		Return 1
	Else
		_GUICtrlListView_SetItemImage($ListViewClients,$i,1)
		Return 0
	Endif
EndFunc

; ===================================================================
;Erneuert die IP des Clients im ListViewCLients an der Stelle $i
;Get:		Zeilennummer des zu prüfenden Clients im ListViewCLients
;Return:	-
; ===================================================================
Func RefreshIP($i)
	TCPStartup()
	Local $client=_GUICtrlListView_GetItemText($ListViewClients,$i,0)
	Local $NewIP=TCPNameToIP($client)
	Local $LastIP=_GUICtrlListView_GetItemText($ListViewClients,$i,1)
	If $NewIP <> "" and $NewIP <> $LastIP Then
		_GUICtrlListView_SetItemText($ListViewClients,$i,$NewIp,1)
		WriteLog("INFO",'Client "' & $client & '" changed IP from ' & $LastIP & 'to ' & $NewIP)
	Endif
	TCPShutdown()
EndFunc

; ===================================================================
;Prüft alle Clients des ListViewCLients auf ihren online/offline status
;Get:		-
;Return:	Zahl der Clients die online sind
; ===================================================================
Func CheckAllClients()
	Local $status=0
	For $i = 0 to _GUICtrlListView_GetItemCount($ListViewClients)-1
		$ip=_GUICtrlListView_GetItemText($ListViewClients,$i,1)
		$status+=CheckClient($i)
	Next
	$OnlineClients=$status
	Return $OnlineClients
EndFunc

; ===================================================================
;Prüft ob der Client des ListViewCLientsan der Stelle $i online ist und ruft "Func RefreshIP" auf falls Checkbox $ChkIPs angehakt
;Get:		DNS-NAme des Clients
;Return:	1 - Client ist online
;			0 - Client ist offline
; ===================================================================
Func get_ip($ClientName)
	TCPStartup()
		$ClientIP=TCPNameToIP($ClientName)
	TCPShutdown()
	If $ClientIP="" then
		MsgBox(0,"Error",'Client "' & $ClientName & '" not exists or is not reachable at this time!')
		WriteLog("Error",'Client "' & $ClientName & '" not exists or is not reachable at this time!')
		Return $DefaultIP
	Else
		Return $ClientIP
	EndIf
Endfunc

Func WriteLog($type,$task)
	Local $log, $logfile
	_FileWriteLog(@ScriptDir & "\log.txt", "["&$type&"]: " & $Task)
	BtnRefreshLogClick()
EndFunc

; ===================================================================
; Setzt die Statusmessage im Gui
; Get:	$msgtext    --- Message for status text
;		$Status		--- Art der Nachricht, ändert Farbe des Statusbar
; ===================================================================
func setStatusMsg($Status,$msgtext)
	Select
		Case $Status="ERROR"
		_GUICtrlStatusBar_SetBkColor ($StatusBar1,0x00FF00)

		Case $Status="INFO"
		_GUICtrlStatusBar_SetBkColor ($StatusBar1, $CLR_DEFAULT)

		Case $Status="SUCCESS"
		_GUICtrlStatusBar_SetBkColor ($StatusBar1,0xFF0000)
	EndSelect

	_GUICtrlStatusBar_SetText($StatusBar1,'['&$Status&']  '&$msgtext,0,0)
	;local $LogMsg=_GUICtrlEdit_GetText($EditLog)&'['&$Status&']  '&$msgtext&@CRLF
	;_GUICtrlEdit_SetText($EditLog,$LogMsg)

endfunc

; ===================================================================
; Sendet an alle CLients in ListViewCLients die angehakt sind
; und über alle Adapter in ListViewAdapters die angehakt sind ein
; WOL-Paket raus.
; ===================================================================
func wol_selected()

	local $SelectedClients=0
	local $SelectedNetworkAdapters=0
	local $WOLSendCounter=0


	for $i = 0 to _GUICtrlListView_GetItemCount($ListViewClients)-1
		local $IP=_GUICtrlListView_GetItemText($ListViewClients,$i,1)

		if _GUICtrlListView_GetItemChecked($ListViewClients, $i) Then
		local $pc=_GUICtrlListView_GetItemText($ListViewClients,$i,0)
		local $SelectedNetworkAdapters=0
			$SelectedClients=$SelectedClients+1

			for $j = 0 to _GUICtrlListView_GetItemCount($ListViewAdapters)-1
				if _GUICtrlListView_GetItemChecked($ListViewAdapters, $j) then
				$SelectedNetworkAdapters=$SelectedNetworkAdapters+1
					Select
						case CheckClient($i)=0
							local $macadress=_GUICtrlListView_GetItemText($ListViewClients,$i,2)
							local $adapter =_GUICtrlListView_GetItemText($ListViewAdapters,$j,1)
							wol_adapter($adapter,$macadress)
							setStatusMsg("SUCCESS","WOL sended to " & $PC)
							$WOLSendCounter=$WOLSendCounter+1
						case CheckClient($i)<>0
							setStatusMsg("INFO","Active Powerstate recogneized! Will not send WOL to "&$pc)
					EndSelect
				EndIf
			Next
		EndIf
	Next

	if $WOLSendCounter<>0 then

	EndIf
	if $SelectedClients=0 then
		msgbox(64,"Error","Sorry, no MAC/Ip selected for WakeUp")
		WriteLog("ERROR","Sorry, no MAC/Ip selected for WakeUp")
	EndIf
	if $SelectedNetworkAdapters=0 then
		msgbox(64,"Error","Sorry, no Adapter for Broadcast selected")
		WriteLog("ERROR","Sorry, no Adapter for Broadcast selected")
	EndIf

endfunc

; ===================================================================
; Ermittelt die Gesamtzahl der angehakten Items eines ListViews
; Get:		$h_ListView		--- Handle des ListView Items
; Return:	$SelectedItems	--- Zahl der angehakten Items
; ===================================================================
Func Get_SelectedItemCount($h_ListView)
	local $SelectedItems=0
	for $i = 0 to _GUICtrlListView_GetItemCount($h_ListView)-1
		if _GUICtrlListView_GetItemChecked($h_ListView, $i) Then
				$SelectedItems=$SelectedItems+1
			EndIf
		Next
	Return $SelectedItems
EndFunc

; ===================================================================
; Sendet an Client des ListViewCLientsan der Stelle $i ein WOL-Paket
; über alle  alle Adapter in ListViewAdapters die angehakt sind.
; Get:		$i	--- Zeilennummer des zu prüfenden Clients im ListViewCLients
; Return:	-
; ===================================================================
Func wol_marked($i)
	local $pc=_GUICtrlListView_GetItemText($ListViewClients,$i,0)
	local $ip=_GUICtrlListView_GetItemText($ListViewClients,$i,1)
	local $user=_GUICtrlListView_GetItemText($ListViewClients,$i,3)
	local $pass=_GUICtrlListView_GetItemText($ListViewClients,$i,4)
	local $SelectedNetworkAdapters=0
	setStatusMsg('INFO','Try to wakeup:' & $pc & '  (User: "' & $user & '" ' & 'Password: "' & $pass & '")')
	WriteLog('INFO','Try to wakeup:' & $pc & '  (User: "' & $user & '" ' & 'Password: "' & $pass & '")')

	for $j = 0 to _GUICtrlListView_GetItemCount($ListViewAdapters)-1
		if _GUICtrlListView_GetItemChecked($ListViewAdapters, $j) then
		$SelectedNetworkAdapters=$SelectedNetworkAdapters+1
			Select
				case CheckClient($i)=0
					local $macadress=_GUICtrlListView_GetItemText($ListViewClients,$i,2)
					local $adapter =_GUICtrlListView_GetItemText($ListViewAdapters,$j,1)
					wol_adapter($adapter,$macadress)
					setStatusMsg("SUCCESS","WOL sended to " & $pc)
				case CheckClient($i)<>0
					setStatusMsg("INFO","Active Powerstate recogneized! No WakeUp possible!")
			EndSelect
		EndIf
	Next

	if $SelectedNetworkAdapters=0 then
		msgbox(64,"Error","Sorry, no Adapter for Broadcast selected")
		WriteLog("ERROR","Sorry, no Adapter for Broadcast selected")
	EndIf
EndFunc

; ===================================================================
; Sendet das WOL MagicPaket raus
; Get:	$Broadcast	--- Ip-adresse des Adapters mit 255 am Ende
; 		$MACAddress	--- Mac-adresse des clients
; ===================================================================

; Wake up on Lan Function (Open connection and broadcast to Lan)
Func WOL($Broadcast,$MACAddress)
	UDPStartUp()
	$connexion = UDPOpen($Broadcast,7)
	UDPSend($connexion, GenerateMagicPacket($MACAddress))
	UDPCloseSocket($connexion)
	UDPShutdown()
EndFunc

; ===================================================================
; Generiert das WOL MagicPaket
; Get:	$strMACAddress	--- Mac-adresse des clients
; Return: $MagicPacket	--- Magic Paket
; ===================================================================
Func GenerateMagicPacket($strMACAddress)

    $MagicPacket = ""
    $MACData = ""

    For $p = 1 To 11 Step 2
        $MACData = $MACData & HexToChar(StringMid($strMACAddress, $p, 2))
    Next

    For $p = 1 To 6
        $MagicPacket = HexToChar("ff") & $MagicPacket
    Next

    For $p = 1 To 16
        $MagicPacket = $MagicPacket & $MACData
    Next

    Return $MagicPacket

EndFunc

; This function convert a MAC Address Byte (e.g. "1f") to a char
Func HexToChar($strHex)

    Return Chr(Dec($strHex))

EndFunc

; ===================================================================
; Function: wol_adapter($adapter,$$macadress)
;           $adapter        --- is the ipadress of the adapter
;          $macadress       --- is the macadress
; ===================================================================

func wol_adapter($adapter,$macadress)
    if $adapter <> "0.0.0.0" Then
        $IPADRESS = StringSplit($adapter,".")
        $Broadcast = $IPADRESS[1] & "." & $IPADRESS[2] & "." & $IPADRESS[3] & "." & "255"

        $String=""
                setStatusMsg("INFO","Sent WOL via "&$Broadcast&" for:"&$macadress)
				WriteLog("INFO","Sent WOL via "&$Broadcast&" for:"&$macadress)
                WOL($Broadcast,$macadress)
    EndIf
EndFunc


; ===================================================================
; Function: addNetworkAdapters2ListView()
;           Adds all networkadapters to the listviw
; ===================================================================
Func addNetworkAdapters2ListView()
	_GUICtrlListView_DeleteAllItems(GUICtrlGetHandle($ListViewAdapters))
	For $i = 0 to Ubound($aNetWorkAdapters)-1
			GUICtrlCreateListViewItem(""&$aNetWorkAdapters[$i][0]&"|"&$aNetWorkAdapters[$i][1], $ListViewAdapters)
	Next

	For $i=0 to _GUICtrlListView_GetColumnCount($ListViewAdapters)-1
		_GUICtrlListView_SetColumnWidth($ListViewAdapters,$i,$LVSCW_AUTOSIZE)
	Next
EndFunc

; ===================================================================
; Function: _getnetworkadapter()
;           Get All Network adapters with WMI
;			@IPAddressx does only support 4
; Original : 99ojo http://www.autoitscript.com/forum/index.php?showtopic=107247&view=findpost&p=756774
; ===================================================================

; WMI get only Adapter with ip settings
; If WMI fail or no adapter with ip settings Return 0
Func _getnetworkadapter ()
    $wbemFlagReturnImmediately = 0x10
    $wbemFlagForwardOnly = 0x20
    $colItems = ""
    $found = False
    $strComputer = "localhost"
    $count = 0
    $objWMIService = ObjGet("winmgmts:\\" & $strComputer & "\root\CIMV2")
    $colItems = $objWMIService.ExecQuery("SELECT * FROM Win32_NetworkAdapterConfiguration", "WQL", _
                                              $wbemFlagReturnImmediately + $wbemFlagForwardOnly)

    If IsObj($colItems) then
        For $objItem In $colItems
            If StringInStr ($objItem.IPAddress(0), ".") <> 0 Then
                ReDim $aNetWorkAdapters [$count + 1] [2]
                $aNetWorkAdapters [$count] [0] = $objItem.Caption ;corrected to $count
                $aNetWorkAdapters [$count] [1] = $objItem.IPAddress(0) ;corrected to $count
                $count += 1
                $found = True
            EndIf
        Next
    Else
        Return 0
    EndIf
    If Not $found Then Return 0
EndFunc

; ===================================================================
; Function: get_mac($remote_ip)
;           $remote_ip      --- remote ip
; ===================================================================
func get_mac($remote_ip)
	Ping($remote_ip,1000)
	if @error =0 Then
		$arpinfo = Run(@ComSpec & " /c ARP -a "&$remote_ip, @SystemDir, @SW_HIDE, 2)
		sleep(400)
		$output = StdoutRead($arpinfo, -1)
			$aOutputLine=StringSplit($output,@CRLF)
			If UBound($aOutputLine) > 5 Then ; <=== added so script doesn't choke when processing the IP for the computer it's running on
				$macadress=Stringmid($aOutputLine[7],25,17)
				$macadress=StringReplace($macadress,"-","")
				setStatusMsg("SUCCESS","Found MAC-Address "&$macadress)
				Return $macadress
			EndIf ; <=== and this one...

	Else
		setStatusMsg("ERROR","Host "&$remote_ip&" not reachable")
		Return ""
	endif
EndFunc

Func start()
	Local $WebEPGIndex,$MusicIndex,$MovieIndex,$SeriesIndex=0, $CheckUpdateIndex
	Local $success=0

	Trayseticon(@ScriptFullPath, -7)
	_GUICtrlListView_DeleteAllItems(GUICtrlGetHandle($ListViewTasks))

	If GUICtrlRead($ChkEpg)=$GUI_CHECKED then
		$WebEPGIndex=_GUICtrlListView_AddItem($ListViewTasks,"Update WebEPG-Database")
	Endif

	If GUICtrlRead($ChkMusic)=$GUI_CHECKED then
		$MusicIndex=_GUICtrlListView_AddItem($ListViewTasks,"Update Music-Database")
	Endif

	If GUICtrlRead($ChkMP)=$GUI_CHECKED then
		$MovieIndex=_GUICtrlListView_AddItem($ListViewTasks,"Update MovingPictures-Database")
	Endif

	If GUICtrlRead($ChkSeries)=$GUI_CHECKED then
		$SeriesIndex=_GUICtrlListView_AddItem($ListViewTasks,"Update TvSeries-Database")
	Endif

	$WolIndex=_GUICtrlListView_AddItem($ListViewTasks,"Wake up clients")

	$WaitIndex=_GUICtrlListView_AddItem($ListViewTasks,"Wait for clients being synchronized...")

	$ShutdownIndex=_GUICtrlListView_AddItem($ListViewTasks,"Shut down clients")

	For $i=0 to _GUICtrlListView_GetItemCount($ListViewTasks)-1
		_GUICtrlListView_AddSubItem($ListViewTasks, $i , "pending...", 1)
	Next

	If GUICtrlRead($ChkEpg)=$GUI_CHECKED then
		SetStatus($WebEPGIndex,"working")
		WriteLog("INFO","Updating WebEPG-Database.")
		WriteLog("INFO","Starting WebEPG.exe")

		If WebEPG()=0 then
			SetStatus($WebEPGIndex,"error")
			WriteLog("Error","Update of WebEPG-Database couldn't be initialized.")

		Else

			WriteLog("INFO","Update of WebEPG-Database initialized.")
			Do
				Local $WebEpg=ProcessExists("WebEPG.exe")

				if $WebEpg=0 then
					SetStatus($WebEPGIndex, "completed")
					WriteLog("INFO","Update of WebEPG-Database completed.")
				Endif
				sleep (60000)
			Until $WebEpg=0
			SetStatus($WebEPGIndex,"completed")
			$success=$success+1
		Endif
	Endif


	If GUICtrlRead($ChkMusic)=$GUI_CHECKED then
		If $MusicUpdate=1 then
			SetStatus($MusicIndex, "working")
			If CheckUpdate("Music")=1 then
				WriteLog("INFO","Updating Music-Database.")
				WriteLog("INFO","Starting Madiaportal's Configuration.")

				If Music()=0 then
					SetStatus($MusicIndex, "error")
					WriteLog("Error","Update of Music-Database couldn't be initialized.")
					$error=$error+1
				Else
					WriteLog("INFO","Update of Music-Database initialized.")
					Do
						Local $Config=ProcessExists("Configuration.exe")

						if $Config=0 then
							WriteLog("INFO","Update of Music-Database completed.")
							SetStatus($MusicIndex, "syncing")
							If Sync("Music")=0 then
								SetStatus($MusicIndex, "error")
								WriteLog("Error","Synchronisation of Music-Profile wasn't successful")
							Else
								WriteLog("INFO","Synchronisation of Music-Profile completed")
								$success=$success+1
								SetStatus($MusicIndex, "completed")
							Endif
						Endif
						sleep (60000)
					Until $Config=0
				Endif
				$LastMusicUpdate=_NowCalc()
				IniWrite(@ScriptDir & "\settings.ini","Date","LastMusicUpdate",$LastMusicUpdate)
			Else
				WriteLog("INFO","Music-Database already Up-to-date.")
			EndIf
		Else
			_GUICtrlListView_SetItemText($ListViewTasks, $MusicIndex , $MusicUpdateInterval-$MusicUpdateDif & " days remaining!", 1)
		Endif
	Endif

	If GUICtrlRead($ChkMP)=$GUI_CHECKED then
		WriteLog("INFO","Updating MovingPicture-Database")
		SetStatus($MovieIndex, "working")
		If CheckUpdate("MovingPictures")=1 then
			WriteLog("INFO","Starting MovingPicture configuration")
			If UpdatePluginDB("MovingPictures.dll","movingpictures.log","Moving Pictures Configuration")=0 then
				SetStatus($MovieIndex, "error")
				WriteLog("Error","Update MovingPicture-Database wasn't successful")
				$error=$error+1
			Else
				WriteLog("INFO","Update of MovingPicture-Database completed.")
				SetStatus($MovieIndex, "syncing")
				If Sync("MovingPictures")=0 then
					SetStatus($MovieIndex, "error")
					WriteLog("Error","Synchronisation of MovingPicture-Profile wasn't successful")
				Else
					WriteLog("INFO","Synchronisation of MovingPicture-Profile completed")
					SetStatus($MovieIndex, "completed")
					$success=$success+1
				EndIf
			Endif
		Else
			WriteLog("INFO","MovingPicture-Database already Up-to-date.")
		EndIf
	Endif

	If GUICtrlRead($ChkSeries)=$GUI_CHECKED then
		WriteLog("INFO","Updating TVSeries-Database")
		SetStatus($SeriesIndex, "working")
		If CheckUpdate("TVSeries")=1 then
			WriteLog("INFO","Starting TVSeries configuration")
			If UpdatePluginDB("MP-TVSeries.dll","MP-TVSeries.log","MP-TV Series Configuration")=0 Then
				SetStatus($SeriesIndex, "error")
				WriteLog("Error","Update TVSeries-Database wasn't successful")
			Else
				WriteLog("INFO","Update of TVSeries-Database completed.")
				SetStatus($SeriesIndex, "syncing")
				If Sync("TVSeries")=0 then
					SetStatus($SeriesIndex, "error")
					WriteLog("Error","Synchronisation of TVSeries-Profile wasn't successful")
				Else
					WriteLog("INFO","Synchronisation of TVSeries-Profile completed")
					SetStatus($SeriesIndex, "completed")
					$success=$success+1
				Endif
			Endif
		Else
			WriteLog("INFO","TVSeries-Database already Up-to-date.")
		EndIf
	Endif

	LastClientState()

	If $success<>0 and Get_SelectedItemCount($ListViewClients)<>0 then
		SetStatus($WolIndex, "working")
		wol_selected()
		SetStatus($WolIndex, "completed")
	else
		SetStatus($WolIndex, "completed")
	EndIf

	If $success<>0 and Get_SelectedItemCount($ListViewClients)<>0 then
		SetStatus($WaitIndex, "working")
		sleep(180000)
		SetStatus($WaitIndex, "completed")
	else
		SetStatus($WaitIndex, "completed")
	EndIf

	If $success<>0 and Get_SelectedItemCount($ListViewClients)<>0  then
		SetStatus($ShutdownIndex, "working")
		If ShutdownAll()<>0 Then
			SetStatus($ShutdownIndex, "error")
		else
			SetStatus($ShutdownIndex, "completed")
		Endif
	else
		SetStatus($ShutdownIndex, "completed")
	EndIf

	sleep(5000)
Endfunc


Func SetStatus($Index, $Status)
	Select
		case $Status="pending"
			_GUICtrlListView_SetItemText($ListViewTasks, $Index , "pending...", 1)
		case $Status="working"
			_GUICtrlListView_SetItemText($ListViewTasks, $Index , "working...", 1)
		case $Status="syncing"
			_GUICtrlListView_SetItemText($ListViewTasks, $Index , "syncing...", 1)
		case $Status="completed"
			_GUICtrlListView_SetItemText($ListViewTasks, $Index , "completed.", 1)
		case $Status="error"
			_GUICtrlListView_SetItemText($ListViewTasks, $Index , "ERROR!", 1)
	Endselect
Endfunc
#EndRegion
#Region Start-Funktionen

Func UpdatePluginDB($dll,$log,$WindowTitle)
	Local $PID=Run($MPPath & '\PluginConfigLoader.exe /plugin="' & $MPPath & '\plugins\Windows\' & $dll & '"')
	If $PID=0 Then
		MsgBox(1,"Error","PluginConfigloader couldn't be started!" & @CRLF & "Check your MediaPortal program path:" & @CRLF & $MPPath,10)
		WriteLog("ERROR","PluginConfigloader couldn't be started!" & @CRLF & "Check your MediaPortal program path:" & @CRLF & $MPPath)
		Return 0
	EndIf

	If WinWait($WindowTitle,"",180)=0 then
		WriteLog("ERROR","PluginConfigloader window wasn't started! Hung up?")
		Return 0
	Endif

	If $dll="MP-TVSeries.dll" then
		#region --- AutoIt Macro Generator V 0.21 beta ---
		Opt("WinWaitDelay",100)
		Opt("WinTitleMatchMode",4)
		Opt("WinDetectHiddenText",1)
		WinWait("MP-TV Series Configuration","")
		If Not WinActive("MP-TV Series Configuration","") Then WinActivate("MP-TV Series Configuration","")
		WinWaitActive("MP-TV Series Configuration","")
		ControlClick ("MP-TV Series Configuration","","[NAME:buttonStartImport]")
		ChkWork($MPConfPath & '\log\' & $log)
		ControlClick ("MP-TV Series Configuration","","[NAME:buttonNext]")
		ChkWork($MPConfPath & '\log\' & $log)
		ControlClick ("MP-TV Series Configuration","","[NAME:buttonNext]")
		#endregion --- End ---
	EndIf
	ChkWork($MPConfPath & '\log\' & $log)

	ProcessClose ($PID)
	sleep(1000)
	Return 1
Endfunc

Func CheckUpdate($plugin)
	local $hQuery, $LocalDbDate, $RemoteDbDate

	Switch $plugin
		Case "MovingPictures"
			$Profilename="MovingPictures Database"
			$Chk=$ChkMP
		Case "TVSeries"
			$Profilename="TVSeries Database"
			$Chk=$ChkSeries
		Case "Music"
			$Profilename="Music Database"
			$Chk=$ChkMusic
	EndSwitch

	Local $Items = _GUICtrlListView_GetItemCount($ListViewProfiles)
	For $Item = 0 To $Items - 1
		Local $itemTxt = _GUICtrlListView_GetItemTextArray($ListViewProfiles, $Item)
		Local $itemSc = _GUICtrlListView_GetItemText($ListViewProfiles,$Item,2)
		Local $itemDest = _GUICtrlListView_GetItemText($ListViewProfiles,$Item,3)
		If $itemTxt = $Profilename then
				If FileExists($itemSc) then $LocalDb=$itemSc
				If FileExists($itemDest) then $RemoteDb=$itemDest
		Endif
	Next

	If $LocalDb<>"" and $RemoteDb<>"" and GUICtrlRead($Chk)=$GUI_CHECKED then
		_SQLite_Startup()
		_SQLite_Open($LocalDb)
		If @error = -1 Then
			WriteLog("ERROR", "Auf Master " & $plugin & " Datenbank kann nicht zugegriffen werden! Ist Syncprofil '" & $Profilename & "' korrekt eingetragen?")
			Return 0
		EndIf
		_SQLite_Query(-1, "SELECT date_added FROM movie_info ORDER BY date_added DESC LIMIT 1;", $hQuery)
		_SQLite_FetchData($hQuery, $LocalDbDate)
		_SQLite_QueryFinalize($hQuery)
		_SQLite_Close()

		_SQLite_Open($RemoteDb)
		Local $MPdbLcDate
		If @error = -1 Then
			WriteLog("ERROR", "Auf lokale " & $plugin & " Datenbank kann nicht zugegriffen werden! Ist Syncprofil '" & $Profilename & "' korrekt eingetragen?")
			Return 0
		EndIf
		_SQLite_Query(-1, "SELECT date_added FROM movie_info ORDER BY date_added DESC LIMIT 1;", $hQuery)
		_SQLite_FetchData($hQuery, $RemoteDbDate)
		_SQLite_QueryFinalize($hQuery)
		_SQLite_Close()
		_SQLite_Shutdown()

		If $plugin="MovingPictures" then
			$LocalDbDate = StringTrimRight(StringReplace($LocalDbDate[0], "-", "/"), 1)
			$RemoteDbDate = StringTrimRight(StringReplace($RemoteDbDate[0], "-", "/"), 1)
		else
			$LocalDbDate = StringReplace($LocalDbDate[0], "-", "/")
			$RemoteDbDate = StringReplace($RemoteDbDate[0], "-", "/")
		EndIf

		WriteLog("INFO", $plugin & ":          Lokales Datum:" & $LocalDbDate & " <--> Server Datum:" & $RemoteDbDate)

		If _DateDiff('s', $RemoteDbDate, $LocalDbDate) <> 0 Then
			WriteLog("INFO", $plugin & " Datenbank wird aktualisiert ...")
			return 1
		EndIf
	EndIf
EndFunc

Func Music()
	Local $PID=Run($MPPath & '\configuration.exe')

	#region --- AutoIt Macro Generator V 0.21 beta ---
	Opt("WinTitleMatchMode", 4)

	WinWait("Windows 2008 R2 [6.1.7600.0]","Your platform is not supported",20)
	ControlClick("Windows 2008 R2 [6.1.7600.0]","Your platform is not supported","Button1")
	#endregion --- End ---

	If $PID=0 Then
		MsgBox(1,"Error","Mediaportal's configuration.exe couldn't be started!" & @CRLF & "Check your MediaPortal program path:" & @CRLF & $MPPath,10)
		WriteLog("ERROR","Mediaportal's configuration.exe couldn't be started!" & @CRLF & "Check your MediaPortal program path:" & @CRLF & $MPPath)
		Return 0
	EndIf

	Opt("WinWaitDelay",100)
	Opt("WinTitleMatchMode",4)
	Opt("WinDetectHiddenText",1)
	Opt("MouseCoordMode",0)
	WinWait("MediaPortal - Configuration","")
	If Not WinActive("MediaPortal - Configuration","") Then WinActivate("MediaPortal - Configuration","")
	WinWaitActive("MediaPortal - Configuration","")

	local $Treeview=ControlGetHandle ( "MediaPortal - Configuration", "", "[NAME:sectionTree]" )
	local $TreeviewMusicItem=_GUICtrlTreeView_GetFirstItem($Treeview)

		for $i=0 to 3	;Music-Item wird ausgewählt
			$TreeviewMusicItem=_GUICtrlTreeView_GetNextSibling($Treeview, $TreeviewMusicItem)
		Next
		_GUICtrlTreeView_Expand($Treeview, $TreeviewMusicItem)
		_GUICtrlTreeView_ClickItem($Treeview, $TreeviewMusicItem)
	local $TreeviewMusicDatabaseItem=_GUICtrlTreeView_GetNext($Treeview, $TreeviewMusicItem)
		$TreeviewMusicDatabaseItem=_GUICtrlTreeView_GetNext($Treeview, $TreeviewMusicDatabaseItem)
		_GUICtrlTreeView_ClickItem($Treeview, $TreeviewMusicDatabaseItem)
		ControlClick("MediaPortal - Configuration","","[NAME:startButton]")
		sleep(1000)
		ControlClick("MediaPortal - Configuration","","[NAME:okButton]")
		Return 1
	Endfunc

Func ChkWindow($WindowTitle)
	Local $PID

	If WinWait($WindowTitle,"",20)=0 then
		$PID=ProcessExists("PluginConfigLoader.exe")
		ProcessClose ($PID)
		Return 0
	else
		Return 1
	Endif
EndFunc

Func ChkWork($File)
	Local $FileTime1, $FileTime2
	$FileTime1 = FileGetTime($File, 0, 1)
	sleep (60000)
	$FileTime2 = FileGetTime($File, 0, 1)

	WriteLog("INFO","Wait for finishing the update process...")
	While $FileTime2 > $FileTime1
		$FileTime1 = FileGetTime($File, 0, 1)
		sleep (60000)
		$FileTime2 = FileGetTime($File, 0, 1)
	WEnd
EndFunc

Func WebEPG()
	Local $PID=Run($WebEPGExe)
	If $PID=0 Then
		MsgBox(1,"Error","WebEPG.exe couldn't be started!" & @CRLF & "Check your MediaPortal program path:" & @CRLF & $MPPath,10)
		WriteLog("ERROR","WebEPG.exe couldn't be started!" & @CRLF & "Check your MediaPortal program path:" & @CRLF & $MPPath)
		Return 0
	EndIf
	Return 1
EndFunc

Func ChkExit($MusicIndex, $WebEPGIndex)
	Local $ConfigFini=0
	Local $WebEpgFIni=0

	Do
		Local $Config=ProcessExists("Configuration.exe")
		Local $WebEpg=ProcessExists("WebEPG.exe")

		if $Config=0 and $ConfigFini=0 then
			$ConfigFini=1
			SetStatus($MusicIndex, "completed")
			WriteLog("INFO","Update of Music-Database completed.")
		Endif

		if $WebEpg=0 and $WebEpgFIni=0 then
			$WebEpgFini=1
			SetStatus($WebEPGIndex, "completed")
			WriteLog("INFO","Update of WebEPG-Database completed.")
		Endif

		sleep (60000)
	Until $Config=0 and $WebEpg=0
EndFunc

;Dateisynchronisation wird vorgenommen
Func Sync($PluginProfile)
	Local $Items = IniRead(@ScriptDir & "\settings.ini", "Profiles", "Count", "0")
	If $Items > 0 Then
		Local $Txt[$Items][3]
		For $i = 0 To $Items - 1
			$Selected = IniRead(@ScriptDir & "\settings.ini", "Profiles", "Data" & $i, "False")
			$ProfileType = IniRead(@ScriptDir & "\settings.ini", "Profiles", "Data" & $i & "4", "Other")
			If $Selected = "True" And $ProfileType = $PluginProfile Then
				For $j = 0 To UBound($Txt, 2) - 1
					$Txt[$i][$j] = IniRead(@ScriptDir & "\settings.ini", "Profiles", "Data" & $i & $j + 1, "")
				Next
				WriteLog("INFO", "Das Profil " & $Txt[$i][0] & " wird Synchronisiert!")
				SyncFiles($Txt[$i][1], $Txt[$i][2], $verifyMethod)
			EndIf
		Next
	EndIf
EndFunc   ;==>Sync

Func CheckVersion()
	Local $VersionOnline, $VersionLocal, $DownAdr, $remote_size, $lokal_size, $Progress=0, $status
	Select
		case $Update="No Update"
			Return
		case $Update="Check for SVN"
			$DownAdr='http://sync-mp.googlecode.com/svn/trunk/MP-SyncServer/'
		case $Update="Check for Stable"
			$DownAdr='http://sync-mp.googlecode.com/files/'
	EndSelect

	$LastCheck=_NowCalc()
	$VersionOnline=BinaryToString(InetRead($DownAdr & 'ServerVersion.txt'))
	$VersionLocal=FileGetVersion(@ScriptFullPath)
	If $VersionOnline>$VersionLocal Then
		WriteLog("INFO", "Newer MP-SyncServer version available for download!")
		sleep(300)

		#include <ProgressConstants.au3>
#Region ### START Koda GUI section ### Form=D:\Benutzer\Seppi\Documents\AutoIT\SyncServer\Source\DownloadForm.kxf
$DownloadForm = GUICreate("Update SyncServer", 523, 80, -1, -1, BitOR($WS_DLGFRAME,$WS_POPUP,$WS_CLIPSIBLINGS,$DS_SETFOREGROUND))
$ProgressBar = GUICtrlCreateProgress(8, 32, 505, 33, BitOR($PBS_SMOOTH,$WS_BORDER))
$LblText = GUICtrlCreateLabel("Downloading new SyncServer-Version", 8, 8, 185, 17)
$Label2 = GUICtrlCreateLabel("LblProgress", 204, 35, 115, 28, $SS_CENTER)
GUICtrlSetFont(-1, 14, 800, 0, "MS Sans Serif")
GUISetState(@SW_SHOW)
#EndRegion ### END Koda GUI section ###

		Local $FileSize = InetGetSize($DownAdr & "SyncServer.exe")
		Local $DownloadProg = InetGet($DownAdr & 'SyncServer.exe',@ScriptDir & '\SyncServer_new.exe',17,1)

		Do
			$BytesDownloaded    = INetGetInfo($DownloadProg, 0)
			$SoFar              = Floor(($BytesDownloaded / $FileSize) * 100)
			GUICtrlSetData($ProgressBar, $SoFar)
			sleep(100)
		Until InetGetInfo($DownloadProg,2)
		If InetGetInfo($DownloadProg,4)<>0 then Msgbox(48,"Download error","Can't download file from " & @CRLF & $DownAdr & "SyncServer.exe" & @CRLF & "Please check your internet connection!" )

		InetClose($DownloadProg)
		GUIDelete ("DownloadForm")

		if $Status=0 then
			WriteLog("INFO", "New MP-SyncServer version downloaded succesfully!")
			sleep(200)
			$RunUpdate=Run(@ScriptDir & "\Updater.exe -SyncServer")
			If $RunUpdate<>0 Then
				Exit
			Else
				WriteLog("ERROR", "Couldn't find Updater.exe!")
			EndIf
		else
			WriteLog("ERROR", "Couldn't download new MP-SyncServer version!")
		EndIf
	Endif
Endfunc
#EndRegion
#Region DauerFunktionen
#EndRegion
#EndRegion

;--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
#Region SyncTool
;--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
;~ Coded by Ian Maxwell (llewxam)
;~ Autoit 3.3.6.1
;~ Coded with many ideas and some code contributions by many people in the forum, thanks to all contributors and people who give their time answering questions!!!
;~ Also, sorry if some variables and the $stats array seem odd, it has been said before (rightly) that I could improve upon that!!  :D   Questions, just ask!





Func SyncFiles($Source, $target, $verifyMethod)
	;Sammle Dateien Msg Ausgeben
	AdlibRegister("_SpeedCalc")
	;GUICtrlSetState($marqueeBanner, $GUI_SHOW)
	$result = _FileListToArrayXT($Source, Default, 1, 2, True)
	AdlibUnRegister("_SpeedCalc")
	$stats[7] = $totalSize

	$put = $target

;~      get to work!
	AdlibRegister("_SpeedCalc")

	$started = True
	$time = TimerInit()
	For $a = 1 To $result[0] Step 2
		$copySource = $result[$a]
		$subdir = StringTrimLeft($copySource, StringLen($Source))
		$Destination = $put & $subdir
		$lastDir = StringMid($Destination, 1, StringInStr($Destination, "\", 2, -1) - 1)
		If Not FileExists($lastDir) Then DirCreate($lastDir)
		$copySize = $result[$a + 1]
		_MarqueeScroll()
		_copy($copySource, $copySize, $Destination)
	Next
;~      done... all this code, and all for THIS!!  :)
	AdlibUnRegister("_SpeedCalc")
	$started = False

	$synced = _StringAddThousandsSep($syncedFiles)
	$skipped = _StringAddThousandsSep($skippedFiles)
	$failed = _StringAddThousandsSep(UBound($failedFiles) - 1)


	If UBound($failedFiles) > 1 Then
		_ArrayDelete($failedFiles, 0)
		_ArrayDisplay($failedFiles, "Failed Items")
		Return 0
	EndIf

	Return 1

EndFunc   ;==>SyncFiles

Func _copy($copySource, $copySize, $copyDestination)
	$sync = False

	$syncedFilesize += $copySize

	If $verifyMethod == "Exist & Size" Then
		If Not FileExists($copyDestination) Or FileGetSize($copyDestination) <> $copySize Then $sync = True
	ElseIf $verifyMethod == "Exist" Then
		If Not FileExists($copyDestination) Then $sync = True
	ElseIf $verifyMethod == "Size" Then
		If FileGetSize($copyDestination) <> $copySize Then $sync = True
	ElseIf $verifyMethod == "MD5 (slow)" Then
		$sourceHash = _Crypt_HashFile($copySource, $CALG_MD5)
		If _Crypt_HashFile($copyDestination, $CALG_MD5) <> $sourceHash Then $sync = True
	EndIf

	If $sync == True Then
		$PID = Run(@ComSpec & " /c copy /y " & Chr(34) & $copySource & Chr(34) & " " & Chr(34) & $copyDestination & Chr(34), @ScriptDir, @SW_HIDE)
		$stats[1] = 0
		$stats[2] = 0
		Do
			$array = ProcessGetStats($PID, 1)
			If IsArray($array) Then
				$stats[1] = $array[4] - $stats[2]
				If $stats[1] > 0 Then $stats[3] += $stats[1]
				$stats[2] = $array[4]
				Sleep(75)
			EndIf
		Until Not ProcessExists($PID)

		If $verifyMethod == "Exist & Size" Then
			If Not FileExists($copyDestination) Then
				$attrib = FileGetAttrib($copySource)
				If StringInStr($attrib, "A") Then FileSetAttrib($copySource, "-A")
				If StringInStr($attrib, "H") Then FileSetAttrib($copySource, "-H")
				If StringInStr($attrib, "R") Then FileSetAttrib($copySource, "-R")
				If StringInStr($attrib, "S") Then FileSetAttrib($copySource, "-S")
				$PID = Run(@ComSpec & " /c copy /y " & Chr(34) & $copySource & Chr(34) & " " & Chr(34) & $copyDestination & Chr(34), @ScriptDir, @SW_HIDE)
				$stats[1] = 0
				$stats[2] = 0
				Do
					$array = ProcessGetStats($PID, 1)
					If IsArray($array) Then
						$stats[1] = $array[4] - $stats[2]
						If $stats[1] > 0 Then $stats[3] += $stats[1]
						$stats[2] = $array[4]
						Sleep(75)
					EndIf
				Until Not ProcessExists($PID)
				If Not FileExists($copyDestination) Then _ArrayAdd($failedFiles, $copySource)
			Else
				$syncedFiles += 1
			EndIf
		EndIf

		If $verifyMethod == "Exist" Then
			If Not FileExists($copyDestination) Then
				$attrib = FileGetAttrib($copySource)
				If StringInStr($attrib, "A") Then FileSetAttrib($copySource, "-A")
				If StringInStr($attrib, "H") Then FileSetAttrib($copySource, "-H")
				If StringInStr($attrib, "R") Then FileSetAttrib($copySource, "-R")
				If StringInStr($attrib, "S") Then FileSetAttrib($copySource, "-S")
				$PID = Run(@ComSpec & " /c copy /y " & Chr(34) & $copySource & Chr(34) & " " & Chr(34) & $copyDestination & Chr(34), @ScriptDir, @SW_HIDE)
				$stats[1] = 0
				$stats[2] = 0
				Do
					$array = ProcessGetStats($PID, 1)
					If IsArray($array) Then
						$stats[1] = $array[4] - $stats[2]
						If $stats[1] > 0 Then $stats[3] += $stats[1]
						$stats[2] = $array[4]
						Sleep(75)
					EndIf
				Until Not ProcessExists($PID)
				If Not FileExists($copyDestination) Then _ArrayAdd($failedFiles, $copySource)
			Else
				$syncedFiles += 1
			EndIf
		EndIf

		If $verifyMethod == "Size" Then
			If FileGetSize($copyDestination) <> $copySize Then
				$attrib = FileGetAttrib($copySource)
				If StringInStr($attrib, "A") Then FileSetAttrib($copySource, "-A")
				If StringInStr($attrib, "H") Then FileSetAttrib($copySource, "-H")
				If StringInStr($attrib, "R") Then FileSetAttrib($copySource, "-R")
				If StringInStr($attrib, "S") Then FileSetAttrib($copySource, "-S")
				$PID = Run(@ComSpec & " /c copy /y " & Chr(34) & $copySource & Chr(34) & " " & Chr(34) & $copyDestination & Chr(34), @ScriptDir, @SW_HIDE)
				$stats[1] = 0
				$stats[2] = 0
				Do
					$array = ProcessGetStats($PID, 1)
					If IsArray($array) Then
						$stats[1] = $array[4] - $stats[2]
						If $stats[1] > 0 Then $stats[3] += $stats[1]
						$stats[2] = $array[4]
						Sleep(75)
					EndIf
				Until Not ProcessExists($PID)
				If FileGetSize($copyDestination) <> $copySize Then _ArrayAdd($failedFiles, $copySource)
			Else
				$syncedFiles += 1
			EndIf
		EndIf
		If $verifyMethod == "MD5 (slow)" Then
			If _Crypt_HashFile($copyDestination, $CALG_MD5) <> $sourceHash Then
				$attrib = FileGetAttrib($copySource)
				If StringInStr($attrib, "A") Then FileSetAttrib($copySource, "-A")
				If StringInStr($attrib, "H") Then FileSetAttrib($copySource, "-H")
				If StringInStr($attrib, "R") Then FileSetAttrib($copySource, "-R")
				If StringInStr($attrib, "S") Then FileSetAttrib($copySource, "-S")
				$PID = Run(@ComSpec & " /c copy /y " & Chr(34) & $copySource & Chr(34) & " " & Chr(34) & $copyDestination & Chr(34), @ScriptDir, @SW_HIDE)
				$stats[1] = 0
				$stats[2] = 0
				Do
					$array = ProcessGetStats($PID, 1)
					If IsArray($array) Then
						$stats[1] = $array[4] - $stats[2]
						If $stats[1] > 0 Then $stats[3] += $stats[1]
						$stats[2] = $array[4]
						Sleep(75)
					EndIf
				Until Not ProcessExists($PID)
				If _Crypt_HashFile($copyDestination, $CALG_MD5) <> $sourceHash Then _ArrayAdd($failedFiles, $copySource)
			Else
				$syncedFiles += 1
			EndIf
		EndIf
	EndIf

	If $sync == False Then $skippedFiles += 1
	If $deleteAfterSync == True Then FileDelete($copySource)

	$stats[4] += $copySize
	$stats[3] = $stats[4]
	$fileCount -= 1
	$stats[7] -= $copySize
	Return
EndFunc   ;==>_copy


Func _FileListToArrayXT($sPath = @ScriptDir, $sFilter = "*", $iRetItemType = 0, $iRetPathType = 0, $bRecursive = False, $sExclude = "", $iRetFormat = 1)
	Local $hSearchFile, $sFile, $sFileList, $sWorkPath, $sRetPath, $iRootPathLen, $iPCount, $iFCount, $fDirFlag
	If $sPath = -1 Or $sPath = Default Then $sPath = @ScriptDir
	$sPath = StringRegExpReplace(StringRegExpReplace($sPath, "(\s*;\s*)+", ";"), "\A;|;\z", "")
	If $sPath = "" Then Return SetError(1, 1, "")
	If $sFilter = -1 Or $sFilter = Default Then $sFilter = "*"
	$sFilter = StringRegExpReplace(StringRegExpReplace($sFilter, "(\s*;\s*)+", ";"), "\A;|;\z", "")
	If StringRegExp($sFilter, "[\\/><:\|]|(?s)\A\s*\z") Then Return SetError(2, 2, "")
	If $bRecursive Then
		$sFilter = StringRegExpReplace($sFilter, '([\Q\.+[^]$(){}=!\E])', '\\$1')
		$sFilter = StringReplace($sFilter, "?", ".")
		$sFilter = StringReplace($sFilter, "*", ".*?")
		$sFilter = "(?i)\A(" & StringReplace($sFilter, ";", "$|") & "$)" ;case-insensitive, convert ';' to '|', match from first char, terminate strings
	EndIf
	If $iRetItemType <> "1" And $iRetItemType <> "2" Then $iRetItemType = "0"
	If $iRetPathType <> "1" And $iRetPathType <> "2" Then $iRetPathType = "0"
	$bRecursive = ($bRecursive = "1")
	If $sExclude = -1 Or $sExclude = Default Then $sExclude = ""
	If $sExclude Then
		$sExclude = StringRegExpReplace(StringRegExpReplace($sExclude, "(\s*;\s*)+", ";"), "\A;|;\z", "")
		$sExclude = StringRegExpReplace($sExclude, '([\Q\.+[^]$(){}=!\E])', '\\$1')
		$sExclude = StringReplace($sExclude, "?", ".")
		$sExclude = StringReplace($sExclude, "*", ".*?")
		$sExclude = "(?i)\A(" & StringReplace($sExclude, ";", "$|") & "$)" ;case-insensitive, convert ';' to '|', match from first char, terminate strings
	EndIf
	If Not ($iRetItemType = 0 Or $iRetItemType = 1 Or $iRetItemType = 2) Then Return SetError(3, 3, "")
	Local $aPath = StringSplit($sPath, ';', 1) ;paths array
	Local $aFilter = StringSplit($sFilter, ';', 1) ;filters array
	For $iPCount = 1 To $aPath[0] ;Path loop
		$sPath = StringRegExpReplace($aPath[$iPCount], "[\\/]+\z", "") & "\" ;ensure exact one trailing slash
		If Not FileExists($sPath) Then ContinueLoop
		$iRootPathLen = StringLen($sPath) - 1
		Local $aPathStack[1024] = [1, $sPath]
		While $aPathStack[0] > 0
			$sWorkPath = $aPathStack[$aPathStack[0]]
			$aPathStack[0] -= 1
			$hSearchFile = FileFindFirstFile($sWorkPath & '*')
			If @error Then
				FileClose($hSearchFile)
				ContinueLoop
			EndIf
			$sRetPath = $sWorkPath
			While True ;Files only
				$sFile = FileFindNextFile($hSearchFile)
				If @error Then
					FileClose($hSearchFile)
					ExitLoop
				EndIf
				If @extended Then
					$aPathStack[0] += 1
					If UBound($aPathStack) <= $aPathStack[0] Then ReDim $aPathStack[UBound($aPathStack) * 2]
					$aPathStack[$aPathStack[0]] = $sWorkPath & $sFile & "\"
					ContinueLoop
				EndIf
				If StringRegExp($sFile, $sFilter) Then
					$size = FileGetSize($sRetPath & $sFile)
					$fileCount += 1
					$totalSize += $size
					$sFileList &= $sRetPath & $sFile & "|" & $size & "|"
				EndIf
			WEnd
		WEnd
		FileClose($hSearchFile)
	Next ;$iPCount - next path
	If $sFileList Then
		Switch $iRetFormat
			Case 2 ;return a delimited string
				Return StringTrimRight($sFileList, 1)
			Case 0 ;return a 0-based array
				Return StringSplit(StringTrimRight($sFileList, 1), "|", 2)
			Case Else ;return a 1-based array
				Return StringSplit(StringTrimRight($sFileList, 1), "|", 1)
		EndSwitch
	Else
		Return SetError(4, 4, "")
	EndIf

EndFunc   ;==>_FileListToArrayXT


Func _MarqueeScroll()
	$marqueeProgress = $syncedFilesize / $totalSize * 100
EndFunc   ;==>_MarqueeScroll


Func _SpeedCalc()

	If $marqueeScroll == True Then
		;GUICtrlSetData($showFileSize, _ByteSuffix($totalSize))
		If $fileCount > 1 Then
			;GUICtrlSetData($showFileCount, _StringAddThousandsSep($fileCount) & " Files")
		Else
			;GUICtrlSetData($showFileCount, _StringAddThousandsSep($fileCount) & " File")
		EndIf
		;GUICtrlSetData($sourceLabel, "Enumerating files, please wait")
	EndIf

	If $started == True Then

		$stats[6] = ($stats[3] - $stats[5]) * 4
		$stats[5] = $stats[3]
		;GUICtrlSetData($fileName, $copySource)
		;GUICtrlSetData($fileSize, "(" & _ByteSuffix($copySize) & ")")
		;GUICtrlSetData($fileProg, ($stats[2] / $copySize) * 100)
		;GUICtrlSetData($totalProg, ($stats[3] / $totalSize) * 100)
		If $fileCount > 1 Then
			;GUICtrlSetData($showFileCount, _StringAddThousandsSep($fileCount) & " Files")
		Else
			;GUICtrlSetData($showFileCount, _StringAddThousandsSep($fileCount) & " File")
		EndIf
		;GUICtrlSetData($showFileSize, _ByteSuffix($totalSize - (($stats[3] / $totalSize)) * $totalSize))
		;GUICtrlSetData($showSynced, _StringAddThousandsSep($syncedFiles) & " Synced")
		;GUICtrlSetData($showSkipped, _StringAddThousandsSep($skippedFiles) & " Skipped")
		;GUICtrlSetData($showFailed, _StringAddThousandsSep(UBound($failedFiles) - 1) & " Failed")
		;GUICtrlSetData($showSpeed, _ByteSuffix($stats[6]) & "/s")

		$elapsedSeconds = Int(TimerDiff($time) / 1000)
		$elapsedMinutes = 0
		$elapsedHours = 0
		Do
			If $elapsedSeconds >= 60 Then
				$elapsedSeconds -= 60
				$elapsedMinutes += 1
			EndIf
		Until $elapsedSeconds < 60
		Do
			If $elapsedMinutes >= 60 Then
				$elapsedMinutes -= 60
				$elapsedHours += 1
			EndIf
		Until $elapsedMinutes < 60
		If StringLen($elapsedSeconds) == 1 Then $elapsedSeconds = "0" & $elapsedSeconds
		If StringLen($elapsedMinutes) == 1 Then $elapsedMinutes = "0" & $elapsedMinutes
		If StringLen($elapsedHours) == 1 Then $elapsedHours = "0" & $elapsedHours
		GUICtrlSetData($showElapsedTime, $elapsedHours & ":" & $elapsedMinutes & ":" & $elapsedSeconds)


	EndIf
EndFunc   ;==>_SpeedCalc


Func _ByteSuffix($bytes)
	Local $x, $bytes_suffix[6] = [" B", " KB", " MB", " GB", " TB", " PB"]
	While $bytes > 1023
		$x += 1
		$bytes /= 1024
	WEnd
	Return StringFormat('%.2f', $bytes) & $bytes_suffix[$x]
EndFunc   ;==>_ByteSuffix


Func _StringAddThousandsSep($sText)
	If Not StringIsInt($sText) And Not StringIsFloat($sText) Then Return SetError(1)
	Local $aSplit = StringSplit($sText, "-" & $sDecimal)
	Local $iInt = 1, $iMod
	If Not $aSplit[1] Then
		$aSplit[1] = "-"
		$iInt = 2
	EndIf
	If $aSplit[0] > $iInt Then
		$aSplit[$aSplit[0]] = "." & $aSplit[$aSplit[0]]
	EndIf
	$iMod = Mod(StringLen($aSplit[$iInt]), 3)
	If Not $iMod Then $iMod = 3
	$aSplit[$iInt] = StringRegExpReplace($aSplit[$iInt], '(?<=\d{' & $iMod & '})(\d{3})', $sThousands & '\1')
	For $i = 2 To $aSplit[0]
		$aSplit[1] &= $aSplit[$i]
	Next
	Return $aSplit[1]
EndFunc   ;==>_StringAddThousandsSep

;--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
#EndRegion SyncTool
;--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
