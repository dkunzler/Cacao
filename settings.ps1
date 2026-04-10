#--- Enable developer mode on the system ---
Set-ItemProperty -Path HKLM:\Software\Microsoft\Windows\CurrentVersion\AppModelUnlock -Name AllowDevelopmentWithoutDevLicense -Value 1

# Change ExecutionPolicy
Update-ExecutionPolicy RemoteSigned

# add en-GB to Language List
$OldList = Get-WinUserLanguageList
$OldList.Add("en-GB")
Set-WinUserLanguageList -LanguageList $OldList

# user different input language per app window
Set-WinLanguageBarOption -UseLegacySwitchMode

# Remove Microsoft Edge from Taskbar (ger/eng only)
$appname = "Microsoft Edge"
((New-Object -Com Shell.Application).NameSpace('shell:::{4234d49b-0245-4df3-b780-3893943456e1}').Items() | ?{$_.Name -eq $appname}).Verbs() | ?{$_.Name.replace('&','') -match 'Von Taskleiste lösen|Unpin from taskbar'} | %{$_.DoIt(); $exec = $true}


# Windows 11 Theming:

# App Dark Mode:
#Set-ItemProperty -Path HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\Themes\Personalize -Name AppsUseLightTheme -Value 0 -Type Dword -Force
#App Light Mode:
Set-ItemProperty -Path HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\Themes\Personalize -Name AppsUseLightTheme -Value 1 -Type Dword -Force
# System Dark Mode
Set-ItemProperty -Path HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\Themes\Personalize -Name SystemUsesLightTheme -Value 0 -Type Dword -Force
# System Light Mode
#Set-ItemProperty -Path HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\Themes\Personalize -Name SystemUsesLightTheme -Value 1 -Type Dword -Force

# extend Path
[Environment]::SetEnvironmentVariable("Path", $env:Path + ";c:\bin", "Machine")
[Environment]::SetEnvironmentVariable("Path", $env:Path + ";c:\dev\bin", "Machine")

# enable hibernate
powercfg /hibernate on
powercfg /h /type full

# add home folder to quick access
$homeFavorite = new-object -com shell.application
$homeFavorite.Namespace($HOME).Self.InvokeVerb("pintohome")

Enable-RemoteDesktop

Copy-Item -Path "settings_134202445372236404.ptb" -Destination $powerToysBackupDir -Force
