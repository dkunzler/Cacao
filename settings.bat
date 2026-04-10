@echo off
chcp 65001 >nul
echo ========================================
echo Windows Post-Install Script (.bat)
echo Generated: 04/09/2026, 22:20
echo ========================================
echo.

:: Check for Administrator privileges
net session >nul 2>&1
if %errorLevel% neq 0 (
    echo ERROR: This script requires Administrator privileges.
    echo Please right-click and select "Run as administrator"
    echo.
    pause
    exit /b 1
)

echo Starting installation process...
echo.

::============================================
:: SYSTEM CONFIGURATIONS
::============================================
echo.
echo Applying system configurations...
echo.

:: Show empty drives
echo Applying: Show empty drives
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced" /v HideDrivesWithNoMedia /t REG_DWORD /d 0 /f
echo.

:: Show status bar
echo Applying: Show status bar
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced" /v ShowStatusBar /t REG_DWORD /d 1 /f
echo.

:: Disable Quick Access
echo Applying: Disable Quick Access
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced" /v LaunchTo /t REG_DWORD /d 1 /f
echo.

:: Show file extensions
echo Applying: Show file extensions
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced" /v HideFileExt /t REG_DWORD /d 0 /f
echo.

:: Show hidden files and folders
echo Applying: Show hidden files and folders
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced" /v Hidden /t REG_DWORD /d 1 /f
echo.

:: Disable Windows Tips
echo Applying: Disable Windows Tips
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" /v SoftLandingEnabled /t REG_DWORD /d 0 /f
echo.

:: Disable app suggestions
echo Applying: Disable app suggestions
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" /v SubscribedContent-338388Enabled /t REG_DWORD /d 0 /f
echo.

:: Disable Cortana
echo Applying: Disable Cortana
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\Windows Search" /v AllowCortana /t REG_DWORD /d 0 /f
echo.

:: Disable tailored experiences
echo Applying: Disable tailored experiences
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Privacy" /v TailoredExperiencesWithDiagnosticDataEnabled /t REG_DWORD /d 0 /f
echo.

:: Disable Windows feedback requests
echo Applying: Disable Windows feedback requests
reg add "HKCU\Software\Microsoft\Siuf\Rules" /v NumberOfSIUFInPeriod /t REG_DWORD /d 0 /f
echo.

:: Disable diagnostic data collection
echo Applying: Disable diagnostic data collection
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\DataCollection" /v AllowTelemetry /t REG_DWORD /d 0 /f
echo.

:: Disable advertising ID
echo Applying: Disable advertising ID
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\AdvertisingInfo" /v Enabled /t REG_DWORD /d 0 /f
echo.

:: Disable telemetry
echo Applying: Disable telemetry
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\DataCollection" /v AllowTelemetry /t REG_DWORD /d 0 /f
echo.

:: Disable Customer Experience Program
echo Applying: Disable Customer Experience Program
reg add "HKLM\SOFTWARE\Policies\Microsoft\SQMClient\Windows" /v CEIPEnable /t REG_DWORD /d 0 /f
echo.

:: Hide search box from taskbar
echo Applying: Hide search box from taskbar
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Search" /v SearchboxTaskbarMode /t REG_DWORD /d 0 /f
echo.

:: Remove OneDrive
echo Applying: Remove OneDrive
taskkill /f /im OneDrive.exe
%SystemRoot%\System32\OneDriveSetup.exe /uninstall
%SystemRoot%\SysWOW64\OneDriveSetup.exe /uninstall
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\OneDrive" /v DisableFileSyncNGSC /t REG_DWORD /d 1 /f
reg delete "HKCU\Software\Microsoft\Windows\CurrentVersion\Run" /v OneDrive /f
echo.

:: Disable automatic restart after updates
echo Applying: Disable automatic restart after updates
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\WindowsUpdate\AU" /v NoAutoRebootWithLoggedOnUsers /t REG_DWORD /d 1 /f
echo.

:: Disable Bing search in Start Menu
echo Applying: Disable Bing search in Start Menu
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Search" /v BingSearchEnabled /t REG_DWORD /d 0 /f
echo.

:: Remove recent items from Start Menu
echo Applying: Remove recent items from Start Menu
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced" /v Start_TrackDocs /t REG_DWORD /d 0 /f
echo.

:: Remove Teams Chat
echo Applying: Remove Teams Chat
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced" /v TaskbarMn /t REG_DWORD /d 0 /f
powershell -Command "Get-AppxPackage MicrosoftTeams* | Remove-AppxPackage"
echo.

:: Remove Skype (pre-installed)
echo Applying: Remove Skype (pre-installed)
powershell -Command "Get-AppxPackage Microsoft.SkypeApp | Remove-AppxPackage"
echo.

:: Remove Mail & Calendar
echo Applying: Remove Mail & Calendar
powershell -Command "Get-AppxPackage microsoft.windowscommunicationsapps | Remove-AppxPackage"
echo.

:: Remove Get Help app
echo Applying: Remove Get Help app
powershell -Command "Get-AppxPackage Microsoft.GetHelp | Remove-AppxPackage"
echo.

:: Remove casual games
echo Applying: Remove casual games
powershell -Command "Get-AppxPackage *CandyCrush* | Remove-AppxPackage"
powershell -Command "Get-AppxPackage *BubbleWitch* | Remove-AppxPackage"
powershell -Command "Get-AppxPackage king.com* | Remove-AppxPackage"
powershell -Command "Get-AppxPackage *MarchofEmpires* | Remove-AppxPackage"
echo.

:: Remove Xbox Game Bar
echo Applying: Remove Xbox Game Bar
powershell -Command "Get-AppxPackage Microsoft.XboxGamingOverlay | Remove-AppxPackage"
powershell -Command "Get-AppxPackage Microsoft.XboxGameCallableUI | Remove-AppxPackage"
echo.

:: Remove all Xbox apps
echo Applying: Remove all Xbox apps
powershell -Command "Get-AppxPackage Microsoft.XboxIdentityProvider | Remove-AppxPackage"
powershell -Command "Get-AppxPackage Microsoft.XboxSpeechToTextOverlay | Remove-AppxPackage"
powershell -Command "Get-AppxPackage Microsoft.Xbox.TCUI | Remove-AppxPackage"
echo.

:: Remove Bing News
echo Applying: Remove Bing News
powershell -Command "Get-AppxPackage Microsoft.BingNews | Remove-AppxPackage"
echo.

:: Disable Xbox Live services
echo Applying: Disable Xbox Live services
sc config XblAuthManager start= disabled
sc stop XblAuthManager
sc config XblGameSave start= disabled
sc stop XblGameSave
sc config XboxGipSvc start= disabled
sc stop XboxGipSvc
echo.

::============================================
:: INSTALLATION COMPLETE
::============================================
echo.
echo ========================================
echo Installation Complete!
echo ========================================
echo.
echo If any installations failed, check errors.log
echo.
echo Next steps:
echo   1. Restart your computer if required
echo   2. Log into your installed applications
echo   3. Customize your settings as needed
echo.
echo Generated by Windows Post-Install Generator
echo https://github.com/kaic/win-post-install
echo.
pause
