

#--- Enable developer mode on the system ---
Set-ItemProperty -Path HKLM:\Software\Microsoft\Windows\CurrentVersion\AppModelUnlock -Name AllowDevelopmentWithoutDevLicense -Value 1

# Change ExecutionPolicy
Update-ExecutionPolicy RemoteSigned

#--- Enable administrative shares ---
Set-ItemProperty -Path HKLM:\Software\Microsoft\Windows\CurrentVersion\Policies\System -Name LocalAccountTokenFilterPolicy -Value 1

# Windows 11: remove Chat from Taskbar
Set-ItemProperty -Path HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced -Name TaskbarMn -Value 0

# Removes Widgets from the Taskbar
Set-ItemProperty -Path HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced -Name TaskbarDa -Value 0

# Removes search from the Taskbar
reg.exe add "HKLM\Default\SOFTWARE\Microsoft\Windows\CurrentVersion\Search" /v SearchboxTaskbarMode /t REG_DWORD /d 0 /f

# Remove Microsoft Store from Taskbar (ger/eng only)
$appname = "Microsoft Store"
((New-Object -Com Shell.Application).NameSpace('shell:::{4234d49b-0245-4df3-b780-3893943456e1}').Items() | ?{$_.Name -eq $appname}).Verbs() | ?{$_.Name.replace('&','') -match 'Von Taskleiste lösen|Unpin from taskbar'} | %{$_.DoIt(); $exec = $true}

# Remove Microsoft Edge from Taskbar (ger/eng only)
$appname = "Microsoft Edge"
((New-Object -Com Shell.Application).NameSpace('shell:::{4234d49b-0245-4df3-b780-3893943456e1}').Items() | ?{$_.Name -eq $appname}).Verbs() | ?{$_.Name.replace('&','') -match 'Von Taskleiste lösen|Unpin from taskbar'} | %{$_.DoIt(); $exec = $true}

# Windows 11 Theming:

# App Dark Mode:
#Set-ItemProperty -Path HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\Themes\Personalize -Name AppsUseLightTheme -Value 0 -Type Dword -Force
#App Light Mode:
Set-ItemProperty -Path HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\Themes\Personalize -Name AppsUseLightTheme -Value 1 -Type Dword -Force
# System Dark Mode
#Set-ItemProperty -Path HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\Themes\Personalize -Name SystemUsesLightTheme -Value 0 -Type Dword -Force
# System Light Mode
Set-ItemProperty -Path HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\Themes\Personalize -Name SystemUsesLightTheme -Value 1 -Type Dword -Force

# add en-GB to Language List
$OldList = Get-WinUserLanguageList
$OldList.Add("en-GB")
Set-WinUserLanguageList -LanguageList $OldList

# user different input language per app window
Set-WinLanguageBarOption -UseLegacySwitchMode