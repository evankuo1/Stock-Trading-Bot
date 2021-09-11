::  *************************************************************************************************************************
::  *************************************************************************************************************************
::  *************************************************************************************************************************
::													Introduction
::													jumpTo Introduction

::  stock buying script. Used to automate stock buying










::  *************************************************************************************************************************
::  *************************************************************************************************************************
::  *************************************************************************************************************************
::													 Notes/Tips
:: 													 jumpTo Notes/Tips

	:: How to check for parameters
	:: IF NOT "%~1"=="" (nircmd sendkeypress %~1) ELSE (nircmd sendkeypress 5)

	:: How to add variables together into a new variable
	:: SET /A ORDER_QUANTITY = !temp! + %~1

	:: How to compare strings
	:: SET random_var=dog
	:: IF "%random_var%" == "dog" (timeout 100) ELSE (timeout 1000)
		:: or
	:: CALL :FunctionName "word"
	:: :FunctionName
	:: 		:: IF %1 == "word" (meow meow meow)


	:: How to divide variables and store into another variable
	::SET /A var3 = 20
	::SET /A var2 = 2
	::SET /A var1 = %var3% / %var2%


	:: batch scripts don't like variables being defined in if blocks






::  *************************************************************************************************************************
::  *************************************************************************************************************************
::  *************************************************************************************************************************
::													Variables/Settings
::													jumpTo Variables/Settings


	:: batch script defaults
	@echo off
	SETLOCAL ENABLEDELAYEDEXPANSION


	:: settings
	SET /A SETTING_FASTCOMPUTER = 0
	SET /A SETTING_TESTING = 0


	:: read from file
	SET /A ORDER_OPENED = -1
	SET /A ORDER_TYPE = -1
	SET /A ORDER_QUANTITY = -1
	SET /A ORDER_PRICEDOLLAR = -1
	SET /A ORDER_PRICECENTS = -1


	:: taskbar
	SET /A TASKBAR_START_Y = 1050
	SET /A TASKBAR_START_X = 685
	SET /A TASKBAR_INCREMENT = 80


	:: searchbar
	SET /A SEARCHBAR_X = 250
	SET /A SEARCHBAR_Y = 1050
	SET /A SEARCHBAR_BESTRESULT_X = 250
	SET /A SEARCHBAR_BESTRESULT_Y = 210


	:: window
	SET /A WINDOW_MINIMIZE_X = 1730
	SET /A WINDOW_MINIMIZE_Y = 30
	SET /A WINDOW_EXIT_X = 2000
	SET /A WINDOW_EXIT_Y = 30


	:: File Explorer
	SET /A FE_RESULTS_ICONS_START_X = 370
	SET /A FE_RESULTS_ICONS_START_Y = 225
	SET /A FE_RESULTS_ICONS_INCREMENT = 160
	SET /A FE_RESULTS_BARS_START_X = 370
	SET /A FE_RESULTS_BARS_START_Y = 220
	SET /A FE_RESULTS_BARS_INCREMENT = 30
	SET /A FE_SIDEBAR_START_X = 160
	SET /A FE_SIDEBAR_START_Y = 185
	SET /A FE_FILENAME_X = 900
	SET /A FE_FILENAME_Y = 850
	SET /A FE_SAVE_X = 670
	SET /A FE_SAVE_Y = 970


	:: Firefox
	SET /A FF_URL_X = 600
	SET /A FF_URL_Y = 80
	SET /A FF_TAB_OPEN_X = 340
	SET /A FF_TAB_OPEN_Y = 15
	SET /A FF_TAB_OPEN_INCREMENT = 340
	SET /A FF_TAB_X = 50
	SET /A FF_TAB_Y = 15
	SET /A FF_TAB_INCREMENT = 340

	:: Robinhood
	SET /A RH_BUYBUTTON_X = 1370
	SET /A RH_BUYBUTTON_Y = 330
	SET /A RH_SELLBUTTON_X = 1500
	SET /A RH_SELLBUTTON_Y = 330
	SET /A RH_SHAREINPUT_X = 1650
	SET /A RH_SHAREINPUT_Y = 500
	SET /A RH_REVIEWBUTTON_X = 1650
	SET /A RH_REVIEWBUTTON_Y = 750
	SET /A RH_PLACEORDERBUTTON_X = 1650
	SET /A RH_PLACEORDERBUTTON_Y = 850
	SET /A RH_DONEBUTTON_X = 1650
	SET /A RH_DONEBUTTON_Y = 750
	SET /A RH_ACCOUNTBUTTON_X = 1780
	SET /A RH_ACCOUNTBUTTON_Y = 200
	SET /A RH_ACCOUNTDROPDOWN_WHITESPACE_X = 1780
	SET /A RH_ACCOUNTDROPDOWN_WHITESPACE_Y = 250
	SET /A RH_LOGOUTBUTTON_X = 1700
	SET /A RH_LOGOUTBUTTON_Y = 950
	SET /A RH_SIGNINBUTTON_X = 1100
	SET /A RH_SIGNINBUTTON_Y = 850
	SET /A RH_SEARCHBAR_X = 500
	SET /A RH_SEARCHBAR_Y = 200

	SET /A BNDICM_RECORDBUTTON_X = 1295
	SET /A BNDICM_RECORDBUTTON_Y = 140
	SET /A BNDICM_MINIMIZEBUTTON_X = 1260
	SET /A BNDICM_MINIMIZEBUTTON_Y = 50


	SET /A MONEY = -1
	SET /A DAYTRADES = -1
	SET /A DATE_MONTH = -1
	SET /A DATE_DAY = -1
	SET /A DATE_YEAR = -1




::  *************************************************************************************************************************
::  *************************************************************************************************************************
::  *************************************************************************************************************************
::													Main
::													jumpTo Main


	:Main


		CALL :Computer_Prep
		CALL :Order_Loop
		

		EXIT /B %ERRORLEVEL%






::  *************************************************************************************************************************
::  *************************************************************************************************************************
::  *************************************************************************************************************************
::													Functions List
::													jumpTo Functions List


	:: ----- Main functions -----
		:: Computer_Prep
		:: Order_Loop


	:: ----- Helper Functions -----

		:: --- Firefox ---
		:: FF_Tab_Close
		:: FF_Url_Change
		:: FF_Tab_Open
		:: FF_Bookmark_Open
		:: FF_Prep
		:: FF_Tab_Change
		:: FF_Extension_Load
		:: FF_Console_SaveToFile
		:: FF_Console_Export


		:: --- Windows ---
		:: FE_Documents_Open
		:: FE_File_Save
		:: Window_Minimize
		:: Window_CloseSecondaryWindow
		:: Window_RemoveOthers
		:: Window_Close
		:: Taskbar_Click
		:: Searchbar_App_Open


		:: --- RobinHood ---
		:: RH_MarketBuy
		:: RH_MarketSell


		:: Order_ReadInData
		:: Order_SetVariables
		:: Order_ResetVariables
		:: Order_FulfillOrder


		:: --- Keyboard/Mouse ---
		:: Keyboard_NumberType
		:: Keyboard_PressKey
		:: Keyboard_WordType
		:: Mouse_LeftClick
		:: Mouse_DoubleLeftClick
		:: Mouse_RightClick


		:: --- Others ---
		:: String_GetLength
		:: Timeout_SlowFast
		:: SaveFilesAndExit
		:: Close_Everything
		:: File_Overwrite


	:: ----- Local Functions -----
		:: order_buysell_something
		:: order_buysell_nothing
 		:: lower_volume_and_brightness






::  ******************************************************************************************************************************************
::  ******************************************************************************************************************************************
::													Main Functions
::													jumpTo Main Functions




:: ------------------------------------------------------------------------------


	:: set everything up to start reading the stock trading
	:: jumpTo Computer_Prep
	:Computer_Prep


		CALL :lower_volume_and_brightness
		CALL :BNDICM_Prep 
		CALL :FF_Prep
		CALL :Window_RemoveOthers


		EXIT /B 0




:: ------------------------------------------------------------------------------

	:: main loop to read files and place orders
	:: jumpTo Order_Loop
	:Order_Loop


		FOR /L %%i IN (0, 1, 2200) DO (
			CALL :FF_Console_SaveToFile 2 "orders.txt" "no date" "overwrite" "fast"
			CALL :Order_ReadInData
			CALL :Order_FulfillOrder
			CALL :Order_ResetVariables
		)


		EXIT /B 0




::  ******************************************************************************************************************************************
::  ******************************************************************************************************************************************
::													Helper Functions
::													jumpTo Helper Functions
	


:: ------------------------------------------------------------------------------


	:order_buysell_something


		IF %ORDER_TYPE% == 0 (
			IF %JUSTBOUGHT% == 0 (
				CALL :RH_MarketBuy %ORDER_QUANTITY%
				SET /A JUSTBOUGHT = 1
				SET /A JUSTSOLD = 0
				nircmd wait 10150
				EXIT /B 0
			)
		) 


		IF %ORDER_TYPE% == 1 (
			IF %JUSTSOLD% == 0 (
				CALL :RH_MarketSell %ORDER_QUANTITY%
				SET /A JUSTBOUGHT = 0
				SET /A JUSTSOLD = 1
				nircmd wait 10150
				EXIT /B 0
			)
		) 


		EXIT /B 0




:: ------------------------------------------------------------------------------


	:order_buysell_nothing


		SET /A JUSTBOUGHT = 0
		SET /A JUSTSOLD = 0
		nircmd wait 10150


		EXIT /B 0




:: ------------------------------------------------------------------------------

	
	:Type_HundredThousands


		SET /A numberToType = %~1 / 100000
		CALL :Keyboard_NumberType %numberToType%
		SET /A newNumber = %~1 %% 100000


		SET /A numberToType = !newNumber! / 10000
		CALL :Keyboard_NumberType %numberToType%
		SET /A newNumber = !newNumber! %% 10000


		SET /A numberToType = !newNumber! / 1000
		CALL :Keyboard_NumberType %numberToType%
		SET /A newNumber = !newNumber! %% 1000

		
		SET /A numberToType = !newNumber! / 100
		CALL :Keyboard_NumberType %numberToType%
		SET /A newNumber = !newNumber! %% 100

		SET /A numberToType = !newNumber! / 10
		CALL :Keyboard_NumberType %numberToType%
		SET /A newNumber = !newNumber! %% 10
		CALL :Keyboard_NumberType %newNumber%


		EXIT /B 0




:: ------------------------------------------------------------------------------

	
	:Type_TenThousands


		SET /A numberToType = %~1 / 10000
		CALL :Keyboard_NumberType %numberToType%
		SET /A newNumber = %~1 %% 10000


		SET /A numberToType = !newNumber! / 1000
		CALL :Keyboard_NumberType %numberToType%
		SET /A newNumber = !newNumber! %% 1000


		SET /A numberToType = !newNumber! / 100
		CALL :Keyboard_NumberType %numberToType%
		SET /A newNumber = !newNumber! %% 100

		
		SET /A numberToType = !newNumber! / 10
		CALL :Keyboard_NumberType %numberToType%
		SET /A newNumber = !newNumber! %% 10
		CALL :Keyboard_NumberType %newNumber%


		EXIT /B 0




:: ------------------------------------------------------------------------------

	
	:Type_Thousands


		SET /A numberToType = %~1 / 1000
		CALL :Keyboard_NumberType %numberToType%
		SET /A newNumber = %~1 %% 1000


		SET /A numberToType = !newNumber! / 100
		CALL :Keyboard_NumberType %numberToType%
		SET /A newNumber = !newNumber! %% 100


		SET /A numberToType = !newNumber! / 10
		CALL :Keyboard_NumberType %numberToType%
		SET /A newNumber = !newNumber! %% 10
		CALL :Keyboard_NumberType %newNumber%

		EXIT /B 0




:: ------------------------------------------------------------------------------

	
	:Type_Hundreds


		SET /A numberToType = %~1 / 100
		CALL :Keyboard_NumberType %numberToType%
		SET /A newNumber = %~1 %% 100


		SET /A numberToType = !newNumber! / 10
		CALL :Keyboard_NumberType %numberToType%
		SET /A newNumber = !newNumber! %% 10
		CALL :Keyboard_NumberType %newNumber%

		EXIT /B 0
	



:: ------------------------------------------------------------------------------


	:Type_Tens


		SET /A numberToType = %~1 / 10
		CALL :Keyboard_NumberType %numberToType%
		SET /A newNumber = %~1 %% 10
		CALL :Keyboard_NumberType %newNumber%


		EXIT /B 0


:: ------------------------------------------------------------------------------


	:BNDICM_Prep


		CALL :Mouse_LeftClick %SEARCHBAR_X% %SEARCHBAR_Y% 1
		CALL :Keyboard_WordType "b a n d i c a m"
		CALL :Keyboard_PressKey "space"
		nircmd sendkeypress Shift+0x39
		timeout 45
		CALL :Keyboard_PressKey "enter"
		timeout 180
		CALL :Mouse_LeftClick %BNDICM_RECORDBUTTON_X% %BNDICM_RECORDBUTTON_Y% 60
		CALL :Mouse_LeftClick %BNDICM_MINIMIZEBUTTON_X% %BNDICM_MINIMIZEBUTTON_Y% 30


		EXIT /B 0




:: ------------------------------------------------------------------------------


	:RH_LOGINLOGOUT


		CALL :FF_Bookmark_Open 1 4
		CALL :Mouse_LeftClick %RH_ACCOUNTBUTTON_X% %RH_ACCOUNTBUTTON_Y% 0
		timeout 1
		CALL :Mouse_LeftClick %RH_ACCOUNTDROPDOWN_WHITESPACE_X% %RH_ACCOUNTDROPDOWN_WHITESPACE_Y% 0
		nircmd sendkeypress 0x28 + 0x28 + 0x28 + 0x28 + 0x28 + 0x28 + 0x28 + 0x28
		timeout 1
		CALL :Mouse_LeftClick %RH_LOGOUTBUTTON_X% %RH_LOGOUTBUTTON_Y% 0
		timeout 15
		CALL :Mouse_LeftClick %RH_SIGNINBUTTON_X% %RH_SIGNINBUTTON_Y% 15


		EXIT /B 0




:: ------------------------------------------------------------------------------
	
	:: jumpTo FE_File_Save
	:FE_File_Save


		:: Type the file name and save it
		nircmd setcursor %FE_FILENAME_X% %FE_FILENAME_Y%
		nircmd sendmouse left down
		nircmd setcursor 100 %FE_FILENAME_Y%
		nircmd sendmouse left up
		CALL :Keyboard_PressKey "backspace"
		IF %1 == "date" (CALL :Keyboard_DateType)
		CALL :GetNameAndTypeIt %2
		timeout 1
		CALL :Keyboard_PressKey "enter"
		timeout 1


		:: Click save (used as bugfixing)
		CALL :Mouse_LeftClick %FE_SAVE_X% %FE_SAVE_Y% 0
		timeout 1


		EXIT /B 0


:: ------------------------------------------------------------------------------

	:: jumpTo Mouse_RightClick
	:Mouse_RightClick


		:: click on the specified spot
		nircmd setcursor %~1 %~2
		nircmd sendmouse right click


		:: timeout for specified amount
		timeout %~3


		: return
		EXIT /B 0

	


:: ------------------------------------------------------------------------------

	:: jumpTo FF_Console_Export
	:FF_Console_Export


		:: to copy order to file
		SET /A consoleStart_x = 400
		SET /A consoleStart_y = 850
		SET /A consoleExportHover_x = 500
		SET /A consoleExportHover_y = 810
		SET /A consoleExportFile_x = 730
		SET /A consoleExportFile_y = 880


		:: right click, move to export
		CALL :Mouse_RightClick %consoleStart_x% %consoleStart_y% 1
		CALL :Mouse_RightClick %consoleExportHover_x% %consoleExportHover_y% 2


		:: export to file
		CALL :Mouse_LeftClick %consoleExportFile_x% %consoleExportFile_y% 2


		EXIT /B 0



:: ------------------------------------------------------------------------------

	:: jumpTo File_Overwrite
	:File_Overwrite


		CALL :Keyboard_PressKey "left"
		CALL :Keyboard_PressKey "left"
		CALL :Keyboard_PressKey "left"
		CALL :Keyboard_PressKey "left"
		CALL :Keyboard_PressKey "enter"
		CALL :Keyboard_PressKey "enter"
		CALL :Keyboard_PressKey "enter"
		CALL :Keyboard_PressKey "enter"


		EXIT /B 0




:: ------------------------------------------------------------------------------

	:: jumpTo Keyboard_DateType
	:Keyboard_DateType


		CALL :Keyboard_NumberType %DATE_MONTH%
		CALL :Keyboard_PressKey "space"
		CALL :Keyboard_NumberType %DATE_DAY%
		CALL :Keyboard_PressKey "space"
		CALL :Keyboard_NumberType %DATE_YEAR%
		CALL :Keyboard_PressKey "space"


		EXIT /B 0




:: ------------------------------------------------------------------------------

	:: arg1 = f12 timeout amount
	:: arg2 = file save name
	:: arg3 = date in file name
	:: arg4 = overwriting file
	:: jumpTo FF_Console_SaveToFile 
	:FF_Console_SaveToFile

		:: f12
		CALL :Keyboard_PressKey "f12"
		timeout %~1


		CALL :FF_Console_Export


		:: go to the batch files folder
		IF %5 == "normal" (CALL :FE_Documents_Open 4)


		:: save the file's name
		CALL :FE_File_Save %3 %2


		:: overwrite the previous file and then exit out of console (key presses happen multiple times because that seems to reduce bugs)
		IF %4 == "overwrite" (
			timeout 1
			CALL :File_Overwrite
		)


		:: close the console
		CALL :Keyboard_PressKey "f12"
		timeout 1


		EXIT /B 0




:: ------------------------------------------------------------------------------

	:: types a string into the url box of firefox_ (doesn't hit enter)
	:: argument1: string to type into url. Note: string must be space seperated. Ex: "dog" should be "d o g".
	:: example: CALL :FF_Url_Change "d a"
	:: jumpTo FF_Url_Change
	:FF_Url_Change


		:: click on the url
		CALL :Mouse_LeftClick %FF_URL_X% %FF_URL_Y% 0


		:: hit backspace to clear url
		CALL :Keyboard_PressKey "backspace"


		:: type url passed in
		FOR %%i IN (%~1) DO  (nircmd sendkeypress %%i)


		:: return
		EXIT /B 0




:: ------------------------------------------------------------------------------

	:: closes a tab in firefox (think this only works if there's only a few tabs, since it won't work with the smaller tabs)
	:: argument1: number tab we want to close, starting with 1
	:: example: CALL :FF_Tab_Close 2
	:: jumpTo FF_Tab_Close
	:FF_Tab_Close 


		SET /A tabClose_x = 650
		SET /A tabClose_y = 15


		:: close 2nd tab
		IF %~1 == 2 (nircmd setcursor %tabClose_x% %tabClose_y%)

		
		:: click the x button and wait to let firefox load
		nircmd sendmouse left click
		timeout 1


		EXIT /B 0




:: ------------------------------------------------------------------------------

	:: opens a tab, similar to FF_Tab_Close
	:: argument1: the current number of tabs open so the script knows where to click
	:: example CALL :FF_Tab_Open 1
	:: jumpTo FF_Tab_Open
	:FF_Tab_Open 


		SET /A jumpNum = %~1 - 1
		SET /A jumpAmount = !jumpNum! * !FF_TAB_OPEN_INCREMENT! + !FF_TAB_OPEN_X!


		:: click the new tab button and wait for firefox to load
		CALL :Mouse_LeftClick %jumpAmount% %FF_TAB_OPEN_Y% 1


		EXIT /B 0




:: ------------------------------------------------------------------------------

	:: minimizes the current window. window must be maximized size
	:: jumpTo Window_Minimize
	:Window_Minimize


		CALL :Mouse_LeftClick %WINDOW_MINIMIZE_X% %WINDOW_MINIMIZE_Y% 0


		EXIT /B 0




:: ------------------------------------------------------------------------------

	:: opens up firefox, starts up the javascript, and then opens up robinhood
	:: jumpTo FF_Prep
	:FF_Prep


		:: open firefox and load the extensions
		CALL :Searchbar_App_Open "f i r e f o x"
		CALL :FF_Extension_Load 1
		CALL :FF_Extension_Load 2
		CALL :FF_Extension_Load 3
		CALL :FF_Extension_Load 4
		CALL :FF_Extension_Load 5


		:: open a new tab
		IF %SETTING_FASTCOMPUTER% == 1 (CALL :FF_Tab_Close 2)
		CALL :FF_Tab_Open 1


		:: get money we have
		CALL :FF_Bookmark_Open 1 3
		CALL :FF_Console_SaveToFile 30 "money.txt" "no date" "overwrite" "normal"
		CALL :Order_MoneyReadIn


		:: open robinhood account and read day trades left
		CALL :FF_Bookmark_Open 1 4
		CALL :FF_Console_SaveToFile 30 "dayTradesCount.txt" "no date" "overwrite" "normal"
		CALL :Order_DayTradesReadIn


		:: sign out of account and sign back in
		CALL :RH_LOGINLOGOUT


		:: get today's date
		CALL :FF_Bookmark_Open 1 6
		CALL :FF_Console_SaveToFile 30 "todayDate.txt" "no date" "overwrite" "normal"
		CALL :Order_DateReadIn


		:: open up stock pages and put how much money we have
		CALL :FF_Bookmark_Open 1 2
		CALL :FF_Tab_Open 2
		CALL :FF_Bookmark_Open 1 5
		CALL :FF_Tab_Open 3
		CALL :FF_Bookmark_Open 1 7
		CALL :FF_Tab_Change 2
		CALL :RH_Searchbar_Type %MONEY%
		CALL :RH_Searchbar_Type %DAYTRADES%


		:: close the library
		CALL :Window_CloseSecondaryWindow 2


		EXIT /B 0




:: ------------------------------------------------------------------------------

	:: open up firefox's about:debugging page and load the stock trading app
	:: jumpTo FF_Extension_Load
	:FF_Extension_Load 


		SET /A thisFirefox_x = 100
		SET /A thisFirefox_y = 350
		SET /A loadTemp_x = 1300
		SET /A loadTemp_y = 480
		SET /A folderScroll_y = %~1 - 2
		SET /A resultScroll_y = %~1 - 1
		SET /A result_y = !FE_RESULTS_ICONS_START_Y! + !FE_RESULTS_BARS_INCREMENT! * !resultScroll_y!




		:: open up about:debugging and load an addon
		CALL :FF_Bookmark_Open 1 1
		CALL :Mouse_LeftClick %thisFirefox_x% %thisFirefox_y% 3
		CALL :Mouse_LeftClick %loadTemp_x% %loadTemp_y% 15


		:: go to the firefox javascript extensions folder
		CALL :FE_Documents_Open 3


		:: click on the top and wait
		CALL :Mouse_LeftClick %FE_RESULTS_ICONS_START_X% %FE_RESULTS_ICONS_START_Y% 5


		:: scroll down
		FOR /L %%i IN (0, 1, %folderScroll_y%) DO (CALL :Keyboard_PressKey "down")
		timeout 5


		:: click on the result as well
		CALL :Mouse_LeftClick %FE_RESULTS_ICONS_START_X% %result_y% 0


		:: enter the folder
		CALL :Keyboard_PressKey "enter"
		timeout 1


		:: click on the first result, go to the next file, and press enter
		CALL :Mouse_LeftClick %FE_RESULTS_ICONS_START_X% %FE_RESULTS_ICONS_START_Y% 1
		CALL :Keyboard_PressKey "down"
		CALL :Keyboard_PressKey "enter"


		EXIT /B 0




:: ------------------------------------------------------------------------------

	:: clicks on one of the items in the taskbar
	:: jumpTo Taskbar_Click
	:Taskbar_Click


		SET /A taskbar_app_x = %~1 * %TASKBAR_INCREMENT% + %TASKBAR_START_X%
		CALL :Mouse_DoubleLeftClick %taskbar_app_x% %TASKBAR_START_Y% 0


		EXIT /B 0 




:: ------------------------------------------------------------------------------

	:: jumpTo Searchbar_App_Open
	:Searchbar_App_Open 


		:: go to the windows search bar
		CALL :Mouse_LeftClick %SEARCHBAR_X% %SEARCHBAR_Y% 1


		:: open up app from the search bars
		FOR %%i IN (%~1) DO  (nircmd sendkeypress %%i)
		nircmd setcursor %SEARCHBAR_BESTRESULT_X% %SEARCHBAR_BESTRESULT_Y%
		CALL :Timeout_SlowFast 45 3
		CALL :Keyboard_PressKey "enter"
		

		:: wait for it to load
		CALL :Timeout_SlowFast 180 5


		EXIT /B 0




:: ------------------------------------------------------------------------------

	:: goes to the documents folder via the sidebar and then opens up a folder in it
	:: jumpTo FE_Documents_Open
	:FE_Documents_Open


		SET /A folderScrollAmount = %~1 - 2
		SET /A folderClickAmount = %~1 - 1
		SET /A folderClickLocation = !FE_RESULTS_ICONS_START_X! + !FE_RESULTS_ICONS_INCREMENT! * !folderClickAmount!


		:: click on the sidebar and then scroll down to documents
		CALL :Mouse_LeftClick %FE_SIDEBAR_START_X% %FE_SIDEBAR_START_Y% 1
		CALL :Mouse_LeftClick %FE_SIDEBAR_START_X% %FE_SIDEBAR_START_Y% 2
		CALL :Keyboard_PressKey "down"
		timeout 1
		CALL :Keyboard_PressKey "down"
		timeout 1
		CALL :Mouse_LeftClick %FE_SIDEBAR_START_X% 265 1
		CALL :Mouse_LeftClick %FE_SIDEBAR_START_X% 265 1
		CALL :Keyboard_PressKey "enter"
		timeout 1


		:: go to the extension folder
		CALL :Mouse_LeftClick %FE_RESULTS_ICONS_START_X% %FE_RESULTS_ICONS_START_Y% 1
		CALL :Mouse_LeftClick %FE_RESULTS_ICONS_START_X% %FE_RESULTS_ICONS_START_Y% 1
		FOR /L %%i IN (0, 1, %folderScrollAmount%) DO (CALL :Keyboard_PressKey "right")
		

		:: click on the place for bugfixing reasons and hit enter
		CALL :Mouse_LeftClick %folderClickLocation% %FE_SIDEBAR_START_Y% 0
		CALL :Keyboard_PressKey "enter"
		timeout 1


		EXIT /B 0




:: ------------------------------------------------------------------------------

	:: opens up a bookmark in the bookmarks menu in firefox
	:: argument1: the folder to click. its position starting from 1
	:: argument2: the link in the folder to click. its position starting from 1
	:: example: CALL :FF_Bookmark_Open 1 2
	:: jumpTo FF_Bookmark_Open
	:FF_Bookmark_Open


		SET /A bookmarks_x = 400
		SET /A relevantWebsites_x = 1660
		SET /A relevantWebsites_y = 80
		SET /A bookmarksTab_x = 1450
		SET /A bookmarksTab_y = 140
		SET /A bookmarksShowAll_x = 1500
		SET /A bookmarksShowAll_y = 970
		SET /A bookmarksMenu_x = 200
		SET /A bookmarksMenu_y = 270
		SET /A folder_y = 35 * %~1 + 90
		SET /A bookmarks_y = 35 * %~2 + 90


		:: click on relevant websites (that book looking thing on the topbar)
		nircmd setcursor %relevantWebsites_x% %relevantWebsites_y%
		nircmd sendmouse left click
		CALL :Timeout_SlowFast 3 1


		:: click on bookmarks
		nircmd setcursor %bookmarksTab_x% %bookmarksTab_y%
		nircmd sendmouse left click
		CALL :Timeout_SlowFast 3 1


		:: click on show all bookmarks
		nircmd setcursor %bookmarksShowAll_x% %bookmarksShowAll_y%
		nircmd sendmouse left click
		CALL :Timeout_SlowFast 3 1


		:: click on bookmarks menu
		nircmd setcursor %bookmarksMenu_x% %bookmarksMenu_y%
		nircmd sendmouse left click
		CALL :Timeout_SlowFast 3 1


		:: go to the folder
		CALL :Mouse_DoubleLeftClick %bookmarks_x% %folder_y% 0
		CALL :Timeout_SlowFast 5 2


		:: go to the bookmark link
		CALL :Mouse_DoubleLeftClick %bookmarks_x% %bookmarks_y% 0
		CALL :Timeout_SlowFast 45 10 


		EXIT /B 0




:: ------------------------------------------------------------------------------

	:FF_Tab_Change


		SET /A jumpNum = %~1 - 1
		SET /A jumpAmount = !jumpNum! * !FF_TAB_INCREMENT! + !FF_TAB_X!


		CALL :Mouse_LeftClick %jumpAmount% %FF_TAB_Y% 1


		EXIT /B 0




:: ------------------------------------------------------------------------------

	:: jumpTo Window_CloseSecondaryWindow
	:Window_CloseSecondaryWindow

		SET /A app_x = %~1 * 100 + 670
		SET /A exit_x = !app_x! + 270
		SET /A exit_y = !TASKBAR_START_Y! - 230


		CALL :Mouse_LeftClick %app_x% %TASKBAR_START_Y% 3


		CALL :Mouse_LeftClick %exit_x% %exit_y% 2


		EXIT /B 0





:: ------------------------------------------------------------------------------

	:: removes popups (such as file explorer and the command prompt)
	:: example: CALL :popupRemover
	:: jumpTo Window_RemoveOthers
	:Window_RemoveOthers


		CALL :Mouse_LeftClick 1850 1000 1


		EXIT /B 0




:: ------------------------------------------------------------------------------

	:: finds the length of a string and returns it as a number
	:: argument1: the string to measure. It must be in a variable in quotations.
	:: argument2: variable to store length in 
	:: example: SET "strToMeasure=This is a string"
	:: example: CALL :String_GetLength strToMeasure String_GetLength
	:: jumpTo String_GetLength
	:String_GetLength
		setlocal enabledelayedexpansion
		:String_GetLength_Loop
		 	if not "!%1:~%len%!"=="" set /A len+=1 & goto :String_GetLength_Loop
		(endlocal & set %2=%len%)
		goto :eof




:: ------------------------------------------------------------------------------

	:: types numbers because RH_MarketBuy/FF_Url_Change and other functions cannot type multi-digit numbers.
	:: can handle 1-29. If argument1 is greater than 29, then it just does 29.
	:: argument1: the num to print.
	:: example: CALL :Keyboard_NumberType 14
	:: jumpTo Keyboard_NumberType
	:Keyboard_NumberType

		:: x < 10
		IF %~1 LSS 10 (
			nircmd sendkeypress %~1
			EXIT /B 0
		)


		IF %~1 LSS 100 (
			CALL :Type_Tens %~1
			EXIT /B 0
		)


		IF %~1 LSS 1000 (
			CALL :Type_Hundreds %~1
			EXIT /B 0
		)


		IF %~1 LSS 10000 (
			CALL :Type_Thousands %~1
			EXIT /B 0
		)


		IF %~1 LSS 100000 (
			CALL :Type_TenThousands %~1
			EXIT /B 0
		)


		IF %~1 LSS 1000000 (
			CALL :Type_HundredThousands %~1
			EXIT /B 0
		)


		EXIT /B 0




:: ------------------------------------------------------------------------------

	:: jumpTo Keyboard_WordType
	:Keyboard_WordType


		:: type url passed in
		FOR %%i IN (%~1) DO  (nircmd sendkeypress %%i)


		EXIT /B 0




::  ******************************************************************************************************************************************
::  ******************************************************************************************************************************************
::						Main Functions




:: ------------------------------------------------------------------------------

	:: executes a market buy
	:: argument1: the number of shares to buy
	:: example: CALL :RH_MarketBuy 10
	:: jumpTo RH_MarketBuy
	:RH_MarketBuy

		:: click on the buy tab
		CALL :Mouse_LeftClick %RH_BUYBUTTON_X% %RH_BUYBUTTON_Y% 1


		:: enter share number
		CALL :Mouse_LeftClick %RH_SHAREINPUT_X% %RH_SHAREINPUT_Y% 1
		CALL :Keyboard_NumberType %~1
		timeout 1


		:: review order
		CALL :Mouse_LeftClick %RH_REVIEWBUTTON_X% %RH_REVIEWBUTTON_Y% 3


		:: place order
		nircmd setcursor %RH_PLACEORDERBUTTON_X% %RH_PLACEORDERBUTTON_Y%
		IF %SETTING_TESTING% == 0 (nircmd sendmouse left click)
		timeout 3


		:: done button
		CALL :Mouse_LeftClick %RH_DONEBUTTON_X% %RH_DONEBUTTON_Y% 0


		EXIT /B 0




:: ------------------------------------------------------------------------------

	:: executes a market sell
	:: argument1: the number of shares to sell
	:: example: CALL :RH_MarketSell 10
	:: jumpTo RH_MarketSell
	:RH_MarketSell

		:: click on the sell tab
		CALL :Mouse_LeftClick %RH_SELLBUTTON_X% %RH_SELLBUTTON_Y% 1


		:: enter num of shares to sell
		CALL :Mouse_LeftClick %RH_SHAREINPUT_X% %RH_SHAREINPUT_Y% 1
		CALL :Keyboard_NumberType %~1
		timeout 1


		:: click review
		CALL :Mouse_LeftClick %RH_REVIEWBUTTON_X% %RH_REVIEWBUTTON_Y% 3


		:: click the done button for the order
		nircmd setcursor %RH_PLACEORDERBUTTON_X% %RH_PLACEORDERBUTTON_Y%
		IF %SETTING_TESTING% == 0 (nircmd sendmouse left click)
		timeout 3


		:: place order
		CALL :Mouse_LeftClick %RH_DONEBUTTON_X% %RH_DONEBUTTON_Y% 0


		EXIT /B 0




:: ------------------------------------------------------------------------------

	:: Reads the variables set in Order_SetVariables and places a buy/sell accordingly
	:: jumpTo Order_FulfillOrder
	:Order_FulfillOrder


		:: if actual order, run the order functions. Else, timeout so that the length of the loop matches
		IF %ORDER_QUANTITY% GTR 0 (CALL :order_buysell_something) ELSE (CALL :order_buysell_nothing)
				

		EXIT /B 0




:: ------------------------------------------------------------------------------

	:: takes the info from :Order_ReadInData and sets variables that will later be used for an order.
	:: argument1: a single letter/number. usually a number
	:: example: CALL :Order_SetVariables 2
	:: jumpTo Order_SetVariables
	:Order_SetVariables


		:: time to exit
		IF %ORDER_OPENED% == -1 (
			IF %~1 == -1 (
				CALL :SaveFilesAndExit
				nircmd initshutdown
			)
			SET /A ORDER_OPENED = 1
			SET /A ORDER_TYPE = %~1
			EXIT /B 0
		)


		:: if first num has been read, then remaining numbers are quantity
		IF %ORDER_QUANTITY% == -1 (
			SET /A ORDER_QUANTITY = %~1
			EXIT /B 0
		)


		IF %ORDER_PRICEDOLLAR% == -1 (
			SET /A ORDER_PRICEDOLLAR = %~1
			EXIT /B 0
		)


		IF %ORDER_PRICECENTS% == -1 (
			SET /A ORDER_PRICECENTS = %~1
			EXIT /B 0
		)


		EXIT /B 0






:: ------------------------------------------------------------------------------

	:: read from orders.txt to get order info
	:: example: CALL :Order_ReadInData
	:: jumpTo Order_ReadInData
	:Order_ReadInData


		FOR /F "tokens=* skip=1" %%x IN (orders.txt) DO (CALL :Order_SetVariables %%x)


		EXIT /B 0




:: ------------------------------------------------------------------------------

	:: resets the variables used in reading files. allows another loop to occur
	:: jumpTo Order_ResetVariables
	:Order_ResetVariables


		SET /A ORDER_OPENED = -1
		SET /A ORDER_TYPE = -1
		SET /A ORDER_QUANTITY = -1
		SET /A ORDER_PRICEDOLLAR = -1
		SET /A ORDER_PRICECENTS = -1


		EXIT /B 0




:: ------------------------------------------------------------------------------

	:: Clicks the mouse at the specified spot and timeouts. Used to make code cleaner.
	:: jumpTo Mouse_LeftClick
	:Mouse_LeftClick


		:: click on the specified spot
		nircmd setcursor %~1 %~2
		nircmd sendmouse left click


		:: timeout for specified amount
		timeout %~3


		: return
		EXIT /B 0




:: ------------------------------------------------------------------------------
	
	:: Takes a string and then performs a keyboard press. Used so we don't have to remember the keycodes
	:: jumpTo Keyboard_PressKey
	:Keyboard_PressKey

		IF "%~1" == "up" (
			nircmd sendkeypress 0x26
			EXIT /B 0
		)


		IF "%~1" == "down" (
			nircmd sendkeypress 0x28
			EXIT /B 0
		)


		IF "%~1" == "left" (
			nircmd sendkeypress 0x25
			EXIT /B 0
		)


		IF "%~1" == "right" (
			nircmd sendkeypress 0x27
			EXIT /B 0
		)


		IF "%~1" == "period" (
			nircmd sendkeypress 0xBE
			EXIT /B 0
		)


		IF "%~1" == "enter" (
			nircmd sendkeypress 0x0D
			EXIT /B 0
		)


		IF "%~1" == "backspace" (
			nircmd sendkeypress 0x08
			EXIT /B 0
		)


		IF "%~1" == "space" (
			nircmd sendkeypress 0x20
			EXIT /B 0
		)


		IF "%~1" == "f12" (
			nircmd sendkeypress 0x7B
			EXIT /B 0
		)


		IF "%~1" == "save" (
			nircmd sendkeypress ctrl+0x53
			EXIT /B 0
		)


		EXIT /B 0




:: ------------------------------------------------------------------------------	

	:: Takes a string and then performs a keyboard press. Used so we don't have to remember the keycodes
	:: jumpTo Mouse_DoubleLeftClick
	:Mouse_DoubleLeftClick

		:: click on the specified spot
		nircmd setcursor %~1 %~2
		nircmd sendmouse left click
		nircmd sendmouse left click


		:: timeout for specified amount
		timeout %~3


		: return
		EXIT /B 0




:: ------------------------------------------------------------------------------

	:: Calls two different timeouts based on whether the %SETTING_FASTCOMPUTER% variable is set. Used to make
	:: the code cleaner
	:: jumpTo Timeout_SlowFast
	:Timeout_SlowFast


		IF %SETTING_FASTCOMPUTER% == 0 (timeout %~1) ELSE (timeout %~2)


		EXIT /B 0




:: ------------------------------------------------------------------------------

	:: jumpTo RH_Searchbar_Type
	:RH_Searchbar_Type


		timeout 1


		CALL :Mouse_LeftClick %RH_SEARCHBAR_X% %RH_SEARCHBAR_Y% 0
		CALL :Keyboard_NumberType %~1
		CALL :Keyboard_PressKey "space"




		EXIT /B 0





:: ------------------------------------------------------------------------------

	:: jumpTo Order_MoneyReadIn
	:Order_MoneyReadIn


		FOR /F "tokens=*" %%x IN (money.txt) DO (CALL :Order_Money_Vars_Set %%x)


		EXIT /B 0




:: ------------------------------------------------------------------------------

	:: jumpTo Order_Money_Vars_Set
	:Order_Money_Vars_Set


		SET /A MONEY = %~1


		EXIT /B 0
	



:: ------------------------------------------------------------------------------

	:: jumpTo Order_DayTradesReadIn
	:Order_DayTradesReadIn


		FOR /F "tokens=*" %%x IN (dayTradesCount.txt) DO (CALL :Order_DayTrades_Vars_Set %%x)




		EXIT /B 0





:: ------------------------------------------------------------------------------

	:: jumpTo Order_DateReadIn
	:Order_DateReadIn


		FOR /F "tokens=*" %%x IN (todayDate.txt) DO (CALL :Order_Date_Vars_Set %%x)




		EXIT /B 0




:: ------------------------------------------------------------------------------

	:: jumpTo Order_Date_Vars_Set
	:Order_Date_Vars_Set

		IF %DATE_MONTH% == -1 (
			SET /A DATE_MONTH = %~1
			EXIT /B 0
		)


		IF %DATE_DAY% == -1 (
			SET /A DATE_DAY = %~1
			EXIT /B 0
		)


		IF %DATE_YEAR% == -1 (
			SET /A DATE_YEAR = %~1
			EXIT /B 0
		)


		EXIT /B 0




:: ------------------------------------------------------------------------------

	:: jumpTo Order_DayTrades_Vars_Set
	:Order_DayTrades_Vars_Set


		SET /A DAYTRADES = %~1


		EXIT /B 0




:: ------------------------------------------------------------------------------
	
	:: jumpTo SaveFilesAndExit
	:SaveFilesAndExit


		:: save stock price info
		timeout 120
		CALL :Taskbar_Click 2
		CALL :FF_Tab_Change 2
		CALL :FF_Console_SaveToFile 10 "GM.txt" "date" "no overwrite" "normal"
		timeout 60
		CALL :FF_Tab_Change 3
		CALL :FF_Console_SaveToFile 10 "NFLX.txt" "date" "no overwrite" "normal"
		timeout 60
		CALL :FF_Tab_Change 4
		CALL :FF_Console_SaveToFile 10 "MSFT.txt" "date" "no overwrite" "normal"
		nircmd changebrightness 100


		EXIT /B 0




:: ------------------------------------------------------------------------------

	:: jumpTo Window_Close
	:Window_Close

		CALL :Taskbar_Click %~1
		CALL :Timeout_SlowFast 5 2
		CALL :Mouse_LeftClick %WINDOW_EXIT_X% %WINDOW_EXIT_Y% 1


		EXIT /B 0





:: ------------------------------------------------------------------------------

	:: jumpTo Close_Everything
	:Close_Everything

		CALL :Window_Close 2
		CALL :Window_Close 3
		CALL :Window_Close 4
		CALL :Window_Close 5




:: ------------------------------------------------------------------------------

	:: jumpTo GetNameAndTypeIt
	:GetNameAndTypeIt 


		IF %1 == "dayTradesCount.txt" (
			CALL :Keyboard_WordType "d a y T r a d e s C o u n t"
			CALL :Keyboard_PressKey "period"
			nircmd sendkeypress "t" + "x" + "t"
			EXIT /B 0
		)


		IF %1 == "money.txt" (
			CALL :Keyboard_WordType "m o n e y"
			CALL :Keyboard_PressKey "period"
			nircmd sendkeypress "t" + "x" + "t"
			EXIT /B 0
		)


		IF %1 == "todayDate.txt" (
			CALL :Keyboard_WordType "t o d a y D a t e"
			CALL :Keyboard_PressKey "period"
			nircmd sendkeypress "t" + "x" + "t"
			EXIT /B 0
		)


		IF %1 == "orders.txt" (
			CALL :Keyboard_WordType "o r d e r s"
			CALL :Keyboard_PressKey "period"
			nircmd sendkeypress "t" + "x" + "t"
			EXIT /B 0
		)


		IF %1 == "GM" (
			CALL :Keyboard_WordType "G M"
			EXIT /B 0
		)


		IF %1 == "CPRX" (
			CALL :Keyboard_WordType "C P R X"
			EXIT /B 0
		)


		IF %1 == "INTL" (
			CALL :Keyboard_WordType "I N T L"
			EXIT /B 0
		)


		IF %1 == "NFLX" (
			CALL :Keyboard_WordType "N F L X"
			EXIT /B 0
		)


		IF %1 == "MSFT" (
			CALL :Keyboard_WordType "M S F T"
			EXIT /B 0
		)


		IF %1 == "GM.txt" (
			CALL :Keyboard_WordType "G M"
			CALL :Keyboard_PressKey "period"
			nircmd sendkeypress "t" + "x" + "t"
			EXIT /B 0
		)


		IF %1 == "CPRX.txt" (
			CALL :Keyboard_WordType "C P R X"
			CALL :Keyboard_PressKey "period"
			nircmd sendkeypress "t" + "x" + "t"
			EXIT /B 0
		)


		IF %1 == "INTL.txt" (
			CALL :Keyboard_WordType "I N T L"
			CALL :Keyboard_PressKey "period"
			nircmd sendkeypress "t" + "x" + "t"
			EXIT /B 0
		)


		IF %1 == "NFLX.txt" (
			CALL :Keyboard_WordType "N F L X"
			CALL :Keyboard_PressKey "period"
			nircmd sendkeypress "t" + "x" + "t"
			EXIT /B 0
		)


		IF %1 == "MSFT.txt" (
			CALL :Keyboard_WordType "M S F T"
			CALL :Keyboard_PressKey "period"
			nircmd sendkeypress "t" + "x" + "t"
			EXIT /B 0
		)


		EXIT /B 0





::  ******************************************************************************************************************************************
::  ******************************************************************************************************************************************
::													Local Functions
::													jumpTo Local Functions



:: ------------------------------------------------------------------------------
	
	:: jumpTo lower_volume_and_brightness
	:lower_volume_and_brightness

		IF %SETTING_TESTING% == 0 (
			nircmd changesysvolume -80000
			nircmd changebrightness -100
		)


		EXIT /B 0
